package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import connection.SingleConnectionBanco;
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
                String sql = "UPDATE conf_salarios SET salario=?, comissao=?, fgts=?, inss=? WHERE id_conf=?";
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
            sql = "UPDATE conf_juros_cartao SET deb_visa_master=?, cred_visa_master=?, deb_outros=?, cred_outros=? WHERE id_conf=?";
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


}
