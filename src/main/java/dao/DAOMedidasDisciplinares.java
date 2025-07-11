package dao;

import connection.SingleConnectionBanco;
import model.ModelAdvertencia;
import model.ModelFaltas;
import model.ModelSuspensao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Date;
import java.time.LocalDate;
import model.ModelCondutaResumo;

@SuppressWarnings("ALL")
public class DAOMedidasDisciplinares {
    private final Connection connection;

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


    public void gravarSuspensao(ModelSuspensao suspensao) throws SQLException {
        String sql = "INSERT INTO suspensao (funcionario_id, data_suspensao, motivo, nome_funcionario, dias, dsr) " +
                "VALUES (?, ?, UPPER(?), UPPER(?), ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, suspensao.getFuncionarioId());
            stmt.setDate(2, suspensao.getDataSuspensao());
            stmt.setString(3, suspensao.getMotivo());
            stmt.setString(4, suspensao.getNomeFuncionario());
            stmt.setInt(5, suspensao.getDias());
            stmt.setInt(6, suspensao.getDsr());

            stmt.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }

    public ModelCondutaResumo buscarResumoConduta(Long funcionarioId, LocalDate dataInicial, LocalDate dataFinal) throws SQLException {
        ModelCondutaResumo resumo = new ModelCondutaResumo();

        // --- Advertências
        String sqlAdvert = "SELECT COUNT(*) FROM advertencias WHERE funcionario_id = ? AND data_advertencia BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlAdvert)) {
            stmt.setLong(1, funcionarioId);
            stmt.setDate(2, java.sql.Date.valueOf(dataInicial));
            stmt.setDate(3, java.sql.Date.valueOf(dataFinal));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    resumo.setTotalAdvertencias(rs.getInt(1));
                }
            }
        }

        // --- Faltas
        String sqlFaltas = "SELECT COUNT(*) FROM faltas WHERE funcionario_id = ? AND data_falta BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlFaltas)) {
            stmt.setLong(1, funcionarioId);
            stmt.setDate(2, java.sql.Date.valueOf(dataInicial));
            stmt.setDate(3, java.sql.Date.valueOf(dataFinal));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    resumo.setTotalFaltas(rs.getInt(1));
                }
            }
        }

        // --- Suspensões
        String sqlSusp = "SELECT COALESCE(SUM(dias),0), COALESCE(SUM(dsr),0) FROM suspensao WHERE funcionario_id = ? AND data_suspensao BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlSusp)) {
            stmt.setLong(1, funcionarioId);
            stmt.setDate(2, java.sql.Date.valueOf(dataInicial));
            stmt.setDate(3, java.sql.Date.valueOf(dataFinal));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    resumo.setTotalDiasSuspensao(rs.getInt(1));
                    resumo.setTotalDsrSuspensao(rs.getInt(2));
                }
            }
        }

        return resumo;
    }



}