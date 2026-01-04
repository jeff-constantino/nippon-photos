package dao;

import connection.SingleConnectionBanco;
import model.ModelFechaMes;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

public class DAOComparativoYoY {
    private final Connection connection;

    public DAOComparativoYoY() {
        this.connection = SingleConnectionBanco.getConnection();
    }

    /**
     * Busca dados de vendas de um mês/ano específico para comparação
     * @param mes Mês (1-12)
     * @param ano Ano (ex: 2024)
     * @return ModelFechaMes com os dados consolidados do mês
     */
    public ModelFechaMes buscarDadosMesAno(int mes, int ano) throws SQLException {


        // Calcula primeiro e último dia do mês
        YearMonth yearMonth = YearMonth.of(ano, mes);
        LocalDate dataInicio = yearMonth.atDay(1);
        LocalDate dataFim = yearMonth.atEndOfMonth();



        ModelFechaMes resumo = new ModelFechaMes();

        // Consulta fecha_dia para totais de fotos
        String sqlFechamento = "SELECT " +
                "SUM(total_ft_din + total_ft_deb + total_ft_cred + total_ft_pix) AS total_ft, " +
                "SUM(total_enc_din + total_enc_deb + total_enc_cred + total_enc_pix) AS total_enc, " +
                "SUM(total_dig_din + total_dig_deb + total_dig_cred + total_dig_pix) AS total_dig, " +
                "SUM(sobras) AS total_sobras " +
                "FROM fecha_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ?";

        // Consulta conf_dia para valores totais
        String sqlConfiguracoes = "SELECT " +
                "SUM(valor_din) AS valor_din, " +
                "SUM(valor_din_real) AS valor_din_real, " +
                "SUM(valor_deb) AS valor_deb, " +
                "SUM(valor_deb_real) AS valor_deb_real, " +
                "SUM(valor_cred) AS valor_cred, " +
                "SUM(valor_cred_real) AS valor_cred_real, " +
                "SUM(valor_pix) AS valor_pix, " +
                "SUM(valor_pix_real) AS valor_pix_real " +
                "FROM conf_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ?";

        // Consulta quantidade de ribbon da tabela conf_materiais
        String sqlQtdRibbon = "SELECT qtd AS qtd_ribbon FROM conf_materiais WHERE id_conf = 1";

        try {
            // Busca a quantidade de ribbon
            int qtdRibbon = 0;

            try (PreparedStatement pst = connection.prepareStatement(sqlQtdRibbon)) {
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        qtdRibbon = rs.getInt("qtd_ribbon");

                    } else {
                        System.out.println("ATENÇÃO: qtd_ribbon não encontrado na tabela conf_materiais");
                    }
                }
            }


            // Busca totais de fotos

