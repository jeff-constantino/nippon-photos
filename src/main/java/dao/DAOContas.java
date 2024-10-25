package dao;

import connection.SingleConnectionBanco;
import model.ModelContas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOContas {
    private Connection connection;

    public DAOContas() {
        connection = SingleConnectionBanco.getConnection();
    }

    public void gravarConta(ModelContas conta) throws Exception {
        String sql = "INSERT INTO contas (numero_pedido, empresa, itens, valor, data_de_pedido, data_de_pagamento, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setLong(1, conta.getNumero_pedido());
            stmt.setString(2, conta.getEmpresa());
            stmt.setString(3, conta.getItens());
            stmt.setDouble(4, conta.getValor());

            // Verifica se data_de_pedido não é null
            if (conta.getData_de_pedido() != null) {
                stmt.setDate(5, new java.sql.Date(conta.getData_de_pedido().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE); // Seta como null no banco
            }

            // Verifica se data_de_pagamento não é null
            if (conta.getData_de_pagamento() != null) {
                stmt.setDate(6, new java.sql.Date(conta.getData_de_pagamento().getTime()));
            } else {
                stmt.setNull(6, java.sql.Types.DATE); // Seta como null no banco
            }

            stmt.setString(7, conta.getStatus());

            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                conta.setConta_id(generatedKeys.getLong(1));
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new Exception("Erro ao gravar conta: " + e.getMessage(), e);
        }
    }

    public void atualizarConta(ModelContas conta) {
        if (conta.getConta_id() == null) {
            throw new IllegalArgumentException("ID da conta não pode ser nulo.");
        }

        String sql = "UPDATE contas SET empresa = ?, itens = ?, valor = ?, data_de_pedido = ?, data_de_pagamento = ?, status = ? WHERE conta_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, conta.getEmpresa());
            stmt.setString(2, conta.getItens());
            stmt.setDouble(3, conta.getValor());

            // Verifica se data_de_pedido não é null
            if (conta.getData_de_pedido() != null) {
                stmt.setDate(4, new java.sql.Date(conta.getData_de_pedido().getTime()));
            } else {
                stmt.setNull(4, java.sql.Types.DATE);
            }

            // Verifica se data_de_pagamento não é null
            if (conta.getData_de_pagamento() != null) {
                stmt.setDate(5, new java.sql.Date(conta.getData_de_pagamento().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }

            stmt.setString(6, conta.getStatus());
            stmt.setLong(7, conta.getConta_id());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                // Adiciona o commit aqui
                connection.commit(); // Commit para confirmar a transação
                System.out.println("Atualização bem-sucedida, linhas afetadas: " + rowsAffected);
            } else {
                System.out.println("Nenhuma linha foi atualizada.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // Se houver um erro, faz o rollback
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
    }





    public boolean existeContaId(Long contaId) {
        // Lógica para verificar se o conta_id já existe no banco de dados
        String sql = "SELECT COUNT(*) FROM contas WHERE conta_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, contaId); // Usando setLong para Long
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Retorna true se o conta_id existir
            }
        } catch (SQLException e) {
            // Tratamento de exceção
        }
        return false; // Retorna false se ocorrer qualquer erro
    }



    public ModelContas buscarContaPorId(Long contaId) throws SQLException {
        ModelContas conta = null;
        String sql = "SELECT * FROM contas WHERE conta_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, contaId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                conta = new ModelContas();
                conta.setConta_id(rs.getLong("conta_id"));
                conta.setNumero_pedido(rs.getLong("numero_pedido"));
                conta.setEmpresa(rs.getString("empresa"));
                conta.setItens(rs.getString("itens"));
                conta.setValor(rs.getDouble("valor"));
                conta.setData_de_pedido(rs.getDate("data_de_pedido"));
                conta.setData_de_pagamento(rs.getDate("data_de_pagamento"));
                conta.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar conta: " + e.getMessage());
            throw e;
        }
        return conta;
    }


    public List<ModelContas> buscarContasRecentes() throws SQLException {
        List<ModelContas> contasRecentes = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pedido >= NOW() - INTERVAL '60 days' ORDER BY data_de_pedido DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelContas conta = new ModelContas();
                conta.setConta_id(rs.getLong("conta_id"));
                conta.setNumero_pedido(rs.getLong("numero_pedido"));
                conta.setEmpresa(rs.getString("empresa"));
                conta.setItens(rs.getString("itens"));
                conta.setValor(rs.getDouble("valor"));
                conta.setData_de_pedido(rs.getDate("data_de_pedido"));
                conta.setData_de_pagamento(rs.getDate("data_de_pagamento"));
                conta.setStatus(rs.getString("status"));
                contasRecentes.add(conta);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas recentes: " + e.getMessage());
            throw e; // Repropaga a exceção
        }
        return contasRecentes;
    }


    public List<ModelContas> buscarContasVencendoEm7Dias() throws SQLException {
        List<ModelContas> contas = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days' AND status = 'A PAGAR'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelContas conta = new ModelContas();
                conta.setConta_id(rs.getLong("conta_id"));
                conta.setNumero_pedido(rs.getLong("numero_pedido"));
                conta.setEmpresa(rs.getString("empresa"));
                conta.setItens(rs.getString("itens"));
                conta.setValor(rs.getDouble("valor"));
                conta.setData_de_pedido(rs.getDate("data_de_pedido"));
                conta.setData_de_pagamento(rs.getDate("data_de_pagamento"));
                conta.setStatus(rs.getString("status"));
                contas.add(conta);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas: " + e.getMessage());
            throw e; // Repropaga a exceção
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
                ModelContas conta = new ModelContas();
                conta.setConta_id(rs.getLong("conta_id"));
                conta.setNumero_pedido(rs.getLong("numero_pedido"));
                conta.setEmpresa(rs.getString("empresa"));
                conta.setItens(rs.getString("itens"));
                conta.setValor(rs.getDouble("valor"));
                conta.setData_de_pedido(rs.getDate("data_de_pedido"));
                conta.setData_de_pagamento(rs.getDate("data_de_pagamento"));
                conta.setStatus(rs.getString("status"));
                contas.add(conta);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar contas: " + e.getMessage());
            throw e; // Repropaga a exceção
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
        }
        return 0;
    }

    public void deleteConta(long id) throws Exception{
        String sql = "delete from contas where conta_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, id);
        preparedSql.executeUpdate();
        connection.commit();
    }
    public void atualizarStatusPorNumeroPedido(Long numeroPedido) throws Exception {
        String sql = "UPDATE contas SET status = ? WHERE numero_pedido = ?";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            // Define o novo status
            preparedSql.setString(1, "PAGO"); // ou outro status que você deseje definir
            preparedSql.setLong(2, numeroPedido);

            // Executa a atualização
            int rowsAffected = preparedSql.executeUpdate();

            // Verifica se a atualização foi bem-sucedida
            if (rowsAffected == 0) {
                throw new SQLException("Nenhuma conta encontrada com o número do pedido: " + numeroPedido);
            }

            // Realiza o commit da transação
            connection.commit();
        } catch (SQLException e) {
            connection.rollback(); // Reverte a transação em caso de erro
            throw new Exception("Erro ao atualizar o status da conta: " + e.getMessage());
        }
    }


}