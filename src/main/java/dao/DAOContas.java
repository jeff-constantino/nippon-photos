package dao;

import connection.ConnectionPool;
import model.ModelContas;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOContas {
    private final Connection connection;
    private final boolean gerenciarTransacao; // Flag para saber se deve fazer commit/rollback

    /**
     * Construtor NOVO - recebe conexão gerenciada pelo Filter
     * USO RECOMENDADO
     */
    public DAOContas(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false; // Filter gerencia
    }

    /**
     * Construtor LEGADO - busca própria conexão
     * Mantido para compatibilidade temporária
     */
    public DAOContas() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true; // DAO gerencia
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    public void gravarConta(ModelContas conta) throws Exception {
        String sql = "INSERT INTO contas (numero_pedido, empresa, itens, valor, data_de_pedido, data_de_pagamento, status, pagamento) " +
                "VALUES (?, UPPER(?), UPPER(?), ?, ?, ?, UPPER(?), UPPER(?))";

        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, conta.getNumero_pedido());
            stmt.setString(2, conta.getEmpresa());
            stmt.setString(3, conta.getItens());
            stmt.setDouble(4, conta.getValor());

            if (conta.getData_de_pedido() != null) {
                stmt.setDate(5, new java.sql.Date(conta.getData_de_pedido().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }

            if (conta.getData_de_pagamento() != null) {
                stmt.setDate(6, new java.sql.Date(conta.getData_de_pagamento().getTime()));
            } else {
                stmt.setNull(6, java.sql.Types.DATE);
            }

            stmt.setString(7, conta.getStatus());
            stmt.setString(8, conta.getPagamento());

            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                conta.setConta_id(generatedKeys.getLong(1));
            }

            // Só faz commit se o DAO está gerenciando a transação
            if (gerenciarTransacao) {
                connection.commit();
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                connection.rollback();
            }
            throw new Exception("Erro ao gravar conta: " + e.getMessage(), e);
        } finally {
            // Fecha conexão apenas se o DAO a criou
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public void atualizarConta(ModelContas conta) throws Exception {
        if (conta.getConta_id() == null) {
            throw new IllegalArgumentException("ID da conta não pode ser nulo.");
        }

        String sql = "UPDATE contas SET empresa = UPPER(?), itens = UPPER(?), valor = ?, " +
                "data_de_pedido = ?, data_de_pagamento = ?, status = UPPER(?), pagamento = UPPER(?) " +
                "WHERE conta_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, conta.getEmpresa());
            stmt.setString(2, conta.getItens());
            stmt.setDouble(3, conta.getValor());

            if (conta.getData_de_pedido() != null) {
                stmt.setDate(4, new java.sql.Date(conta.getData_de_pedido().getTime()));
            } else {
                stmt.setNull(4, java.sql.Types.DATE);
            }

            if (conta.getData_de_pagamento() != null) {
                stmt.setDate(5, new java.sql.Date(conta.getData_de_pagamento().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }

            stmt.setString(6, conta.getStatus());
            stmt.setString(7, conta.getPagamento());
            stmt.setLong(8, conta.getConta_id());

            int linhasAfetadas = stmt.executeUpdate();

            if (linhasAfetadas > 0) {
                if (gerenciarTransacao) {
                    connection.commit();
                }
            } else {
                System.out.println("⚠️ Nenhuma conta atualizada. ID: " + conta.getConta_id());
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new Exception("Erro ao atualizar conta: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public boolean existeContaId(Long contaId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM contas WHERE conta_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, contaId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao verificar existência da conta", e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return false;
    }

    public ModelContas buscarContaPorId(Long contaId) throws SQLException {
        ModelContas conta = null;
        String sql = "SELECT * FROM contas WHERE conta_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, contaId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                conta = extrairContaDoResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar conta: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return conta;
    }

    public List<ModelContas> buscarContasRecentes() throws SQLException {
        List<ModelContas> contasRecentes = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento >= NOW() - INTERVAL '60 days' ORDER BY data_de_pedido DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                contasRecentes.add(extrairContaDoResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas recentes: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return contasRecentes;
    }

    public List<ModelContas> buscarContasMes(String dataInicio, String dataFim) throws SQLException {
        List<ModelContas> contasMes = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento >= ? AND data_de_pagamento <= ? ORDER BY data_de_pagamento DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(dataInicio));
            stmt.setDate(2, java.sql.Date.valueOf(dataFim));

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                contasMes.add(extrairContaDoResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return contasMes;
    }

    public List<ModelContas> buscarContasRelMes(String dataInicio, String dataFim) throws SQLException {
        return buscarContasMes(dataInicio, dataFim); // Mesmo método
    }

    public List<ModelContas> buscarContasVencendoEm7Dias() throws SQLException {
        List<ModelContas> contas = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days' AND status = 'A PAGAR'";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                contas.add(extrairContaDoResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return contas;
    }

    public List<ModelContas> buscarContasVencidas() throws SQLException {
        List<ModelContas> contas = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento < CURRENT_DATE AND status = 'A PAGAR'";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                contas.add(extrairContaDoResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas vencidas: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return contas;
    }

    public List<ModelContas> listarContas(int pagina, int tamanho) throws SQLException {
        List<ModelContas> contas = new ArrayList<>();
        String sql = "SELECT * FROM contas ORDER BY data_de_pedido DESC LIMIT ? OFFSET ?";
        int offset = (pagina - 1) * tamanho;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, tamanho);
            stmt.setInt(2, offset);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                contas.add(extrairContaDoResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return contas;
    }

    public int contarTotalContas() throws SQLException {
        String sql = "SELECT COUNT(*) FROM contas";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return 0;
    }

    public void deleteConta(long id) throws Exception {
        String sql = "DELETE FROM contas WHERE conta_id = ?";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setLong(1, id);
            preparedSql.executeUpdate();

            if (gerenciarTransacao) {
                connection.commit();
            }
        } catch (SQLException e) {
            if (gerenciarTransacao) {
                connection.rollback();
            }
            throw new Exception("Erro ao deletar conta: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public void atualizarStatusPorNumeroPedido(Long numeroPedido, String formaPgto) throws Exception {
        String sql = "UPDATE contas SET status = ?, pagamento = UPPER(?) WHERE numero_pedido = ?";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setString(1, "PAGO");
            preparedSql.setString(2, formaPgto);
            preparedSql.setLong(3, numeroPedido);

            int rowsAffected = preparedSql.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Nenhuma conta encontrada com o número do pedido: " + numeroPedido);
            }

            if (gerenciarTransacao) {
                connection.commit();
            }
        } catch (SQLException e) {
            if (gerenciarTransacao) {
                connection.rollback();
            }
            throw new Exception("Erro ao atualizar o status da conta: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public BigDecimal buscarTotalContasPorPeriodo(String dataInicial, String dataFinal) throws SQLException {
        BigDecimal total = BigDecimal.ZERO;
        String sql = "SELECT SUM(valor) AS total_contas FROM contas WHERE data_de_pagamento >= ? AND data_de_pagamento <= ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, java.sql.Date.valueOf(LocalDate.parse(dataInicial)));
            statement.setDate(2, java.sql.Date.valueOf(LocalDate.parse(dataFinal)));

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    total = rs.getBigDecimal("total_contas");
                    if (total == null) {
                        total = BigDecimal.ZERO;
                    }
                }
            }
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
        return total;
    }

    // ===== MÉTODOS AUXILIARES =====

    /**
     * Extrai ModelContas do ResultSet (DRY - Don't Repeat Yourself)
     */
    private ModelContas extrairContaDoResultSet(ResultSet rs) throws SQLException {
        ModelContas conta = new ModelContas();
        conta.setConta_id(rs.getLong("conta_id"));
        conta.setNumero_pedido(rs.getLong("numero_pedido"));
        conta.setEmpresa(rs.getString("empresa"));
        conta.setItens(rs.getString("itens"));
        conta.setValor(rs.getDouble("valor"));
        conta.setData_de_pedido(rs.getDate("data_de_pedido"));
        conta.setData_de_pagamento(rs.getDate("data_de_pagamento"));
        conta.setStatus(rs.getString("status"));
        conta.setPagamento(rs.getString("pagamento"));
        return conta;
    }

    /**
     * Fecha a conexão (apenas quando DAO gerencia)
     */
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