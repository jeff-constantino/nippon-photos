package dao;

import connection.ConnectionPool;
import model.ModelLogin;
import model.ModelVendas;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOFuncionario {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAOFuncionario(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAOFuncionario() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public List<ModelVendas> consultarVendas(String funcionarioId, String dataInicial, String dataFinal, int offset, int limit) throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT v.*, l.nome FROM vendas v INNER JOIN model_login l ON v.vendedor_id = l.id WHERE 1=1 ");
        if (funcionarioId != null && !funcionarioId.isEmpty()) sql.append(" AND l.id = ?");
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }
        sql.append(" ORDER BY v.data_venda ASC LIMIT ? OFFSET ?");
        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (funcionarioId != null && !funcionarioId.isEmpty()) preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }
            preparedSql.setInt(index++, limit);
            preparedSql.setInt(index++, offset);
            ResultSet resultado = preparedSql.executeQuery();
            while (resultado.next()) {
                ModelVendas modelVenda = new ModelVendas();
                modelVenda.setVenda_id(resultado.getLong("venda_id"));
                modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
                modelVenda.setNome(resultado.getString("nome"));
                modelVenda.setProd1_din(resultado.getInt("prod1_din"));
                modelVenda.setProd1_deb(resultado.getInt("prod1_deb"));
                modelVenda.setProd1_cred(resultado.getInt("prod1_cred"));
                modelVenda.setProd1_pix(resultado.getInt("prod1_pix"));
                modelVenda.setProd2_din(resultado.getInt("prod2_din"));
                modelVenda.setProd2_deb(resultado.getInt("prod2_deb"));
                modelVenda.setProd2_cred(resultado.getInt("prod2_cred"));
                modelVenda.setProd2_pix(resultado.getInt("prod2_pix"));
                modelVenda.setProd3_din(resultado.getInt("prod3_din"));
                modelVenda.setProd3_deb(resultado.getInt("prod3_deb"));
                modelVenda.setProd3_cred(resultado.getInt("prod3_cred"));
                modelVenda.setProd3_pix(resultado.getInt("prod3_pix"));
                modelVenda.setSobras(resultado.getInt("sobras"));
                modelVenda.setData_venda(resultado.getDate("data_venda"));
                modelVendasList.add(modelVenda);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar vendas: " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return modelVendasList;
    }

    public List<ModelVendas> consultarRanking(String dataInicial, String dataFinal, int offset, int limit) throws Exception {
        List<ModelVendas> rankingList = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT l.id AS vendedor_id, l.nome, l.apelido, " +  // ← ADICIONADO l.apelido
                        "   SUM(v.prod1_din + v.prod1_deb + v.prod1_cred + v.prod1_pix) AS total_vendas, " +
                        "   SUM(v.prod1_din + v.prod1_deb + v.prod1_cred + v.prod1_pix + v.sobras) AS total_producao, " +
                        "   COUNT(DISTINCT v.data_venda) AS dias_trabalhados " +
                        "FROM vendas v " +
                        "INNER JOIN model_login l ON v.vendedor_id = l.id " +
                        "WHERE 1=1 ");
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') ");
        }
        sql.append(" GROUP BY l.id, l.nome, l.apelido ");  // ← ADICIONADO l.apelido no GROUP BY
        sql.append(" ORDER BY total_vendas DESC LIMIT ? OFFSET ?");
        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }
            preparedSql.setInt(index++, limit);
            preparedSql.setInt(index++, offset);
            ResultSet resultado = preparedSql.executeQuery();
            while (resultado.next()) {
                ModelVendas modelVenda = new ModelVendas();
                modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
                modelVenda.setNome(resultado.getString("nome"));
                modelVenda.setApelido(resultado.getString("apelido"));  // ← ADICIONADO
                modelVenda.setTotalFotosVendidas(resultado.getInt("total_vendas"));
                modelVenda.setTotalProducao(resultado.getInt("total_producao"));
                modelVenda.setDiasTrabalhados(resultado.getInt("dias_trabalhados"));
                rankingList.add(modelVenda);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar ranking: " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return rankingList;
    }

    public int contarVendas(String funcionarioId, String dataInicial, String dataFinal) throws Exception {
        int totalRegistros = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM vendas v INNER JOIN model_login l ON v.vendedor_id = l.id WHERE 1=1 ");
        if (funcionarioId != null && !funcionarioId.isEmpty()) sql.append(" AND l.id = ?");
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }
        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (funcionarioId != null && !funcionarioId.isEmpty()) preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }
            ResultSet resultado = preparedSql.executeQuery();
            if (resultado.next()) totalRegistros = resultado.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao contar vendas: " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return totalRegistros;
    }

    public List<ModelVendas> consultarVendasSemPaginacao(String funcionarioId, String dataInicial, String dataFinal) throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT v.*, l.nome FROM vendas v INNER JOIN model_login l ON v.vendedor_id = l.id WHERE 1=1 ");
        if (funcionarioId != null && !funcionarioId.isEmpty()) sql.append(" AND l.id = ?");
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }
        sql.append(" ORDER BY v.data_venda ASC");
        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (funcionarioId != null && !funcionarioId.isEmpty()) preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }
            ResultSet resultado = preparedSql.executeQuery();
            while (resultado.next()) {
                ModelVendas modelVenda = new ModelVendas();
                modelVenda.setVenda_id(resultado.getLong("venda_id"));
                modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
                modelVenda.setNome(resultado.getString("nome"));
                modelVenda.setProd1_din(resultado.getInt("prod1_din"));
                modelVenda.setProd1_deb(resultado.getInt("prod1_deb"));
                modelVenda.setProd1_cred(resultado.getInt("prod1_cred"));
                modelVenda.setProd1_pix(resultado.getInt("prod1_pix"));
                modelVenda.setProd2_din(resultado.getInt("prod2_din"));
                modelVenda.setProd2_deb(resultado.getInt("prod2_deb"));
                modelVenda.setProd2_cred(resultado.getInt("prod2_cred"));
                modelVenda.setProd2_pix(resultado.getInt("prod2_pix"));
                modelVenda.setProd3_din(resultado.getInt("prod3_din"));
                modelVenda.setProd3_deb(resultado.getInt("prod3_deb"));
                modelVenda.setProd3_cred(resultado.getInt("prod3_cred"));
                modelVenda.setProd3_pix(resultado.getInt("prod3_pix"));
                modelVenda.setSobras(resultado.getInt("sobras"));
                modelVenda.setData_venda(resultado.getDate("data_venda"));
                modelVendasList.add(modelVenda);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar vendas: " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return modelVendasList;
    }

    public List<ModelVendas> consultarVendasFuncionario(String funcionarioId, String dataInicial, String dataFinal, int offset, int limit) throws Exception {
        List<ModelVendas> modelVendasFuncionarioList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT l.nome, SUM(COALESCE(v.ft_total::INTEGER, 0)) AS foto_total, SUM(COALESCE(v.enc_total::INTEGER, 0)) AS encarte_total, SUM(COALESCE(v.dig_total::INTEGER, 0)) AS digital_total, SUM(COALESCE(v.sobras::INTEGER, 0)) AS sobras_total, l.status FROM vendas v INNER JOIN model_login l ON v.vendedor_id = l.id WHERE 1=1 ");
        if (funcionarioId != null && !funcionarioId.isEmpty()) sql.append(" AND l.id = ?");
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }
        sql.append(" GROUP BY l.nome, l.status ORDER BY l.status = 'Ativo' DESC LIMIT ? OFFSET ?");
        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (funcionarioId != null && !funcionarioId.isEmpty()) preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }
            preparedSql.setInt(index++, limit);
            preparedSql.setInt(index++, offset);
            ResultSet resultado = preparedSql.executeQuery();
            while (resultado.next()) {
                ModelVendas modelVendaFuncionario = new ModelVendas();
                modelVendaFuncionario.setNome(resultado.getString("nome"));
                modelVendaFuncionario.setFt_total(resultado.getInt("foto_total"));
                modelVendaFuncionario.setEnc_total(resultado.getInt("encarte_total"));
                modelVendaFuncionario.setDig_total(resultado.getInt("digital_total"));
                modelVendaFuncionario.setSobras(resultado.getInt("sobras_total"));
                modelVendasFuncionarioList.add(modelVendaFuncionario);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar vendas: " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return modelVendasFuncionarioList;
    }

    public int contarVendasFuncionario(String funcionarioId, String dataInicial, String dataFinal) throws Exception {
        int totalResultados = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM (SELECT l.nome FROM vendas v INNER JOIN model_login l ON v.vendedor_id = l.id WHERE l.status = 'Ativo' ");
        if (funcionarioId != null && !funcionarioId.isEmpty()) sql.append(" AND l.id = ?");
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }
        sql.append(" GROUP BY l.nome) AS subquery");
        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (funcionarioId != null && !funcionarioId.isEmpty()) preparedSql.setLong(index++, Long.parseLong(funcionarioId));
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }
            ResultSet resultado = preparedSql.executeQuery();
            if (resultado.next()) totalResultados = resultado.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao contar vendas: " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return totalResultados;
    }

    public List<ModelLogin> buscaFuncionarios() throws Exception {
        List<ModelLogin> funcionarios = new ArrayList<>();
        String sql = "SELECT id, nome, status FROM model_login ORDER BY status = 'Ativo' DESC";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultado = preparedSql.executeQuery()) {
            while (resultado.next()) {
                ModelLogin funcionario = new ModelLogin();
                funcionario.setId(resultado.getLong("id"));
                funcionario.setNome(resultado.getString("nome"));
                funcionario.setStatus(resultado.getString("status"));
                funcionarios.add(funcionario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Erro ao buscar funcionários : " + e.getMessage());
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return funcionarios;
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