package dao;

import connection.ConnectionPool;
import model.ModelDre;
import model.ModelFechaMes;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DAODre {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAODre(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAODre() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public List<Map<String, Object>> buscarMesesNaoFechados() throws SQLException {
        List<Map<String, Object>> mesesNaoFechados = new ArrayList<>();
        String sql = "SELECT DISTINCT fm.mes, fm.ano FROM fecha_mes fm LEFT JOIN dre d ON fm.mes = d.mes AND fm.ano = d.ano WHERE d.mes IS NULL AND d.ano IS NULL ORDER BY fm.ano DESC, fm.mes DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> mesAno = new HashMap<>();
                mesAno.put("mes", rs.getInt("mes"));
                mesAno.put("ano", rs.getInt("ano"));
                mesesNaoFechados.add(mesAno);
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return mesesNaoFechados;
    }

    public ModelFechaMes buscarFechamentoPorMesAno(int mes, int ano) throws SQLException {
        String sql = "SELECT * FROM fecha_mes WHERE mes = ? AND ano = ?";
        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setInt(1, mes);
            pst.setInt(2, ano);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    ModelFechaMes fechamento = new ModelFechaMes();
                    fechamento.setId(rs.getLong("id"));
                    fechamento.setMes(rs.getInt("mes"));
                    fechamento.setAno(rs.getInt("ano"));
                    fechamento.setTotal_ft(rs.getInt("total_ft"));
                    fechamento.setTotal_enc(rs.getInt("total_enc"));
                    fechamento.setTotal_dig(rs.getInt("total_dig"));
                    fechamento.setTotal_sobras(rs.getInt("total_sobras"));
                    fechamento.setTotal_ribbons(rs.getBigDecimal("total_ribbons"));
                    fechamento.setValor_din_mes_real(rs.getBigDecimal("valor_din_mes_real"));
                    fechamento.setValor_deb_mes_real(rs.getBigDecimal("valor_deb_mes_real"));
                    fechamento.setValor_cred_mes_real(rs.getBigDecimal("valor_cred_mes_real"));
                    fechamento.setValor_pix_mes_real(rs.getBigDecimal("valor_pix_mes_real"));
                    fechamento.setTotal_geral(rs.getBigDecimal("total_geral"));
                    fechamento.setJuros_cartoes(rs.getBigDecimal("juros_cartoes"));
                    fechamento.setJurosdebvm(rs.getBigDecimal("jurosdebvm"));
                    fechamento.setJuroscredvm(rs.getBigDecimal("juroscredvm"));
                    fechamento.setJurosdeboutros(rs.getBigDecimal("jurosdeboutros"));
                    fechamento.setJuroscredoutros(rs.getBigDecimal("juroscredoutros"));
                    fechamento.setValor_total_despesas(rs.getBigDecimal("valor_total_despesas"));
                    fechamento.setValor_total_contas(rs.getBigDecimal("valor_total_contas"));
                    fechamento.setValor_vale_total(rs.getBigDecimal("valor_vale_total"));
                    fechamento.setDesconto_mes(rs.getBigDecimal("desconto_mes"));
                    fechamento.setDebitoVm(rs.getBigDecimal("debito_vm"));
                    fechamento.setCreditoVm(rs.getBigDecimal("credito_vm"));
                    fechamento.setDebitoOutros(rs.getBigDecimal("debito_outros"));
                    fechamento.setCreditoOutros(rs.getBigDecimal("credito_outros"));
                    fechamento.setReceitas(rs.getBigDecimal("receitas"));
                    fechamento.setSalarios(rs.getBigDecimal("salarios"));
                    fechamento.setDespesasdin(rs.getBigDecimal("despesasdin"));
                    fechamento.setSangria(rs.getBigDecimal("sangria"));
                    fechamento.setSaldo(rs.getBigDecimal("saldo"));
                    fechamento.setReceitadin(rs.getBigDecimal("receitadin"));
                    return fechamento;
                }
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return null;
    }

    public BigDecimal buscarCustoMaterial(int idConf) throws SQLException {
        String sql = "SELECT custo FROM conf_materiais WHERE id_conf = ?";
        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setInt(1, idConf);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("custo");
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return BigDecimal.ZERO;
    }

    public List<ModelFechaMes> buscarFechamentoMensal(String dataInicial, String dataFinal) throws SQLException {
        List<ModelFechaMes> resumoMensal = new ArrayList<>();
        try {
            // TODO: implementar conforme lógica original
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return resumoMensal;
    }

    public void gravarDRE(ModelDre dre) throws SQLException {
        boolean exists = existeRegistro(dre.getMes(), dre.getAno());
        String sql;
        if (exists) {
            sql = "UPDATE dre SET receita_bruta=?, custos_operacionais=?, lucro_bruto=?, icms=?, pis=?, cofins=?, inss=?, irpj=?, csll=?, total_impostos=?, aluguel=?, salarios=?, contas=?, despesas_gerais=?, bonificacoes=?, prestacoes=?, internet=?, outras_despesas=?, total_despesas_adm=?, lucro_liquido=?, data_gravacao=?, receita_dinheiro=?, receita_debito=?, receita_credito=?, receita_pix=?, custos_ribbons=?, custos_encartes=?, custos_juros_cartoes=?, obsDesp=? WHERE mes=? AND ano=?";
        } else {
            sql = "INSERT INTO dre (mes, ano, receita_bruta, custos_operacionais, lucro_bruto, icms, pis, cofins, inss, irpj, csll, total_impostos, aluguel, salarios, contas, despesas_gerais, bonificacoes, prestacoes, internet, outras_despesas, total_despesas_adm, lucro_liquido, data_gravacao, receita_dinheiro, receita_debito, receita_credito, receita_pix, custos_ribbons, custos_encartes, custos_juros_cartoes, obsDesp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            int index = 1;
            if (exists) {
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
                statement.setBigDecimal(index++, dre.getReceita_dinheiro());
                statement.setBigDecimal(index++, dre.getReceita_debito());
                statement.setBigDecimal(index++, dre.getReceita_credito());
                statement.setBigDecimal(index++, dre.getReceita_pix());
                statement.setBigDecimal(index++, dre.getCustos_ribbons());
                statement.setBigDecimal(index++, dre.getCustos_encartes());
                statement.setBigDecimal(index++, dre.getCustos_juros_cartoes());
                statement.setString(index++, dre.getObsDesp());
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
                statement.setBigDecimal(index++, dre.getReceita_dinheiro());
                statement.setBigDecimal(index++, dre.getReceita_debito());
                statement.setBigDecimal(index++, dre.getReceita_credito());
                statement.setBigDecimal(index++, dre.getReceita_pix());
                statement.setBigDecimal(index++, dre.getCustos_ribbons());
                statement.setBigDecimal(index++, dre.getCustos_encartes());
                statement.setBigDecimal(index++, dre.getCustos_juros_cartoes());
                statement.setString(index++, dre.getObsDesp());
            }
            statement.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public ModelDre buscarDREPorMesAno(int mes, int ano) throws SQLException {
        String sql = "SELECT * FROM dre WHERE mes = ? AND ano = ?";
        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setInt(1, mes);
            pst.setInt(2, ano);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    ModelDre dre = new ModelDre();
                    dre.setId_dre(rs.getLong("id_dre"));
                    dre.setMes(rs.getInt("mes"));
                    dre.setAno(rs.getInt("ano"));
                    dre.setReceita_bruta(rs.getBigDecimal("receita_bruta"));
                    dre.setCustos_operacionais(rs.getBigDecimal("custos_operacionais"));
                    dre.setLucro_bruto(rs.getBigDecimal("lucro_bruto"));
                    dre.setIcms(rs.getBigDecimal("icms"));
                    dre.setPis(rs.getBigDecimal("pis"));
                    dre.setCofins(rs.getBigDecimal("cofins"));
                    dre.setInss(rs.getBigDecimal("inss"));
                    dre.setIrpj(rs.getBigDecimal("irpj"));
                    dre.setCsll(rs.getBigDecimal("csll"));
                    dre.setTotal_impostos(rs.getBigDecimal("total_impostos"));
                    dre.setAluguel(rs.getBigDecimal("aluguel"));
                    dre.setSalarios(rs.getBigDecimal("salarios"));
                    dre.setContas(rs.getBigDecimal("contas"));
                    dre.setDespesas_gerais(rs.getBigDecimal("despesas_gerais"));
                    dre.setBonificacoes(rs.getBigDecimal("bonificacoes"));
                    dre.setPrestacoes(rs.getBigDecimal("prestacoes"));
                    dre.setInternet(rs.getBigDecimal("internet"));
                    dre.setOutras_despesas(rs.getBigDecimal("outras_despesas"));
                    dre.setTotal_despesas_adm(rs.getBigDecimal("total_despesas_adm"));
                    dre.setLucro_liquido(rs.getBigDecimal("lucro_liquido"));
                    dre.setData_gravacao(rs.getDate("data_gravacao"));
                    dre.setReceita_dinheiro(rs.getBigDecimal("receita_dinheiro"));
                    dre.setReceita_debito(rs.getBigDecimal("receita_debito"));
                    dre.setReceita_credito(rs.getBigDecimal("receita_credito"));
                    dre.setReceita_pix(rs.getBigDecimal("receita_pix"));
                    dre.setCustos_ribbons(rs.getBigDecimal("custos_ribbons"));
                    dre.setCustos_encartes(rs.getBigDecimal("custos_encartes"));
                    dre.setCustos_juros_cartoes(rs.getBigDecimal("custos_juros_cartoes"));
                    dre.setObsDesp(rs.getString("obsDesp"));
                    return dre;
                }
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return null;
    }

    public boolean existeRegistro(int mes, int ano) throws SQLException {
        String sql = "SELECT COUNT(*) FROM dre WHERE mes = ? AND ano = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, mes);
            statement.setInt(2, ano);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return false;
    }

    private void fecharConexao() {
        if (connection != null && gerenciarTransacao) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
}
