package dao;

import connection.SingleConnectionBanco;
import model.ModelConfig;
import model.ModelFechaDia;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


public class DAOFechaDia {
    private Connection connection;

    public DAOFechaDia() {
        connection = SingleConnectionBanco.getConnection();
    }

    public boolean existeVendaParaData(Date data) {
        String query = "SELECT COUNT(*) FROM vendas WHERE data_venda = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setDate(1, data);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next() && resultSet.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ModelFechaDia consultarFechamentoPorData(Date data_fechamento) throws Exception {
        ModelFechaDia modelFechaDia = new ModelFechaDia();

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
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao consultar fechamento do dia: " + e.getMessage());
        }

        // Consulta os ribbons diretamente na tabela controle_ribbon
        String ribbonSql = "SELECT old_ribbon_1, old_ribbon_2, old_ribbon_3, old_ribbon_4, old_ribbon_5, old_ribbon_6, " +
                "ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, ribbon_4_atual, ribbon_5_atual, ribbon_6_atual, " +
                "fim_ribbon_1, fim_ribbon_2, fim_ribbon_3, fim_ribbon_4, fim_ribbon_5, fim_ribbon_6, " +
                "troca_ribbon_1, troca_ribbon_2, troca_ribbon_3, troca_ribbon_4, troca_ribbon_5, troca_ribbon_6 " +
                "FROM controle_ribbon " +
                "ORDER BY data_ribbon DESC " +
                "LIMIT 1";

