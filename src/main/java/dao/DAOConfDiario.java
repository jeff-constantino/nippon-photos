package dao;

import connection.SingleConnectionBanco;
import model.ModelConfDiario;
import model.ModelFechaDia;

import java.sql.*;
import java.util.Calendar;

public class DAOConfDiario {

    private Connection connection;

    public DAOConfDiario() {
        connection = SingleConnectionBanco.getConnection();
    }


//

    public void atualizarConfiguracao(ModelConfDiario confDiario) throws SQLException {
        String sql = "UPDATE conf_dia SET " +
                "valor_din = ?, valor_din_real = ?, valor_din_dif = ?, " +
                "valor_deb = ?, valor_deb_real = ?, valor_deb_dif = ?, " +
                "valor_cred = ?, valor_cred_real = ?, valor_cred_dif = ?, " +
                "valor_pix = ?, valor_pix_real = ?, valor_pix_dif = ?, " +
                "valor_despesa_total = ?, valor_vale_total = ?, valor_descontos = ?, " +
                "valor_total_dia = ?, observacao = UPPER(?), total_revelado = ?, total_informado = ?, " +
                "valor_deb_24h = ?, valor_cred_24h = ? " +
                "WHERE data_fechamento = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setBigDecimal(1, confDiario.getValor_din());
            preparedStatement.setBigDecimal(2, confDiario.getValor_din_real());
            preparedStatement.setBigDecimal(3, confDiario.getValor_din_dif());
            preparedStatement.setBigDecimal(4, confDiario.getValor_deb());
            preparedStatement.setBigDecimal(5, confDiario.getValor_deb_real());
            preparedStatement.setBigDecimal(6, confDiario.getValor_deb_dif());
            preparedStatement.setBigDecimal(7, confDiario.getValor_cred());
            preparedStatement.setBigDecimal(8, confDiario.getValor_cred_real());
            preparedStatement.setBigDecimal(9, confDiario.getValor_cred_dif());
            preparedStatement.setBigDecimal(10, confDiario.getValor_pix());
            preparedStatement.setBigDecimal(11, confDiario.getValor_pix_real());
            preparedStatement.setBigDecimal(12, confDiario.getValor_pix_dif());
            preparedStatement.setBigDecimal(13, confDiario.getValor_despesa_total());
            preparedStatement.setBigDecimal(14, confDiario.getValor_vale_total());
            preparedStatement.setBigDecimal(15, confDiario.getValor_descontos());
            preparedStatement.setBigDecimal(16, confDiario.getValor_total_dia());
            preparedStatement.setString(17, confDiario.getObservacao());
            preparedStatement.setInt(18, confDiario.getTotal_revelado());
            preparedStatement.setInt(19, confDiario.getTotal_informado());
            preparedStatement.setBigDecimal(20, confDiario.getValor_deb_24h());
            preparedStatement.setBigDecimal(21, confDiario.getValor_cred_24h());
            preparedStatement.setDate(22, confDiario.getData_fechamento()); // Parâmetro para a data de fechamento

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao atualizar os dados da conferência diária: " + e.getMessage(), e);
        }
    }


