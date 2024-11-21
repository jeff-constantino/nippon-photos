package dao;

import connection.SingleConnectionBanco;
import model.ModelDespesas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAODespesas {
    private Connection connection;

    public DAODespesas() {
        connection = SingleConnectionBanco.getConnection();
    }

    // Método para gravar uma nova despesa
    public void gravarDespesa(ModelDespesas despesas) throws Exception {
        String sql = "INSERT INTO despesas (nome_despesa, descricao_despesa, valor_despesa, pagamento_despesa, data_despesa) VALUES (UPPER(?), UPPER(?), ?, UPPER(?), ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, despesas.getNome_despesa());
            stmt.setString(2, despesas.getDescricao_despesa());
            stmt.setDouble(3, despesas.getValor_despesa());
            stmt.setString(4, despesas.getPagamento_despesa());

            // Verifica se data_despesa não é null
            if (despesas.getData_despesa() != null) {
                stmt.setDate(5, new java.sql.Date(despesas.getData_despesa().getTime())); // Corrigido para a posição 4
            } else {
                stmt.setNull(5, java.sql.Types.DATE); // Seta como null no banco na posição 4
            }
            System.out.println(despesas);
            stmt.executeUpdate();

            // Recupera a chave gerada automaticamente (ID)
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                despesas.setId_despesa(generatedKeys.getLong(1));
            }

            connection.commit(); // Confirma a transação
        } catch (SQLException e) {
            connection.rollback(); // Desfaz a transação em caso de erro
            throw new Exception("Erro ao gravar Despesa: " + e.getMessage(), e);
        }
    }

    // Método para atualizar uma despesa existente
    public void atualizarDespesa(ModelDespesas despesas) throws Exception {
        if (despesas.getId_despesa() == null) {
            throw new IllegalArgumentException("ID da despesa não pode ser nulo.");
        }

        String sql = "UPDATE despesas SET nome_despesa = UPPER(?), descricao_despesa = UPPER(?), valor_despesa = ?, pagamento_despesa = UPPER(?), data_despesa = ? WHERE id_despesa = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, despesas.getNome_despesa());
            stmt.setString(2, despesas.getDescricao_despesa());
            stmt.setDouble(3, despesas.getValor_despesa());
            stmt.setString(4, despesas.getPagamento_despesa());

            // Verifica se data_despesa não é null
            if (despesas.getData_despesa() != null) {
                stmt.setDate(5, new java.sql.Date(despesas.getData_despesa().getTime()));
            } else {
                stmt.setNull(5, java.sql.Types.DATE);
            }

            // Corrigido o índice para definir o ID corretamente
            stmt.setLong(5, despesas.getId_despesa());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                connection.commit(); // Commit para confirmar a transação
                System.out.println("Atualização bem-sucedida, linhas afetadas: " + rowsAffected);
            } else {
                System.out.println("Nenhuma linha foi atualizada.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback(); // Rollback em caso de erro
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
    }

    // Método para verificar se uma despesa com o ID existe
    public boolean existeDespesaId(Long despesaId) {
        String sql = "SELECT COUNT(*) FROM despesas WHERE id_despesa = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, despesaId); // Usando setLong para Long
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Retorna true se o id_despesa existir
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Tratamento de exceção
        }
        return false; // Retorna false se ocorrer qualquer erro
    }


    public void excluirDespesa(Long id_despesa) throws SQLException {
        String sql = "DELETE FROM despesas WHERE id_despesa = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id_despesa);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                connection.commit(); // Confirma a transação
            } else {
                throw new SQLException("Nenhuma despesa foi excluída.");
            }
        } catch (SQLException e) {
            connection.rollback(); // Rollback em caso de erro
            throw new SQLException("Erro ao excluir despesa", e);
        }
    }



    public List<ModelDespesas> listarDespesasUltimos60Dias() throws SQLException {
        List<ModelDespesas> despesasList = new ArrayList<>();

        // Mantendo o uso da conexão inicializada no construtor
        String sql = "SELECT * FROM despesas WHERE data_despesa >= CURRENT_DATE - INTERVAL '60' DAY ORDER BY data_despesa DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) { // Usando a conexão já existente
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
            throw new SQLException("Erro ao listar despesas", e); // Re-lança a exceção com uma mensagem clara
        }

        return despesasList;
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
        }

        return todasDespesasList;
    }
    public int contarTotalDespesas() throws SQLException {
        String sql = "SELECT COUNT(*) FROM despesas";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }




}
