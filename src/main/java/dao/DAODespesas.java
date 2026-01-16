package dao;

import connection.ConnectionPool;
import model.ModelDespesas;

import java.math.BigDecimal;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAODespesas {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAODespesas(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAODespesas() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public void gravarDespesa(ModelDespesas despesas) throws Exception {
        String sql = "INSERT INTO despesas (nome_despesa, descricao_despesa, valor_despesa, pagamento_despesa, data_despesa) VALUES (UPPER(?), UPPER(?), ?, UPPER(?), ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, despesas.getNome_despesa());
            stmt.setString(2, despesas.getDescricao_despesa());
            stmt.setDouble(3, despesas.getValor_despesa());
            stmt.setString(4, despesas.getPagamento_despesa());
            if (despesas.getData_despesa() != null) {
                stmt.setDate(5, new java.sql.Date(despesas.getData_despesa().getTime()));
            } else {
                stmt.setNull(5, Types.DATE);
            }
            stmt.executeUpdate();
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) despesas.setId_despesa(generatedKeys.getLong(1));
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw new Exception("Erro ao gravar Despesa: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public void atualizarDespesa(ModelDespesas despesas) throws Exception {
        if (despesas.getId_despesa() == null) throw new IllegalArgumentException("ID da despesa não pode ser nulo.");
        String sql = "UPDATE despesas SET nome_despesa = UPPER(?), descricao_despesa = UPPER(?), valor_despesa = ?, pagamento_despesa = UPPER(?), data_despesa = ? WHERE id_despesa = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, despesas.getNome_despesa());
            stmt.setString(2, despesas.getDescricao_despesa());
            stmt.setDouble(3, despesas.getValor_despesa());
            stmt.setString(4, despesas.getPagamento_despesa());
            if (despesas.getData_despesa() != null) {
                stmt.setDate(5, new java.sql.Date(despesas.getData_despesa().getTime()));
            } else {
                stmt.setNull(5, Types.DATE);
            }
            stmt.setLong(6, despesas.getId_despesa());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) System.out.println("Nenhuma linha foi atualizada.");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Erro ao atualizar a despesa: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public boolean existeDespesaId(Long despesaId) {
        String sql = "SELECT COUNT(*) FROM despesas WHERE id_despesa = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, despesaId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return false;
    }

    public void excluirDespesa(Long id_despesa) throws SQLException {
        String sql = "DELETE FROM despesas WHERE id_despesa = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id_despesa);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) throw new SQLException("Nenhuma despesa foi excluída.");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Erro ao excluir despesa", e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public List<ModelDespesas> listarDespesasUltimos60Dias() throws SQLException {
        List<ModelDespesas> despesasList = new ArrayList<>();
        String sql = "SELECT * FROM despesas WHERE data_despesa >= CURRENT_DATE - INTERVAL '60' DAY ORDER BY data_despesa DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelDespesas despesa = new ModelDespesas();
                despesa.setId_despesa(rs.getLong("id_despesa"));
                despesa.setNome_despesa(rs.getString("nome_despesa"));
                despesa.setDescricao_despesa(rs.getString("descricao_despesa"));
                despesa.setValor_despesa(rs.getDouble("valor_despesa"));
                despesa.setPagamento_despesa(rs.getString("pagamento_despesa"));
                despesa.setData_despesa(rs.getDate("data_despesa"));
                despesasList.add(despesa);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Erro ao listar despesas", e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return despesasList;
    }

    public List<ModelDespesas> listarDespesasPorPeriodo(String dataInicio, String dataFim) throws SQLException {
        List<ModelDespesas> despesasMes = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date inicio = sdf.parse(dataInicio);
            Date fim = sdf.parse(dataFim);
            String sql = "SELECT * FROM despesas WHERE data_despesa >= ? AND data_despesa <= ? ORDER BY data_despesa DESC";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setDate(1, new java.sql.Date(inicio.getTime()));
                stmt.setDate(2, new java.sql.Date(fim.getTime()));
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    ModelDespesas despesa = new ModelDespesas();
                    despesa.setId_despesa(rs.getLong("id_despesa"));
                    despesa.setNome_despesa(rs.getString("nome_despesa"));
                    despesa.setDescricao_despesa(rs.getString("descricao_despesa"));
                    despesa.setValor_despesa(rs.getDouble("valor_despesa"));
                    despesa.setPagamento_despesa(rs.getString("pagamento_despesa"));
                    despesa.setData_despesa(rs.getDate("data_despesa"));
                    despesasMes.add(despesa);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Erro ao listar despesas por período", e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return despesasMes;
    }

    public double somarDespesasDinheiroPorPeriodo(String dataInicio, String dataFim) throws SQLException {
        String sql = "SELECT COALESCE(SUM(valor_despesa), 0) AS total_dinheiro FROM despesas WHERE pagamento_despesa = 'DINHEIRO' AND data_despesa >= ? AND data_despesa <= ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(dataInicio));
            stmt.setDate(2, java.sql.Date.valueOf(dataFim));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble("total_dinheiro");
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return 0.0;
    }

    public List<ModelDespesas> listarTodasDespesas(int pagina, int tamanho) throws SQLException {
        List<ModelDespesas> todasDespesasList = new ArrayList<>();
        String sql = "SELECT * FROM despesas ORDER BY data_despesa DESC LIMIT ? OFFSET ?";
        int offset = (pagina - 1) * tamanho;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tamanho);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelDespesas despesa = new ModelDespesas();
                despesa.setId_despesa(rs.getLong("id_despesa"));
                despesa.setNome_despesa(rs.getString("nome_despesa"));
                despesa.setDescricao_despesa(rs.getString("descricao_despesa"));
                despesa.setValor_despesa(rs.getDouble("valor_despesa"));
                despesa.setPagamento_despesa(rs.getString("pagamento_despesa"));
                despesa.setData_despesa(rs.getDate("data_despesa"));
                todasDespesasList.add(despesa);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Erro ao listar todas as despesas", e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return todasDespesasList;
    }

    public int contarTotalDespesas() throws SQLException {
        String sql = "SELECT COUNT(*) FROM despesas";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return 0;
    }

    public BigDecimal buscarTotalDespesasPorPeriodo(String dataInicial, String dataFinal) throws SQLException {
        BigDecimal total = BigDecimal.ZERO;
        String sql = "SELECT SUM(valor_despesa) AS total_despesas FROM despesas WHERE data_despesa >= ? AND data_despesa <= ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, java.sql.Date.valueOf(LocalDate.parse(dataInicial)));
            statement.setDate(2, java.sql.Date.valueOf(LocalDate.parse(dataFinal)));
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    total = rs.getBigDecimal("total_despesas");
                    if (total == null) total = BigDecimal.ZERO;
                }
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return total;
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