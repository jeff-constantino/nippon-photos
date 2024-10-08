package dao;

import connection.SingleConnectionBanco;
import model.ModelContas;
import model.ModelDespesas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAODespesas {
    private Connection connection;
    public DAODespesas() {
        connection = SingleConnectionBanco.getConnection();
    }


    public void gravarConta(ModelDespesas despesas) throws Exception {
        String sql = "INSERT INTO despesas (nome_despesa, descricao_despesa, valor_despesa, data_despesa) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, despesas.getNome_despesa());
            stmt.setString(2, despesas.getDescricao_despesa());
            stmt.setDouble(3, despesas.getValor_despesa());

            // Verifica se data_de_pedido não é null
            if (despesas.getData_despesa() != null) {
                stmt.setDate(5, new java.sql.Date(despesas.getData_despesa().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE); // Seta como null no banco
            }



            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                despesas.setId_despesa(generatedKeys.getLong(1));
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new Exception("Erro ao gravar Despesa: " + e.getMessage(), e);
        }
    }

    public void atualizarConta(ModelDespesas despesas) throws Exception {
        if (despesas.getId_despesa() == null) {
            throw new IllegalArgumentException("ID da despesa não pode ser nulo.");
        }

        String sql = "UPDATE despesas SET nome_despesa = ?, descricao_despesa = ?, valor_despesa = ?, data_despesa = ? WHERE id_despesa = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, despesas.getNome_despesa());
            stmt.setString(2, despesas.getDescricao_despesa());
            stmt.setDouble(3, despesas.getValor_despesa());

            // Verifica se data_de_pedido não é null
            if (despesas.getData_despesa()!= null) {
                stmt.setDate(4, new java.sql.Date(despesas.getData_despesa().getTime()));
            } else {
                stmt.setNull(4, java.sql.Types.DATE);
            }

            stmt.setLong(7, despesas.getId_despesa());

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

    public boolean existeDespesaId(Long despesaId) {
        String sql = "SELECT COUNT(*) FROM despesas WHERE id_despesa = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, despesaId); // Usando setLong para Long
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Retorna true se o conta_id existir
            }
        } catch (SQLException e) {
            // Tratamento de exceção
        }
        return false; // Retorna false se ocorrer qualquer erro
    }

}
