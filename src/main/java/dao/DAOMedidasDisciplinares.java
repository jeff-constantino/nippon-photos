package dao;

import connection.ConnectionPool;
import model.*;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("ALL")
public class DAOMedidasDisciplinares {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAOMedidasDisciplinares(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAOMedidasDisciplinares() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public void gravarAdvertencia(ModelAdvertencia advertencia) throws SQLException {
        String sql = "INSERT INTO advertencias (funcionario_id, data_advertencia, motivo,nome_funcionario) VALUES (?, ?, UPPER(?),?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, advertencia.getFuncionarioId());
            stmt.setDate(2, advertencia.getDataAdvertencia());
            stmt.setString(3, advertencia.getMotivo());
            stmt.setString(4, advertencia.getNomeFuncionario());
            stmt.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public void gravarFalta(ModelFaltas falta) throws SQLException {
        String sql = "INSERT INTO faltas (funcionario_id, data_falta, observacoes, nome_funcionario,dias_falta, dsr_falta) VALUES (?, ?, UPPER(?),?,?,?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, falta.getFuncionarioId());
            stmt.setDate(2, falta.getDataFalta());
            stmt.setString(3, falta.getObservacoes());
            stmt.setString(4, falta.getNomeFuncionario());
            stmt.setInt(5, falta.getDias_falta());
            stmt.setInt(6, falta.getDsr_falta());
            stmt.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public void gravarSuspensao(ModelSuspensao suspensao) throws SQLException {
        String sql = "INSERT INTO suspensao (funcionario_id, data_suspensao, motivo, nome_funcionario, dias, dsr) VALUES (?, ?, UPPER(?), UPPER(?), ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, suspensao.getFuncionarioId());
            stmt.setDate(2, suspensao.getDataSuspensao());
            stmt.setString(3, suspensao.getMotivo());
            stmt.setString(4, suspensao.getNomeFuncionario());
            stmt.setInt(5, suspensao.getDias());
            stmt.setInt(6, suspensao.getDsr());
            stmt.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public ModelCondutaResumo buscarResumoConduta(Long funcionarioId, LocalDate dataInicial, LocalDate dataFinal) throws SQLException {
        ModelCondutaResumo resumo = new ModelCondutaResumo();
        try {
            // Advertências
            String sqlAdvert = "SELECT COUNT(*) FROM advertencias WHERE funcionario_id = ? AND data_advertencia BETWEEN ? AND ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlAdvert)) {
                stmt.setLong(1, funcionarioId);
                stmt.setDate(2, Date.valueOf(dataInicial));
                stmt.setDate(3, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) resumo.setTotalAdvertencias(rs.getInt(1));
                }
            }

            // Faltas
            String sqlFaltas = "SELECT SUM(dias_falta + dsr_falta) FROM faltas WHERE funcionario_id = ? AND data_falta BETWEEN ? AND ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlFaltas)) {
                stmt.setLong(1, funcionarioId);
                stmt.setDate(2, Date.valueOf(dataInicial));
                stmt.setDate(3, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) resumo.setTotalFaltas(rs.getInt(1));
                }
            }

            // Suspensões
            String sqlSusp = "SELECT COALESCE(SUM(dias),0), COALESCE(SUM(dsr),0) FROM suspensao WHERE funcionario_id = ? AND data_suspensao BETWEEN ? AND ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlSusp)) {
                stmt.setLong(1, funcionarioId);
                stmt.setDate(2, Date.valueOf(dataInicial));
                stmt.setDate(3, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        resumo.setTotalDiasSuspensao(rs.getInt(1));
                        resumo.setTotalDsrSuspensao(rs.getInt(2));
                    }
                }
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return resumo;
    }

    public List<ModelMedidasDisciplinaresCompleto> buscarMedidasPorFuncionarioEPeriodo(Long funcionarioId, LocalDate dataInicial, LocalDate dataFinal) throws SQLException {
        List<ModelMedidasDisciplinaresCompleto> listaMedidas = new ArrayList<>();
        try {
            // ADVERTÊNCIAS
            String sqlAdv = "SELECT id, funcionario_id, nome_funcionario, data_advertencia, motivo FROM advertencias WHERE funcionario_id = ? AND data_advertencia BETWEEN ? AND ? ORDER BY data_advertencia DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sqlAdv)) {
                stmt.setLong(1, funcionarioId);
                stmt.setDate(2, Date.valueOf(dataInicial));
                stmt.setDate(3, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ModelMedidasDisciplinaresCompleto medida = new ModelMedidasDisciplinaresCompleto();
                        medida.setId(rs.getLong("id"));
                        medida.setFuncionarioId(rs.getLong("funcionario_id"));
                        medida.setNomeFuncionario(rs.getString("nome_funcionario"));
                        medida.setTipoMedida("ADVERTÊNCIA");
                        medida.setDataMedida(rs.getDate("data_advertencia"));
                        medida.setMotivo(rs.getString("motivo"));
                        listaMedidas.add(medida);
                    }
                }
            }

