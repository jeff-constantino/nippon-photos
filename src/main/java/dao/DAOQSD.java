package dao;

import connection.SingleConnectionBanco;
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

    public DAOQSD() {
        connection = SingleConnectionBanco.getConnection();
    }

    /* =====================================================
       INSERT OU UPDATE
       ===================================================== */
    public ModelCrediarioQSD gravarQSD(ModelCrediarioQSD model) throws Exception {

        if (model.getId() != null && model.getId() > 0 && existe(model.getId())) {
            return atualizar(model);
        } else {
            return inserir(model);
        }
    }

    /* =====================================================
       VERIFICA SE EXISTE
       ===================================================== */
    private boolean existe(Long id) throws SQLException {

        String sql = "SELECT 1 FROM public.qsd WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /* =====================================================
       INSERT
       ===================================================== */
    private ModelCrediarioQSD inserir(ModelCrediarioQSD model) throws Exception {

        String sql =
                "INSERT INTO public.qsd " +
                        "(cliente, empresa, produtos, valor, datavenda, desconto, status) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt =
                     connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, model.getCliente());
            stmt.setString(2, model.getEmpresa());
            stmt.setString(3, model.getProdutos());
            stmt.setBigDecimal(4, model.getValor());
            stmt.setDate(5, new java.sql.Date(model.getDatavenda().getTime()));
            stmt.setBigDecimal(6,
                    model.getDesconto() != null ? model.getDesconto() : java.math.BigDecimal.ZERO);
            stmt.setString(7, "A Receber");

            stmt.executeUpdate();
            connection.commit();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    model.setId(rs.getLong(1));
                }
            }

        } catch (Exception e) {
            connection.rollback();
            throw e;
        }

        return model;
    }

    /* =====================================================
       UPDATE
       ===================================================== */
    private ModelCrediarioQSD atualizar(ModelCrediarioQSD model) throws Exception {

        String sql =
                "UPDATE public.qsd SET " +
                        "cliente = ?, " +
                        "empresa = ?, " +
                        "produtos = ?, " +
                        "valor = ?, " +
                        "datavenda = ?, " +
                        "datapagamento = ?, " +
                        "forma = ?, " +
                        "desconto = ?, " +
                        "valorpago = ?, " +
                        "status = ? " +
                        "WHERE id = ?";

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
            stmt.setBigDecimal(8,
                    model.getDesconto() != null ? model.getDesconto() : java.math.BigDecimal.ZERO);
            stmt.setBigDecimal(9, model.getValorpago());
            stmt.setString(10, model.getStatus());
            stmt.setLong(11, model.getId());

            stmt.executeUpdate();
            connection.commit();

        } catch (Exception e) {
            connection.rollback();
            throw e;
        }

        return model;
    }

    /* =====================================================
       BUSCAR POR NOME
       ===================================================== */
    public List<ModelCrediarioQSD> buscarPorNome(String nome) throws SQLException {

        List<ModelCrediarioQSD> lista = new ArrayList<>();

        String sql = "SELECT * FROM public.qsd WHERE LOWER(cliente) LIKE LOWER(?) ORDER BY datavenda DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + nome + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearResultSet(rs));
                }
            }
        }

        return lista;
    }

    /* =====================================================
       BUSCAR POR PERÍODO
       ===================================================== */
    public List<ModelCrediarioQSD> buscarPorPeriodo(Date dataInicio, Date dataFim) throws SQLException {

        List<ModelCrediarioQSD> lista = new ArrayList<>();

        String sql = "SELECT * FROM public.qsd WHERE datavenda BETWEEN ? AND ? ORDER BY datavenda DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(dataInicio.getTime()));
            stmt.setDate(2, new java.sql.Date(dataFim.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearResultSet(rs));
                }
            }
        }

        return lista;
    }

    /* =====================================================
       BUSCAR POR NOME E PERÍODO
       ===================================================== */
    public List<ModelCrediarioQSD> buscarPorNomeEPeriodo(String nome, Date dataInicio, Date dataFim) throws SQLException {

        List<ModelCrediarioQSD> lista = new ArrayList<>();

        String sql = "SELECT * FROM public.qsd WHERE LOWER(cliente) LIKE LOWER(?) " +
                "AND datavenda BETWEEN ? AND ? ORDER BY datavenda DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + nome + "%");
            stmt.setDate(2, new java.sql.Date(dataInicio.getTime()));
            stmt.setDate(3, new java.sql.Date(dataFim.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearResultSet(rs));
                }
            }
        }

        return lista;
    }

    /* =====================================================
       BUSCAR TODOS
       ===================================================== */
    public List<ModelCrediarioQSD> buscarTodos() throws SQLException {

        List<ModelCrediarioQSD> lista = new ArrayList<>();

        String sql = "SELECT * FROM public.qsd ORDER BY datavenda DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearResultSet(rs));
            }
        }

        return lista;
    }

    /* =====================================================
       BUSCAR POR ID
       ===================================================== */
    public ModelCrediarioQSD buscarPorId(Long id) throws SQLException {

        String sql = "SELECT * FROM public.qsd WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearResultSet(rs);
                }
            }
        }

        return null;
    }

    /* =====================================================
       LISTAR CLIENTES UNICOS
       ===================================================== */
    public List<ModelCrediarioQSD> listarClientesUnicos() throws SQLException {

        List<ModelCrediarioQSD> lista = new ArrayList<>();

        String sql = "SELECT DISTINCT cliente, empresa FROM public.qsd ORDER BY cliente";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ModelCrediarioQSD model = new ModelCrediarioQSD();
                model.setCliente(rs.getString("cliente"));
                model.setEmpresa(rs.getString("empresa"));
                lista.add(model);
            }
        }

        return lista;
    }

    /* =====================================================
       MAPEAR RESULTSET PARA MODEL
       ===================================================== */
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
}