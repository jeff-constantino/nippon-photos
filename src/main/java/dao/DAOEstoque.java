package dao;

import connection.HikariCPUtil;
import model.ModelEstoque;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOEstoque {

    public ModelEstoque buscarPorCodBarra(String codBarra) throws Exception {
        String sql = "SELECT * FROM estoque_produto WHERE cod_barra = ?";
        try (Connection conn = HikariCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codBarra);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ModelEstoque m = new ModelEstoque();
                    m.setProdutoId(rs.getLong("id"));
                    m.setNome(rs.getString("nome"));
                    m.setMarca(rs.getString("marca"));
                    m.setPeso(rs.getString("peso"));
                    m.setCodBarra(rs.getString("cod_barra"));
                    m.setEstoqueAtual(rs.getInt("estoque_atual"));
                    m.setValorCompra(rs.getBigDecimal("valor_compra"));
                    m.setValorVenda(rs.getBigDecimal("valor_venda"));
                    return m;
                }
            }
        }
        return null;
    }

    public void salvarProduto(ModelEstoque p, Connection conn) throws Exception {
        String sql = "INSERT INTO estoque_produto (cod_barra, nome, marca, peso, valor_compra, valor_venda, estoque_atual) VALUES (?,?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getCodBarra());
            ps.setString(2, p.getNome());
            ps.setString(3, p.getMarca());
            ps.setString(4, p.getPeso());
            ps.setBigDecimal(5, p.getValorCompra());
            ps.setBigDecimal(6, p.getValorVenda());
            ps.setInt(7, p.getEstoqueAtual());
            ps.execute();
        }
    }

    public void atualizarProduto(ModelEstoque p, Connection conn) throws Exception {
        String sql = "UPDATE estoque_produto SET cod_barra = ?, nome = ?, marca = ?, peso = ?, estoque_atual = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getCodBarra());
            ps.setString(2, p.getNome());
            ps.setString(3, p.getMarca());
            ps.setString(4, p.getPeso());
            ps.setInt(5, p.getEstoqueAtual());
            ps.setLong(6, p.getProdutoId());
            ps.executeUpdate();
        }
    }

    public void registrarMovimento(ModelEstoque mov, Connection conn) throws Exception {
        String sqlMov = "INSERT INTO estoque_movimento (produto_id, quantidade, tipo_movimento, motivo, observacao) VALUES (?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sqlMov)) {
            ps.setLong(1, mov.getProdutoId());
            ps.setInt(2, mov.getQuantidade());
            ps.setString(3, mov.getTipoMovimento());
            ps.setString(4, mov.getMotivo());
            ps.setString(5, mov.getObservacao());
            ps.execute();
        }
        String op = (mov.getTipoMovimento().equals("ENTRADA") || mov.getMotivo().contains("DEVOLUCAO")) ? "+" : "-";
        String sqlUpdate = "UPDATE estoque_produto SET estoque_atual = estoque_atual " + op + " ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
            ps.setInt(1, mov.getQuantidade());
            ps.setLong(2, mov.getProdutoId());
            ps.execute();
        }
    }

    public List<ModelEstoque> listarMovimentacoes(String inicio, String fim, String tipo) throws Exception {
        List<ModelEstoque> lista = new ArrayList<>();
        String sql = "SELECT m.*, p.nome, p.cod_barra, p.marca, p.peso FROM estoque_movimento m " +
                "JOIN estoque_produto p ON p.id = m.produto_id " +
                "WHERE m.data_movimento::date BETWEEN ?::date AND ?::date ";
        if ("ENTRADA".equals(tipo) || "SAIDA".equals(tipo)) sql += " AND m.tipo_movimento = '" + tipo + "'";
        sql += " ORDER BY m.data_movimento DESC";

        try (Connection conn = HikariCPUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, inicio); ps.setString(2, fim);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ModelEstoque m = new ModelEstoque();
                m.setNome(rs.getString("nome"));
                m.setMarca(rs.getString("marca"));
                m.setPeso(rs.getString("peso"));
                m.setCodBarra(rs.getString("cod_barra"));
                m.setQuantidade(rs.getInt("quantidade"));
                m.setTipoMovimento(rs.getString("tipo_movimento"));
                m.setMotivo(rs.getString("motivo"));
                m.setObservacao(rs.getString("observacao"));
                m.setDataMovimento(rs.getTimestamp("data_movimento").toLocalDateTime());
                lista.add(m);
            }
        }
        return lista;
    }

    public List<ModelEstoque> gerarRelatorioResumido(String inicio, String fim) throws Exception {
        List<ModelEstoque> lista = new ArrayList<>();
        String sql = "SELECT p.id, p.nome, p.marca, p.peso, p.estoque_atual, " +
                "COALESCE((SELECT SUM(quantidade) FROM estoque_movimento WHERE produto_id = p.id AND (tipo_movimento = 'ENTRADA' OR motivo LIKE '%DEVOLUCAO%') AND data_movimento::date BETWEEN ?::date AND ?::date), 0) as entradas, " +
                "COALESCE((SELECT SUM(quantidade) FROM estoque_movimento WHERE produto_id = p.id AND tipo_movimento = 'SAIDA' AND data_movimento::date BETWEEN ?::date AND ?::date), 0) as saidas " +
                "FROM estoque_produto p ORDER BY p.nome";

        try (Connection conn = HikariCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, inicio);
            ps.setString(2, fim);
            ps.setString(3, inicio);
            ps.setString(4, fim);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ModelEstoque m = new ModelEstoque();
                m.setNome(rs.getString("nome"));
                m.setMarca(rs.getString("marca"));
                m.setPeso(rs.getString("peso"));
                m.setEstoqueAtual(rs.getInt("estoque_atual"));
                m.setEntradasNoPeriodo(rs.getInt("entradas"));
                m.setSaidasNoPeriodo(rs.getInt("saidas"));
                m.setEstoqueInicialNoPeriodo(m.getEstoqueAtual() - m.getEntradasNoPeriodo() + m.getSaidasNoPeriodo());
                lista.add(m);
            }
        }
        return lista;
    }

    public List<String> listarMarcasDistintas() throws Exception {
        List<String> marcas = new ArrayList<>();
        String sql = "SELECT DISTINCT marca FROM estoque_produto WHERE marca IS NOT NULL AND marca != '' ORDER BY marca";
        try (Connection conn = HikariCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                marcas.add(rs.getString("marca"));
            }
        }
        return marcas;
    }

    public List<String> listarPesosDistintos() throws Exception {
        List<String> pesos = new ArrayList<>();
        String sql = "SELECT DISTINCT peso FROM estoque_produto WHERE peso IS NOT NULL AND peso != '' ORDER BY peso";
        try (Connection conn = HikariCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                pesos.add(rs.getString("peso"));
            }
        }
        return pesos;
    }

    public List<ModelEstoque> listarProdutosEstoqueBaixo() throws Exception {
        List<ModelEstoque> lista = new ArrayList<>();
        String sql = "SELECT * FROM estoque_produto WHERE estoque_atual <= 5 ORDER BY estoque_atual ASC, nome";
        try (Connection conn = HikariCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ModelEstoque m = new ModelEstoque();
                m.setProdutoId(rs.getLong("id"));
                m.setCodBarra(rs.getString("cod_barra"));
                m.setNome(rs.getString("nome"));
                m.setMarca(rs.getString("marca"));
                m.setPeso(rs.getString("peso"));
                m.setEstoqueAtual(rs.getInt("estoque_atual"));
                lista.add(m);
            }
        }
        return lista;
    }

    public List<ModelEstoque> listarTodosProdutos() throws Exception {
        List<ModelEstoque> lista = new ArrayList<>();
        String sql = "SELECT * FROM estoque_produto ORDER BY nome";
        try (Connection conn = HikariCPUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ModelEstoque m = new ModelEstoque();
                m.setProdutoId(rs.getLong("id"));
                m.setCodBarra(rs.getString("cod_barra"));
                m.setNome(rs.getString("nome"));
                m.setMarca(rs.getString("marca"));
                m.setPeso(rs.getString("peso"));
                m.setEstoqueAtual(rs.getInt("estoque_atual"));
                lista.add(m);
            }
        }
        return lista;
    }
}