package dao;

import connection.SingleConnectionBanco;
import model.ModelDespesas;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.*;

public class DAODespesas {
    private final Connection connection;

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

            stmt.executeUpdate();

            // Recupera a chave gerada automaticamente (ID)
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                despesas.setId_despesa(generatedKeys.getLong(1));
            }

            connection.commit(); // Confirma a transação
        } catch (SQLException e) {

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

            // Define o ID da despesa corretamente
            stmt.setLong(6, despesas.getId_despesa());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Atualização bem-sucedida, linhas afetadas: " + rowsAffected);
            } else {
                System.out.println("Nenhuma linha foi atualizada.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Erro ao atualizar a despesa: " + e.getMessage(), e);
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
                System.out.println("Exclusão bem-sucedida, linhas afetadas: " + rowsAffected);
            } else {
                throw new SQLException("Nenhuma despesa foi excluída.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
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



    public List<ModelDespesas> listarDespesasPorPeriodo(String dataInicio, String dataFim) throws SQLException {
        List<ModelDespesas> despesasMes = new ArrayList<>();

        // Definindo o formato da data (ajuste conforme o formato que você está usando)
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  // Ajuste conforme o formato da data

        try {
            // Convertendo as strings para objetos Date
            Date inicio = sdf.parse(dataInicio);
            Date fim = sdf.parse(dataFim);

            // Consulta SQL com parâmetros para o intervalo de datas
            String sql = "SELECT * FROM despesas WHERE data_despesa >= ? AND data_despesa <= ? ORDER BY data_despesa DESC";

            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                // Definindo os parâmetros da consulta
                stmt.setDate(1, new java.sql.Date(inicio.getTime())); // Convertendo Date para java.sql.Date
                stmt.setDate(2, new java.sql.Date(fim.getTime()));    // Convertendo Date para java.sql.Date

                // Executando a consulta
                ResultSet rs = stmt.executeQuery();

                // Processando o resultado
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
        }

        return despesasMes;
    }
    public double somarDespesasDinheiroPorPeriodo(String dataInicio, String dataFim) throws SQLException {

        String sql =
                "SELECT COALESCE(SUM(valor_despesa), 0) AS total_dinheiro " +
                        "FROM despesas " +
                        "WHERE pagamento_despesa = 'DINHEIRO' " +
                        "AND data_despesa >= ? " +
                        "AND data_despesa <= ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setDate(1, java.sql.Date.valueOf(dataInicio));
            stmt.setDate(2, java.sql.Date.valueOf(dataFim));

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total_dinheiro");
            }
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

    public BigDecimal buscarTotalDespesasPorPeriodo(String dataInicial, String dataFinal) throws SQLException {
        BigDecimal total = BigDecimal.ZERO;
        String sql = "SELECT SUM(valor_despesa) AS total_despesas FROM despesas WHERE data_despesa >= ? AND data_despesa <= ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, java.sql.Date.valueOf(LocalDate.parse(dataInicial)));
            statement.setDate(2, java.sql.Date.valueOf(LocalDate.parse(dataFinal)));

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    total = rs.getBigDecimal("total_despesas");
                    // Se o resultado for nulo, retorne zero
                    if (total == null) {
                        total = BigDecimal.ZERO;
                    }
                }
            }
        }
        return total;
    }


}
