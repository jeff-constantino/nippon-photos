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
        String sqlConfDia = "UPDATE conf_dia SET " +
                "valor_din = ?, valor_din_real = ?, valor_din_dif = ?, " +
                "valor_deb = ?, valor_deb_real = ?, valor_deb_dif = ?, " +
                "valor_cred = ?, valor_cred_real = ?, valor_cred_dif = ?, " +
                "valor_pix = ?, valor_pix_real = ?, valor_pix_dif = ?, " +
                "valor_despesa_total = ?, valor_vale_total = ?, desconto = ?, " +
                "valor_total_dia = ?, observacao = UPPER(?), total_revelado = ?, total_informado = ?, " +
                "valor_deb_24h = ?, valor_cred_24h = ?, total_ribbon_1 = ?, total_ribbon_2 = ?, total_ribbon_3 = ?, " +
                "total_ribbon_4 = ?, total_ribbon_5 = ?, total_ribbon_6 = ?, sobras = ?, dif_ribbon_1 = ?, dif_ribbon_2 = ?, " +
                "dif_ribbon_3 = ?, dif_ribbon_4 = ?, dif_ribbon_5 = ?, dif_ribbon_6 = ?, " +
                "old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, old_ribbon_4 = ?, old_ribbon_5 = ?, old_ribbon_6 = ?, " +
                "rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, rev_ribbon_4 = ?, rev_ribbon_5 = ?, rev_ribbon_6 = ?, " +
                "total_dif = ? " +
                "WHERE data_fechamento = ?";

        String sqlControleRibbon = "UPDATE controle_ribbon SET " +
                "observacao_ribbon = ?, total_dif = ? " +
                "WHERE data_ribbon = ?";

        try (PreparedStatement psConfDia = connection.prepareStatement(sqlConfDia);
             PreparedStatement psControleRibbon = connection.prepareStatement(sqlControleRibbon)) {

            // Configuração para conf_dia
            psConfDia.setBigDecimal(1, confDiario.getValor_din());
            psConfDia.setBigDecimal(2, confDiario.getValor_din_real());
            psConfDia.setBigDecimal(3, confDiario.getValor_din_dif());
            psConfDia.setBigDecimal(4, confDiario.getValor_deb());
            psConfDia.setBigDecimal(5, confDiario.getValor_deb_real());
            psConfDia.setBigDecimal(6, confDiario.getValor_deb_dif());
            psConfDia.setBigDecimal(7, confDiario.getValor_cred());
            psConfDia.setBigDecimal(8, confDiario.getValor_cred_real());
            psConfDia.setBigDecimal(9, confDiario.getValor_cred_dif());
            psConfDia.setBigDecimal(10, confDiario.getValor_pix());
            psConfDia.setBigDecimal(11, confDiario.getValor_pix_real());
            psConfDia.setBigDecimal(12, confDiario.getValor_pix_dif());
            psConfDia.setBigDecimal(13, confDiario.getValor_despesa_total());
            psConfDia.setBigDecimal(14, confDiario.getValor_vale_total());
            psConfDia.setBigDecimal(15, confDiario.getDesconto());
            psConfDia.setBigDecimal(16, confDiario.getValor_total_dia());
            psConfDia.setString(17, confDiario.getObservacao());
            psConfDia.setInt(18, confDiario.getTotal_revelado());
            psConfDia.setInt(19, confDiario.getTotal_informado());
            psConfDia.setBigDecimal(20, confDiario.getValor_deb_24h());
            psConfDia.setBigDecimal(21, confDiario.getValor_cred_24h());
            psConfDia.setInt(22, confDiario.getTotal_ribbon_1());
            psConfDia.setInt(23, confDiario.getTotal_ribbon_2());
            psConfDia.setInt(24, confDiario.getTotal_ribbon_3());
            psConfDia.setInt(25, confDiario.getTotal_ribbon_4());
            psConfDia.setInt(26, confDiario.getTotal_ribbon_5());
            psConfDia.setInt(27, confDiario.getTotal_ribbon_6());
            psConfDia.setInt(28, confDiario.getSobras());
            psConfDia.setInt(29, confDiario.getDif_ribbon_1());
            psConfDia.setInt(30, confDiario.getDif_ribbon_2());
            psConfDia.setInt(31, confDiario.getDif_ribbon_3());
            psConfDia.setInt(32, confDiario.getDif_ribbon_4());
            psConfDia.setInt(33, confDiario.getDif_ribbon_5());
            psConfDia.setInt(34, confDiario.getDif_ribbon_6());
            psConfDia.setInt(35, confDiario.getOld_ribbon_1());
            psConfDia.setInt(36, confDiario.getOld_ribbon_2());
            psConfDia.setInt(37, confDiario.getOld_ribbon_3());
            psConfDia.setInt(38, confDiario.getOld_ribbon_4());
            psConfDia.setInt(39, confDiario.getOld_ribbon_5());
            psConfDia.setInt(40, confDiario.getOld_ribbon_6());
            psConfDia.setInt(41, confDiario.getRev_ribbon_1());
            psConfDia.setInt(42, confDiario.getRev_ribbon_2());
            psConfDia.setInt(43, confDiario.getRev_ribbon_3());
            psConfDia.setInt(44, confDiario.getRev_ribbon_4());
            psConfDia.setInt(45, confDiario.getRev_ribbon_5());
            psConfDia.setInt(46, confDiario.getRev_ribbon_6());
            psConfDia.setInt(47, confDiario.getTotal_dif());
            psConfDia.setDate(48, confDiario.getData_fechamento());

            psConfDia.executeUpdate();

            // Configuração para controle_ribbon
            psControleRibbon.setString(1, confDiario.getObservacao_ribbon());
            psControleRibbon.setInt(2, confDiario.getTotal_dif());
            psControleRibbon.setDate(3, confDiario.getData_fechamento());

            psControleRibbon.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao atualizar as tabelas conf_dia e controle_ribbon: " + e.getMessage(), e);
        }
    }







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
                conf.setDesconto(rs.getBigDecimal("desconto"));
                conf.setValor_total_dia(rs.getBigDecimal("valor_total_dia"));
                conf.setObservacao(rs.getString("observacao"));
                conf.setData_fechamento(rs.getDate("data_fechamento"));
                conf.setTotal_revelado(rs.getInt("total_revelado"));
                conf.setTotal_informado(rs.getInt("total_informado"));
                conf.setValor_deb_24h(rs.getBigDecimal("valor_deb_24h"));
                conf.setValor_cred_24h(rs.getBigDecimal("valor_cred_24h"));


