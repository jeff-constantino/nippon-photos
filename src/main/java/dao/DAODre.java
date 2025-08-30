package dao;

import connection.SingleConnectionBanco;
import model.ModelDre;
import model.ModelFechaMes;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAODre {
    private final Connection connection;

    public DAODre() {
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
                "SUM(desconto) AS desconto " +
                "FROM conf_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ?";

        String sqlDespesas = "SELECT SUM(valor_despesa) AS despesa_total FROM despesas WHERE data_despesa >= ? AND data_despesa <= ?";
        String sqlContas = "SELECT SUM(valor) AS total_contas FROM contas WHERE data_de_pagamento >= ? AND data_de_pagamento <= ?";
        String sqlVales = "SELECT SUM(valor) AS total_vales FROM vales WHERE data >= ? AND data <= ?";
        String sqlConfiguracao = "SELECT * FROM configuracao WHERE \"idConf\" = 1";

        // 🔽 NOVA CONSULTA SALÁRIOS
        String sqlSalarios = "SELECT SUM(salario_total2) AS total_salarios FROM salarios " +
                "WHERE mes >= ? AND mes <= ? AND ano >= ? AND ano <= ?";

        // 🔽 BUSCA DE CONDUTAS
        int totalAdvert = 0;
        int totalFaltas = 0;
        int totalSusp = 0;

        // Advertências
        String sqlAdvert = "SELECT COUNT(*) AS total_advert FROM advertencias WHERE data_advertencia BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlAdvert)) {
            stmt.setDate(1, java.sql.Date.valueOf(dataInicio));
            stmt.setDate(2, java.sql.Date.valueOf(dataFim));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) totalAdvert = rs.getInt("total_advert");
            }
        }

        // Faltas
        String sqlFaltas = "SELECT COUNT(*) AS total_faltas FROM faltas WHERE data_falta BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlFaltas)) {
            stmt.setDate(1, java.sql.Date.valueOf(dataInicio));
            stmt.setDate(2, java.sql.Date.valueOf(dataFim));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) totalFaltas = rs.getInt("total_faltas");
            }
        }

        // Suspensões
        String sqlSusp = "SELECT COUNT(*) AS total_susp FROM suspensao WHERE data_suspensao BETWEEN ? AND ?";
        try (PreparedStatement stmt = connection.prepareStatement(sqlSusp)) {
            stmt.setDate(1, java.sql.Date.valueOf(dataInicio));
            stmt.setDate(2, java.sql.Date.valueOf(dataFim));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) totalSusp = rs.getInt("total_susp");
            }
        }

        try {
            // Consulta fecha_dia
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

            // Consulta conf_dia
            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracoes)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setValor_din_mes(rs.getBigDecimal("valor_din"));
                        resumo.setValor_din_mes_real(rs.getBigDecimal("valor_din_real"));
                        resumo.setValor_deb_mes(rs.getBigDecimal("valor_deb"));
                        resumo.setValor_deb_mes_real(rs.getBigDecimal("valor_deb_real"));
                        resumo.setValor_cred_mes(rs.getBigDecimal("valor_cred"));
                        resumo.setValor_cred_mes_real(rs.getBigDecimal("valor_cred_real"));
                        resumo.setValor_pix_mes(rs.getBigDecimal("valor_pix"));
                        resumo.setValor_pix_mes_real(rs.getBigDecimal("valor_pix_real"));
                        resumo.setDesconto_mes(rs.getBigDecimal("desconto"));
                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // Consulta vales
            try (PreparedStatement pst = connection.prepareStatement(sqlVales)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setValor_vale_total(rs.getBigDecimal("total_vales"));
                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // Consulta despesas
            try (PreparedStatement pst = connection.prepareStatement(sqlDespesas)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setValor_despesa_total(rs.getBigDecimal("despesa_total"));
                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // Consulta contas
            try (PreparedStatement pst = connection.prepareStatement(sqlContas)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setValor_total_contas(rs.getBigDecimal("total_contas"));
                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // 🔽 NOVA CONSULTA SALÁRIOS
            try (PreparedStatement pst = connection.prepareStatement(sqlSalarios)) {
                // Define os parâmetros baseados no período de datas
                pst.setInt(1, dataInicio.getMonthValue()); // mês inicial
                pst.setInt(2, dataFim.getMonthValue());     // mês final
                pst.setInt(3, dataInicio.getYear());       // ano inicial
                pst.setInt(4, dataFim.getYear());          // ano final

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setTotal_salarios(rs.getBigDecimal("total_salarios"));
                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // Consulta configuracao
            try (PreparedStatement pst = connection.prepareStatement(sqlConfiguracao)) {
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setIdConf(rs.getLong("idConf"));
                        resumo.setConf1_valor(rs.getBigDecimal("conf1_valor"));
                        resumo.setConf2_valor(rs.getBigDecimal("conf2_valor"));
                        resumo.setConf3_valor(rs.getBigDecimal("conf3_valor"));
                        resumo.setConf1_nome(rs.getString("conf1_nome"));
                        resumo.setConf2_nome(rs.getString("conf2_nome"));
                        resumo.setConf3_nome(rs.getString("conf3_nome"));
                        resumo.setConf_name(rs.getString("conf_name"));

                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // =================== CONSULTA RIBBONS, ENCARTES E JUROS ===================
            String sqlMateriais = "SELECT " +
                    "(total_ft + total_sobras) AS qtd_ribbons, " +
                    "total_enc AS qtd_encartes, " +
                    "juros_cartoes " +
                    "FROM fecha_mes " +
                    "WHERE (ano > ? OR (ano = ? AND mes >= ?)) " +
                    "AND (ano < ? OR (ano = ? AND mes <= ?))";

            try (PreparedStatement pst = connection.prepareStatement(sqlMateriais)) {
                pst.setInt(1, dataInicio.getYear());
                pst.setInt(2, dataInicio.getYear());
                pst.setInt(3, dataInicio.getMonthValue());
                pst.setInt(4, dataFim.getYear());
                pst.setInt(5, dataFim.getYear());
                pst.setInt(6, dataFim.getMonthValue());

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        int qtdRibbons = rs.getInt("qtd_ribbons");
                        int qtdEncartes = rs.getInt("qtd_encartes");
                        BigDecimal jurosCartoes = rs.getBigDecimal("juros_cartoes");

                        // Buscar os custos dos materiais
                        BigDecimal custoRibbon = BigDecimal.ZERO;
                        BigDecimal custoEncarte = BigDecimal.ZERO;

                        String sqlCustos = "SELECT id_conf, custo FROM conf_materiais WHERE id_conf IN (1,2)";
                        try (PreparedStatement pstCusto = connection.prepareStatement(sqlCustos);
                             ResultSet rsCusto = pstCusto.executeQuery()) {
                            while (rsCusto.next()) {
                                int idConf = rsCusto.getInt("id_conf");
                                BigDecimal custo = rsCusto.getBigDecimal("custo");
                                if (idConf == 1) custoRibbon = custo;
                                if (idConf == 2) custoEncarte = custo;
                            }
                        }

                        // Calcular valores totais
                        BigDecimal totalRibbons = custoRibbon.multiply(BigDecimal.valueOf(qtdRibbons));
                        BigDecimal totalEncartes = custoEncarte.multiply(BigDecimal.valueOf(qtdEncartes));

                        // Adicionar ao resumo mensal
                        ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
                        resumo.setQtd_ribbons(qtdRibbons);
                        resumo.setTotal_enc(qtdEncartes);
                        resumo.setTotal_ribbons(totalRibbons);
                        resumo.setValor_enc(totalEncartes);
                        resumo.setJuros_cartoes(jurosCartoes != null ? jurosCartoes : BigDecimal.ZERO);

                        if (resumoMensal.isEmpty()) resumoMensal.add(resumo);
                    }
                }
            }

            // 🔽 Totais de condutas
            ModelFechaMes resumo = resumoMensal.isEmpty() ? new ModelFechaMes() : resumoMensal.get(0);
            resumo.setTotal_advert(totalAdvert);
            resumo.setTotal_faltas(totalFaltas);
            resumo.setTotal_susp(totalSusp);
            resumo.setTotal_condutas(totalAdvert + totalFaltas + totalSusp);
            if (resumoMensal.isEmpty()) resumoMensal.add(resumo);

            // ================= RELATÓRIO POR DIA =================
            String sqlRelatorioDia = "SELECT " +
                    "EXTRACT(DAY FROM data_fechamento) AS dia, " +
                    "EXTRACT(DOW FROM data_fechamento) AS dow, " +
                    "venda_total_dia " +
                    "FROM conf_dia " +
                    "WHERE data_fechamento >= ? AND data_fechamento <= ? " +
                    "ORDER BY data_fechamento";

            List<ModelFechaMes> relatorioDiario = new ArrayList<>();
            // 0 = domingo, 1 = segunda ... 6 = sábado
            String[] diasPt = {"Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"};

            try (PreparedStatement pst = connection.prepareStatement(sqlRelatorioDia)) {
                pst.setDate(1, java.sql.Date.valueOf(dataInicio));
                pst.setDate(2, java.sql.Date.valueOf(dataFim));

                try (ResultSet rs = pst.executeQuery()) {
                    while (rs.next()) {
                        ModelFechaMes dia = new ModelFechaMes();
                        dia.setDia(rs.getInt("dia"));

                        int dow = rs.getInt("dow"); // número do dia da semana
                        if (dow >=0 && dow <=6) {
                            dia.setDiaSemana(diasPt[dow]);
                        } else {
                            dia.setDiaSemana("?");
                        }

                        dia.setVenda_total_dia(rs.getBigDecimal("venda_total_dia"));
                        relatorioDiario.add(dia);
                    }
                }
            }
            resumo.setRelatorioDiario(relatorioDiario);

        } catch (SQLException e) {
            System.err.println("Erro ao executar as consultas: " + e.getMessage());
            throw e;
        }

        // ✅ Retorna apenas no final do método
        return resumoMensal;
    }

    public void gravarDRE(ModelDre dre) throws SQLException {
        // SQL para inserir os dados do DRE
        String sql = "INSERT INTO dre (mes, ano, receita_bruta, custos_operacionais, lucro_bruto, icms, pis, cofins, inss, irpj, csll, total_impostos, aluguel, salarios, contas, despesas_gerais, bonificacoes, prestacoes, internet, outras_despesas, total_despesas_adm, lucro_liquido, data_gravacao) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // Verifica se já existe um registro para o mesmo mês/ano
        if (existeRegistro(dre.getMes(), dre.getAno())) {
            // Se existe, atualiza
            sql = "UPDATE dre SET receita_bruta=?, custos_operacionais=?, lucro_bruto=?, icms=?, pis=?, cofins=?, inss=?, irpj=?, csll=?, total_impostos=?, aluguel=?, salarios=?, contas=?, despesas_gerais=?, bonificacoes=?, prestacoes=?, internet=?, outras_despesas=?, total_despesas_adm=?, lucro_liquido=?, data_gravacao=? WHERE mes=? AND ano=?";
        }

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            int index = 1;

            // Setar os parâmetros
            if (existeRegistro(dre.getMes(), dre.getAno())) {
                statement.setBigDecimal(index++, dre.getReceita_bruta());
                statement.setBigDecimal(index++, dre.getCustos_operacionais());
                statement.setBigDecimal(index++, dre.getLucro_bruto());
                statement.setBigDecimal(index++, dre.getIcms());
                statement.setBigDecimal(index++, dre.getPis());
                statement.setBigDecimal(index++, dre.getCofins());
                statement.setBigDecimal(index++, dre.getInss());
                statement.setBigDecimal(index++, dre.getIrpj());
                statement.setBigDecimal(index++, dre.getCsll());
                statement.setBigDecimal(index++, dre.getTotal_impostos());
                statement.setBigDecimal(index++, dre.getAluguel());
                statement.setBigDecimal(index++, dre.getSalarios());
                statement.setBigDecimal(index++, dre.getContas());
                statement.setBigDecimal(index++, dre.getDespesas_gerais());
                statement.setBigDecimal(index++, dre.getBonificacoes());
                statement.setBigDecimal(index++, dre.getPrestacoes());
                statement.setBigDecimal(index++, dre.getInternet());
                statement.setBigDecimal(index++, dre.getOutras_despesas());
                statement.setBigDecimal(index++, dre.getTotal_despesas_adm());
                statement.setBigDecimal(index++, dre.getLucro_liquido());
                statement.setDate(index++, Date.valueOf(LocalDate.now()));

                // Parâmetros de WHERE
                statement.setInt(index++, dre.getMes());
                statement.setInt(index++, dre.getAno());

            } else {
                statement.setInt(index++, dre.getMes());
                statement.setInt(index++, dre.getAno());
                statement.setBigDecimal(index++, dre.getReceita_bruta());
                statement.setBigDecimal(index++, dre.getCustos_operacionais());
                statement.setBigDecimal(index++, dre.getLucro_bruto());
                statement.setBigDecimal(index++, dre.getIcms());
                statement.setBigDecimal(index++, dre.getPis());
                statement.setBigDecimal(index++, dre.getCofins());
                statement.setBigDecimal(index++, dre.getInss());
                statement.setBigDecimal(index++, dre.getIrpj());
                statement.setBigDecimal(index++, dre.getCsll());
                statement.setBigDecimal(index++, dre.getTotal_impostos());
                statement.setBigDecimal(index++, dre.getAluguel());
                statement.setBigDecimal(index++, dre.getSalarios());
                statement.setBigDecimal(index++, dre.getContas());
                statement.setBigDecimal(index++, dre.getDespesas_gerais());
                statement.setBigDecimal(index++, dre.getBonificacoes());
                statement.setBigDecimal(index++, dre.getPrestacoes());
                statement.setBigDecimal(index++, dre.getInternet());
                statement.setBigDecimal(index++, dre.getOutras_despesas());
                statement.setBigDecimal(index++, dre.getTotal_despesas_adm());
                statement.setBigDecimal(index++, dre.getLucro_liquido());
                statement.setDate(index++, Date.valueOf(LocalDate.now()));
            }

            statement.executeUpdate();
            connection.commit();

        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }

    // Método auxiliar para verificar se o registro já existe
    public boolean existeRegistro(int mes, int ano) throws SQLException {
        String sql = "SELECT COUNT(*) FROM dre WHERE mes = ? AND ano = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, mes);
            statement.setInt(2, ano);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }


}
