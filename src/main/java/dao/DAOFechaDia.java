package dao;

import connection.SingleConnectionBanco;
import model.ModelFechaDia;

import java.sql.*;
import java.time.LocalDate;
import java.util.Calendar;

public class DAOFechaDia {
    private Connection connection;

    public DAOFechaDia() {
        connection = SingleConnectionBanco.getConnection();
    }
    public ModelFechaDia consultarFechamentoPorData(Date data_fechamento) throws Exception {
        ModelFechaDia modelFechaDia = new ModelFechaDia();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(data_fechamento);
        int dia = calendar.get(Calendar.DAY_OF_MONTH);

        // Consulta para a tabela vendas
        String sql = "SELECT data_venda, " +
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
                "WHERE data_venda = ? " +
                "GROUP BY data_venda";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setDate(1, new java.sql.Date(data_fechamento.getTime()));
            ResultSet resultado = preparedSql.executeQuery();

            if (resultado.next()) {
                // Popula o model com os resultados da consulta
                modelFechaDia.setData_fechamento(resultado.getDate("data_venda"));
                modelFechaDia.setTotal_ft_din(resultado.getInt("total_prod1_din"));
                modelFechaDia.setTotal_ft_deb(resultado.getInt("total_prod1_deb"));
                modelFechaDia.setTotal_ft_cred(resultado.getInt("total_prod1_cred"));
                modelFechaDia.setTotal_ft_pix(resultado.getInt("total_prod1_pix"));
                modelFechaDia.setTotal_enc_din(resultado.getInt("total_prod2_din"));
                modelFechaDia.setTotal_enc_deb(resultado.getInt("total_prod2_deb"));
                modelFechaDia.setTotal_enc_cred(resultado.getInt("total_prod2_cred"));
                modelFechaDia.setTotal_enc_pix(resultado.getInt("total_prod2_pix"));
                modelFechaDia.setTotal_dig_din(resultado.getInt("total_prod3_din"));
                modelFechaDia.setTotal_dig_deb(resultado.getInt("total_prod3_deb"));
                modelFechaDia.setTotal_dig_cred(resultado.getInt("total_prod3_cred"));
                modelFechaDia.setTotal_dig_pix(resultado.getInt("total_prod3_pix"));
                modelFechaDia.setSobras(resultado.getInt("total_sobras"));
            } else {
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao consultar fechamento do dia: " + e.getMessage());
        }

        // Se for o dia 01, buscar os ribbons da tabela fecha_mes
        if (dia == 1) {
            String ribbonSql = "SELECT final_ribbon_1, final_ribbon_2, final_ribbon_3, final_ribbon_4, final_ribbon_5, final_ribbon_6 " +
                    "FROM fecha_mes ORDER BY data_final DESC LIMIT 1";

            try (PreparedStatement preparedRibbonSql = connection.prepareStatement(ribbonSql)) {
                ResultSet resultadoRibbon = preparedRibbonSql.executeQuery();
                if (resultadoRibbon.next()) {
                    modelFechaDia.setTotal_ribbon_1(resultadoRibbon.getInt("final_ribbon_1"));
                    modelFechaDia.setTotal_ribbon_2(resultadoRibbon.getInt("final_ribbon_2"));
                    modelFechaDia.setTotal_ribbon_3(resultadoRibbon.getInt("final_ribbon_3"));
                    modelFechaDia.setTotal_ribbon_4(resultadoRibbon.getInt("final_ribbon_4"));
                    modelFechaDia.setTotal_ribbon_5(resultadoRibbon.getInt("final_ribbon_5"));
                    modelFechaDia.setTotal_ribbon_6(resultadoRibbon.getInt("final_ribbon_6"));
                } else {
                }
            } catch (SQLException e) {
                throw new Exception("Erro ao consultar ribbons: " + e.getMessage());
            }
        } else {
            // Consultar os ribbons da tabela fecha_dia
            String fechaDiaSql = "SELECT total_ribbon_1, total_ribbon_2, total_ribbon_3, total_ribbon_4, total_ribbon_5, total_ribbon_6 " +
                    "FROM fecha_dia ORDER BY data_fechamento DESC LIMIT 1";

            try (PreparedStatement preparedFechaDiaSql = connection.prepareStatement(fechaDiaSql)) {
                ResultSet resultadoFechaDia = preparedFechaDiaSql.executeQuery();
                if (resultadoFechaDia.next()) {
                    modelFechaDia.setTotal_ribbon_1(resultadoFechaDia.getInt("total_ribbon_1"));
                    modelFechaDia.setTotal_ribbon_2(resultadoFechaDia.getInt("total_ribbon_2"));
                    modelFechaDia.setTotal_ribbon_3(resultadoFechaDia.getInt("total_ribbon_3"));
                    modelFechaDia.setTotal_ribbon_4(resultadoFechaDia.getInt("total_ribbon_4"));
                    modelFechaDia.setTotal_ribbon_5(resultadoFechaDia.getInt("total_ribbon_5"));
                    modelFechaDia.setTotal_ribbon_6(resultadoFechaDia.getInt("total_ribbon_6"));
                } else {
                }
            } catch (SQLException e) {
                throw new Exception("Erro ao consultar fecha_dia: " + e.getMessage());
            }
        }

        return modelFechaDia;
    }

