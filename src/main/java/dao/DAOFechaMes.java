package dao;

import connection.SingleConnectionBanco;
import model.ModelConfig;
import model.ModelFechaDia;
import model.ModelFechaMes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOFechaMes {

    private Connection connection;

    public DAOFechaMes() {
        this.connection = SingleConnectionBanco.getConnection();
    }

    public List<ModelFechaMes> buscarFechamentoMensal(String dataInicial, String dataFinal) throws SQLException {
        List<ModelFechaMes> resumoMensal = new ArrayList<>();

        LocalDate dataInicio = LocalDate.parse(dataInicial);
        LocalDate dataFim = LocalDate.parse(dataFinal);

        String sqlFechamento = "SELECT " +
                "SUM(total_ft_din + total_ft_deb + total_ft_cred + total_ft_pix) AS total_ft, " +
                "SUM(total_enc_din + total_enc_deb + total_enc_cred + total_enc_pix) AS total_enc, " +
                "SUM(total_dig_din + total_dig_deb + total_dig_cred + total_dig_pix) AS total_dig, " +
                "SUM(sobras) AS total_sobras " +
                "FROM fecha_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ?";

        String sqlConfiguracoes = "SELECT " +
                "SUM(valor_din) AS valor_din, " +
                "SUM(valor_din_real) AS valor_din_real, " +
                "SUM(valor_deb) AS valor_deb, " +
                "SUM(valor_deb_real) AS valor_deb_real, " +
                "SUM(valor_cred) AS valor_cred, " +
                "SUM(valor_cred_real) AS valor_cred_real, " +
                "SUM(valor_pix) AS valor_pix, " +
                "SUM(valor_pix_real) AS valor_pix_real, " +
                "SUM(valor_despesa_total) AS valor_despesa_total, " +
                "SUM(valor_vale_total) AS valor_vale_total, " +
                "SUM(desconto) AS desconto " +
                "FROM conf_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ?";

        // SQL para configuracao
        String sqlConfiguracao = "SELECT * FROM configuracao WHERE \"idConf\" = 2";

        try {
            // Prepara a conexão e executa a primeira consulta (fecha_dia)
            try (PreparedStatement pst = connection.prepareStatement(sqlFechamento)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = new ModelFechaMes();
                        resumo.setTotal_ft(rs.getInt("total_ft"));
                        resumo.setTotal_enc(rs.getInt("total_enc"));
                        resumo.setTotal_dig(rs.getInt("total_dig"));
                        resumo.setTotal_sobras(rs.getInt("total_sobras"));
                        resumoMensal.add(resumo); // Adiciona os dados de fecha_dia
                    }
                }
            }

            // Prepara e executa a segunda consulta (conf_dia)
            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracoes)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        // Verifica se a lista já tem um objeto, se tiver, atualiza com os dados de conf_dia
                        if (!resumoMensal.isEmpty()) {
                            ModelFechaMes resumo = resumoMensal.get(0);  // Pega o primeiro item
                            resumo.setValor_din_mes(rs.getBigDecimal("valor_din"));
                            resumo.setValor_din_mes_real(rs.getBigDecimal("valor_din_real"));
                            resumo.setValor_deb_mes(rs.getBigDecimal("valor_deb"));
                            resumo.setValor_deb_mes_real(rs.getBigDecimal("valor_deb_real"));
                            resumo.setValor_cred_mes(rs.getBigDecimal("valor_cred"));
                            resumo.setValor_cred_mes_real(rs.getBigDecimal("valor_cred_real"));
                            resumo.setValor_pix_mes(rs.getBigDecimal("valor_pix"));
                            resumo.setValor_pix_mes_real(rs.getBigDecimal("valor_pix_real"));
                            resumo.setValor_despesa_total(rs.getBigDecimal("valor_despesa_total"));
                            resumo.setValor_vale_total(rs.getBigDecimal("valor_vale_total"));
                            resumo.setDesconto_mes(rs.getBigDecimal("desconto"));
                        }
                    }
                }
            }

            // Prepara e executa a terceira consulta (configuracao)
            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracao)) {
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        // Verifica se a lista já tem um objeto, se tiver, atualiza com os dados de configuracao
                        if (!resumoMensal.isEmpty()) {
                            ModelFechaMes resumo = resumoMensal.get(0); // Pega o primeiro item
                            resumo.setIdConf(rs.getLong("idConf"));
                            resumo.setConf1_valor(rs.getBigDecimal("conf1_valor"));
                            resumo.setConf1_valor2(rs.getBigDecimal("conf1_valor2"));
                            resumo.setConf2_valor(rs.getBigDecimal("conf2_valor"));
                            resumo.setConf3_valor(rs.getBigDecimal("conf3_valor"));
                            resumo.setConf4_valor(rs.getBigDecimal("conf4_valor"));
                            resumo.setConf1_custo(rs.getBigDecimal("conf1_custo"));
                            resumo.setConf2_custo(rs.getBigDecimal("conf2_custo"));
                            resumo.setConf3_custo(rs.getBigDecimal("conf3_custo"));
                            resumo.setConf4_custo(rs.getBigDecimal("conf4_custo"));
                            resumo.setConf1_nome(rs.getString("conf1_nome"));
                            resumo.setConf2_nome(rs.getString("conf2_nome"));
                            resumo.setConf3_nome(rs.getString("conf3_nome"));
                            resumo.setConf4_nome(rs.getString("conf4_nome"));
                            resumo.setConf_name(rs.getString("conf_name"));
                            resumo.setConf1_qtd(rs.getInt("conf1_qtd"));
                            resumo.setConf2_qtd(rs.getInt("conf2_qtd"));
                            resumo.setConf3_qtd(rs.getInt("conf3_qtd"));
                            resumo.setConf4_qtd(rs.getInt("conf4_qtd"));
                        } else {
                            // Se não houver objeto, cria um novo e adiciona à lista
                            ModelFechaMes configuracao = new ModelFechaMes();
                            configuracao.setIdConf(rs.getLong("idConf"));
                            configuracao.setConf1_valor(rs.getBigDecimal("conf1_valor"));
                            configuracao.setConf1_valor2(rs.getBigDecimal("conf1_valor2"));
                            configuracao.setConf2_valor(rs.getBigDecimal("conf2_valor"));
                            configuracao.setConf3_valor(rs.getBigDecimal("conf3_valor"));
                            configuracao.setConf4_valor(rs.getBigDecimal("conf4_valor"));
                            configuracao.setConf1_custo(rs.getBigDecimal("conf1_custo"));
                            configuracao.setConf2_custo(rs.getBigDecimal("conf2_custo"));
                            configuracao.setConf3_custo(rs.getBigDecimal("conf3_custo"));
                            configuracao.setConf4_custo(rs.getBigDecimal("conf4_custo"));
                            configuracao.setConf1_nome(rs.getString("conf1_nome"));
                            configuracao.setConf2_nome(rs.getString("conf2_nome"));
                            configuracao.setConf3_nome(rs.getString("conf3_nome"));
                            configuracao.setConf4_nome(rs.getString("conf4_nome"));
                            configuracao.setConf_name(rs.getString("conf_name"));
                            configuracao.setConf1_qtd(rs.getInt("conf1_qtd"));
                            configuracao.setConf2_qtd(rs.getInt("conf2_qtd"));
                            configuracao.setConf3_qtd(rs.getInt("conf3_qtd"));
                            configuracao.setConf4_qtd(rs.getInt("conf4_qtd"));

                            resumoMensal.add(configuracao); // Adiciona o novo objeto à lista
                        }
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Erro ao executar as consultas: " + e.getMessage());
            throw e;
        }

        return resumoMensal;  // Retorna a lista com todos os dados combinados
    }






}

