package dao;

import connection.SingleConnectionBanco;
import model.ModelFechaDia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class DAOFechaDia {
    private Connection connection;

    public DAOFechaDia() {
        connection = SingleConnectionBanco.getConnection();
    }

    // Método para gravar fechamento do dia
    public void gravarFechaDia(ModelFechaDia fechaDia) throws Exception {
        String sql = "INSERT INTO fecha_dia (data_fechamento, total_ft_din, total_ft_deb, total_ft_cred, total_ft_pix, " +
                "total_enc_din, total_enc_deb, total_enc_cred, total_enc_pix, " +
                "total_dig_din, total_dig_deb, total_dig_cred, total_dig_pix, " +
                "total_ribbon_1, total_ribbon_2, total_ribbon_3, total_ribbon_4, total_ribbon_5, total_ribbon_6, " +
                "desconto, observacao) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setDate(1, new java.sql.Date(fechaDia.getData_fechamento().getTime()));
            stmt.setInt(2, fechaDia.getTotal_ft_din());
            stmt.setInt(3, fechaDia.getTotal_ft_deb());
            stmt.setInt(4, fechaDia.getTotal_ft_cred());
            stmt.setInt(5, fechaDia.getTotal_ft_pix());

            stmt.setInt(6, fechaDia.getTotal_enc_din());
            stmt.setInt(7, fechaDia.getTotal_enc_deb());
            stmt.setInt(8, fechaDia.getTotal_enc_cred());
            stmt.setInt(9, fechaDia.getTotal_enc_pix());

            stmt.setInt(10, fechaDia.getTotal_dig_din());
            stmt.setInt(11, fechaDia.getTotal_dig_deb());
            stmt.setInt(12, fechaDia.getTotal_dig_cred());
            stmt.setInt(13, fechaDia.getTotal_dig_pix());

            stmt.setInt(14, fechaDia.getTotal_ribbon_1());
            stmt.setInt(15, fechaDia.getTotal_ribbon_2());
            stmt.setInt(16, fechaDia.getTotal_ribbon_3());
            stmt.setInt(17, fechaDia.getTotal_ribbon_4());
            stmt.setInt(18, fechaDia.getTotal_ribbon_5());
            stmt.setInt(19, fechaDia.getTotal_ribbon_6());

            stmt.setBigDecimal(20, fechaDia.getDesconto());
            stmt.setString(21, fechaDia.getObservacao());

            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                fechaDia.setId(generatedKeys.getLong(1));
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new Exception("Erro ao gravar fechamento do dia: " + e.getMessage(), e);
        }
    }

    public boolean existeFechaDiaId(Long contaId) {
        // Lógica para verificar se o conta_id já existe no banco de dados
        String sql = "SELECT COUNT(*) FROM fecha_dia WHERE conta_id = ?";
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

    // Método para atualizar fechamento do dia
    public void atualizarFechaDia(ModelFechaDia fechaDia) throws Exception {
        if (fechaDia.getId() == 0) {
            throw new IllegalArgumentException("ID do fechamento não pode ser nulo.");
        }

        String sql = "UPDATE fecha_dia SET data_fechamento = ?, total_ft_din = ?, total_ft_deb = ?, total_ft_cred = ?, total_ft_pix = ?, " +
                "total_enc_din = ?, total_enc_deb = ?, total_enc_cred = ?, total_enc_pix = ?, " +
                "total_dig_din = ?, total_dig_deb = ?, total_dig_cred = ?, total_dig_pix = ?, " +
                "total_ribbon_1 = ?, total_ribbon_2 = ?, total_ribbon_3 = ?, total_ribbon_4 = ?, total_ribbon_5 = ?, total_ribbon_6 = ?, " +
                "desconto = ?, observacao = ? WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, new java.sql.Date(fechaDia.getData_fechamento().getTime()));
            stmt.setInt(2, fechaDia.getTotal_ft_din());
            stmt.setInt(3, fechaDia.getTotal_ft_deb());
            stmt.setInt(4, fechaDia.getTotal_ft_cred());
            stmt.setInt(5, fechaDia.getTotal_ft_pix());

            stmt.setInt(6, fechaDia.getTotal_enc_din());
            stmt.setInt(7, fechaDia.getTotal_enc_deb());
            stmt.setInt(8, fechaDia.getTotal_enc_cred());
            stmt.setInt(9, fechaDia.getTotal_enc_pix());

            stmt.setInt(10, fechaDia.getTotal_dig_din());
            stmt.setInt(11, fechaDia.getTotal_dig_deb());
            stmt.setInt(12, fechaDia.getTotal_dig_cred());
            stmt.setInt(13, fechaDia.getTotal_dig_pix());

            stmt.setInt(14, fechaDia.getTotal_ribbon_1());
            stmt.setInt(15, fechaDia.getTotal_ribbon_2());
            stmt.setInt(16, fechaDia.getTotal_ribbon_3());
            stmt.setInt(17, fechaDia.getTotal_ribbon_4());
            stmt.setInt(18, fechaDia.getTotal_ribbon_5());
            stmt.setInt(19, fechaDia.getTotal_ribbon_6());

            stmt.setBigDecimal(20, fechaDia.getDesconto());
            stmt.setString(21, fechaDia.getObservacao());
            stmt.setLong(22, fechaDia.getId());

            stmt.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new Exception("Erro ao atualizar fechamento do dia: " + e.getMessage(), e);
        }
    }

    // Método para buscar fechamento por ID
    public ModelFechaDia buscarFechaDiaPorId(Long id) throws SQLException {
        ModelFechaDia fechaDia = null;
        String sql = "SELECT * FROM fecha_dia WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                fechaDia = new ModelFechaDia();
                fechaDia.setId(rs.getLong("id"));
                fechaDia.setData_fechamento(rs.getDate("data_fechamento"));
                fechaDia.setTotal_ft_din(rs.getInt("total_ft_din"));
                fechaDia.setTotal_ft_deb(rs.getInt("total_ft_deb"));
                fechaDia.setTotal_ft_cred(rs.getInt("total_ft_cred"));
                fechaDia.setTotal_ft_pix(rs.getInt("total_ft_pix"));

                fechaDia.setTotal_enc_din(rs.getInt("total_enc_din"));
                fechaDia.setTotal_enc_deb(rs.getInt("total_enc_deb"));
                fechaDia.setTotal_enc_cred(rs.getInt("total_enc_cred"));
                fechaDia.setTotal_enc_pix(rs.getInt("total_enc_pix"));

                fechaDia.setTotal_dig_din(rs.getInt("total_dig_din"));
                fechaDia.setTotal_dig_deb(rs.getInt("total_dig_deb"));
                fechaDia.setTotal_dig_cred(rs.getInt("total_dig_cred"));
                fechaDia.setTotal_dig_pix(rs.getInt("total_dig_pix"));

                fechaDia.setTotal_ribbon_1(rs.getInt("total_ribbon_1"));
                fechaDia.setTotal_ribbon_2(rs.getInt("total_ribbon_2"));
                fechaDia.setTotal_ribbon_3(rs.getInt("total_ribbon_3"));
                fechaDia.setTotal_ribbon_4(rs.getInt("total_ribbon_4"));
                fechaDia.setTotal_ribbon_5(rs.getInt("total_ribbon_5"));
                fechaDia.setTotal_ribbon_6(rs.getInt("total_ribbon_6"));

                fechaDia.setDesconto(rs.getBigDecimal("desconto"));
                fechaDia.setObservacao(rs.getString("observacao"));
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar fechamento do dia por ID: " + e.getMessage(), e);
        }
        return fechaDia;
    }

    // Método para listar todos os fechamentos do dia
    public List<ModelFechaDia> listarFechamentos() throws SQLException {
        List<ModelFechaDia> fechamentos = new ArrayList<>();
        String sql = "SELECT * FROM fecha_dia ORDER BY data_fechamento DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelFechaDia fechaDia = new ModelFechaDia();
                fechaDia.setId(rs.getLong("id"));
                fechaDia.setData_fechamento(rs.getDate("data_fechamento"));
                fechaDia.setTotal_ft_din(rs.getInt("total_ft_din"));
                fechaDia.setTotal_ft_deb(rs.getInt("total_ft_deb"));
                fechaDia.setTotal_ft_cred(rs.getInt("total_ft_cred"));
                fechaDia.setTotal_ft_pix(rs.getInt("total_ft_pix"));

                fechaDia.setTotal_enc_din(rs.getInt("total_enc_din"));
                fechaDia.setTotal_enc_deb(rs.getInt("total_enc_deb"));
                fechaDia.setTotal_enc_cred(rs.getInt("total_enc_cred"));
                fechaDia.setTotal_enc_pix(rs.getInt("total_enc_pix"));

                fechaDia.setTotal_dig_din(rs.getInt("total_dig_din"));
                fechaDia.setTotal_dig_deb(rs.getInt("total_dig_deb"));
                fechaDia.setTotal_dig_cred(rs.getInt("total_dig_cred"));
                fechaDia.setTotal_dig_pix(rs.getInt("total_dig_pix"));

                fechaDia.setTotal_ribbon_1(rs.getInt("total_ribbon_1"));
                fechaDia.setTotal_ribbon_2(rs.getInt("total_ribbon_2"));
                fechaDia.setTotal_ribbon_3(rs.getInt("total_ribbon_3"));
                fechaDia.setTotal_ribbon_4(rs.getInt("total_ribbon_4"));
                fechaDia.setTotal_ribbon_5(rs.getInt("total_ribbon_5"));
                fechaDia.setTotal_ribbon_6(rs.getInt("total_ribbon_6"));

                fechaDia.setDesconto(rs.getBigDecimal("desconto"));
                fechaDia.setObservacao(rs.getString("observacao"));

                fechamentos.add(fechaDia);
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao listar fechamentos do dia: " + e.getMessage(), e);
        }

        return fechamentos;
    }
    public void deletarFechamento(long id) throws Exception{
        String sql = "delete from fecha_dia where id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, id);
        preparedSql.executeUpdate();
        connection.commit();
    }


}