// Novos campos adicionados


            }
        }

        // 2ª Consulta: Buscar dados da tabela fecha_dia
        String sqlControleRibbon = "SELECT * FROM controle_ribbon WHERE data_ribbon = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlControleRibbon)) {
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
                conf.setSobras(rs.getInt("sobras"));
                conf.setDif_ribbon_1(rs.getInt("dif_ribbon_1"));
                conf.setDif_ribbon_2(rs.getInt("dif_ribbon_2"));
                conf.setDif_ribbon_3(rs.getInt("dif_ribbon_3"));
                conf.setDif_ribbon_4(rs.getInt("dif_ribbon_4"));
                conf.setDif_ribbon_5(rs.getInt("dif_ribbon_5"));
                conf.setDif_ribbon_6(rs.getInt("dif_ribbon_6"));

                conf.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
                conf.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
                conf.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
                conf.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
                conf.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
                conf.setOld_ribbon_6(rs.getInt("old_ribbon_6"));

                conf.setRev_ribbon_1(rs.getInt("rev_ribbon_1"));
                conf.setRev_ribbon_2(rs.getInt("rev_ribbon_2"));
                conf.setRev_ribbon_3(rs.getInt("rev_ribbon_3"));
                conf.setRev_ribbon_4(rs.getInt("rev_ribbon_4"));
                conf.setRev_ribbon_5(rs.getInt("rev_ribbon_5"));
                conf.setRev_ribbon_6(rs.getInt("rev_ribbon_6"));
                conf.setTotal_dif(rs.getInt("total_dif"));
                conf.setObservacao_ribbon(rs.getString("observacao_ribbon"));

            }
        }

//        // 3ª Consulta: Buscar dados da tabela despesas
    String sqlDespesa = "SELECT * FROM despesas WHERE data_despesa = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sqlDespesa)) { // Corrigindo aqui
        stmt.setDate(1, new java.sql.Date(dataFechamento.getTime())); // Conversão para SQL Date
        ResultSet rs = stmt.executeQuery();

        if (rs.next() && conf != null) { // Verificando se o objeto conf já foi preenchido
            // Preenchendo os dados da tabela despesas
            conf.setValor_despesa_total(rs.getBigDecimal("valor_despesa"));
        }
    }

        return conf; // Retorna o objeto preenchido ou null caso não tenha encontrado dados
    }


}
