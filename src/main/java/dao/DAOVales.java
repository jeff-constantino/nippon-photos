package dao;

import connection.SingleConnectionBanco;
import model.ModelVales;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOVales {

    private final Connection connection;

    // Construtor para inicializar a conexão com o banco
    public DAOVales() {
        this.connection = SingleConnectionBanco.getConnection();
    }
    public List<ModelVales> buscarValesUltimos30Dias() throws Exception {
        List<ModelVales> vales = new ArrayList<>();

        String sql = "SELECT id_vale, nome_funcionario, data, observacao, valor, forma_pagamento " +
                "FROM vales WHERE data >= ? ORDER BY data DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            LocalDate trintaDiasAtras = LocalDate.now().minusDays(30);
            stmt.setDate(1, java.sql.Date.valueOf(trintaDiasAtras));

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
        }

        return vales;
    }


    // Método para inserir um vale
    public boolean inserirVale(ModelVales vale) {
        String sql = "INSERT INTO vales (id_funcionario, nome_funcionario, data, observacao, valor, forma_pagamento) VALUES (?, ?, ?, UPPER(?), ?, UPPER(?))";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Configura os parâmetros
            stmt.setLong(1, vale.getId_funcionario()); // Adiciona o ID do funcionário
            stmt.setString(2, vale.getNome_funcionario());
            stmt.setDate(3, Date.valueOf(vale.getData())); // Convertendo LocalDate para Date
            stmt.setString(4, vale.getObservacao());
            stmt.setBigDecimal(5, vale.getValor());
            stmt.setString(6, vale.getForma_pagamento());

            // Executa o comando SQL
            int rowsAffected = stmt.executeUpdate();

            // Dá commit manualmente
            connection.commit();

            return rowsAffected > 0;
        } catch (SQLException e) {
            try {
                // Em caso de erro, faz rollback
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        }
    }

    public BigDecimal somarValesPorFuncionarioEPeriodo(Long funcionarioId, LocalDate dataInicial, LocalDate dataFinal) throws Exception {
        BigDecimal totalVales = BigDecimal.ZERO;
        String sql = "SELECT SUM(valor) FROM vales WHERE id_funcionario = ? AND data BETWEEN ? AND ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, funcionarioId);
            stmt.setDate(2, java.sql.Date.valueOf(dataInicial));
            stmt.setDate(3, java.sql.Date.valueOf(dataFinal));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalVales = rs.getBigDecimal(1);
                if (totalVales == null) {
                    totalVales = BigDecimal.ZERO;
                }
            }
        }

        return totalVales;
    }





    public boolean excluirVale(long idVale) {
        String sql = "DELETE FROM vales WHERE id_vale = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, idVale);

            // Executa a operação de exclusão
            int rowsAffected = stmt.executeUpdate();

            // Se o autocommit estiver desabilitado, é necessário fazer o commit manualmente
            if (rowsAffected > 0) {
                connection.commit(); // Comita a transação
            }

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback(); // Em caso de erro, faz o rollback
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
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
                vale.setId_funcionario(rs.getLong("id_funcionario")); // corrigido conforme o nome da coluna
                vale.setValor(rs.getBigDecimal("valor"));
                vale.setData(rs.getDate("data").toLocalDate()); // corrigido conforme o nome da coluna
                vale.setObservacao(rs.getString("observacao")); // corrigido conforme o nome da coluna
                vale.setNome_funcionario(rs.getString("nome_funcionario"));
                vale.setForma_pagamento(rs.getString("forma_pagamento"));
                vales.add(vale);
            }
        }

        return vales;
    }



}
