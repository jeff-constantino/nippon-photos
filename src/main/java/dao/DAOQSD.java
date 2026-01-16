package dao;

import connection.ConnectionPool;
import model.ModelCrediarioQSD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAOQSD {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAOQSD(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAOQSD() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public ModelCrediarioQSD gravarQSD(ModelCrediarioQSD model) throws Exception {
        if (model.getId() != null && model.getId() > 0 && existe(model.getId())) {
            return atualizar(model);
        } else {
            return inserir(model);
        }
    }

    private boolean existe(Long id) throws SQLException {
        String sql = "SELECT 1 FROM public.qsd WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private ModelCrediarioQSD inserir(ModelCrediarioQSD model) throws Exception {
        String sql = "INSERT INTO public.qsd (cliente, empresa, produtos, valor, datavenda, desconto, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, model.getCliente());
            stmt.setString(2, model.getEmpresa());
            stmt.setString(3, model.getProdutos());
            stmt.setBigDecimal(4, model.getValor());
            stmt.setDate(5, new java.sql.Date(model.getDatavenda().getTime()));
            stmt.setBigDecimal(6, model.getDesconto() != null ? model.getDesconto() : java.math.BigDecimal.ZERO);
            stmt.setString(7, "A Receber");
            stmt.executeUpdate();
            if (gerenciarTransacao) connection.commit();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) model.setId(rs.getLong(1));
            }
        } catch (Exception e) {
            if (gerenciarTransacao) connection.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return model;
    }

    private ModelCrediarioQSD atualizar(ModelCrediarioQSD model) throws Exception {
        String sql = "UPDATE public.qsd SET cliente = ?, empresa = ?, produtos = ?, valor = ?, datavenda = ?, datapagamento = ?, forma = ?, desconto = ?, valorpago = ?, status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, model.getCliente());
            stmt.setString(2, model.getEmpresa());
            stmt.setString(3, model.getProdutos());
            stmt.setBigDecimal(4, model.getValor());
            stmt.setDate(5, new java.sql.Date(model.getDatavenda().getTime()));
            if (model.getDatapagamento() != null) {
                stmt.setDate(6, new java.sql.Date(model.getDatapagamento().getTime()));
            } else {
                stmt.setDate(6, null);
            }
            stmt.setString(7, model.getForma());
            stmt.setBigDecimal(8, model.getDesconto() != null ? model.getDesconto() : java.math.BigDecimal.ZERO);
            stmt.setBigDecimal(9, model.getValorpago());
            stmt.setString(10, model.getStatus());
            stmt.setLong(11, model.getId());
            stmt.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (Exception e) {
            if (gerenciarTransacao) connection.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return model;
    }

    public List<ModelCrediarioQSD> buscarPorCliente(String cliente, String empresa) throws SQLException {
        List<ModelCrediarioQSD> lista = new ArrayList<>();
        String sql = "SELECT * FROM public.qsd WHERE LOWER(cliente) = LOWER(?) AND LOWER(empresa) = LOWER(?) ORDER BY datavenda DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, cliente);
            stmt.setString(2, empresa);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) lista.add(mapearResultSet(rs));
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return lista;
    }

    public List<ModelCrediarioQSD> buscarPorPeriodo(Date dataInicio, Date dataFim) throws SQLException {
        List<ModelCrediarioQSD> lista = new ArrayList<>();
        String sql = "SELECT * FROM public.qsd WHERE datavenda BETWEEN ? AND ? ORDER BY datavenda DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(dataInicio.getTime()));
            stmt.setDate(2, new java.sql.Date(dataFim.getTime()));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) lista.add(mapearResultSet(rs));
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return lista;
    }

    public List<ModelCrediarioQSD> buscarPorClienteEPeriodo(String cliente, String empresa, Date dataInicio, Date dataFim) throws SQLException {
        List<ModelCrediarioQSD> lista = new ArrayList<>();
        String sql = "SELECT * FROM public.qsd WHERE LOWER(cliente) = LOWER(?) AND LOWER(empresa) = LOWER(?) AND datavenda BETWEEN ? AND ? ORDER BY datavenda DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, cliente);
            stmt.setString(2, empresa);
            stmt.setDate(3, new java.sql.Date(dataInicio.getTime()));
            stmt.setDate(4, new java.sql.Date(dataFim.getTime()));
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) lista.add(mapearResultSet(rs));
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return lista;
    }

    public List<ModelCrediarioQSD> buscarTodos() throws SQLException {
        List<ModelCrediarioQSD> lista = new ArrayList<>();
        String sql = "SELECT * FROM public.qsd ORDER BY datavenda DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) lista.add(mapearResultSet(rs));
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return lista;
    }

    public ModelCrediarioQSD buscarPorId(Long id) throws SQLException {
        String sql = "SELECT * FROM public.qsd WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapearResultSet(rs);
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return null;
    }

    public List<ModelCrediarioQSD> getClientesUnicos() throws SQLException {
        List<ModelCrediarioQSD> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT cliente, empresa FROM public.qsd ORDER BY cliente";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ModelCrediarioQSD m = new ModelCrediarioQSD();
                m.setCliente(rs.getString("cliente"));
                m.setEmpresa(rs.getString("empresa"));
                lista.add(m);
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return lista;
    }

    private ModelCrediarioQSD mapearResultSet(ResultSet rs) throws SQLException {
        ModelCrediarioQSD model = new ModelCrediarioQSD();
        model.setId(rs.getLong("id"));
        model.setCliente(rs.getString("cliente"));
        model.setEmpresa(rs.getString("empresa"));
        model.setProdutos(rs.getString("produtos"));
        model.setValor(rs.getBigDecimal("valor"));
        model.setDatavenda(rs.getDate("datavenda"));
        model.setDatapagamento(rs.getDate("datapagamento"));
        model.setForma(rs.getString("forma"));
        model.setDesconto(rs.getBigDecimal("desconto"));
        model.setValorpago(rs.getBigDecimal("valorpago"));
        model.setStatus(rs.getString("status"));
        return model;
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