            // FALTAS
            String sqlFaltas = "SELECT id, funcionario_id, nome_funcionario, data_falta, observacoes, dias_falta, dsr_falta FROM faltas WHERE funcionario_id = ? AND data_falta BETWEEN ? AND ? ORDER BY data_falta DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sqlFaltas)) {
                stmt.setLong(1, funcionarioId);
                stmt.setDate(2, Date.valueOf(dataInicial));
                stmt.setDate(3, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ModelMedidasDisciplinaresCompleto medida = new ModelMedidasDisciplinaresCompleto();
                        medida.setId(rs.getLong("id"));
                        medida.setFuncionarioId(rs.getLong("funcionario_id"));
                        medida.setNomeFuncionario(rs.getString("nome_funcionario"));
                        medida.setTipoMedida("FALTA");
                        medida.setDataMedida(rs.getDate("data_falta"));
                        medida.setMotivo(rs.getString("observacoes"));
                        medida.setDias(rs.getInt("dias_falta"));
                        medida.setDsr(rs.getInt("dsr_falta"));
                        listaMedidas.add(medida);
                    }
                }
            }

            // SUSPENSÕES
            String sqlSusp = "SELECT id, funcionario_id, nome_funcionario, data_suspensao, motivo, dias, dsr FROM suspensao WHERE funcionario_id = ? AND data_suspensao BETWEEN ? AND ? ORDER BY data_suspensao DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sqlSusp)) {
                stmt.setLong(1, funcionarioId);
                stmt.setDate(2, Date.valueOf(dataInicial));
                stmt.setDate(3, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ModelMedidasDisciplinaresCompleto medida = new ModelMedidasDisciplinaresCompleto();
                        medida.setId(rs.getLong("id"));
                        medida.setFuncionarioId(rs.getLong("funcionario_id"));
                        medida.setNomeFuncionario(rs.getString("nome_funcionario"));
                        medida.setTipoMedida("SUSPENSÃO");
                        medida.setDataMedida(rs.getDate("data_suspensao"));
                        medida.setMotivo(rs.getString("motivo"));
                        medida.setDias(rs.getInt("dias"));
                        medida.setDsr(rs.getInt("dsr"));
                        listaMedidas.add(medida);
                    }
                }
            }

            // Ordena por data decrescente
            listaMedidas.sort((m1, m2) -> m2.getDataMedida().compareTo(m1.getDataMedida()));
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return listaMedidas;
    }

    public List<ModelMedidasDisciplinaresCompleto> buscarTodasMedidasPorPeriodo(LocalDate dataInicial, LocalDate dataFinal) throws SQLException {
        List<ModelMedidasDisciplinaresCompleto> listaMedidas = new ArrayList<>();
        try {
            // ADVERTÊNCIAS
            String sqlAdv = "SELECT id, funcionario_id, nome_funcionario, data_advertencia, motivo FROM advertencias WHERE data_advertencia BETWEEN ? AND ? ORDER BY data_advertencia DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sqlAdv)) {
                stmt.setDate(1, Date.valueOf(dataInicial));
                stmt.setDate(2, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ModelMedidasDisciplinaresCompleto medida = new ModelMedidasDisciplinaresCompleto();
                        medida.setId(rs.getLong("id"));
                        medida.setFuncionarioId(rs.getLong("funcionario_id"));
                        medida.setNomeFuncionario(rs.getString("nome_funcionario"));
                        medida.setTipoMedida("ADVERTÊNCIA");
                        medida.setDataMedida(rs.getDate("data_advertencia"));
                        medida.setMotivo(rs.getString("motivo"));
                        listaMedidas.add(medida);
                    }
                }
            }

            // FALTAS
            String sqlFaltas = "SELECT id, funcionario_id, nome_funcionario, data_falta, observacoes, dias_falta, dsr_falta FROM faltas WHERE data_falta BETWEEN ? AND ? ORDER BY data_falta DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sqlFaltas)) {
                stmt.setDate(1, Date.valueOf(dataInicial));
                stmt.setDate(2, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ModelMedidasDisciplinaresCompleto medida = new ModelMedidasDisciplinaresCompleto();
                        medida.setId(rs.getLong("id"));
                        medida.setFuncionarioId(rs.getLong("funcionario_id"));
                        medida.setNomeFuncionario(rs.getString("nome_funcionario"));
                        medida.setTipoMedida("FALTA");
                        medida.setDataMedida(rs.getDate("data_falta"));
                        medida.setMotivo(rs.getString("observacoes"));
                        medida.setDias(rs.getInt("dias_falta"));
                        medida.setDsr(rs.getInt("dsr_falta"));
                        listaMedidas.add(medida);
                    }
                }
            }

            // SUSPENSÕES
            String sqlSusp = "SELECT id, funcionario_id, nome_funcionario, data_suspensao, motivo, dias, dsr FROM suspensao WHERE data_suspensao BETWEEN ? AND ? ORDER BY data_suspensao DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sqlSusp)) {
                stmt.setDate(1, Date.valueOf(dataInicial));
                stmt.setDate(2, Date.valueOf(dataFinal));
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ModelMedidasDisciplinaresCompleto medida = new ModelMedidasDisciplinaresCompleto();
                        medida.setId(rs.getLong("id"));
                        medida.setFuncionarioId(rs.getLong("funcionario_id"));
                        medida.setNomeFuncionario(rs.getString("nome_funcionario"));
                        medida.setTipoMedida("SUSPENSÃO");
                        medida.setDataMedida(rs.getDate("data_suspensao"));
                        medida.setMotivo(rs.getString("motivo"));
                        medida.setDias(rs.getInt("dias"));
                        medida.setDsr(rs.getInt("dsr"));
                        listaMedidas.add(medida);
                    }
                }
            }

            // Ordena por data decrescente
            listaMedidas.sort((m1, m2) -> m2.getDataMedida().compareTo(m1.getDataMedida()));
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return listaMedidas;
    }

    private void fecharConexao() {
        if (connection != null && gerenciarTransacao) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
}