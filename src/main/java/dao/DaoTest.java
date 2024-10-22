package dao;

import model.ModelFechaDia;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;

public class DaoTest {


//    public ModelFechaDia consultarFechamentoPorData(Date data_fechamento) throws Exception {
//        ModelFechaDia modelFechaDia = new ModelFechaDia();
//        Calendar calendar = Calendar.getInstance();
//        calendar.setTime(data_fechamento);
//        int dia = calendar.get(Calendar.DAY_OF_MONTH);
//        LOGGER.info("Dia da data de fechamento: " + dia);
//
//        // Consulta para a tabela vendas
//        String sql = "SELECT data_venda, " +
//                "SUM(COALESCE(CAST(prod1_din AS integer), 0)) AS total_prod1_din, " +
//                "SUM(COALESCE(CAST(prod1_deb AS integer), 0)) AS total_prod1_deb, " +
//                "SUM(COALESCE(CAST(prod1_cred AS integer), 0)) AS total_prod1_cred, " +
//                "SUM(COALESCE(CAST(prod1_pix AS integer), 0)) AS total_prod1_pix, " +
//                "SUM(COALESCE(CAST(prod2_din AS integer), 0)) AS total_prod2_din, " +
//                "SUM(COALESCE(CAST(prod2_deb AS integer), 0)) AS total_prod2_deb, " +
//                "SUM(COALESCE(CAST(prod2_cred AS integer), 0)) AS total_prod2_cred, " +
//                "SUM(COALESCE(CAST(prod2_pix AS integer), 0)) AS total_prod2_pix, " +
//                "SUM(COALESCE(CAST(prod3_din AS integer), 0)) AS total_prod3_din, " +
//                "SUM(COALESCE(CAST(prod3_deb AS integer), 0)) AS total_prod3_deb, " +
//                "SUM(COALESCE(CAST(prod3_cred AS integer), 0)) AS total_prod3_cred, " +
//                "SUM(COALESCE(CAST(prod3_pix AS integer), 0)) AS total_prod3_pix, " +
//                "SUM(COALESCE(CAST(sobras AS integer), 0)) AS total_sobras " +
//                "FROM vendas " +
//                "WHERE data_venda = ? " +
//                "GROUP BY data_venda";
//
//        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
//            preparedSql.setDate(1, new java.sql.Date(data_fechamento.getTime()));
//            ResultSet resultado = preparedSql.executeQuery();
//
//            if (resultado.next()) {
//                // Popula o model com os resultados da consulta
//                modelFechaDia.setData_fechamento(resultado.getDate("data_venda"));
//                modelFechaDia.setTotal_ft_din(resultado.getInt("total_prod1_din"));
//                modelFechaDia.setTotal_ft_deb(resultado.getInt("total_prod1_deb"));
//                modelFechaDia.setTotal_ft_cred(resultado.getInt("total_prod1_cred"));
//                modelFechaDia.setTotal_ft_pix(resultado.getInt("total_prod1_pix"));
//                modelFechaDia.setTotal_enc_din(resultado.getInt("total_prod2_din"));
//                modelFechaDia.setTotal_enc_deb(resultado.getInt("total_prod2_deb"));
//                modelFechaDia.setTotal_enc_cred(resultado.getInt("total_prod2_cred"));
//                modelFechaDia.setTotal_enc_pix(resultado.getInt("total_prod2_pix"));
//                modelFechaDia.setTotal_dig_din(resultado.getInt("total_prod3_din"));
//                modelFechaDia.setTotal_dig_deb(resultado.getInt("total_prod3_deb"));
//                modelFechaDia.setTotal_dig_cred(resultado.getInt("total_prod3_cred"));
//                modelFechaDia.setTotal_dig_pix(resultado.getInt("total_prod3_pix"));
//                modelFechaDia.setSobras(resultado.getInt("total_sobras"));
//                LOGGER.info("ModelFechaDia preenchido com os valores da consulta");
//            } else {
//                LOGGER.warning("Nenhum resultado encontrado para a data de venda: " + data_fechamento);
//            }
//        } catch (SQLException e) {
//            LOGGER.log(Level.SEVERE, "Erro ao executar a consulta SQL", e);
//            throw new Exception("Erro ao consultar fechamento do dia: " + e.getMessage());
//        }
//
//        // Se for o dia 01, buscar os ribbons da tabela fecha_mes
//        if (dia == 1) {
//            String ribbonSql = "SELECT final_ribbon_1, final_ribbon_2, final_ribbon_3, final_ribbon_4, final_ribbon_5, final_ribbon_6 " +
//                    "FROM fecha_mes ORDER BY data_final DESC LIMIT 1";
//
//            try (PreparedStatement preparedRibbonSql = connection.prepareStatement(ribbonSql)) {
//                ResultSet resultadoRibbon = preparedRibbonSql.executeQuery();
//                if (resultadoRibbon.next()) {
//                    modelFechaDia.setTotal_ribbon_1(resultadoRibbon.getInt("final_ribbon_1"));
//                    modelFechaDia.setTotal_ribbon_2(resultadoRibbon.getInt("final_ribbon_2"));
//                    modelFechaDia.setTotal_ribbon_3(resultadoRibbon.getInt("final_ribbon_3"));
//                    modelFechaDia.setTotal_ribbon_4(resultadoRibbon.getInt("final_ribbon_4"));
//                    modelFechaDia.setTotal_ribbon_5(resultadoRibbon.getInt("final_ribbon_5"));
//                    modelFechaDia.setTotal_ribbon_6(resultadoRibbon.getInt("final_ribbon_6"));
//                    LOGGER.info("Ribbons consultados e atribuídos ao ModelFechaDia");
//                } else {
//                    LOGGER.warning("Nenhum resultado encontrado para ribbons");
//                }
//            } catch (SQLException e) {
//                LOGGER.log(Level.SEVERE, "Erro ao consultar ribbons", e);
//                throw new Exception("Erro ao consultar ribbons: " + e.getMessage());
//            }
//        } else {
//            // Consultar os ribbons da tabela fecha_dia
//            String fechaDiaSql = "SELECT total_ribbon_1, total_ribbon_2, total_ribbon_3, total_ribbon_4, total_ribbon_5, total_ribbon_6 " +
//                    "FROM fecha_dia ORDER BY data_fechamento DESC LIMIT 1";
//
//            try (PreparedStatement preparedFechaDiaSql = connection.prepareStatement(fechaDiaSql)) {
//                ResultSet resultadoFechaDia = preparedFechaDiaSql.executeQuery();
//                if (resultadoFechaDia.next()) {
//                    modelFechaDia.setTotal_ribbon_1(resultadoFechaDia.getInt("total_ribbon_1"));
//                    modelFechaDia.setTotal_ribbon_2(resultadoFechaDia.getInt("total_ribbon_2"));
//                    modelFechaDia.setTotal_ribbon_3(resultadoFechaDia.getInt("total_ribbon_3"));
//                    modelFechaDia.setTotal_ribbon_4(resultadoFechaDia.getInt("total_ribbon_4"));
//                    modelFechaDia.setTotal_ribbon_5(resultadoFechaDia.getInt("total_ribbon_5"));
//                    modelFechaDia.setTotal_ribbon_6(resultadoFechaDia.getInt("total_ribbon_6"));
//                    LOGGER.info("Último registro da tabela fecha_dia consultado e preenchido no ModelFechaDia");
//                } else {
//                    LOGGER.warning("Nenhum resultado encontrado para fecha_dia");
//                }
//            } catch (SQLException e) {
//                LOGGER.log(Level.SEVERE, "Erro ao consultar fecha_dia", e);
//                throw new Exception("Erro ao consultar fecha_dia: " + e.getMessage());
//            }
//        }
//
//        return modelFechaDia;
//    }
}
