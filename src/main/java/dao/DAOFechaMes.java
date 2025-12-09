package dao;

import connection.SingleConnectionBanco;
import model.ModelConfig;
import model.ModelFechaDia;
import model.ModelFechaMes;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOFechaMes {

    private final Connection connection;

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
                "SUM(desconto) AS desconto " +
                "FROM conf_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ?";

        String sqlVales = "SELECT SUM(valor) AS total_vales FROM vales WHERE data >= ? AND data <= ?";
        String sqlConfiguracao = "SELECT * FROM configuracao WHERE idconf = 1";
        String sqlMateriais = "SELECT qtd AS qtd_ribbon FROM conf_materiais WHERE id_conf = 1";

        // 🔽 CONSULTA SALÁRIOS (mantém a mesma SQL)
        String sqlSalarios = "SELECT SUM(salario_liquido1) AS total_salarios FROM salarios " +
                "WHERE mes >= ? AND mes <= ? AND ano >= ? AND ano <= ?";

        try {
            /* === Consulta fecha_dia === */
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
                        resumoMensal.add(resumo);
                    }
                }
            }

            /* === Consulta conf_dia === */
            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracoes)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next() && !resumoMensal.isEmpty()) {
                        ModelFechaMes resumo = resumoMensal.get(0);
                        resumo.setValor_din_mes(rs.getBigDecimal("valor_din"));
                        resumo.setValor_din_mes_real(rs.getBigDecimal("valor_din_real"));
                        resumo.setValor_deb_mes(rs.getBigDecimal("valor_deb"));
                        resumo.setValor_deb_mes_real(rs.getBigDecimal("valor_deb_real"));
                        resumo.setValor_cred_mes(rs.getBigDecimal("valor_cred"));
                        resumo.setValor_cred_mes_real(rs.getBigDecimal("valor_cred_real"));
                        resumo.setValor_pix_mes(rs.getBigDecimal("valor_pix"));
                        resumo.setValor_pix_mes_real(rs.getBigDecimal("valor_pix_real"));
                        resumo.setValor_despesa_total(rs.getBigDecimal("valor_despesa_total"));
                        resumo.setDesconto_mes(rs.getBigDecimal("desconto"));
                    }
                }
            }

            /* === Consulta vales === */
            try (PreparedStatement pst = connection.prepareStatement(sqlVales)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next() && !resumoMensal.isEmpty()) {
                        ModelFechaMes resumo = resumoMensal.get(0);
                        resumo.setValor_vale_total(rs.getBigDecimal("total_vales"));
                    }
                }
            }

            /* === Consulta configuracao === */
            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracao)) {
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);

                        resumo.setIdconf(rs.getLong("idconf"));
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

                        if (resumoMensal.isEmpty()) {
                            resumoMensal.add(resumo);
                        }
                    }
                }
            }

            /* === Consulta conf_materiais === */
            try (PreparedStatement pst = connection.prepareStatement(sqlMateriais);
                 ResultSet rs = pst.executeQuery()) {

                if (rs.next() && !resumoMensal.isEmpty()) {
                    ModelFechaMes resumo = resumoMensal.get(0);
                    resumo.setQtd_ribbon(rs.getInt("qtd_ribbon"));
                }
            }

            // 🆕 CONSULTA SALÁRIOS - AGORA NA POSIÇÃO CORRETA (DEPOIS DE CRIAR O OBJETO)
            try (PreparedStatement pst = connection.prepareStatement(sqlSalarios)) {
                pst.setInt(1, dataInicio.getMonthValue()); // mês inicial
                pst.setInt(2, dataFim.getMonthValue());     // mês final
                pst.setInt(3, dataInicio.getYear());       // ano inicial
                pst.setInt(4, dataFim.getYear());          // ano final

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next() && !resumoMensal.isEmpty()) {
                        ModelFechaMes resumo = resumoMensal.get(0);
                        resumo.setTotal_salarios(rs.getBigDecimal("total_salarios"));
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Erro ao executar as consultas: " + e.getMessage());
            throw e;
        }

        return resumoMensal;
    }




    public void gravarFechamentoMes(ModelFechaMes fechamento) throws SQLException {
        String sql = "INSERT INTO fecha_mes (" +
                "mes, ano, total_ft, total_enc, total_dig, total_sobras, total_ribbons, " +
                "valor_din_mes_real, valor_deb_mes_real, valor_cred_mes_real, valor_pix_mes_real, " +
                "total_geral, juros_cartoes, valor_total_despesas, valor_total_contas, " +
                "valor_vale_total, desconto_mes, debito_vm, credito_vm, debito_outros, credito_outros" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setInt(1, fechamento.getMes());
            pst.setInt(2, fechamento.getAno());
            pst.setInt(3, fechamento.getTotal_ft());
            pst.setInt(4, fechamento.getTotal_enc());
            pst.setInt(5, fechamento.getTotal_dig());
            pst.setInt(6, fechamento.getTotal_sobras());
            pst.setBigDecimal(7, fechamento.getTotal_ribbons());

            pst.setBigDecimal(8, fechamento.getValor_din_mes_real());
            pst.setBigDecimal(9, fechamento.getValor_deb_mes_real());
            pst.setBigDecimal(10, fechamento.getValor_cred_mes_real());
            pst.setBigDecimal(11, fechamento.getValor_pix_mes_real());

            pst.setBigDecimal(12, fechamento.getTotal_geral());
            pst.setBigDecimal(13, fechamento.getJuros_cartoes());
            pst.setBigDecimal(14, fechamento.getValor_total_despesas());
            pst.setBigDecimal(15, fechamento.getValor_total_contas());
            pst.setBigDecimal(16, fechamento.getValor_vale_total());
            pst.setBigDecimal(17, fechamento.getDesconto_mes());

            pst.setBigDecimal(18, fechamento.getDebitoVm());
            pst.setBigDecimal(19, fechamento.getCreditoVm());
            pst.setBigDecimal(20, fechamento.getDebitoOutros());
            pst.setBigDecimal(21, fechamento.getCreditoOutros());

            pst.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            System.err.println("Erro ao gravar fechamento do mês: " + e.getMessage());
            throw e;
        }
    }





}