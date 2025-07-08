package dao;

import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelConfig;
import model.ModelConfiguracao;

public class DAOConfiguracao {
    private final Connection connection;

    public DAOConfiguracao() {
        connection = SingleConnectionBanco.getConnection();
    }

    public ModelConfiguracao gravarConfig(ModelConfiguracao model) throws SQLException {
        // Desabilita o autocommit para gerenciar a transação manualmente
        connection.setAutoCommit(false);

        try {
            String sql;

            // Verifica se o idConf é nulo para decidir entre inserir ou atualizar
            if (model.getIdConf() == null) {
                sql = "INSERT INTO conf_salarios (salario, comissao, fgts, inss) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getComissao());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getInss());
                    stmt.executeUpdate();

                    // Recupera o ID gerado
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            model.setIdConf(rs.getLong(1)); // Define o idConf gerado
                        }
                    }
                }
            } else {
                sql = "UPDATE conf_salarios SET salario=?, comissao=?, fgts=?, inss=? WHERE \"idConf\" =?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getComissao());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getInss());
                    stmt.setLong(5, model.getIdConf());
                    stmt.executeUpdate();
                }
            }

            // Realiza o commit da transação
            connection.commit();
        } catch (SQLException e) {
            // Em caso de erro, faz rollback
            connection.rollback();
            throw e; // Repropaga a exceção
        } finally {
            // Restaura o autocommit
            connection.setAutoCommit(true);
        }

        return model;
    }

    public ModelConfiguracao gravarConfigCartao(ModelConfiguracao model) throws SQLException {
        // Desabilita o autocommit para gerenciar a transação manualmente
        connection.setAutoCommit(false);

        try {
            String sql;

            // Verifica se o idConf é nulo para decidir entre inserir ou atualizar
            if (model.getIdConf() == null) {
                sql = "INSERT INTO conf_juros_cartao (deb_visa_master, cred_visa_master, deb_outros, cred_outros) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setBigDecimal(1, model.getDeb_visa_master());
                    stmt.setBigDecimal(2, model.getCred_visa_master());
                    stmt.setBigDecimal(3, model.getDeb_outros());
                    stmt.setBigDecimal(4, model.getCred_outros());
                    stmt.executeUpdate();

                    // Recupera o ID gerado
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            model.setIdConf(rs.getLong(1)); // Define o idConf gerado
                        }
                    }
                }
            } else {
                sql = "UPDATE conf_juros_cartao SET deb_visa_master=?, cred_visa_master=?, deb_outros=?, cred_outros=? WHERE \"idConf\" =?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setBigDecimal(1, model.getDeb_visa_master());
                    stmt.setBigDecimal(2, model.getCred_visa_master());
                    stmt.setBigDecimal(3, model.getDeb_outros());
                    stmt.setBigDecimal(4, model.getCred_outros());
                    stmt.setLong(5, model.getIdConf());
                    stmt.executeUpdate();
                }
            }

            // Realiza o commit da transação
            connection.commit();
        } catch (SQLException e) {
            // Em caso de erro, faz rollback
            connection.rollback();
            throw e; // Repropaga a exceção
        } finally {
            // Restaura o autocommit
            connection.setAutoCommit(true);
        }

        return model;
    }

    public List<ModelConfiguracao> consultarSalarios() throws Exception {
        List<ModelConfiguracao> listaSalarios = new ArrayList<>();
        String sql = "SELECT * FROM public.conf_salarios"; // Certifique-se de que a tabela existe

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
                modelConfiguracao.setIdConf(resultSet.getLong("idConf"));
                modelConfiguracao.setSalario(resultSet.getBigDecimal("salario"));
                modelConfiguracao.setComissao(resultSet.getBigDecimal("comissao"));
                modelConfiguracao.setFgts(resultSet.getBigDecimal("fgts"));
                modelConfiguracao.setInss(resultSet.getBigDecimal("inss"));




                listaSalarios.add(modelConfiguracao);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage()); // Captura erros de SQL
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaSalarios;
    }

    public ModelConfiguracao buscarFaixasInss() throws Exception {
        ModelConfiguracao configInss = new ModelConfiguracao();

        String sql = "SELECT id_inss, inss, min_inss, max_inss FROM inss ORDER BY id_inss";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet rs = preparedSql.executeQuery()) {

            int faixa = 1;
            while (rs.next() && faixa <= 4) {
                Long id = rs.getLong("id_inss");
                BigDecimal inss = rs.getBigDecimal("inss");
                BigDecimal min = rs.getBigDecimal("min_inss");
                BigDecimal max = rs.getBigDecimal("max_inss");

                switch (faixa) {
                    case 1:
                        configInss.setId_inss_1(id);
                        configInss.setInss_1(inss);
                        configInss.setMin_inss_1(min);
                        configInss.setMax_inss_1(max);
                        break;
                    case 2:
                        configInss.setId_inss_2(id);
                        configInss.setInss_2(inss);
                        configInss.setMin_inss_2(min);
                        configInss.setMax_inss_2(max);
                        break;
                    case 3:
                        configInss.setId_inss_3(id);
                        configInss.setInss_3(inss);
                        configInss.setMin_inss_3(min);
                        configInss.setMax_inss_3(max);
                        break;
                    case 4:
                        configInss.setId_inss_4(id);
                        configInss.setInss_4(inss);
                        configInss.setMin_inss_4(min);
                        configInss.setMax_inss_4(max);
                        break;
                }

                faixa++;
            }
        }



        return configInss;
    }
    public void salvarOuAtualizarFaixaInss(Long id, BigDecimal inss, BigDecimal min, BigDecimal max) throws SQLException {
        String sql;
        boolean isUpdate = (id != null && id > 0);

        if (isUpdate) {
            sql = "UPDATE inss SET inss = ?, min_inss = ?, max_inss = ? WHERE id_inss = ?";
        } else {
            sql = "INSERT INTO inss (inss, min_inss, max_inss) VALUES (?, ?, ?)";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBigDecimal(1, inss);
            ps.setBigDecimal(2, min);
            ps.setBigDecimal(3, max);

            if (isUpdate) {
                ps.setLong(4, id);
            }

            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }




    public List<ModelConfiguracao> consultarJuros() throws Exception {
        List<ModelConfiguracao> listaJuros = new ArrayList<>();
        String sql = "SELECT * FROM public.conf_juros_cartao"; // Certifique-se de que a tabela existe

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
                modelConfiguracao.setIdConf(resultSet.getLong("idConf"));

                // Divide os valores por 100 diretamente no Java
                BigDecimal debVisaMaster = resultSet.getBigDecimal("deb_visa_master").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
                BigDecimal credVisaMaster = resultSet.getBigDecimal("cred_visa_master").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
                BigDecimal debOutros = resultSet.getBigDecimal("deb_outros").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
                BigDecimal credOutros = resultSet.getBigDecimal("cred_outros").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);

                modelConfiguracao.setDeb_visa_master(debVisaMaster);
                modelConfiguracao.setCred_visa_master(credVisaMaster);
                modelConfiguracao.setDeb_outros(debOutros);
                modelConfiguracao.setCred_outros(credOutros);

                listaJuros.add(modelConfiguracao);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage()); // Captura erros de SQL
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaJuros;
    }



}
