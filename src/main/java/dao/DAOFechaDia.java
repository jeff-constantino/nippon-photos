package dao;

import connection.SingleConnectionBanco;
import model.ModelFechaDia;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DAOFechaDia {
    private Connection connection;

    public DAOFechaDia() {
        connection = SingleConnectionBanco.getConnection();
    }

    // Método para consultar o fechamento de vendas por data
    public ModelFechaDia consultarFechamentoPorData(Date dataFechamento) throws Exception {
        ModelFechaDia modelFechaDia = new ModelFechaDia();

        String sql = "SELECT " +
                "SUM(COALESCE(CAST(prod1_din AS integer), 0)) AS total_prod1_din, " +
                "SUM(COALESCE(CAST(prod1_deb AS integer), 0)) AS total_prod1_deb, " +
                "SUM(COALESCE(CAST(prod1_cred AS integer), 0)) AS total_prod1_cred, " +
                "SUM(COALESCE(CAST(prod1_pix AS integer), 0)) AS total_prod1_pix, " +
                "SUM(COALESCE(CAST(prod2_din AS integer), 0)) AS total_prod2_din, " +
                "SUM(COALESCE(CAST(prod2_deb AS integer), 0)) AS total_prod2_deb, " +
                "SUM(COALESCE(CAST(prod2_cred AS integer), 0)) AS total_prod2_cred, " +
                "SUM(COALESCE(CAST(prod2_pix AS integer), 0)) AS total_prod2_pix, " +
                "SUM(COALESCE(CAST(prod3_din AS integer), 0)) AS total_prod3_din, " +
                "SUM(COALESCE(CAST(prod3_deb AS integer), 0)) AS total_prod3_deb, " +
                "SUM(COALESCE(CAST(prod3_cred AS integer), 0)) AS total_prod3_cred, " +
                "SUM(COALESCE(CAST(prod3_pix AS integer), 0)) AS total_prod3_pix, " +
                "SUM(COALESCE(CAST(sobras AS integer), 0)) AS total_sobras " +
                "FROM vendas " +
                "WHERE data_venda = TO_DATE(?, 'YYYY-MM-DD')";



        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setDate(1, new java.sql.Date(dataFechamento.getTime()));

            ResultSet resultado = preparedSql.executeQuery();

            if (resultado.next()) {
                // Definindo os valores no modelo com os aliases corretos
                modelFechaDia.setTotal_ft_din(resultado.getInt("total_prod1_din")); // Ajustado
                modelFechaDia.setTotal_ft_deb(resultado.getInt("total_prod1_deb")); // Ajustado
                modelFechaDia.setTotal_ft_cred(resultado.getInt("total_prod1_cred")); // Ajustado
                modelFechaDia.setTotal_ft_pix(resultado.getInt("total_prod1_pix")); // Ajustado

                modelFechaDia.setTotal_enc_din(resultado.getInt("total_prod2_din")); // Ajustado
                modelFechaDia.setTotal_enc_deb(resultado.getInt("total_prod2_deb")); // Ajustado
                modelFechaDia.setTotal_enc_cred(resultado.getInt("total_prod2_cred")); // Ajustado
                modelFechaDia.setTotal_enc_pix(resultado.getInt("total_prod2_pix")); // Ajustado

                modelFechaDia.setTotal_dig_din(resultado.getInt("total_prod3_din")); // Ajustado
                modelFechaDia.setTotal_dig_deb(resultado.getInt("total_prod3_deb")); // Ajustado
                modelFechaDia.setTotal_dig_cred(resultado.getInt("total_prod3_cred")); // Ajustado
                modelFechaDia.setTotal_dig_pix(resultado.getInt("total_prod3_pix")); // Ajustado

                modelFechaDia.setData_fechamento(dataFechamento);

//                modelFechaDia.setTotal_ribbon_1(resultado.getInt("total_ribbon_1")); // Mantenha como está
//                modelFechaDia.setTotal_ribbon_2(resultado.getInt("total_ribbon_2")); // Mantenha como está
//                modelFechaDia.setTotal_ribbon_3(resultado.getInt("total_ribbon_3")); // Mantenha como está
//                modelFechaDia.setTotal_ribbon_4(resultado.getInt("total_ribbon_4")); // Mantenha como está
//                modelFechaDia.setTotal_ribbon_5(resultado.getInt("total_ribbon_5")); // Mantenha como está
//                modelFechaDia.setTotal_ribbon_6(resultado.getInt("total_ribbon_6")); // Mantenha como está

                // Corrigindo a atribuição para sobras
                modelFechaDia.setSobras(resultado.getInt("total_sobras")); // Ajuste para usar o total de sobras

            }



        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar fechamento do dia: " + e.getMessage());
        }

        return modelFechaDia;
    }



}
