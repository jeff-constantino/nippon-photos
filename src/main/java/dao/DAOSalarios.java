package dao;

import connection.SingleConnectionBanco;
import model.ModelLogin;
import model.ModelSalarios;
import model.ModelVendas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOSalarios {
    private final Connection connection;

    public DAOSalarios() {
        this.connection = SingleConnectionBanco.getConnection();
    }


    public List<ModelVendas> consultarVendasFuncionario(String funcionarioId, String dataInicial, String dataFinal, int offset, int limit) throws Exception {
        List<ModelVendas> modelVendasFuncionarioList = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT l.nome, ")
                .append("SUM(COALESCE(v.ft_total::INTEGER, 0)) AS foto_total, ")
                .append("SUM(COALESCE(v.enc_total::INTEGER, 0)) AS encarte_total, ")
                .append("SUM(COALESCE(v.dig_total::INTEGER, 0)) AS digital_total, ")
                .append("SUM(COALESCE(v.sobras::INTEGER, 0)) AS sobras_total, ")
                .append("l.status, ") // Mantém l.status
                .append("SUM(CASE WHEN v.ribbon = 'DESCONTAR' THEN ABS(COALESCE(v.ribbon_dif::INTEGER, 0)) ELSE 0 END) AS ribbon_descontar ") // Adiciona a nova lógica para a coluna ribbon
                .append("FROM vendas v ")
                .append("INNER JOIN model_login l ON v.vendedor_id = l.id ")
                .append("WHERE 1=1 ");

        if (funcionarioId != null && !funcionarioId.isEmpty()) {
            sql.append(" AND l.id = ?");
        }

        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }

        sql.append(" GROUP BY l.nome, l.status ")
                .append(" ORDER BY l.status = 'Ativo' DESC ")
                .append(" LIMIT ? OFFSET ?");


        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;

            if (funcionarioId != null && !funcionarioId.isEmpty()) {
                preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            }

            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            preparedSql.setInt(index++, limit);
            preparedSql.setInt(index++, offset);


            try (ResultSet resultado = preparedSql.executeQuery()) {
                while (resultado.next()) {
                    ModelVendas modelVendaFuncionario = new ModelVendas();

                    modelVendaFuncionario.setNome(resultado.getString("nome"));
                    modelVendaFuncionario.setFt_total(resultado.getInt("foto_total"));
                    modelVendaFuncionario.setEnc_total(resultado.getInt("encarte_total"));
                    modelVendaFuncionario.setDig_total(resultado.getInt("digital_total"));
                    modelVendaFuncionario.setSobras(resultado.getInt("sobras_total"));

                    // Adiciona o valor da soma de ribbon
                    modelVendaFuncionario.setRibbon_descontar(resultado.getInt("ribbon_descontar"));


                    modelVendasFuncionarioList.add(modelVendaFuncionario);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar vendas: " + e.getMessage());
        }

        return modelVendasFuncionarioList;
    }




    public int contarVendasFuncionario(String funcionarioId, String dataInicial, String dataFinal) throws Exception {
        int totalResultados = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM (")
                .append("SELECT l.nome ")
                .append("FROM vendas v ")
                .append("INNER JOIN model_login l ON v.vendedor_id = l.id ")
                .append("WHERE l.status = 'Ativo' ");

        if (funcionarioId != null && !funcionarioId.isEmpty()) {
            sql.append(" AND l.id = ?");
        }

        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }

        sql.append(" GROUP BY l.nome) AS subquery"); // Agrupando por nome

        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;

            if (funcionarioId != null && !funcionarioId.isEmpty()) {
                preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            }

            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            ResultSet resultado = preparedSql.executeQuery();
            if (resultado.next()) {
                totalResultados = resultado.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao contar vendas: " + e.getMessage());
        }

        return totalResultados;
    }



    public void gravarSalarios(ModelSalarios model) throws Exception {
        String sql = "INSERT INTO salarios (" +
                "mes, ano, funcionario_id, nome_funcionario, qtd_fotos, qtd_arquivos, qtd_sobras, " +
                "atrasos, faltas, advertencias, suspensoes, dsr, valor_atrasos, valor_faltas, " +
                "valor_suspensoes, vales, inss, fgts, venda_total, comissao, salario_total, salario_liquido1, " +
                "comissao2, salario_total2, salario_liquido2, aproveitamento, descontos_mes, descontos_1, descontos_2, parcela, " +
                "tipo_comissao, adc_noturno, bonificacoes) " + // <<< NOVAS COLUNAS ADICIONADAS
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // <<< NOVOS PLACEHOLDERS (33)

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, model.getMes());
            stmt.setInt(2, model.getAno());
            stmt.setLong(3, model.getFuncionarioId());
            stmt.setString(4, model.getNomeFuncionario());
            stmt.setInt(5, model.getQtdFotos());
            stmt.setInt(6, model.getQtdArquivos());
            stmt.setInt(7, model.getQtdSobras());
            stmt.setDouble(8, model.getAtrasos());
            stmt.setInt(9, model.getFaltas());
            stmt.setInt(10, model.getAdvertencias());
            stmt.setInt(11, model.getSuspensoes());
            stmt.setInt(12, model.getDsr());
            stmt.setBigDecimal(13, model.getValorAtrasos());
            stmt.setBigDecimal(14, model.getValorFaltas());
            stmt.setBigDecimal(15, model.getValorSuspensoes());
            stmt.setBigDecimal(16, model.getVales());
            stmt.setBigDecimal(17, model.getInss());
            stmt.setBigDecimal(18, model.getFgts());
            stmt.setBigDecimal(19, model.getVenda_total());
            stmt.setBigDecimal(20, model.getComissao());
            stmt.setBigDecimal(21, model.getSalario_total());
            stmt.setBigDecimal(22, model.getSalario_liquido1());
            stmt.setBigDecimal(23, model.getComissao2());
            stmt.setBigDecimal(24, model.getSalario_total2());
            stmt.setBigDecimal(25, model.getSalario_liquido2());
            stmt.setBigDecimal(26, model.getAproveitamento());
            stmt.setBigDecimal(27, model.getDescontos_mes());
            stmt.setBigDecimal(28, model.getDescontos_1());
            stmt.setBigDecimal(29, model.getDescontos_2());
            stmt.setBigDecimal(30, model.getParcela());
            stmt.setString(31, model.getTipoComissao());

            // <<< NOVOS SETTERS >>>
            stmt.setBigDecimal(32, model.getAdcNoturno());
            stmt.setBigDecimal(33, model.getBonificacoes());

            stmt.execute();
            connection.commit();
        } catch (Exception e) {
            connection.rollback();
            throw new Exception("Erro ao gravar salários: " + e.getMessage(), e);
        }
    }



    public List<ModelSalarios> buscarSalariosPorMesAnoFuncionario(int mes, int ano, long funcionarioId) throws Exception {
        List<ModelSalarios> lista = new ArrayList<>();
        String sql = "SELECT * FROM salarios WHERE mes = ? AND ano = ? AND funcionario_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, mes);
            stmt.setInt(2, ano);
            stmt.setLong(3, funcionarioId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ModelSalarios salario = new ModelSalarios();
                salario.setIdSalario(rs.getInt("id_salario"));
                salario.setMes(rs.getInt("mes"));
                salario.setAno(rs.getInt("ano"));
                salario.setFuncionarioId(rs.getLong("funcionario_id"));
                salario.setNomeFuncionario(rs.getString("nome_funcionario"));

                salario.setQtdFotos(rs.getInt("qtd_fotos"));
                salario.setQtdArquivos(rs.getInt("qtd_arquivos"));
                salario.setQtdSobras(rs.getInt("qtd_sobras"));


                salario.setAtrasos(rs.getDouble("atrasos"));
                salario.setFaltas(rs.getInt("faltas"));
                salario.setAdvertencias(rs.getInt("advertencias"));
                salario.setSuspensoes(rs.getInt("suspensoes"));
                salario.setDsr(rs.getInt("dsr"));

                salario.setValorAtrasos(rs.getBigDecimal("valor_atrasos"));
                salario.setValorFaltas(rs.getBigDecimal("valor_faltas"));
                salario.setValorSuspensoes(rs.getBigDecimal("valor_suspensoes"));

                salario.setVales(rs.getBigDecimal("vales"));
                salario.setInss(rs.getBigDecimal("inss"));
                salario.setParcela(rs.getBigDecimal("parcela"));
                salario.setFgts(rs.getBigDecimal("fgts"));

                salario.setVenda_total(rs.getBigDecimal("venda_total"));
                salario.setComissao(rs.getBigDecimal("comissao"));
                salario.setSalario_total(rs.getBigDecimal("salario_total"));
                salario.setSalario_liquido1(rs.getBigDecimal("salario_liquido1"));

                salario.setComissao2(rs.getBigDecimal("comissao2"));
                salario.setSalario_total2(rs.getBigDecimal("salario_total2"));
                salario.setSalario_liquido2(rs.getBigDecimal("salario_liquido2"));

                salario.setAproveitamento(rs.getBigDecimal("aproveitamento"));
                salario.setDescontos_mes(rs.getBigDecimal("descontos_mes"));
                salario.setDescontos_1(rs.getBigDecimal("descontos_1"));
                salario.setDescontos_2(rs.getBigDecimal("descontos_2"));
                salario.setTipoComissao(rs.getString("tipo_comissao"));

                // <<< NOVOS GETTERS >>>
                salario.setAdcNoturno(rs.getBigDecimal("adc_noturno"));
                salario.setBonificacoes(rs.getBigDecimal("bonificacoes"));


                lista.add(salario);
            }
        } catch (Exception e) {
            throw new Exception("Erro ao consultar salários: " + e.getMessage(), e);
        }
        return lista;
    }


    public void atualizarSalario(ModelSalarios model) throws Exception {
        String sql = "UPDATE salarios SET " +
                "qtd_fotos = ?, " +
                "qtd_arquivos = ?, " +
                "qtd_sobras = ?, " +
                "aproveitamento = ?, " +
                "advertencias = ?, " +
                "faltas = ?, " +
                "suspensoes = ?, " +
                "dsr = ?, " +
                "atrasos = ?, " +
                "valor_faltas = ?, " +
                "valor_suspensoes = ?, " +
                "valor_atrasos = ?, " +
                "venda_total = ?, " +
                "vales = ?, " +
                "inss = ?, " +
                "parcela = ?, " +
                "fgts = ?, " +
                "descontos_mes = ?, " +
                "comissao = ?, " +
                "salario_total = ?, " +
                "descontos_1 = ?, " +
                "salario_liquido1 = ?, " +
                "comissao2 = ?, " +
                "salario_total2 = ?, " +
                "descontos_2 = ?, " +
                "salario_liquido2 = ?, " +
                "tipo_comissao = ?, " +
                "adc_noturno = ?, " + // <<< NOVA COLUNA ADICIONADA
                "bonificacoes = ? " + // <<< NOVA COLUNA ADICIONADA
                "WHERE id_salario = ?";

        try {
            if (connection == null) {
                throw new Exception("Connection é null!");
            }
            if (connection.isClosed()) {
                throw new Exception("Connection está fechada!");
            }

            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                int i = 1;

                // Vendas (1-4)
                stmt.setInt(i++, model.getQtdFotos());
                stmt.setInt(i++, model.getQtdArquivos());
                stmt.setInt(i++, model.getQtdSobras());
                stmt.setBigDecimal(i++, model.getAproveitamento());

                // Conduta (5-9)
                stmt.setInt(i++, model.getAdvertencias());
                stmt.setInt(i++, model.getFaltas());
                stmt.setInt(i++, model.getSuspensoes());
                stmt.setInt(i++, model.getDsr());
                stmt.setDouble(i++, model.getAtrasos());

                // Valores de descontos (10-12)
                stmt.setBigDecimal(i++, model.getValorFaltas());
                stmt.setBigDecimal(i++, model.getValorSuspensoes());
                stmt.setBigDecimal(i++, model.getValorAtrasos());

                // Salários e benefícios (13-18)
                stmt.setBigDecimal(i++, model.getVenda_total());
                stmt.setBigDecimal(i++, model.getVales());
                stmt.setBigDecimal(i++, model.getInss());
                stmt.setBigDecimal(i++, model.getParcela());
                stmt.setBigDecimal(i++, model.getFgts());
                stmt.setBigDecimal(i++, model.getDescontos_mes());

                // Primeira linha de salário (19-22)
                stmt.setBigDecimal(i++, model.getComissao());
                stmt.setBigDecimal(i++, model.getSalario_total());
                stmt.setBigDecimal(i++, model.getDescontos_1());
                stmt.setBigDecimal(i++, model.getSalario_liquido1());

                // Segunda linha de salário (23-26)
                stmt.setBigDecimal(i++, model.getComissao2());
                stmt.setBigDecimal(i++, model.getSalario_total2());
                stmt.setBigDecimal(i++, model.getDescontos_2());
                stmt.setBigDecimal(i++, model.getSalario_liquido2());

                // Tipo Comissão (27)
                stmt.setString(i++, model.getTipoComissao());

                // <<< NOVOS SETTERS >>>
                stmt.setBigDecimal(i++, model.getAdcNoturno()); // (28)
                stmt.setBigDecimal(i++, model.getBonificacoes()); // (29)

                // WHERE (30)
                stmt.setInt(i++, model.getIdSalario());


                int rowsAffected = stmt.executeUpdate();


                if (rowsAffected == 0) {
                    // ... (lógica de verificação de ID) ...
                    String selectSql = "SELECT COUNT(*) FROM salarios WHERE id_salario = ?";
                    try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
                        selectStmt.setInt(1, model.getIdSalario());
                        try (ResultSet rs = selectStmt.executeQuery()) {
                            rs.next();
                            // int count = rs.getInt(1);
                        }
                    }
                    throw new Exception("Nenhum registro foi atualizado. ID não encontrado: " + model.getIdSalario());
                }

            }
        } catch (SQLException e) {
            System.out.println("Erro SQL: " + e.getMessage());
            e.printStackTrace();

            // ROLLBACK em caso de erro
            try {
                if (!connection.getAutoCommit()) {
                    connection.rollback();
                    System.out.println("Rollback realizado!");
                }
            } catch (SQLException rollbackException) {
                System.out.println("Erro no rollback: " + rollbackException.getMessage());
                rollbackException.printStackTrace();
            }
            throw new Exception("Erro ao atualizar salário no banco de dados: " + e.getMessage(), e);
        }
    }



    public List<ModelLogin> buscaFuncionarios() throws Exception {
        List<ModelLogin> funcionarios = new ArrayList<>();

        String sql = "SELECT id, nome, status FROM model_login ORDER BY  status = 'Ativo' DESC";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultado = preparedSql.executeQuery()) {

            while (resultado.next()) {
                ModelLogin funcionario = new ModelLogin();
                funcionario.setId(resultado.getLong("id")); // Supondo que você tenha um método setId em ModelLogin
                funcionario.setNome(resultado.getString("nome")); // Supondo que você tenha um método setNome em ModelLogin
                funcionario.setStatus(resultado.getString("status")); // Supondo que você tenha um método setStatus
                funcionarios.add(funcionario);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Logar o erro
            throw new Exception("Erro ao buscar funcionários : " + e.getMessage());
        }
        return funcionarios;
    }

    public String buscarComissaoFuncionario(Long funcionarioId) throws Exception {
        String sql = "SELECT comissao FROM model_login WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, funcionarioId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("comissao"); // Retorna "COMISSÃO 1" ou "COMISSÃO 2"
            }
        } catch (Exception e) {
            throw new Exception("Erro ao buscar comissão do funcionário: " + e.getMessage(), e);
        }
        return null;
    }


    public boolean verificarSalarioExistente(int mes, int ano, long funcionarioId) throws Exception {
        String sql = "SELECT COUNT(*) FROM salarios WHERE mes = ? AND ano = ? AND funcionario_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, mes);
            stmt.setInt(2, ano);
            stmt.setLong(3, funcionarioId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            throw new Exception("Erro ao verificar salário existente: " + e.getMessage(), e);
        }
        return false;
    }
}