        try (PreparedStatement preparedRibbonSql = connection.prepareStatement(ribbonSql)) {
            ResultSet resultadoRibbon = preparedRibbonSql.executeQuery();
            if (resultadoRibbon.next()) {
                // Cálculo para cada ribbon com a fórmula: (ribbon_atual - fim_ribbon) + troca_ribbon
                modelFechaDia.setOld_ribbon_1(
                        (resultadoRibbon.getInt("ribbon_1_atual") - resultadoRibbon.getInt("fim_ribbon_1")) +
                                resultadoRibbon.getInt("troca_ribbon_1")
                );
                modelFechaDia.setOld_ribbon_2(
                        (resultadoRibbon.getInt("ribbon_2_atual") - resultadoRibbon.getInt("fim_ribbon_2")) +
                                resultadoRibbon.getInt("troca_ribbon_2")
                );
                modelFechaDia.setOld_ribbon_3(
                        (resultadoRibbon.getInt("ribbon_3_atual") - resultadoRibbon.getInt("fim_ribbon_3")) +
                                resultadoRibbon.getInt("troca_ribbon_3")
                );
                modelFechaDia.setOld_ribbon_4(
                        (resultadoRibbon.getInt("ribbon_4_atual") - resultadoRibbon.getInt("fim_ribbon_4")) +
                                resultadoRibbon.getInt("troca_ribbon_4")
                );
                modelFechaDia.setOld_ribbon_5(
                        (resultadoRibbon.getInt("ribbon_5_atual") - resultadoRibbon.getInt("fim_ribbon_5")) +
                                resultadoRibbon.getInt("troca_ribbon_5")
                );
                modelFechaDia.setOld_ribbon_6(
                        (resultadoRibbon.getInt("ribbon_6_atual") - resultadoRibbon.getInt("fim_ribbon_6")) +
                                resultadoRibbon.getInt("troca_ribbon_6")
                );
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao consultar ribbons na tabela controle_ribbon: " + e.getMessage());
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


    public void inserirFechamento(ModelFechaDia fechamento) {
        String sqlFechaDia = "INSERT INTO fecha_dia (data_fechamento, total_ft_din, total_ft_deb, total_ft_cred, total_ft_pix, " +
                "total_enc_din, total_enc_deb, total_enc_cred, total_enc_pix, total_dig_din, total_dig_deb, total_dig_cred, " +
                "total_dig_pix, ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, ribbon_4_atual, ribbon_5_atual, ribbon_6_atual, " +
                "total_revelado, total_informado, desconto, observacao, rev_ribbon_1, rev_ribbon_2, rev_ribbon_3, rev_ribbon_4, " +
                "rev_ribbon_5, rev_ribbon_6, sobras, old_ribbon_1, old_ribbon_2, old_ribbon_3, old_ribbon_4, old_ribbon_5, old_ribbon_6, " +
                "valor_din, valor_deb, valor_cred, valor_pix) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, UPPER(?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?, ?)";

        String sqlConfDia = "INSERT INTO conf_dia (data_fechamento, valor_din,  valor_deb, " +
                "valor_cred, valor_pix, observacao, ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, " +
                "ribbon_4_atual, ribbon_5_atual, ribbon_6_atual, total_revelado, total_informado, desconto, sobras, rev_ribbon_1, " +
                "rev_ribbon_2, rev_ribbon_3, rev_ribbon_4, rev_ribbon_5, rev_ribbon_6, old_ribbon_1, old_ribbon_2, old_ribbon_3, " +
                "old_ribbon_4, old_ribbon_5, old_ribbon_6) " +
                "VALUES (?, ?, ?, ?, ?, UPPER(?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String sqlControleRibbon = "INSERT INTO controle_ribbon (data_ribbon, ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, " +
                "ribbon_4_atual, ribbon_5_atual, ribbon_6_atual, rev_ribbon_1, rev_ribbon_2, rev_ribbon_3, rev_ribbon_4, rev_ribbon_5, " +
                "rev_ribbon_6, dif_ribbon_1, dif_ribbon_2, dif_ribbon_3, dif_ribbon_4, dif_ribbon_5, dif_ribbon_6, old_ribbon_1, old_ribbon_2, old_ribbon_3, " +
                "old_ribbon_4, old_ribbon_5, old_ribbon_6,sobras) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

        try (PreparedStatement pstmtFechaDia = connection.prepareStatement(sqlFechaDia);
             PreparedStatement pstmtConfDia = connection.prepareStatement(sqlConfDia);
             PreparedStatement pstmtControleRibbon = connection.prepareStatement(sqlControleRibbon)) {

            connection.setAutoCommit(false); // Desabilita o auto-commit

            // Inserção na tabela fecha_dia
            pstmtFechaDia.setDate(1, Date.valueOf(fechamento.getData_fechamento().toLocalDate()));
            pstmtFechaDia.setInt(2, fechamento.getTotal_ft_din());
            pstmtFechaDia.setInt(3, fechamento.getTotal_ft_deb());
            pstmtFechaDia.setInt(4, fechamento.getTotal_ft_cred());
            pstmtFechaDia.setInt(5, fechamento.getTotal_ft_pix());
            pstmtFechaDia.setInt(6, fechamento.getTotal_enc_din());
            pstmtFechaDia.setInt(7, fechamento.getTotal_enc_deb());
            pstmtFechaDia.setInt(8, fechamento.getTotal_enc_cred());
            pstmtFechaDia.setInt(9, fechamento.getTotal_enc_pix());
            pstmtFechaDia.setInt(10, fechamento.getTotal_dig_din());
            pstmtFechaDia.setInt(11, fechamento.getTotal_dig_deb());
            pstmtFechaDia.setInt(12, fechamento.getTotal_dig_cred());
            pstmtFechaDia.setInt(13, fechamento.getTotal_dig_pix());
            pstmtFechaDia.setInt(14, fechamento.getRibbon_1_atual());
            pstmtFechaDia.setInt(15, fechamento.getRibbon_2_atual());
            pstmtFechaDia.setInt(16, fechamento.getRibbon_3_atual());
            pstmtFechaDia.setInt(17, fechamento.getRibbon_4_atual());
            pstmtFechaDia.setInt(18, fechamento.getRibbon_5_atual());
            pstmtFechaDia.setInt(19, fechamento.getRibbon_6_atual());
            pstmtFechaDia.setInt(20, fechamento.getTotal_revelado());
            pstmtFechaDia.setInt(21, fechamento.getTotal_informado());
            pstmtFechaDia.setBigDecimal(22, fechamento.getDesconto());
            pstmtFechaDia.setString(23, fechamento.getObservacao());
            pstmtFechaDia.setInt(24, fechamento.getRev_ribbon_1());
            pstmtFechaDia.setInt(25, fechamento.getRev_ribbon_2());
            pstmtFechaDia.setInt(26, fechamento.getRev_ribbon_3());
            pstmtFechaDia.setInt(27, fechamento.getRev_ribbon_4());
            pstmtFechaDia.setInt(28, fechamento.getRev_ribbon_5());
            pstmtFechaDia.setInt(29, fechamento.getRev_ribbon_6());
            pstmtFechaDia.setInt(30, fechamento.getSobras());
            pstmtFechaDia.setInt(31, fechamento.getOld_ribbon_1());
            pstmtFechaDia.setInt(32, fechamento.getOld_ribbon_2());
            pstmtFechaDia.setInt(33, fechamento.getOld_ribbon_3());
            pstmtFechaDia.setInt(34, fechamento.getOld_ribbon_4());
            pstmtFechaDia.setInt(35, fechamento.getOld_ribbon_5());
            pstmtFechaDia.setInt(36, fechamento.getOld_ribbon_6());
            pstmtFechaDia.setBigDecimal(37, fechamento.getValor_din());
            pstmtFechaDia.setBigDecimal(38, fechamento.getValor_deb());
            pstmtFechaDia.setBigDecimal(39, fechamento.getValor_cred());
            pstmtFechaDia.setBigDecimal(40, fechamento.getValor_pix());
            pstmtFechaDia.executeUpdate();

            // Inserção na tabela conf_dia
            pstmtConfDia.setDate(1, Date.valueOf(fechamento.getData_fechamento().toLocalDate()));
            pstmtConfDia.setBigDecimal(2, fechamento.getValor_din());
            pstmtConfDia.setBigDecimal(3, fechamento.getValor_deb());
            pstmtConfDia.setBigDecimal(4, fechamento.getValor_cred());
            pstmtConfDia.setBigDecimal(5, fechamento.getValor_pix());
            pstmtConfDia.setString(6, fechamento.getObservacao());
            pstmtConfDia.setInt(7, fechamento.getRibbon_1_atual());
            pstmtConfDia.setInt(8, fechamento.getRibbon_2_atual());
            pstmtConfDia.setInt(9, fechamento.getRibbon_3_atual());
            pstmtConfDia.setInt(10, fechamento.getRibbon_4_atual());
            pstmtConfDia.setInt(11, fechamento.getRibbon_5_atual());
            pstmtConfDia.setInt(12, fechamento.getRibbon_6_atual());
            pstmtConfDia.setInt(13, fechamento.getTotal_revelado());
            pstmtConfDia.setInt(14, fechamento.getTotal_informado());
            pstmtConfDia.setBigDecimal(15, fechamento.getDesconto());
            pstmtConfDia.setInt(16, fechamento.getSobras());
            pstmtConfDia.setInt(17, fechamento.getRev_ribbon_1());
            pstmtConfDia.setInt(18, fechamento.getRev_ribbon_2());
            pstmtConfDia.setInt(19, fechamento.getRev_ribbon_3());
            pstmtConfDia.setInt(20, fechamento.getRev_ribbon_4());
            pstmtConfDia.setInt(21, fechamento.getRev_ribbon_5());
            pstmtConfDia.setInt(22, fechamento.getRev_ribbon_6());
            pstmtConfDia.setInt(23, fechamento.getOld_ribbon_1());
            pstmtConfDia.setInt(24, fechamento.getOld_ribbon_2());
            pstmtConfDia.setInt(25, fechamento.getOld_ribbon_3());
            pstmtConfDia.setInt(26, fechamento.getOld_ribbon_4());
            pstmtConfDia.setInt(27, fechamento.getOld_ribbon_5());
            pstmtConfDia.setInt(28, fechamento.getOld_ribbon_6());
            pstmtConfDia.executeUpdate();

            // Inserção na tabela controle_ribbon
            pstmtControleRibbon.setDate(1, Date.valueOf(fechamento.getData_fechamento().toLocalDate()));
            pstmtControleRibbon.setInt(2, fechamento.getRibbon_1_atual());
            pstmtControleRibbon.setInt(3, fechamento.getRibbon_2_atual());
            pstmtControleRibbon.setInt(4, fechamento.getRibbon_3_atual());
            pstmtControleRibbon.setInt(5, fechamento.getRibbon_4_atual());
            pstmtControleRibbon.setInt(6, fechamento.getRibbon_5_atual());
            pstmtControleRibbon.setInt(7, fechamento.getRibbon_6_atual());
            pstmtControleRibbon.setInt(8, fechamento.getRev_ribbon_1());
            pstmtControleRibbon.setInt(9, fechamento.getRev_ribbon_2());
            pstmtControleRibbon.setInt(10, fechamento.getRev_ribbon_3());
            pstmtControleRibbon.setInt(11, fechamento.getRev_ribbon_4());
            pstmtControleRibbon.setInt(12, fechamento.getRev_ribbon_5());
            pstmtControleRibbon.setInt(13, fechamento.getRev_ribbon_6());
            pstmtControleRibbon.setInt(14, fechamento.getDif_ribbon_1());
            pstmtControleRibbon.setInt(15, fechamento.getDif_ribbon_2());
            pstmtControleRibbon.setInt(16, fechamento.getDif_ribbon_3());
            pstmtControleRibbon.setInt(17, fechamento.getDif_ribbon_4());
            pstmtControleRibbon.setInt(18, fechamento.getDif_ribbon_5());
            pstmtControleRibbon.setInt(19, fechamento.getDif_ribbon_6());
            pstmtControleRibbon.setInt(20, fechamento.getOld_ribbon_1());
            pstmtControleRibbon.setInt(21, fechamento.getOld_ribbon_2());
            pstmtControleRibbon.setInt(22, fechamento.getOld_ribbon_3());
            pstmtControleRibbon.setInt(23, fechamento.getOld_ribbon_4());
            pstmtControleRibbon.setInt(24, fechamento.getOld_ribbon_5());
            pstmtControleRibbon.setInt(25, fechamento.getOld_ribbon_6());
            pstmtControleRibbon.setInt(26, fechamento.getSobras());
            pstmtControleRibbon.executeUpdate();

            connection.commit(); // Finaliza a transação

        } catch (SQLException e) {
            try {
                connection.rollback(); // Reverte a transação em caso de erro
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true); // Restaura o auto-commit
            } catch (SQLException autoCommitEx) {
                autoCommitEx.printStackTrace();
            }
        }

    }







    public void atualizarFechamento(ModelFechaDia fechamento) {
        String sqlFechaDia = "UPDATE fecha_dia SET total_ft_din = ?, total_ft_deb = ?, total_ft_cred = ?, total_ft_pix = ?, " +
                "total_enc_din = ?, total_enc_deb = ?, total_enc_cred = ?, total_enc_pix = ?, " +
                "total_dig_din = ?, total_dig_deb = ?, total_dig_cred = ?, total_dig_pix = ?, " +
                "ribbon_1_atual = ?, ribbon_2_atual = ?, ribbon_3_atual = ?, ribbon_4_atual = ?, " +
                "ribbon_5_atual = ?, ribbon_6_atual = ?, total_revelado = ?, total_informado = ?, " +
                "desconto = ?, observacao = UPPER(?), rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, rev_ribbon_4 = ?, " +
                "rev_ribbon_5 = ?, rev_ribbon_6 = ?, sobras = ?, old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, " +
                "old_ribbon_4 = ?, old_ribbon_5 = ?, old_ribbon_6 = ?, " +
                "valor_din = ?, valor_deb = ?, valor_cred = ?, valor_pix = ? " +
                "WHERE data_fechamento = ?";

        String sqlConfDia = "UPDATE conf_dia SET valor_din = ?, valor_deb = ?, valor_cred = ?, valor_pix = ?, observacao = UPPER(?), " +
                "ribbon_1_atual = ?, ribbon_2_atual = ?, ribbon_3_atual = ?, ribbon_4_atual = ?, " +
                "ribbon_5_atual = ?, ribbon_6_atual = ?, total_revelado = ?, total_informado = ?, " +
                "desconto = ?, sobras = ?, rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, rev_ribbon_4 = ?, " +
                "rev_ribbon_5 = ?, rev_ribbon_6 = ?, old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, " +
                "old_ribbon_4 = ?, old_ribbon_5 = ?, old_ribbon_6 = ? " +
                "WHERE data_fechamento = ?";

        String sqlControleRibbon = "UPDATE controle_ribbon SET ribbon_1_atual = ?, ribbon_2_atual = ?, ribbon_3_atual = ?, " +
                "ribbon_4_atual = ?, ribbon_5_atual = ?, ribbon_6_atual = ?, " +
                "rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, rev_ribbon_4 = ?, rev_ribbon_5 = ?, rev_ribbon_6 = ?, " +
                "dif_ribbon_1 = ?, dif_ribbon_2 = ?, dif_ribbon_3 = ?, dif_ribbon_4 = ?, dif_ribbon_5 = ?, dif_ribbon_6 = ? " +
                "WHERE data_ribbon = ?";

        try (PreparedStatement pstmtFechaDia = connection.prepareStatement(sqlFechaDia);
             PreparedStatement pstmtConfDia = connection.prepareStatement(sqlConfDia);
             PreparedStatement pstmtControleRibbon = connection.prepareStatement(sqlControleRibbon)) {

            // Atualização na tabela fecha_dia
            pstmtFechaDia.setInt(1, fechamento.getTotal_ft_din());
            pstmtFechaDia.setInt(2, fechamento.getTotal_ft_deb());
            pstmtFechaDia.setInt(3, fechamento.getTotal_ft_cred());
            pstmtFechaDia.setInt(4, fechamento.getTotal_ft_pix());
            pstmtFechaDia.setInt(5, fechamento.getTotal_enc_din());
            pstmtFechaDia.setInt(6, fechamento.getTotal_enc_deb());
            pstmtFechaDia.setInt(7, fechamento.getTotal_enc_cred());
            pstmtFechaDia.setInt(8, fechamento.getTotal_enc_pix());
            pstmtFechaDia.setInt(9, fechamento.getTotal_dig_din());
            pstmtFechaDia.setInt(10, fechamento.getTotal_dig_deb());
            pstmtFechaDia.setInt(11, fechamento.getTotal_dig_cred());
            pstmtFechaDia.setInt(12, fechamento.getTotal_dig_pix());
            pstmtFechaDia.setInt(13, fechamento.getRibbon_1_atual());
            pstmtFechaDia.setInt(14, fechamento.getRibbon_2_atual());
            pstmtFechaDia.setInt(15, fechamento.getRibbon_3_atual());
            pstmtFechaDia.setInt(16, fechamento.getRibbon_4_atual());
            pstmtFechaDia.setInt(17, fechamento.getRibbon_5_atual());
            pstmtFechaDia.setInt(18, fechamento.getRibbon_6_atual());
            pstmtFechaDia.setInt(19, fechamento.getTotal_revelado());
            pstmtFechaDia.setInt(20, fechamento.getTotal_informado());
            pstmtFechaDia.setBigDecimal(21, fechamento.getDesconto());
            pstmtFechaDia.setString(22, fechamento.getObservacao());
            pstmtFechaDia.setInt(23, fechamento.getRev_ribbon_1());
            pstmtFechaDia.setInt(24, fechamento.getRev_ribbon_2());
            pstmtFechaDia.setInt(25, fechamento.getRev_ribbon_3());
            pstmtFechaDia.setInt(26, fechamento.getRev_ribbon_4());
            pstmtFechaDia.setInt(27, fechamento.getRev_ribbon_5());
            pstmtFechaDia.setInt(28, fechamento.getRev_ribbon_6());
            pstmtFechaDia.setInt(29, fechamento.getSobras());
            pstmtFechaDia.setInt(30, fechamento.getOld_ribbon_1());
            pstmtFechaDia.setInt(31, fechamento.getOld_ribbon_2());
            pstmtFechaDia.setInt(32, fechamento.getOld_ribbon_3());
            pstmtFechaDia.setInt(33, fechamento.getOld_ribbon_4());
            pstmtFechaDia.setInt(34, fechamento.getOld_ribbon_5());
            pstmtFechaDia.setInt(35, fechamento.getOld_ribbon_6());
            pstmtFechaDia.setBigDecimal(36, fechamento.getValor_din());
            pstmtFechaDia.setBigDecimal(37, fechamento.getValor_deb());
            pstmtFechaDia.setBigDecimal(38, fechamento.getValor_cred());
            pstmtFechaDia.setBigDecimal(39, fechamento.getValor_pix());
            pstmtFechaDia.setDate(40, Date.valueOf(fechamento.getData_fechamento().toLocalDate()));

            // Atualização na tabela conf_dia
            pstmtConfDia.setBigDecimal(1, fechamento.getValor_din());
            pstmtConfDia.setBigDecimal(2, fechamento.getValor_deb());
            pstmtConfDia.setBigDecimal(3, fechamento.getValor_cred());
            pstmtConfDia.setBigDecimal(4, fechamento.getValor_pix());
            pstmtConfDia.setString(5, fechamento.getObservacao());
            pstmtConfDia.setInt(6, fechamento.getRibbon_1_atual());
            pstmtConfDia.setInt(7, fechamento.getRibbon_2_atual());
            pstmtConfDia.setInt(8, fechamento.getRibbon_3_atual());
            pstmtConfDia.setInt(9, fechamento.getRibbon_4_atual());
            pstmtConfDia.setInt(10, fechamento.getRibbon_5_atual());
            pstmtConfDia.setInt(11, fechamento.getRibbon_6_atual());
            pstmtConfDia.setInt(12, fechamento.getTotal_revelado());
            pstmtConfDia.setInt(13, fechamento.getTotal_informado());
            pstmtConfDia.setBigDecimal(14, fechamento.getDesconto());
            pstmtConfDia.setInt(15, fechamento.getSobras());
            pstmtConfDia.setInt(16, fechamento.getRev_ribbon_1());
            pstmtConfDia.setInt(17, fechamento.getRev_ribbon_2());
            pstmtConfDia.setInt(18, fechamento.getRev_ribbon_3());
            pstmtConfDia.setInt(19, fechamento.getRev_ribbon_4());
            pstmtConfDia.setInt(20, fechamento.getRev_ribbon_5());
            pstmtConfDia.setInt(21, fechamento.getRev_ribbon_6());
            pstmtConfDia.setInt(22, fechamento.getOld_ribbon_1());
            pstmtConfDia.setInt(23, fechamento.getOld_ribbon_2());
            pstmtConfDia.setInt(24, fechamento.getOld_ribbon_3());
            pstmtConfDia.setInt(25, fechamento.getOld_ribbon_4());
            pstmtConfDia.setInt(26, fechamento.getOld_ribbon_5());
            pstmtConfDia.setInt(27, fechamento.getOld_ribbon_6());
            pstmtConfDia.setDate(28, Date.valueOf(fechamento.getData_fechamento().toLocalDate()));

            // Atualização na tabela controle_ribbon
            pstmtControleRibbon.setInt(1, fechamento.getRibbon_1_atual());
            pstmtControleRibbon.setInt(2, fechamento.getRibbon_2_atual());
            pstmtControleRibbon.setInt(3, fechamento.getRibbon_3_atual());
            pstmtControleRibbon.setInt(4, fechamento.getRibbon_4_atual());
            pstmtControleRibbon.setInt(5, fechamento.getRibbon_5_atual());
            pstmtControleRibbon.setInt(6, fechamento.getRibbon_6_atual());
            pstmtControleRibbon.setInt(7, fechamento.getRev_ribbon_1());
            pstmtControleRibbon.setInt(8, fechamento.getRev_ribbon_2());
            pstmtControleRibbon.setInt(9, fechamento.getRev_ribbon_3());
            pstmtControleRibbon.setInt(10, fechamento.getRev_ribbon_4());
            pstmtControleRibbon.setInt(11, fechamento.getRev_ribbon_5());
            pstmtControleRibbon.setInt(12, fechamento.getRev_ribbon_6());
            pstmtControleRibbon.setInt(13, fechamento.getDif_ribbon_1());
            pstmtControleRibbon.setInt(14, fechamento.getDif_ribbon_2());
            pstmtControleRibbon.setInt(15, fechamento.getDif_ribbon_3());
            pstmtControleRibbon.setInt(16, fechamento.getDif_ribbon_4());
            pstmtControleRibbon.setInt(17, fechamento.getDif_ribbon_5());
            pstmtControleRibbon.setInt(18, fechamento.getDif_ribbon_6());
            pstmtControleRibbon.setDate(19, Date.valueOf(fechamento.getData_fechamento().toLocalDate()));

            pstmtFechaDia.executeUpdate();
            pstmtConfDia.executeUpdate();
            pstmtControleRibbon.executeUpdate();
        } catch (SQLException e) {
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

                    fechamento.setRibbon_1_atual(resultSet.getInt("ribbon_1_atual"));
                    fechamento.setRibbon_2_atual(resultSet.getInt("ribbon_2_atual"));
                    fechamento.setRibbon_3_atual(resultSet.getInt("ribbon_3_atual"));
                    fechamento.setRibbon_4_atual(resultSet.getInt("ribbon_4_atual"));
                    fechamento.setRibbon_5_atual(resultSet.getInt("ribbon_5_atual"));
                    fechamento.setRibbon_6_atual(resultSet.getInt("ribbon_6_atual"));

                    // Adicionando os novos campos old_ribbon
                    fechamento.setOld_ribbon_1(resultSet.getInt("old_ribbon_1"));
                    fechamento.setOld_ribbon_2(resultSet.getInt("old_ribbon_2"));
                    fechamento.setOld_ribbon_3(resultSet.getInt("old_ribbon_3"));
                    fechamento.setOld_ribbon_4(resultSet.getInt("old_ribbon_4"));
                    fechamento.setOld_ribbon_5(resultSet.getInt("old_ribbon_5"));
                    fechamento.setOld_ribbon_6(resultSet.getInt("old_ribbon_6"));

                    fechamento.setSobras(resultSet.getInt("sobras"));
                    fechamento.setRev_ribbon_1(resultSet.getInt("rev_ribbon_1"));
                    fechamento.setRev_ribbon_2(resultSet.getInt("rev_ribbon_2"));
                    fechamento.setRev_ribbon_3(resultSet.getInt("rev_ribbon_3"));
                    fechamento.setRev_ribbon_4(resultSet.getInt("rev_ribbon_4"));
                    fechamento.setRev_ribbon_5(resultSet.getInt("rev_ribbon_5"));
                    fechamento.setRev_ribbon_6(resultSet.getInt("rev_ribbon_6"));

                    fechamento.setDesconto(resultSet.getBigDecimal("desconto"));
                    fechamento.setObservacao(resultSet.getString("observacao"));

                    fechamento.setTotal_revelado(resultSet.getInt("total_revelado"));
                    fechamento.setTotal_informado(resultSet.getInt("total_informado"));

                    // Novos campos de valor
                    fechamento.setValor_din(resultSet.getBigDecimal("valor_din"));
                    fechamento.setValor_deb(resultSet.getBigDecimal("valor_deb"));
                    fechamento.setValor_cred(resultSet.getBigDecimal("valor_cred"));
                    fechamento.setValor_pix(resultSet.getBigDecimal("valor_pix"));


                }
            }
        }

        return fechamento; // Retorna o objeto ModelFechaDia ou null se não encontrado
    }




}








