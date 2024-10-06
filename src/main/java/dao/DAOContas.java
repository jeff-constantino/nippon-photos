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
            stmt.setInt(1, conta.getNumero_pedido());
            stmt.setString(2, conta.getEmpresa());
            stmt.setString(3, conta.getItens());
            stmt.setDouble(4, conta.getValor());
            stmt.setDate(5, new java.sql.Date(conta.getData_de_pedido().getTime())); // Converte para java.sql.Date
            stmt.setDate(6, new java.sql.Date(conta.getData_de_pagamento().getTime())); // Converte para java.sql.Date
            stmt.setString(7, conta.getStatus().toUpperCase());

            stmt.executeUpdate();

            // Se você precisar do ID gerado, pode usar isso:
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                conta.setConta_id(generatedKeys.getLong(1)); // Atualiza o modelo com o id gerado
            }

            connection.commit(); // Confirma a transação
        } catch (SQLException e) {
            connection.rollback(); // Faz rollback em caso de erro
            throw new Exception("Erro ao gravar conta: " + e.getMessage(), e);
        }
    }

    public List<ModelContas> buscarContasVencendoEm7Dias() throws SQLException {
        List<ModelContas> contas = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days' AND status = 'A PAGAR'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelContas conta = new ModelContas();
                conta.setConta_id(rs.getLong("conta_id"));
                conta.setNumero_pedido(rs.getInt("numero_pedido"));
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
}
