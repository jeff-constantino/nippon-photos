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
    private Connection connection;

    public DAOConfiguracao() {
        connection = SingleConnectionBanco.getConnection();
    }

    public ModelConfiguracao gravarConfig(ModelConfiguracao model) throws SQLException {
        // Desabilita o autocommit
        connection.setAutoCommit(false);

        try {
            if (model.getIdConf() == null) {
                String sql = "INSERT INTO conf_salarios (salario, comissao, fgts, inss) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getComissao());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getInss());
                    stmt.executeUpdate();

                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            model.setIdConf(rs.getLong(1));
                        }
                    }
                }
            } else {
                String sql = "UPDATE conf_salarios SET salario=?, comissao=?, fgts=?, inss=? WHERE \"idConf\" =?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {

                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getComissao());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getInss());
                    stmt.setLong(5, model.getIdConf());
                    stmt.executeUpdate();
                }
            }

            // Realiza o commit
            connection.commit();
        } catch (SQLException e) {
            // Em caso de erro, faz rollback
            connection.rollback();
            throw e;
        } finally {
            // Restaura o autocommit
            connection.setAutoCommit(true);
        }

        return model;
    }

    public ModelConfiguracao gravarConfigCartao(ModelConfiguracao model) throws SQLException {
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

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        model.setIdConf(rs.getLong(1)); // Definindo o idConf gerado
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
