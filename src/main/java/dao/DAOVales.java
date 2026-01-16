package dao;

import connection.ConnectionPool;
import model.ModelVales;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOVales {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAOVales(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAOVales() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public List<ModelVales> buscarValesUltimos30Dias() throws Exception {
        List<ModelVales> vales = new ArrayList<>();
        String sql = "SELECT id_vale, nome_funcionario, data, observacao, valor, forma_pagamento FROM vales WHERE data >= ? ORDER BY data DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            LocalDate trintaDiasAtras = LocalDate.now().minusDays(30);
            stmt.setDate(1, Date.valueOf(trintaDiasAtras));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelVales vale = new ModelVales();
                vale.setId_vale(rs.getLong("id_vale"));
                vale.setNome_funcionario(rs.getString("nome_funcionario"));
                vale.setData(rs.getDate("data").toLocalDate());
                vale.setObservacao(rs.getString("observacao"));
                vale.setValor(rs.getBigDecimal("valor"));
                vale.setForma_pagamento(rs.getString("forma_pagamento"));
                vales.add(vale);
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return vales;
    }

    public boolean inserirVale(ModelVales vale) {
        String sql = "INSERT INTO vales (id_funcionario, nome_funcionario, data, observacao, valor, forma_pagamento) VALUES (?, ?, ?, UPPER(?), ?, UPPER(?))";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, vale.getId_funcionario());
            stmt.setString(2, vale.getNome_funcionario());
            stmt.setDate(3, Date.valueOf(vale.getData()));
            stmt.setString(4, vale.getObservacao());
            stmt.setBigDecimal(5, vale.getValor());
            stmt.setString(6, vale.getForma_pagamento());
            int rowsAffected = stmt.executeUpdate();
            if (gerenciarTransacao) connection.commit();
            return rowsAffected > 0;
        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public BigDecimal somarValesPorFuncionarioEPeriodo(Long funcionarioId, LocalDate dataInicial, LocalDate dataFinal) throws Exception {
        BigDecimal totalVales = BigDecimal.ZERO;
        String sql = "SELECT SUM(valor) FROM vales WHERE id_funcionario = ? AND data BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, funcionarioId);
            stmt.setDate(2, Date.valueOf(dataInicial));
            stmt.setDate(3, Date.valueOf(dataFinal));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalVales = rs.getBigDecimal(1);
                if (totalVales == null) totalVales = BigDecimal.ZERO;
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return totalVales;
    }

    public boolean excluirVale(long idVale) {
        String sql = "DELETE FROM vales WHERE id_vale = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, idVale);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0 && gerenciarTransacao) connection.commit();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            return false;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public List<ModelVales> buscarValesPorDataEFuncionario(LocalDate dataInicial, LocalDate dataFinal, Long funcionarioId) throws Exception {
        List<ModelVales> vales = new ArrayList<>();
        String sql = "SELECT * FROM vales WHERE data BETWEEN ? AND ? AND id_funcionario = ? ORDER BY data DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, Date.valueOf(dataInicial));
            stmt.setDate(2, Date.valueOf(dataFinal));
            stmt.setLong(3, funcionarioId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelVales vale = new ModelVales();
                vale.setId_vale(rs.getLong("id_vale"));
                vale.setId_funcionario(rs.getLong("id_funcionario"));
                vale.setValor(rs.getBigDecimal("valor"));
                vale.setData(rs.getDate("data").toLocalDate());
                vale.setObservacao(rs.getString("observacao"));
                vale.setNome_funcionario(rs.getString("nome_funcionario"));
                vale.setForma_pagamento(rs.getString("forma_pagamento"));
                vales.add(vale);
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return vales;
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