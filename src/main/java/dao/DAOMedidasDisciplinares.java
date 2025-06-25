package dao;

import connection.SingleConnectionBanco;
import model.ModelAdvertencia;
import model.ModelFaltas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DAOMedidasDisciplinares {
    private Connection connection;

    // Construtor para inicializar a conexão com o banco
    public DAOMedidasDisciplinares() {
        this.connection = SingleConnectionBanco.getConnection();
    }

    public void gravarAdvertencia(ModelAdvertencia advertencia) throws SQLException {
        String sql = "INSERT INTO advertencias (funcionario_id, data_advertencia, motivo,nome_funcionario) VALUES (?, ?, UPPER(?),?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, advertencia.getFuncionarioId());
            stmt.setDate(2, advertencia.getDataAdvertencia());
            stmt.setString(3, advertencia.getMotivo());
            stmt.setString(4, advertencia.getNomeFuncionario());

            stmt.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            throw e; // Repropaga a exceção
        }
    }

    public void gravarFalta(ModelFaltas falta) throws SQLException {
        String sql = "INSERT INTO faltas (funcionario_id, data_falta, observacoes, nome_funcionario) VALUES (?, ?, UPPER(?),?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, falta.getFuncionarioId());
            stmt.setDate(2, falta.getDataFalta());
            stmt.setString(3, falta.getObservacoes());
            stmt.setString(4, falta.getNomeFuncionario());

            stmt.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }

}