//    public ModelConfDiario buscarPorData(Date dataFechamento) throws SQLException {
//        String sql = "SELECT * FROM conf_dia WHERE data_fechamento = ?";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setDate(1, new java.sql.Date(dataFechamento.getTime())); // Conversão para SQL Date
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                ModelConfDiario conf = new ModelConfDiario();
//                conf.setId(rs.getLong("id"));
//                conf.setValor_din(rs.getBigDecimal("valor_din"));
//                conf.setValor_din_real(rs.getBigDecimal("valor_din_real"));
//                conf.setValor_din_dif(rs.getBigDecimal("valor_din_dif"));
//                conf.setValor_deb(rs.getBigDecimal("valor_deb"));
//                conf.setValor_deb_real(rs.getBigDecimal("valor_deb_real"));
//                conf.setValor_deb_dif(rs.getBigDecimal("valor_deb_dif"));
//                conf.setValor_cred(rs.getBigDecimal("valor_cred"));
//                conf.setValor_cred_real(rs.getBigDecimal("valor_cred_real"));
//                conf.setValor_cred_dif(rs.getBigDecimal("valor_cred_dif"));
//                conf.setValor_pix(rs.getBigDecimal("valor_pix"));
//                conf.setValor_pix_real(rs.getBigDecimal("valor_pix_real"));
//                conf.setValor_pix_dif(rs.getBigDecimal("valor_pix_dif"));
//                conf.setValor_despesa_total(rs.getBigDecimal("valor_despesa_total"));
//                conf.setValor_vale_total(rs.getBigDecimal("valor_vale_total"));
//                conf.setValor_descontos(rs.getBigDecimal("valor_descontos"));
//                conf.setValor_total_dia(rs.getBigDecimal("valor_total_dia"));
//                conf.setObservacao(rs.getString("observacao"));
//                conf.setData_fechamento(rs.getDate("data_fechamento"));
//                conf.setTotal_revelado(rs.getInt("total_revelado"));
//                conf.setTotal_informado(rs.getInt("total_informado"));
//                conf.setValor_deb_24h(rs.getBigDecimal("valor_deb_24h"));
//                conf.setValor_cred_24h(rs.getBigDecimal("valor_cred_24h"));
//
//                return conf;
//            }
//        }
//        return null; // Retorna null caso nenhuma conferência seja encontrada
//    }


    public ModelConfDiario buscarPorData(Date dataFechamento) throws SQLException {
        // Criando um objeto para armazenar os dados
        ModelConfDiario conf = null;

        // 1ª Consulta: Buscar dados da tabela conf_dia
        String sqlConfDia = "SELECT * FROM conf_dia WHERE data_fechamento = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlConfDia)) {
            stmt.setDate(1, new java.sql.Date(dataFechamento.getTime())); // Conversão para SQL Date
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                conf = new ModelConfDiario();

                // Preenchendo os dados da tabela conf_dia
                conf.setId(rs.getLong("id"));
                conf.setValor_din(rs.getBigDecimal("valor_din"));
                conf.setValor_din_real(rs.getBigDecimal("valor_din_real"));
                conf.setValor_din_dif(rs.getBigDecimal("valor_din_dif"));
                conf.setValor_deb(rs.getBigDecimal("valor_deb"));
                conf.setValor_deb_real(rs.getBigDecimal("valor_deb_real"));
                conf.setValor_deb_dif(rs.getBigDecimal("valor_deb_dif"));
                conf.setValor_cred(rs.getBigDecimal("valor_cred"));
                conf.setValor_cred_real(rs.getBigDecimal("valor_cred_real"));
                conf.setValor_cred_dif(rs.getBigDecimal("valor_cred_dif"));
                conf.setValor_pix(rs.getBigDecimal("valor_pix"));
                conf.setValor_pix_real(rs.getBigDecimal("valor_pix_real"));
                conf.setValor_pix_dif(rs.getBigDecimal("valor_pix_dif"));
                conf.setValor_despesa_total(rs.getBigDecimal("valor_despesa_total"));
                conf.setValor_vale_total(rs.getBigDecimal("valor_vale_total"));
                conf.setValor_descontos(rs.getBigDecimal("valor_descontos"));
                conf.setValor_total_dia(rs.getBigDecimal("valor_total_dia"));
                conf.setObservacao(rs.getString("observacao"));
                conf.setData_fechamento(rs.getDate("data_fechamento"));
                conf.setTotal_revelado(rs.getInt("total_revelado"));
                conf.setTotal_informado(rs.getInt("total_informado"));
                conf.setValor_deb_24h(rs.getBigDecimal("valor_deb_24h"));
                conf.setValor_cred_24h(rs.getBigDecimal("valor_cred_24h"));
            }
        }

        // 2ª Consulta: Buscar dados da tabela fecha_dia
        String sqlFechaDia = "SELECT * FROM fecha_dia WHERE data_fechamento = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlFechaDia)) {
            stmt.setDate(1, new java.sql.Date(dataFechamento.getTime())); // Conversão para SQL Date
            ResultSet rs = stmt.executeQuery();

            if (rs.next() && conf != null) { // Verificando se o objeto conf já foi preenchido
                // Preenchendo os dados da tabela fecha_dia (Ribbon e outros campos)
                conf.setTotal_ribbon_1(rs.getInt("total_ribbon_1"));
                conf.setTotal_ribbon_2(rs.getInt("total_ribbon_2"));
                conf.setTotal_ribbon_3(rs.getInt("total_ribbon_3"));
                conf.setTotal_ribbon_4(rs.getInt("total_ribbon_4"));
                conf.setTotal_ribbon_5(rs.getInt("total_ribbon_5"));
                conf.setTotal_ribbon_6(rs.getInt("total_ribbon_6"));

                // Adicionando os novos campos old_ribbon
                conf.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
                conf.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
                conf.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
                conf.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
                conf.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
                conf.setOld_ribbon_6(rs.getInt("old_ribbon_6"));

                conf.setSobras(rs.getInt("sobras"));
                conf.setDifRibbon1(rs.getInt("dif_ribbon_1"));
                conf.setDifRibbon2(rs.getInt("dif_ribbon_2"));
                conf.setDifRibbon3(rs.getInt("dif_ribbon_3"));
                conf.setDifRibbon4(rs.getInt("dif_ribbon_4"));
                conf.setDifRibbon5(rs.getInt("dif_ribbon_5"));
                conf.setDifRibbon6(rs.getInt("dif_ribbon_6"));
            }
        }

        return conf; // Retorna o objeto preenchido ou null caso não tenha encontrado dados
    }


}
