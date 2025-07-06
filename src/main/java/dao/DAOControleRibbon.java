package dao;

import connection.SingleConnectionBanco;
import model.ModelControleRibbon;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOControleRibbon {

    private final Connection connection;

    public DAOControleRibbon()  {
        connection = SingleConnectionBanco.getConnection();
    }

    // Buscar o último controle registrado
    public ModelControleRibbon buscarUltimoControle() throws SQLException {
        String sql = "SELECT * FROM controle_ribbon ORDER BY data_ribbon DESC LIMIT 1";

        try (PreparedStatement pst = connection.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {


            if (rs.next()) {

                ModelControleRibbon controle = montarControleRibbon(rs);

                return controle;
            } else {

            }
        } catch (SQLException e) {
            System.err.println("Erro ao executar a consulta: " + e.getMessage());
            throw e; // Relança a exceção para ser tratada pelo chamador
        }
        return null;
    }

    // Buscar os valores dos ribbons atuais
    public List<BigDecimal> buscarRibbonAtual() throws SQLException {
        List<BigDecimal> ribbonValues = new ArrayList<>();

        String sql = "SELECT ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, ribbon_4_atual, ribbon_5_atual, ribbon_6_atual,troca_ribbon_1,troca_ribbon_2,troca_ribbon_3,troca_ribbon_4,troca_ribbon_5,troca_ribbon_6,fim_ribbon_1,fim_ribbon_2,fim_ribbon_3,fim_ribbon_4,fim_ribbon_5,fim_ribbon_6 FROM controle_ribbon ORDER BY data_ribbon DESC LIMIT 1";

        try (PreparedStatement pst = connection.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                // Adiciona os valores dos ribbons atuais na lista
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("ribbon_1_atual")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("ribbon_2_atual")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("ribbon_3_atual")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("ribbon_4_atual")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("ribbon_5_atual")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("ribbon_6_atual")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("troca_ribbon_1")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("troca_ribbon_2")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("troca_ribbon_3")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("troca_ribbon_4")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("troca_ribbon_5")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("troca_ribbon_6")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("fim_ribbon_1")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("fim_ribbon_2")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("fim_ribbon_3")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("fim_ribbon_4")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("fim_ribbon_5")));
                ribbonValues.add(BigDecimal.valueOf(rs.getDouble("fim_ribbon_6")));

            }

        } catch (SQLException e) {
            System.err.println("Erro ao executar a consulta: " + e.getMessage());
            throw e; // Relança a exceção para ser tratada pelo chamador
        }

        return ribbonValues;
    }



    public void atualizarControle(ModelControleRibbon controle) throws SQLException {
        String sql = "UPDATE controle_ribbon SET " +
                "data_ribbon = ?, ribbon_1_atual = ?, ribbon_2_atual = ?, ribbon_3_atual = ?, ribbon_4_atual = ?, " +
                "ribbon_5_atual = ?, ribbon_6_atual = ?, rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, " +
                "rev_ribbon_4 = ?, rev_ribbon_5 = ?, rev_ribbon_6 = ?, dif_ribbon_1 = ?, dif_ribbon_2 = ?, " +
                "dif_ribbon_3 = ?, dif_ribbon_4 = ?, dif_ribbon_5 = ?, dif_ribbon_6 = ?, troca_ribbon_1 = ?, " +
                "troca_ribbon_2 = ?, troca_ribbon_3 = ?, troca_ribbon_4 = ?, troca_ribbon_5 = ?, troca_ribbon_6 = ?, " +
                "fim_ribbon_1 = ?, fim_ribbon_2 = ?, fim_ribbon_3 = ?, fim_ribbon_4 = ?, fim_ribbon_5 = ?, fim_ribbon_6 = ?, " +
                "old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, old_ribbon_4 = ?, old_ribbon_5 = ?, old_ribbon_6 = ?, " +
                "observacao_ribbon = ? WHERE id_controle = ?";
        try (PreparedStatement pstUpdate = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false); // Desabilita o auto-commit
            setParametrosAtualizacao(pstUpdate, controle);
            pstUpdate.setLong(39, controle.getIdControle()); // Índice ajustado

            // Executa a atualização
            pstUpdate.executeUpdate();

            // Realiza o commit manual
            connection.commit(); // Confirma a transação
        } catch (SQLException e) {
            // Caso haja erro, faz o rollback para reverter as alterações
            connection.rollback();
            throw e;
        }
    }


    private void setParametrosAtualizacao(PreparedStatement pstUpdate, ModelControleRibbon controle) throws SQLException {
        pstUpdate.setDate(1, controle.getData_ribbon());
        pstUpdate.setInt(2, controle.getRibbon_1_atual());
        pstUpdate.setInt(3, controle.getRibbon_2_atual());
        pstUpdate.setInt(4, controle.getRibbon_3_atual());
        pstUpdate.setInt(5, controle.getRibbon_4_atual());
        pstUpdate.setInt(6, controle.getRibbon_5_atual());
        pstUpdate.setInt(7, controle.getRibbon_6_atual());
        pstUpdate.setInt(8, controle.getRev_ribbon_1());
        pstUpdate.setInt(9, controle.getRev_ribbon_2());
        pstUpdate.setInt(10, controle.getRev_ribbon_3());
        pstUpdate.setInt(11, controle.getRev_ribbon_4());
        pstUpdate.setInt(12, controle.getRev_ribbon_5());
        pstUpdate.setInt(13, controle.getRev_ribbon_6());
        pstUpdate.setInt(14, controle.getDif_ribbon_1());
        pstUpdate.setInt(15, controle.getDif_ribbon_2());
        pstUpdate.setInt(16, controle.getDif_ribbon_3());
        pstUpdate.setInt(17, controle.getDif_ribbon_4());
        pstUpdate.setInt(18, controle.getDif_ribbon_5());
        pstUpdate.setInt(19, controle.getDif_ribbon_6());
        pstUpdate.setInt(20, controle.getTroca_ribbon_1());
        pstUpdate.setInt(21, controle.getTroca_ribbon_2());
        pstUpdate.setInt(22, controle.getTroca_ribbon_3());
        pstUpdate.setInt(23, controle.getTroca_ribbon_4());
        pstUpdate.setInt(24, controle.getTroca_ribbon_5());
        pstUpdate.setInt(25, controle.getTroca_ribbon_6());
        pstUpdate.setInt(26, controle.getFim_ribbon_1());
        pstUpdate.setInt(27, controle.getFim_ribbon_2());
        pstUpdate.setInt(28, controle.getFim_ribbon_3());
        pstUpdate.setInt(29, controle.getFim_ribbon_4());
        pstUpdate.setInt(30, controle.getFim_ribbon_5());
        pstUpdate.setInt(31, controle.getFim_ribbon_6());
        pstUpdate.setInt(32, controle.getOld_ribbon_1());
        pstUpdate.setInt(33, controle.getOld_ribbon_2());
        pstUpdate.setInt(34, controle.getOld_ribbon_3());
        pstUpdate.setInt(35, controle.getOld_ribbon_4());
        pstUpdate.setInt(36, controle.getOld_ribbon_5());
        pstUpdate.setInt(37, controle.getOld_ribbon_6());
        pstUpdate.setString(38, controle.getObservacao_ribbon());
    }


    public long buscarUltimoIdControle() throws SQLException {
        String sql = "SELECT id_controle FROM controle_ribbon ORDER BY id_controle DESC LIMIT 1";
        try (PreparedStatement pst = connection.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                return rs.getLong("id_controle");
            }

        }
        throw new SQLException("Nenhum registro encontrado na tabela controle_ribbon.");
    }


    public void gravarTrocaRibbon(ModelControleRibbon controle) throws SQLException {
        StringBuilder sql = new StringBuilder("UPDATE controle_ribbon SET ");
        int paramIndex = 1; // Variável para controlar o índice dos parâmetros

        // Atualiza apenas o ribbon selecionado
        if (controle.getTroca_ribbon_1() != 0) {
            sql.append("troca_ribbon_1 = ?, fim_ribbon_1 = ?, ");
        }
        if (controle.getTroca_ribbon_2() != 0) {
            sql.append("troca_ribbon_2 = ?, fim_ribbon_2 = ?, ");
        }
        if (controle.getTroca_ribbon_3() != 0) {
            sql.append("troca_ribbon_3 = ?, fim_ribbon_3 = ?, ");
        }
        if (controle.getTroca_ribbon_4() != 0) {
            sql.append("troca_ribbon_4 = ?, fim_ribbon_4 = ?, ");
        }
        if (controle.getTroca_ribbon_5() != 0) {
            sql.append("troca_ribbon_5 = ?, fim_ribbon_5 = ?, ");
        }
        if (controle.getTroca_ribbon_6() != 0) {
            sql.append("troca_ribbon_6 = ?, fim_ribbon_6 = ?, ");
        }

        // Remove a vírgula extra no final da string
        sql.setLength(sql.length() - 2); // Remove a última vírgula

        sql.append(" WHERE id_controle = ?"); // Restringe ao ID específico

        try {
            connection.setAutoCommit(false);

            try (PreparedStatement pst = connection.prepareStatement(sql.toString())) {
                // Preenche os parâmetros dinamicamente
                if (controle.getTroca_ribbon_1() != 0) {
                    pst.setInt(paramIndex++, controle.getTroca_ribbon_1());
                    pst.setInt(paramIndex++, controle.getFim_ribbon_1());
                }
                if (controle.getTroca_ribbon_2() != 0) {
                    pst.setInt(paramIndex++, controle.getTroca_ribbon_2());
                    pst.setInt(paramIndex++, controle.getFim_ribbon_2());
                }
                if (controle.getTroca_ribbon_3() != 0) {
                    pst.setInt(paramIndex++, controle.getTroca_ribbon_3());
                    pst.setInt(paramIndex++, controle.getFim_ribbon_3());
                }
                if (controle.getTroca_ribbon_4() != 0) {
                    pst.setInt(paramIndex++, controle.getTroca_ribbon_4());
                    pst.setInt(paramIndex++, controle.getFim_ribbon_4());
                }
                if (controle.getTroca_ribbon_5() != 0) {
                    pst.setInt(paramIndex++, controle.getTroca_ribbon_5());
                    pst.setInt(paramIndex++, controle.getFim_ribbon_5());
                }
                if (controle.getTroca_ribbon_6() != 0) {
                    pst.setInt(paramIndex++, controle.getTroca_ribbon_6());
                    pst.setInt(paramIndex++, controle.getFim_ribbon_6());
                }

                // Define o ID do controle para a atualização
                pst.setLong(paramIndex, controle.getIdControle());

                int rowsUpdated = pst.executeUpdate();
                if (rowsUpdated == 0) {
                    throw new SQLException("Nenhum registro foi atualizado. Verifique o ID do controle.");
                }
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }





    // Buscar controle com base em um intervalo de datas
    public List<ModelControleRibbon> buscarPorIntervalo(Date dataInicial, Date dataFinal) throws SQLException {
        List<ModelControleRibbon> controles = new ArrayList<>();
        String sql = "SELECT * FROM controle_ribbon WHERE data_ribbon BETWEEN ? AND ? ORDER BY data_ribbon DESC";
        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setDate(1, dataInicial);
            pst.setDate(2, dataFinal);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    controles.add(montarControleRibbon(rs));
                }
            }
        }
        return controles;
    }




    private ModelControleRibbon montarControleRibbon(ResultSet rs) throws SQLException {
        ModelControleRibbon controle = new ModelControleRibbon();
        controle.setIdControle(rs.getLong("id_controle"));
        controle.setData_ribbon(rs.getDate("data_ribbon"));
        controle.setRibbon_1_atual(rs.getInt("ribbon_1_atual"));
        controle.setRibbon_2_atual(rs.getInt("ribbon_2_atual"));
        controle.setRibbon_3_atual(rs.getInt("ribbon_3_atual"));
        controle.setRibbon_4_atual(rs.getInt("ribbon_4_atual"));
        controle.setRibbon_5_atual(rs.getInt("ribbon_5_atual"));
        controle.setRibbon_6_atual(rs.getInt("ribbon_6_atual"));
        controle.setRev_ribbon_1(rs.getInt("rev_ribbon_1"));
        controle.setRev_ribbon_2(rs.getInt("rev_ribbon_2"));
        controle.setRev_ribbon_3(rs.getInt("rev_ribbon_3"));
        controle.setRev_ribbon_4(rs.getInt("rev_ribbon_4"));
        controle.setRev_ribbon_5(rs.getInt("rev_ribbon_5"));
        controle.setRev_ribbon_6(rs.getInt("rev_ribbon_6"));
        controle.setDif_ribbon_1(rs.getInt("dif_ribbon_1"));
        controle.setDif_ribbon_2(rs.getInt("dif_ribbon_2"));
        controle.setDif_ribbon_3(rs.getInt("dif_ribbon_3"));
        controle.setDif_ribbon_4(rs.getInt("dif_ribbon_4"));
        controle.setDif_ribbon_5(rs.getInt("dif_ribbon_5"));
        controle.setDif_ribbon_6(rs.getInt("dif_ribbon_6"));
        controle.setTroca_ribbon_1(rs.getInt("troca_ribbon_1"));
        controle.setTroca_ribbon_2(rs.getInt("troca_ribbon_2"));
        controle.setTroca_ribbon_3(rs.getInt("troca_ribbon_3"));
        controle.setTroca_ribbon_4(rs.getInt("troca_ribbon_4"));
        controle.setTroca_ribbon_5(rs.getInt("troca_ribbon_5"));
        controle.setTroca_ribbon_6(rs.getInt("troca_ribbon_6"));
        controle.setFim_ribbon_1(rs.getInt("fim_ribbon_1"));
        controle.setFim_ribbon_2(rs.getInt("fim_ribbon_2"));
        controle.setFim_ribbon_3(rs.getInt("fim_ribbon_3"));
        controle.setFim_ribbon_4(rs.getInt("fim_ribbon_4"));
        controle.setFim_ribbon_5(rs.getInt("fim_ribbon_5"));
        controle.setFim_ribbon_6(rs.getInt("fim_ribbon_6"));
        controle.setObservacao_ribbon(rs.getString("observacao_ribbon"));
        // Adicionando os campos old_ribbon
        controle.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
        controle.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
        controle.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
        controle.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
        controle.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
        controle.setOld_ribbon_6(rs.getInt("old_ribbon_6"));
        return controle;
    }



    public List<ModelControleRibbon> listarControles(String dataInicial, String dataFinal, int offset, int limit) throws Exception {
        List<ModelControleRibbon> modelControleRibbonList = new ArrayList<>();

        // Constrói a consulta SQL base
        StringBuilder sql = new StringBuilder("SELECT * FROM controle_ribbon WHERE 1=1");

        // Adiciona as condições de data, se fornecidas
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND data_ribbon BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }

        // Adiciona paginação
        sql.append(" LIMIT ? OFFSET ?");

        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;

            // Define os parâmetros de data, se necessário
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            // Define o limit e offset para a paginação
            preparedSql.setInt(index++, limit);   // Número máximo de registros por página (ex: 10)
            preparedSql.setInt(index++, offset);  // Posição inicial (baseada na página)

            // Executa a consulta
            ResultSet rs = preparedSql.executeQuery();

            // Processa os resultados
            while (rs.next()) {
                ModelControleRibbon controles = new ModelControleRibbon();
                controles.setIdControle(rs.getLong("id_controle"));
                controles.setData_ribbon(rs.getDate("data_ribbon"));

                controles.setRibbon_1_atual(rs.getInt("ribbon_1_atual"));
                controles.setRibbon_2_atual(rs.getInt("ribbon_2_atual"));
                controles.setRibbon_3_atual(rs.getInt("ribbon_3_atual"));
                controles.setRibbon_4_atual(rs.getInt("ribbon_4_atual"));
                controles.setRibbon_5_atual(rs.getInt("ribbon_5_atual"));
                controles.setRibbon_6_atual(rs.getInt("ribbon_6_atual"));

                controles.setRev_ribbon_1(rs.getInt("rev_ribbon_1"));
                controles.setRev_ribbon_2(rs.getInt("rev_ribbon_2"));
                controles.setRev_ribbon_3(rs.getInt("rev_ribbon_3"));
                controles.setRev_ribbon_4(rs.getInt("rev_ribbon_4"));
                controles.setRev_ribbon_5(rs.getInt("rev_ribbon_5"));
                controles.setRev_ribbon_6(rs.getInt("rev_ribbon_6"));

                controles.setDif_ribbon_1(rs.getInt("dif_ribbon_1"));
                controles.setDif_ribbon_2(rs.getInt("dif_ribbon_2"));
                controles.setDif_ribbon_3(rs.getInt("dif_ribbon_3"));
                controles.setDif_ribbon_4(rs.getInt("dif_ribbon_4"));
                controles.setDif_ribbon_5(rs.getInt("dif_ribbon_5"));
                controles.setDif_ribbon_6(rs.getInt("dif_ribbon_6"));

                controles.setTroca_ribbon_1(rs.getInt("troca_ribbon_1"));
                controles.setTroca_ribbon_2(rs.getInt("troca_ribbon_2"));
                controles.setTroca_ribbon_3(rs.getInt("troca_ribbon_3"));
                controles.setTroca_ribbon_4(rs.getInt("troca_ribbon_4"));
                controles.setTroca_ribbon_5(rs.getInt("troca_ribbon_5"));
                controles.setTroca_ribbon_6(rs.getInt("troca_ribbon_6"));

                controles.setFim_ribbon_1(rs.getInt("fim_ribbon_1"));
                controles.setFim_ribbon_2(rs.getInt("fim_ribbon_2"));
                controles.setFim_ribbon_3(rs.getInt("fim_ribbon_3"));
                controles.setFim_ribbon_4(rs.getInt("fim_ribbon_4"));
                controles.setFim_ribbon_5(rs.getInt("fim_ribbon_5"));
                controles.setFim_ribbon_6(rs.getInt("fim_ribbon_6"));

                controles.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
                controles.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
                controles.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
                controles.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
                controles.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
                controles.setOld_ribbon_6(rs.getInt("old_ribbon_6"));

                controles.setObservacao_ribbon(rs.getString("observacao_ribbon"));

                modelControleRibbonList.add(controles);

            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar controle_ribbon: " + e.getMessage());
        }

        return modelControleRibbonList;
    }



    public List<ModelControleRibbon> listarRibbon(int pagina, int tamanho) throws SQLException {

        List<ModelControleRibbon> controle = new ArrayList<>();
        String sql = "SELECT * FROM controle_ribbon ORDER BY data_ribbon DESC LIMIT ? OFFSET ?";
        int offset = (pagina - 1) * tamanho;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tamanho);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelControleRibbon controles = new ModelControleRibbon();
                controles.setIdControle(rs.getLong("id_controle"));
                controles.setData_ribbon(rs.getDate("data_ribbon"));

                controles.setRibbon_1_atual(rs.getInt("ribbon_1_atual"));
                controles.setRibbon_2_atual(rs.getInt("ribbon_2_atual"));
                controles.setRibbon_3_atual(rs.getInt("ribbon_3_atual"));
                controles.setRibbon_4_atual(rs.getInt("ribbon_4_atual"));
                controles.setRibbon_5_atual(rs.getInt("ribbon_5_atual"));
                controles.setRibbon_6_atual(rs.getInt("ribbon_6_atual"));

                controles.setRev_ribbon_1(rs.getInt("rev_ribbon_1"));
                controles.setRev_ribbon_2(rs.getInt("rev_ribbon_2"));
                controles.setRev_ribbon_3(rs.getInt("rev_ribbon_3"));
                controles.setRev_ribbon_4(rs.getInt("rev_ribbon_4"));
                controles.setRev_ribbon_5(rs.getInt("rev_ribbon_5"));
                controles.setRev_ribbon_6(rs.getInt("rev_ribbon_6"));

                controles.setDif_ribbon_1(rs.getInt("dif_ribbon_1"));
                controles.setDif_ribbon_2(rs.getInt("dif_ribbon_2"));
                controles.setDif_ribbon_3(rs.getInt("dif_ribbon_3"));
                controles.setDif_ribbon_4(rs.getInt("dif_ribbon_4"));
                controles.setDif_ribbon_5(rs.getInt("dif_ribbon_5"));
                controles.setDif_ribbon_6(rs.getInt("dif_ribbon_6"));

                controles.setTroca_ribbon_1(rs.getInt("troca_ribbon_1"));
                controles.setTroca_ribbon_2(rs.getInt("troca_ribbon_2"));
                controles.setTroca_ribbon_3(rs.getInt("troca_ribbon_3"));
                controles.setTroca_ribbon_4(rs.getInt("troca_ribbon_4"));
                controles.setTroca_ribbon_5(rs.getInt("troca_ribbon_5"));
                controles.setTroca_ribbon_6(rs.getInt("troca_ribbon_6"));

                controles.setFim_ribbon_1(rs.getInt("fim_ribbon_1"));
                controles.setFim_ribbon_2(rs.getInt("fim_ribbon_2"));
                controles.setFim_ribbon_3(rs.getInt("fim_ribbon_3"));
                controles.setFim_ribbon_4(rs.getInt("fim_ribbon_4"));
                controles.setFim_ribbon_5(rs.getInt("fim_ribbon_5"));
                controles.setFim_ribbon_6(rs.getInt("fim_ribbon_6"));

                controles.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
                controles.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
                controles.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
                controles.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
                controles.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
                controles.setOld_ribbon_6(rs.getInt("old_ribbon_6"));

                controles.setObservacao_ribbon(rs.getString("observacao_ribbon"));
                controle.add(controles);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar controle: " + e.getMessage());
            throw e; // Repropaga a exceção
        }
        return controle;
    }


    public int contarControle( String dataInicial, String dataFinal) throws Exception {
        int totalRegistros = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM controle_ribbon v ")

                .append("WHERE 1=1 "); // Usando 1=1 para facilitar a adição de condições



        // Adiciona as condições de data, se fornecidas
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }

        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;



            // Define os parâmetros de data, se necessário
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            ResultSet resultado = preparedSql.executeQuery();
            if (resultado.next()) {
                totalRegistros = resultado.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao contar Controle: " + e.getMessage());
        }
        return totalRegistros;
    }


    private ModelControleRibbon mapearControle(ResultSet resultSet) throws Exception {
        ModelControleRibbon controle = new ModelControleRibbon();

        controle.setIdControle(resultSet.getLong("id_controle"));
        controle.setData_ribbon(resultSet.getDate("data_ribbon"));

        controle.setRibbon_1_atual(resultSet.getInt("ribbon_1_atual"));
        controle.setRibbon_2_atual(resultSet.getInt("ribbon_2_atual"));
        controle.setRibbon_3_atual(resultSet.getInt("ribbon_3_atual"));
        controle.setRibbon_4_atual(resultSet.getInt("ribbon_4_atual"));
        controle.setRibbon_5_atual(resultSet.getInt("ribbon_5_atual"));
        controle.setRibbon_6_atual(resultSet.getInt("ribbon_6_atual"));

        controle.setRev_ribbon_1(resultSet.getInt("rev_ribbon_1"));
        controle.setRev_ribbon_2(resultSet.getInt("rev_ribbon_2"));
        controle.setRev_ribbon_3(resultSet.getInt("rev_ribbon_3"));
        controle.setRev_ribbon_4(resultSet.getInt("rev_ribbon_4"));
        controle.setRev_ribbon_5(resultSet.getInt("rev_ribbon_5"));
        controle.setRev_ribbon_6(resultSet.getInt("rev_ribbon_6"));

        controle.setDif_ribbon_1(resultSet.getInt("dif_ribbon_1"));
        controle.setDif_ribbon_2(resultSet.getInt("dif_ribbon_2"));
        controle.setDif_ribbon_3(resultSet.getInt("dif_ribbon_3"));
        controle.setDif_ribbon_4(resultSet.getInt("dif_ribbon_4"));
        controle.setDif_ribbon_5(resultSet.getInt("dif_ribbon_5"));
        controle.setDif_ribbon_6(resultSet.getInt("dif_ribbon_6"));

        controle.setTroca_ribbon_1(resultSet.getInt("troca_ribbon_1"));
        controle.setTroca_ribbon_2(resultSet.getInt("troca_ribbon_2"));
        controle.setTroca_ribbon_3(resultSet.getInt("troca_ribbon_3"));
        controle.setTroca_ribbon_4(resultSet.getInt("troca_ribbon_4"));
        controle.setTroca_ribbon_5(resultSet.getInt("troca_ribbon_5"));
        controle.setTroca_ribbon_6(resultSet.getInt("troca_ribbon_6"));

        controle.setFim_ribbon_1(resultSet.getInt("fim_ribbon_1"));
        controle.setFim_ribbon_2(resultSet.getInt("fim_ribbon_2"));
        controle.setFim_ribbon_3(resultSet.getInt("fim_ribbon_3"));
        controle.setFim_ribbon_4(resultSet.getInt("fim_ribbon_4"));
        controle.setFim_ribbon_5(resultSet.getInt("fim_ribbon_5"));
        controle.setFim_ribbon_6(resultSet.getInt("fim_ribbon_6"));

        controle.setOld_ribbon_1(resultSet.getInt("old_ribbon_1"));
        controle.setOld_ribbon_2(resultSet.getInt("old_ribbon_2"));
        controle.setOld_ribbon_3(resultSet.getInt("old_ribbon_3"));
        controle.setOld_ribbon_4(resultSet.getInt("old_ribbon_4"));
        controle.setOld_ribbon_5(resultSet.getInt("old_ribbon_5"));
        controle.setOld_ribbon_6(resultSet.getInt("old_ribbon_6"));

        controle.setObservacao_ribbon(resultSet.getString("observacao_ribbon"));

        return controle;
    }


}