    public void gravarFechamento(ModelFechaDia fechamento) {
        // Verifica se o fechamento já existe
        if (verificarExistenciaFechamento(fechamento.getData_fechamento().toLocalDate())) {
            // Em vez de lançar uma exceção, apenas retorne para indicar que já existe
            return; // Retorna, permitindo que o servlet trate a situação
        }

        // Verifica se o idFechamento está presente para determinar se é uma atualização ou inserção
        if (fechamento.getId() > 0) { // Verifica se o ID é maior que zero
            atualizarFechamento(fechamento);
        } else {
            inserirFechamento(fechamento);
        }
    }


    private void inserirFechamento(ModelFechaDia fechamento) {
        String sql = "INSERT INTO fecha_dia (data_fechamento, total_ft_din, total_ft_deb, total_ft_cred, total_ft_pix, " +
                "total_enc_din, total_enc_deb, total_enc_cred, total_enc_pix, " +
                "total_dig_din, total_dig_deb, total_dig_cred, total_dig_pix, " +
                "total_ribbon_1, total_ribbon_2, total_ribbon_3, total_ribbon_4, " +
                "total_ribbon_5, total_ribbon_6, total_revelado, total_informado, " +
                "desconto, observacao, dif_ribbon_1, dif_ribbon_2, dif_ribbon_3, dif_ribbon_4, " +
                "dif_ribbon_5, dif_ribbon_6) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // Definindo os parâmetros da inserção
            pstmt.setDate(1, Date.valueOf(fechamento.getData_fechamento().toLocalDate())); // data_fechamento
            pstmt.setInt(2, fechamento.getTotal_ft_din()); // total_ft_din
            pstmt.setInt(3, fechamento.getTotal_ft_deb()); // total_ft_deb
            pstmt.setInt(4, fechamento.getTotal_ft_cred()); // total_ft_cred
            pstmt.setInt(5, fechamento.getTotal_ft_pix()); // total_ft_pix
            pstmt.setInt(6, fechamento.getTotal_enc_din()); // total_enc_din
            pstmt.setInt(7, fechamento.getTotal_enc_deb()); // total_enc_deb
            pstmt.setInt(8, fechamento.getTotal_enc_cred()); // total_enc_cred
            pstmt.setInt(9, fechamento.getTotal_enc_pix()); // total_enc_pix
            pstmt.setInt(10, fechamento.getTotal_dig_din()); // total_dig_din
            pstmt.setInt(11, fechamento.getTotal_dig_deb()); // total_dig_deb
            pstmt.setInt(12, fechamento.getTotal_dig_cred()); // total_dig_cred
            pstmt.setInt(13, fechamento.getTotal_dig_pix()); // total_dig_pix
            pstmt.setInt(14, fechamento.getTotal_ribbon_1()); // total_ribbon_1
            pstmt.setInt(15, fechamento.getTotal_ribbon_2()); // total_ribbon_2
            pstmt.setInt(16, fechamento.getTotal_ribbon_3()); // total_ribbon_3
            pstmt.setInt(17, fechamento.getTotal_ribbon_4()); // total_ribbon_4
            pstmt.setInt(18, fechamento.getTotal_ribbon_5()); // total_ribbon_5
            pstmt.setInt(19, fechamento.getTotal_ribbon_6()); // total_ribbon_6
            pstmt.setInt(20, fechamento.getTotal_revelado()); // total_revelado
            pstmt.setInt(21, fechamento.getTotal_informado()); // total_informado
            pstmt.setBigDecimal(22, fechamento.getDesconto()); // desconto
            pstmt.setString(23, fechamento.getObservacao()); // observacao
            pstmt.setInt(24, fechamento.getDifRibbon1()); // dif_ribbon_1
            pstmt.setInt(25, fechamento.getDifRibbon2()); // dif_ribbon_2
            pstmt.setInt(26, fechamento.getDifRibbon3()); // dif_ribbon_3
            pstmt.setInt(27, fechamento.getDifRibbon4()); // dif_ribbon_4
            pstmt.setInt(28, fechamento.getDifRibbon5()); // dif_ribbon_5
            pstmt.setInt(29, fechamento.getDifRibbon6()); // dif_ribbon_6

            // Executa a inserção
            pstmt.executeUpdate();
            connection.commit(); // Commit das mudanças
        } catch (SQLException e) {
            e.printStackTrace();
            rollbackConnection();
        }
    }

    private void atualizarFechamento(ModelFechaDia fechamento) {
        String sql = "UPDATE fecha_dia SET " +
                "total_ft_din = ?, total_ft_deb = ?, total_ft_cred = ?, total_ft_pix = ?, " +
                "total_enc_din = ?, total_enc_deb = ?, total_enc_cred = ?, total_enc_pix = ?, " +
                "total_dig_din = ?, total_dig_deb = ?, total_dig_cred = ?, total_dig_pix = ?, " +
                "total_ribbon_1 = ?, total_ribbon_2 = ?, total_ribbon_3 = ?, total_ribbon_4 = ?, " +
                "total_ribbon_5 = ?, total_ribbon_6 = ?, total_revelado = ?, total_informado = ?, " +
                "desconto = ?, observacao = ?, " +
                "dif_ribbon_1 = ?, dif_ribbon_2 = ?, dif_ribbon_3 = ?, dif_ribbon_4 = ?, " +
                "dif_ribbon_5 = ?, dif_ribbon_6 = ? " +
                "WHERE data_fechamento = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // Definindo os parâmetros da atualização
            pstmt.setInt(1, fechamento.getTotal_ft_din()); // total_ft_din
            pstmt.setInt(2, fechamento.getTotal_ft_deb()); // total_ft_deb
            pstmt.setInt(3, fechamento.getTotal_ft_cred()); // total_ft_cred
            pstmt.setInt(4, fechamento.getTotal_ft_pix()); // total_ft_pix
            pstmt.setInt(5, fechamento.getTotal_enc_din()); // total_enc_din
            pstmt.setInt(6, fechamento.getTotal_enc_deb()); // total_enc_deb
            pstmt.setInt(7, fechamento.getTotal_enc_cred()); // total_enc_cred
            pstmt.setInt(8, fechamento.getTotal_enc_pix()); // total_enc_pix
            pstmt.setInt(9, fechamento.getTotal_dig_din()); // total_dig_din
            pstmt.setInt(10, fechamento.getTotal_dig_deb()); // total_dig_deb
            pstmt.setInt(11, fechamento.getTotal_dig_cred()); // total_dig_cred
            pstmt.setInt(12, fechamento.getTotal_dig_pix()); // total_dig_pix
            pstmt.setInt(13, fechamento.getTotal_ribbon_1()); // total_ribbon_1
            pstmt.setInt(14, fechamento.getTotal_ribbon_2()); // total_ribbon_2
            pstmt.setInt(15, fechamento.getTotal_ribbon_3()); // total_ribbon_3
            pstmt.setInt(16, fechamento.getTotal_ribbon_4()); // total_ribbon_4
            pstmt.setInt(17, fechamento.getTotal_ribbon_5()); // total_ribbon_5
            pstmt.setInt(18, fechamento.getTotal_ribbon_6()); // total_ribbon_6
            pstmt.setInt(19, fechamento.getTotal_revelado()); // total_revelado
            pstmt.setInt(20, fechamento.getTotal_informado()); // total_informado
            pstmt.setBigDecimal(21, fechamento.getDesconto()); // desconto
            pstmt.setString(22, fechamento.getObservacao()); // observacao
            pstmt.setInt(23, fechamento.getDifRibbon1()); // dif_ribbon_1
            pstmt.setInt(24, fechamento.getDifRibbon2()); // dif_ribbon_2
            pstmt.setInt(25, fechamento.getDifRibbon3()); // dif_ribbon_3
            pstmt.setInt(26, fechamento.getDifRibbon4()); // dif_ribbon_4
            pstmt.setInt(27, fechamento.getDifRibbon5()); // dif_ribbon_5
            pstmt.setInt(28, fechamento.getDifRibbon6()); // dif_ribbon_6
            pstmt.setDate(29, Date.valueOf(fechamento.getData_fechamento().toLocalDate())); // Adiciona a data_fechamento para o WHERE

            // Executa a atualização
            pstmt.executeUpdate();
            connection.commit(); // Commit das mudanças
        } catch (SQLException e) {
            e.printStackTrace();
            rollbackConnection();
        }
    }


    private void rollbackConnection() {
        if (connection != null) {
            try {
                connection.rollback(); // Rollback em caso de erro
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
    }

    public boolean verificarExistenciaFechamento(LocalDate dataFechamento) {
        String sql = "SELECT COUNT(*) FROM fecha_dia WHERE data_fechamento = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDate(1, Date.valueOf(dataFechamento));
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Retorna true se existe pelo menos um registro
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Retorna false se não houver registro
    }



}








