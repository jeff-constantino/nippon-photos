package dao;

import connection.SingleConnectionBanco;
import model.ModelConfig;
import model.ModelFechaDia;


import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


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
                    modelFechaDia.setOld_ribbon_1(resultadoRibbon.getInt("final_ribbon_1"));
                    modelFechaDia.setOld_ribbon_2(resultadoRibbon.getInt("final_ribbon_2"));
                    modelFechaDia.setOld_ribbon_3(resultadoRibbon.getInt("final_ribbon_3"));
                    modelFechaDia.setOld_ribbon_4(resultadoRibbon.getInt("final_ribbon_4"));
                    modelFechaDia.setOld_ribbon_5(resultadoRibbon.getInt("final_ribbon_5"));
                    modelFechaDia.setOld_ribbon_6(resultadoRibbon.getInt("final_ribbon_6"));
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
                    modelFechaDia.setOld_ribbon_1(resultadoFechaDia.getInt("total_ribbon_1"));
                    modelFechaDia.setOld_ribbon_2(resultadoFechaDia.getInt("total_ribbon_2"));
                    modelFechaDia.setOld_ribbon_3(resultadoFechaDia.getInt("total_ribbon_3"));
                    modelFechaDia.setOld_ribbon_4(resultadoFechaDia.getInt("total_ribbon_4"));
                    modelFechaDia.setOld_ribbon_5(resultadoFechaDia.getInt("total_ribbon_5"));
                    modelFechaDia.setOld_ribbon_6(resultadoFechaDia.getInt("total_ribbon_6"));
                } else {
                }
            } catch (SQLException e) {
                throw new Exception("Erro ao consultar fecha_dia: " + e.getMessage());
            }
        }

        return modelFechaDia;
    }
    public List<ModelConfig> consultarValor() throws Exception {
        List<ModelConfig> listaConfigs = new ArrayList<>();
        String query = "SELECT conf1_valor, conf2_valor, conf3_valor FROM public.configuracao WHERE \"idConf\" = 1";

        try (PreparedStatement preparedSql = connection.prepareStatement(query);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfig modelConfig = new ModelConfig();

                modelConfig.setConf1_valor(resultSet.getBigDecimal("conf1_valor"));
                modelConfig.setConf2_valor(resultSet.getBigDecimal("conf2_valor"));
                modelConfig.setConf3_valor(resultSet.getBigDecimal("conf3_valor"));

                listaConfigs.add(modelConfig);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage());
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaConfigs;
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
                "dif_ribbon_5, dif_ribbon_6, sobras, old_ribbon_1, old_ribbon_2, old_ribbon_3, " +
                "old_ribbon_4, old_ribbon_5, old_ribbon_6, " +
                "valor_din, valor_deb, valor_cred, valor_pix, valor_din_real, valor_deb_real, valor_cred_real, valor_pix_real) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, UPPER(?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            pstmt.setInt(30, fechamento.getSobras()); // sobras
            pstmt.setInt(31, fechamento.getOld_ribbon_1()); // old_ribbon_1
            pstmt.setInt(32, fechamento.getOld_ribbon_2()); // old_ribbon_2
            pstmt.setInt(33, fechamento.getOld_ribbon_3()); // old_ribbon_3
            pstmt.setInt(34, fechamento.getOld_ribbon_4()); // old_ribbon_4
            pstmt.setInt(35, fechamento.getOld_ribbon_5()); // old_ribbon_5
            pstmt.setInt(36, fechamento.getOld_ribbon_6()); // old_ribbon_6
            pstmt.setBigDecimal(37, fechamento.getValor_din()); // valor_din
            pstmt.setBigDecimal(38, fechamento.getValor_deb()); // valor_deb
            pstmt.setBigDecimal(39, fechamento.getValor_cred()); // valor_cred
            pstmt.setBigDecimal(40, fechamento.getValor_pix()); // valor_pix
            pstmt.setBigDecimal(41, fechamento.getValor_din_real()); // valor_din_real
            pstmt.setBigDecimal(42, fechamento.getValor_deb_real()); // valor_deb_real
            pstmt.setBigDecimal(43, fechamento.getValor_cred_real()); // valor_cred_real
            pstmt.setBigDecimal(44, fechamento.getValor_pix_real()); // valor_pix_real

            // Executa a inserção
            pstmt.executeUpdate();
            connection.commit(); // Commit das mudanças
        } catch (SQLException e) {
            e.printStackTrace();
            rollbackConnection();
        }
    }




    public void atualizarFechamento(ModelFechaDia fechamento) {
        String sql = "UPDATE fecha_dia SET " +
                "total_ft_din = ?, total_ft_deb = ?, total_ft_cred = ?, total_ft_pix = ?, " +
                "total_enc_din = ?, total_enc_deb = ?, total_enc_cred = ?, total_enc_pix = ?, " +
                "total_dig_din = ?, total_dig_deb = ?, total_dig_cred = ?, total_dig_pix = ?, " +
                "total_ribbon_1 = ?, total_ribbon_2 = ?, total_ribbon_3 = ?, total_ribbon_4 = ?, " +
                "total_ribbon_5 = ?, total_ribbon_6 = ?, total_revelado = ?, total_informado = ?, " +
                "desconto = ?, observacao = UPPER(?), " +
                "dif_ribbon_1 = ?, dif_ribbon_2 = ?, dif_ribbon_3 = ?, dif_ribbon_4 = ?, " +
                "dif_ribbon_5 = ?, dif_ribbon_6 = ?, " +
                "sobras = ?, " +
                "old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, old_ribbon_4 = ?, " + // Novas colunas
                "old_ribbon_5 = ?, old_ribbon_6 = ?, " + // Novas colunas
                "valor_din = ?, valor_deb = ?, valor_cred = ?, valor_pix = ?, valor_din_real = ?, valor_deb_real = ?, " +
                "valor_cred_real = ?, valor_pix_real = ? " +
                "WHERE data_fechamento = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // Verifica se o valor não é zero e, caso contrário, define como 0
            pstmt.setInt(1, fechamento.getTotal_ft_din() != 0 ? fechamento.getTotal_ft_din() : 0); // total_ft_din
            pstmt.setInt(2, fechamento.getTotal_ft_deb() != 0 ? fechamento.getTotal_ft_deb() : 0); // total_ft_deb
            pstmt.setInt(3, fechamento.getTotal_ft_cred() != 0 ? fechamento.getTotal_ft_cred() : 0); // total_ft_cred
            pstmt.setInt(4, fechamento.getTotal_ft_pix() != 0 ? fechamento.getTotal_ft_pix() : 0); // total_ft_pix
            pstmt.setInt(5, fechamento.getTotal_enc_din() != 0 ? fechamento.getTotal_enc_din() : 0); // total_enc_din
            pstmt.setInt(6, fechamento.getTotal_enc_deb() != 0 ? fechamento.getTotal_enc_deb() : 0); // total_enc_deb
            pstmt.setInt(7, fechamento.getTotal_enc_cred() != 0 ? fechamento.getTotal_enc_cred() : 0); // total_enc_cred
            pstmt.setInt(8, fechamento.getTotal_enc_pix() != 0 ? fechamento.getTotal_enc_pix() : 0); // total_enc_pix
            pstmt.setInt(9, fechamento.getTotal_dig_din() != 0 ? fechamento.getTotal_dig_din() : 0); // total_dig_din
            pstmt.setInt(10, fechamento.getTotal_dig_deb() != 0 ? fechamento.getTotal_dig_deb() : 0); // total_dig_deb
            pstmt.setInt(11, fechamento.getTotal_dig_cred() != 0 ? fechamento.getTotal_dig_cred() : 0); // total_dig_cred
            pstmt.setInt(12, fechamento.getTotal_dig_pix() != 0 ? fechamento.getTotal_dig_pix() : 0); // total_dig_pix
            pstmt.setInt(13, fechamento.getTotal_ribbon_1() != 0 ? fechamento.getTotal_ribbon_1() : 0); // total_ribbon_1
            pstmt.setInt(14, fechamento.getTotal_ribbon_2() != 0 ? fechamento.getTotal_ribbon_2() : 0); // total_ribbon_2
            pstmt.setInt(15, fechamento.getTotal_ribbon_3() != 0 ? fechamento.getTotal_ribbon_3() : 0); // total_ribbon_3
            pstmt.setInt(16, fechamento.getTotal_ribbon_4() != 0 ? fechamento.getTotal_ribbon_4() : 0); // total_ribbon_4
            pstmt.setInt(17, fechamento.getTotal_ribbon_5() != 0 ? fechamento.getTotal_ribbon_5() : 0); // total_ribbon_5
            pstmt.setInt(18, fechamento.getTotal_ribbon_6() != 0 ? fechamento.getTotal_ribbon_6() : 0); // total_ribbon_6
            pstmt.setInt(19, fechamento.getTotal_revelado() != 0 ? fechamento.getTotal_revelado() : 0); // total_revelado
            pstmt.setInt(20, fechamento.getTotal_informado() != 0 ? fechamento.getTotal_informado() : 0); // total_informado
            pstmt.setBigDecimal(21, fechamento.getDesconto() != null ? fechamento.getDesconto() : BigDecimal.ZERO); // desconto
            pstmt.setString(22, fechamento.getObservacao() != null ? fechamento.getObservacao() : ""); // observacao
            pstmt.setInt(23, fechamento.getDifRibbon1() != 0 ? fechamento.getDifRibbon1() : 0); // dif_ribbon_1
            pstmt.setInt(24, fechamento.getDifRibbon2() != 0 ? fechamento.getDifRibbon2() : 0); // dif_ribbon_2
            pstmt.setInt(25, fechamento.getDifRibbon3() != 0 ? fechamento.getDifRibbon3() : 0); // dif_ribbon_3
            pstmt.setInt(26, fechamento.getDifRibbon4() != 0 ? fechamento.getDifRibbon4() : 0); // dif_ribbon_4
            pstmt.setInt(27, fechamento.getDifRibbon5() != 0 ? fechamento.getDifRibbon5() : 0); // dif_ribbon_5
            pstmt.setInt(28, fechamento.getDifRibbon6() != 0 ? fechamento.getDifRibbon6() : 0); // dif_ribbon_6
            pstmt.setInt(29, fechamento.getSobras() != 0 ? fechamento.getSobras() : 0); // sobras
            pstmt.setInt(30, fechamento.getOld_ribbon_1() != 0 ? fechamento.getOld_ribbon_1() : 0); // old_ribbon_1
            pstmt.setInt(31, fechamento.getOld_ribbon_2() != 0 ? fechamento.getOld_ribbon_2() : 0); // old_ribbon_2
            pstmt.setInt(32, fechamento.getOld_ribbon_3() != 0 ? fechamento.getOld_ribbon_3() : 0); // old_ribbon_3
            pstmt.setInt(33, fechamento.getOld_ribbon_4() != 0 ? fechamento.getOld_ribbon_4() : 0); // old_ribbon_4
            pstmt.setInt(34, fechamento.getOld_ribbon_5() != 0 ? fechamento.getOld_ribbon_5() : 0); // old_ribbon_5
            pstmt.setInt(35, fechamento.getOld_ribbon_6() != 0 ? fechamento.getOld_ribbon_6() : 0); // old_ribbon_6
            pstmt.setBigDecimal(36, fechamento.getValor_din() != null ? fechamento.getValor_din() : BigDecimal.ZERO); // valor_din
            pstmt.setBigDecimal(37, fechamento.getValor_deb() != null ? fechamento.getValor_deb() : BigDecimal.ZERO); // valor_deb
            pstmt.setBigDecimal(38, fechamento.getValor_cred() != null ? fechamento.getValor_cred() : BigDecimal.ZERO); // valor_cred
            pstmt.setBigDecimal(39, fechamento.getValor_pix() != null ? fechamento.getValor_pix() : BigDecimal.ZERO); // valor_pix
            pstmt.setBigDecimal(40, fechamento.getValor_din_real() != null ? fechamento.getValor_din_real() : BigDecimal.ZERO); // valor_din_real
            pstmt.setBigDecimal(41, fechamento.getValor_deb_real() != null ? fechamento.getValor_deb_real() : BigDecimal.ZERO); // valor_deb_real
            pstmt.setBigDecimal(42, fechamento.getValor_cred_real() != null ? fechamento.getValor_cred_real() : BigDecimal.ZERO); // valor_cred_real
            pstmt.setBigDecimal(43, fechamento.getValor_pix_real() != null ? fechamento.getValor_pix_real() : BigDecimal.ZERO); // valor_pix_real
            Date.valueOf(fechamento.getData_fechamento().toLocalDate()); // data_fechamento

            pstmt.executeUpdate();
        } catch (SQLException e) {
            try {
                connection.rollback(); // Rollback em caso de erro
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
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
    public ModelFechaDia buscarFechamento(Date dataFechamento) throws SQLException {
        ModelFechaDia fechamento = null;

        String sql = "SELECT * FROM fecha_dia WHERE data_fechamento = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            // Define o parâmetro da data de fechamento na query
            statement.setDate(1, new java.sql.Date(dataFechamento.getTime()));

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    fechamento = new ModelFechaDia();
                    fechamento.setId(resultSet.getLong("id"));
                    fechamento.setData_fechamento(resultSet.getDate("data_fechamento"));

                    fechamento.setTotal_ft_din(resultSet.getInt("total_ft_din"));
                    fechamento.setTotal_ft_deb(resultSet.getInt("total_ft_deb"));
                    fechamento.setTotal_ft_cred(resultSet.getInt("total_ft_cred"));
                    fechamento.setTotal_ft_pix(resultSet.getInt("total_ft_pix"));

                    fechamento.setTotal_enc_din(resultSet.getInt("total_enc_din"));
                    fechamento.setTotal_enc_deb(resultSet.getInt("total_enc_deb"));
                    fechamento.setTotal_enc_cred(resultSet.getInt("total_enc_cred"));
                    fechamento.setTotal_enc_pix(resultSet.getInt("total_enc_pix"));

                    fechamento.setTotal_dig_din(resultSet.getInt("total_dig_din"));
                    fechamento.setTotal_dig_deb(resultSet.getInt("total_dig_deb"));
                    fechamento.setTotal_dig_cred(resultSet.getInt("total_dig_cred"));
                    fechamento.setTotal_dig_pix(resultSet.getInt("total_dig_pix"));

                    fechamento.setTotal_ribbon_1(resultSet.getInt("total_ribbon_1"));
                    fechamento.setTotal_ribbon_2(resultSet.getInt("total_ribbon_2"));
                    fechamento.setTotal_ribbon_3(resultSet.getInt("total_ribbon_3"));
                    fechamento.setTotal_ribbon_4(resultSet.getInt("total_ribbon_4"));
                    fechamento.setTotal_ribbon_5(resultSet.getInt("total_ribbon_5"));
                    fechamento.setTotal_ribbon_6(resultSet.getInt("total_ribbon_6"));

                    // Adicionando os novos campos old_ribbon
                    fechamento.setOld_ribbon_1(resultSet.getInt("old_ribbon_1"));
                    fechamento.setOld_ribbon_2(resultSet.getInt("old_ribbon_2"));
                    fechamento.setOld_ribbon_3(resultSet.getInt("old_ribbon_3"));
                    fechamento.setOld_ribbon_4(resultSet.getInt("old_ribbon_4"));
                    fechamento.setOld_ribbon_5(resultSet.getInt("old_ribbon_5"));
                    fechamento.setOld_ribbon_6(resultSet.getInt("old_ribbon_6"));

                    fechamento.setSobras(resultSet.getInt("sobras"));
                    fechamento.setDifRibbon1(resultSet.getInt("dif_ribbon_1"));
                    fechamento.setDifRibbon2(resultSet.getInt("dif_ribbon_2"));
                    fechamento.setDifRibbon3(resultSet.getInt("dif_ribbon_3"));
                    fechamento.setDifRibbon4(resultSet.getInt("dif_ribbon_4"));
                    fechamento.setDifRibbon5(resultSet.getInt("dif_ribbon_5"));
                    fechamento.setDifRibbon6(resultSet.getInt("dif_ribbon_6"));

                    fechamento.setDesconto(resultSet.getBigDecimal("desconto"));
                    fechamento.setObservacao(resultSet.getString("observacao"));

                    fechamento.setTotal_revelado(resultSet.getInt("total_revelado"));
                    fechamento.setTotal_informado(resultSet.getInt("total_informado"));

                    // Novos campos de valor
                    fechamento.setValor_din(resultSet.getBigDecimal("valor_din"));
                    fechamento.setValor_deb(resultSet.getBigDecimal("valor_deb"));
                    fechamento.setValor_cred(resultSet.getBigDecimal("valor_cred"));
                    fechamento.setValor_pix(resultSet.getBigDecimal("valor_pix"));

                    fechamento.setValor_din_real(resultSet.getBigDecimal("valor_din_real"));
                    fechamento.setValor_deb_real(resultSet.getBigDecimal("valor_deb_real"));
                    fechamento.setValor_cred_real(resultSet.getBigDecimal("valor_cred_real"));
                    fechamento.setValor_pix_real(resultSet.getBigDecimal("valor_pix_real"));
                }
            }
        }

        return fechamento; // Retorna o objeto ModelFechaDia ou null se não encontrado
    }




}