            try (PreparedStatement pst = connection.prepareStatement(sqlFechamento)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        resumo.setTotal_ft(rs.getInt("total_ft"));
                        resumo.setTotal_enc(rs.getInt("total_enc"));
                        resumo.setTotal_dig(rs.getInt("total_dig"));
                        resumo.setTotal_sobras(rs.getInt("total_sobras"));

                    } else {
                        System.out.println("Nenhum registro encontrado em fecha_dia");
                    }
                }
            }

            // Busca valores monetários

            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracoes)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        // Usa BigDecimal.ZERO como padrão se for null
                        resumo.setValor_din_mes(rs.getBigDecimal("valor_din") != null ? rs.getBigDecimal("valor_din") : BigDecimal.ZERO);
                        resumo.setValor_din_mes_real(rs.getBigDecimal("valor_din_real") != null ? rs.getBigDecimal("valor_din_real") : BigDecimal.ZERO);
                        resumo.setValor_deb_mes(rs.getBigDecimal("valor_deb") != null ? rs.getBigDecimal("valor_deb") : BigDecimal.ZERO);
                        resumo.setValor_deb_mes_real(rs.getBigDecimal("valor_deb_real") != null ? rs.getBigDecimal("valor_deb_real") : BigDecimal.ZERO);
                        resumo.setValor_cred_mes(rs.getBigDecimal("valor_cred") != null ? rs.getBigDecimal("valor_cred") : BigDecimal.ZERO);
                        resumo.setValor_cred_mes_real(rs.getBigDecimal("valor_cred_real") != null ? rs.getBigDecimal("valor_cred_real") : BigDecimal.ZERO);
                        resumo.setValor_pix_mes(rs.getBigDecimal("valor_pix") != null ? rs.getBigDecimal("valor_pix") : BigDecimal.ZERO);
                        resumo.setValor_pix_mes_real(rs.getBigDecimal("valor_pix_real") != null ? rs.getBigDecimal("valor_pix_real") : BigDecimal.ZERO);

                    } else {
                        System.out.println("Nenhum registro encontrado em conf_dia");
                        // Inicializa com zeros para evitar NullPointerException
                        resumo.setValor_din_mes(BigDecimal.ZERO);
                        resumo.setValor_din_mes_real(BigDecimal.ZERO);
                        resumo.setValor_deb_mes(BigDecimal.ZERO);
                        resumo.setValor_deb_mes_real(BigDecimal.ZERO);
                        resumo.setValor_cred_mes(BigDecimal.ZERO);
                        resumo.setValor_cred_mes_real(BigDecimal.ZERO);
                        resumo.setValor_pix_mes(BigDecimal.ZERO);
                        resumo.setValor_pix_mes_real(BigDecimal.ZERO);
                    }
                }
            }

            // Busca ribbons (ajuste conforme necessário)
            // Se não tiver ribbons no banco, comente esta parte
            /*
            try (PreparedStatement pst = connection.prepareStatement(sqlRibbons)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        resumo.setTotal_ribbons(rs.getInt("total_ribbons"));
                    }
                }
            }
            */

            // Busca vendas diárias

            String sqlRelatorioDia = "SELECT " +
                    "EXTRACT(DAY FROM data_fechamento) AS dia, " +
                    "EXTRACT(DOW FROM data_fechamento) AS dow, " +
                    "venda_total_dia " +
                    "FROM conf_dia " +
                    "WHERE data_fechamento >= ? AND data_fechamento <= ? " +
                    "ORDER BY data_fechamento";

            List<ModelFechaMes> relatorioDiario = new ArrayList<>();
            String[] diasPt = {"Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"};

            try (PreparedStatement pst = connection.prepareStatement(sqlRelatorioDia)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));

                try (ResultSet rs = pst.executeQuery()) {
                    int count = 0;
                    while (rs.next()) {
                        ModelFechaMes dia = new ModelFechaMes();
                        dia.setDia(rs.getInt("dia"));

                        int dow = rs.getInt("dow");
                        if (dow >= 0 && dow <= 6) {
                            dia.setDiaSemana(diasPt[dow]);
                        } else {
                            dia.setDiaSemana("?");
                        }

                        // Protege contra valores null
                        BigDecimal vendaDia = rs.getBigDecimal("venda_total_dia");
                        dia.setVenda_total_dia(vendaDia != null ? vendaDia : BigDecimal.ZERO);
                        relatorioDiario.add(dia);
                        count++;
                    }

                }
            }
            resumo.setRelatorioDiario(relatorioDiario);

            // Calcula ribbons: (total_ft + total_sobras) / qtd_ribbon usando BigDecimal
            BigDecimal totalRibbons = BigDecimal.ZERO;
            if (qtdRibbon > 0) {
                BigDecimal qtdRibbonBD = BigDecimal.valueOf(qtdRibbon);
                BigDecimal totalFt = BigDecimal.valueOf(resumo.getTotal_ft());
                BigDecimal totalSobras = BigDecimal.valueOf(resumo.getTotal_sobras());
                totalRibbons = totalFt.add(totalSobras).divide(qtdRibbonBD, 2, java.math.RoundingMode.HALF_UP);

            } else {
                System.out.println("qtd_ribbon é 0, ribbons definido como 0");
            }

            // Armazena o valor de ribbons como BigDecimal no resumo
            resumo.setTotal_ribbons_decimal(totalRibbons);
            // Armazena qtd_ribbon para referência
            resumo.setQtd_ribbon(qtdRibbon);



        } catch (SQLException e) {
            System.err.println("ERRO SQL NO DAO: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }

        return resumo;
    }
}