package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class ModelFechaMes implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;
    private long id_conf;
    private LocalDate data_fechamento;

    private String formattedDate;
    private int final_ft_din;
    private int final_ft_deb;
    private int final_ft_cred;
    private int final_ft_pix;
    private int final_enc_din;
    private int final_enc_deb;
    private int final_enc_cred;
    private int final_enc_pix;
    private int final_dig_din;
    private int final_dig_deb;
    private int final_dig_cred;
    private int final_dig_pix;
    private int total_ft;
    private int total_enc;
    private int total_dig;

    private BigDecimal valor_din_mes;
    private BigDecimal valor_din_mes_real;
    private BigDecimal valor_deb_mes;
    private BigDecimal valor_deb_mes_real;
    private BigDecimal valor_cred_mes;
    private BigDecimal valor_cred_mes_real;
    private BigDecimal valor_pix_mes;
    private BigDecimal valor_pix_mes_real;

    private BigDecimal valor_despesa_total;
    private BigDecimal valor_vale_total;
    private BigDecimal desconto_mes;
    private BigDecimal venda_total_mes;


    private BigDecimal final_descontos;
    private int final_ribbon_1;
    private int final_ribbon_2;
    private int final_ribbon_3;
    private int final_ribbon_4;
    private int final_ribbon_5;
    private int final_ribbon_6;
    private int total_sobras;


    private BigDecimal resultadoDivisao;


    private BigDecimal conf1_valor;
    private BigDecimal conf1_valor2;
    private BigDecimal conf2_valor;
    private BigDecimal conf3_valor;
    private BigDecimal conf4_valor;
    private BigDecimal conf1_custo;
    private BigDecimal conf2_custo;
    private BigDecimal conf3_custo;
    private BigDecimal conf4_custo;


    private String conf1_nome;
    private String conf2_nome;
    private String conf3_nome;
    private String conf4_nome;
    private String conf_name;

    private int conf1_qtd;
    private int conf2_qtd;
    private int conf3_qtd;
    private int conf4_qtd;

    private BigDecimal juros_cartoes;

    private int mes;
    private int ano;
    private BigDecimal total_ribbons;
    private BigDecimal total_geral;
    private BigDecimal valor_total_despesas;
    private BigDecimal valor_total_contas;

    public BigDecimal getResultadoDivisao() {
        return resultadoDivisao;
    }

    public void setResultadoDivisao(BigDecimal resultadoDivisao) {
        this.resultadoDivisao = resultadoDivisao;
    }

    private BigDecimal debitoVm;
    private BigDecimal creditoVm;
    private BigDecimal debitoOutros;
    private BigDecimal creditoOutros;

    private int total_advert;
    private int total_faltas;
    private int total_susp;
    private int total_condutas;

    private int dia;
    private String diaSemana;
    private BigDecimal venda_total_dia;
    private List<ModelFechaMes> relatorioDiario;


    private BigDecimal valor;
    private int qtd;
    private BigDecimal custo;

    public long getId_conf() {
        return id_conf;
    }

    public void setId_conf(long id_conf) {
        this.id_conf = id_conf;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public int getQtd() {
        return qtd;
    }

    public void setQtd(int qtd) {
        this.qtd = qtd;
    }

    public BigDecimal getCusto() {
        return custo;
    }

    public void setCusto(BigDecimal custo) {
        this.custo = custo;
    }

    public int getDia() { return dia; }
    public void setDia(int dia) { this.dia = dia; }

    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }

    public BigDecimal getVenda_total_dia() { return venda_total_dia; }
    public void setVenda_total_dia(BigDecimal venda_total_dia) { this.venda_total_dia = venda_total_dia; }

    public List<ModelFechaMes> getRelatorioDiario() { return relatorioDiario; }
    public void setRelatorioDiario(List<ModelFechaMes> relatorioDiario) { this.relatorioDiario = relatorioDiario; }









    public void setFormattedDate(String formattedDate) {
        this.formattedDate = formattedDate;
    }

    public int getTotal_advert() {
        return total_advert;
    }

    public void setTotal_advert(int total_advert) {
        this.total_advert = total_advert;
    }

    public int getTotal_faltas() {
        return total_faltas;
    }

    public void setTotal_faltas(int total_faltas) {
        this.total_faltas = total_faltas;
    }

    public int getTotal_susp() {
        return total_susp;
    }

    public void setTotal_susp(int total_susp) {
        this.total_susp = total_susp;
    }

    public int getTotal_condutas() {
        return total_condutas;
    }

    public void setTotal_condutas(int total_condutas) {
        this.total_condutas = total_condutas;
    }

    public BigDecimal getDebitoVm() {
        return debitoVm;
    }

    public void setDebitoVm(BigDecimal debitoVm) {
        this.debitoVm = debitoVm;
    }

    public BigDecimal getCreditoVm() {
        return creditoVm;
    }

    public void setCreditoVm(BigDecimal creditoVm) {
        this.creditoVm = creditoVm;
    }

    public BigDecimal getDebitoOutros() {
        return debitoOutros;
    }

    public void setDebitoOutros(BigDecimal debitoOutros) {
        this.debitoOutros = debitoOutros;
    }

    public BigDecimal getCreditoOutros() {
        return creditoOutros;
    }

    public void setCreditoOutros(BigDecimal creditoOutros) {
        this.creditoOutros = creditoOutros;
    }

    public BigDecimal getJuros_cartoes() {
        return juros_cartoes;
    }

    public void setJuros_cartoes(BigDecimal juros_cartoes) {
        this.juros_cartoes = juros_cartoes;
    }

    public int getMes() {
        return mes;
    }

    public void setMes(int mes) {
        this.mes = mes;
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public BigDecimal getTotal_ribbons() {
        return total_ribbons;
    }

    public void setTotal_ribbons(BigDecimal total_ribbons) {
        this.total_ribbons = total_ribbons;
    }

    public BigDecimal getTotal_geral() {
        return total_geral;
    }

    public void setTotal_geral(BigDecimal total_geral) {
        this.total_geral = total_geral;
    }

    public BigDecimal getValor_total_despesas() {
        return valor_total_despesas;
    }

    public void setValor_total_despesas(BigDecimal valor_total_despesas) {
        this.valor_total_despesas = valor_total_despesas;
    }

    public BigDecimal getValor_total_contas() {
        return valor_total_contas;
    }

    public void setValor_total_contas(BigDecimal valor_total_contas) {
        this.valor_total_contas = valor_total_contas;
    }

    public void setData_fechamento(LocalDate data_fechamento) {
        this.data_fechamento = data_fechamento;
        this.formattedDate = data_fechamento.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }


    public BigDecimal getValor_despesa_total() {
        return valor_despesa_total;
    }

    public void setValor_despesa_total(BigDecimal valor_despesa_total) {
        this.valor_despesa_total = valor_despesa_total;
    }

    public BigDecimal getValor_vale_total() {
        return valor_vale_total;
    }

    public void setValor_vale_total(BigDecimal valor_vale_total) {
        this.valor_vale_total = valor_vale_total;
    }

    public BigDecimal getDesconto_mes() {
        return desconto_mes;
    }

    public void setDesconto_mes(BigDecimal desconto_mes) {
        this.desconto_mes = desconto_mes;
    }

    public BigDecimal getVenda_total_mes() {
        return venda_total_mes;
    }

    public void setVenda_total_mes(BigDecimal venda_total_mes) {
        this.venda_total_mes = venda_total_mes;
    }

    public String getFormattedDate() {
        return formattedDate;
    }

    public BigDecimal getValor_din_mes() {
        return valor_din_mes;
    }

    public void setValor_din_mes(BigDecimal valor_din_mes) {
        this.valor_din_mes = valor_din_mes;
    }

    public BigDecimal getValor_din_mes_real() {
        return valor_din_mes_real;
    }

    public void setValor_din_mes_real(BigDecimal valor_din_mes_real) {
        this.valor_din_mes_real = valor_din_mes_real;
    }

    public BigDecimal getValor_deb_mes() {
        return valor_deb_mes;
    }

    public void setValor_deb_mes(BigDecimal valor_deb_mes) {
        this.valor_deb_mes = valor_deb_mes;
    }

    public BigDecimal getValor_deb_mes_real() {
        return valor_deb_mes_real;
    }

    public void setValor_deb_mes_real(BigDecimal valor_deb_mes_real) {
        this.valor_deb_mes_real = valor_deb_mes_real;
    }

    public BigDecimal getValor_cred_mes() {
        return valor_cred_mes;
    }

    public void setValor_cred_mes(BigDecimal valor_cred_mes) {
        this.valor_cred_mes = valor_cred_mes;
    }

    public BigDecimal getValor_cred_mes_real() {
        return valor_cred_mes_real;
    }

    public void setValor_cred_mes_real(BigDecimal valor_cred_mes_real) {
        this.valor_cred_mes_real = valor_cred_mes_real;
    }

    public BigDecimal getValor_pix_mes() {
        return valor_pix_mes;
    }

    public void setValor_pix_mes(BigDecimal valor_pix_mes) {
        this.valor_pix_mes = valor_pix_mes;
    }

    public BigDecimal getValor_pix_mes_real() {
        return valor_pix_mes_real;
    }

    public void setValor_pix_mes_real(BigDecimal valor_pix_mes_real) {
        this.valor_pix_mes_real = valor_pix_mes_real;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LocalDate getData_fechamento() {
        return data_fechamento;
    }



    public int getFinal_ft_din() {
        return final_ft_din;
    }

    public void setFinal_ft_din(int final_ft_din) {
        this.final_ft_din = final_ft_din;
    }

    public int getFinal_ft_deb() {
        return final_ft_deb;
    }

    public void setFinal_ft_deb(int final_ft_deb) {
        this.final_ft_deb = final_ft_deb;
    }

    public int getFinal_ft_cred() {
        return final_ft_cred;
    }

    public void setFinal_ft_cred(int final_ft_cred) {
        this.final_ft_cred = final_ft_cred;
    }

    public int getFinal_ft_pix() {
        return final_ft_pix;
    }

    public void setFinal_ft_pix(int final_ft_pix) {
        this.final_ft_pix = final_ft_pix;
    }

    public int getFinal_enc_din() {
        return final_enc_din;
    }

    public void setFinal_enc_din(int final_enc_din) {
        this.final_enc_din = final_enc_din;
    }

    public int getFinal_enc_deb() {
        return final_enc_deb;
    }

    public void setFinal_enc_deb(int final_enc_deb) {
        this.final_enc_deb = final_enc_deb;
    }

    public int getFinal_enc_cred() {
        return final_enc_cred;
    }

    public void setFinal_enc_cred(int final_enc_cred) {
        this.final_enc_cred = final_enc_cred;
    }

    public int getFinal_enc_pix() {
        return final_enc_pix;
    }

    public void setFinal_enc_pix(int final_enc_pix) {
        this.final_enc_pix = final_enc_pix;
    }

    public int getFinal_dig_din() {
        return final_dig_din;
    }

    public void setFinal_dig_din(int final_dig_din) {
        this.final_dig_din = final_dig_din;
    }

    public int getFinal_dig_deb() {
        return final_dig_deb;
    }

    public void setFinal_dig_deb(int final_dig_deb) {
        this.final_dig_deb = final_dig_deb;
    }

    public int getFinal_dig_cred() {
        return final_dig_cred;
    }

    public void setFinal_dig_cred(int final_dig_cred) {
        this.final_dig_cred = final_dig_cred;
    }

    public int getFinal_dig_pix() {
        return final_dig_pix;
    }

    public void setFinal_dig_pix(int final_dig_pix) {
        this.final_dig_pix = final_dig_pix;
    }

    public int getTotal_ft() {
        return total_ft;
    }

    public void setTotal_ft(int total_ft) {
        this.total_ft = total_ft;
    }

    public int getTotal_enc() {
        return total_enc;
    }

    public void setTotal_enc(int total_enc) {
        this.total_enc = total_enc;
    }

    public int getTotal_dig() {
        return total_dig;
    }

    public void setTotal_dig(int total_dig) {
        this.total_dig = total_dig;
    }

    public BigDecimal getFinal_descontos() {
        return final_descontos;
    }

    public void setFinal_descontos(BigDecimal final_descontos) {
        this.final_descontos = final_descontos;
    }

    public int getFinal_ribbon_1() {
        return final_ribbon_1;
    }

    public void setFinal_ribbon_1(int final_ribbon_1) {
        this.final_ribbon_1 = final_ribbon_1;
    }

    public int getFinal_ribbon_2() {
        return final_ribbon_2;
    }

    public void setFinal_ribbon_2(int final_ribbon_2) {
        this.final_ribbon_2 = final_ribbon_2;
    }

    public int getFinal_ribbon_3() {
        return final_ribbon_3;
    }

    public void setFinal_ribbon_3(int final_ribbon_3) {
        this.final_ribbon_3 = final_ribbon_3;
    }

    public int getFinal_ribbon_4() {
        return final_ribbon_4;
    }

    public void setFinal_ribbon_4(int final_ribbon_4) {
        this.final_ribbon_4 = final_ribbon_4;
    }

    public int getFinal_ribbon_5() {
        return final_ribbon_5;
    }

    public void setFinal_ribbon_5(int final_ribbon_5) {
        this.final_ribbon_5 = final_ribbon_5;
    }

    public int getFinal_ribbon_6() {
        return final_ribbon_6;
    }

    public void setFinal_ribbon_6(int final_ribbon_6) {
        this.final_ribbon_6 = final_ribbon_6;
    }

    public int getTotal_sobras() {
        return total_sobras;
    }

    public void setTotal_sobras(int total_sobras) {
        this.total_sobras = total_sobras;
    }

    public BigDecimal getConf1_valor() {
        return conf1_valor;
    }

    public void setConf1_valor(BigDecimal conf1_valor) {
        this.conf1_valor = conf1_valor;
    }

    public BigDecimal getConf1_valor2() {
        return conf1_valor2;
    }

    public void setConf1_valor2(BigDecimal conf1_valor2) {
        this.conf1_valor2 = conf1_valor2;
    }

    public BigDecimal getConf2_valor() {
        return conf2_valor;
    }

    public void setConf2_valor(BigDecimal conf2_valor) {
        this.conf2_valor = conf2_valor;
    }

    public BigDecimal getConf3_valor() {
        return conf3_valor;
    }

    public void setConf3_valor(BigDecimal conf3_valor) {
        this.conf3_valor = conf3_valor;
    }

    public BigDecimal getConf4_valor() {
        return conf4_valor;
    }

    public void setConf4_valor(BigDecimal conf4_valor) {
        this.conf4_valor = conf4_valor;
    }

    public BigDecimal getConf1_custo() {
        return conf1_custo;
    }

    public void setConf1_custo(BigDecimal conf1_custo) {
        this.conf1_custo = conf1_custo;
    }

    public BigDecimal getConf2_custo() {
        return conf2_custo;
    }

    public void setConf2_custo(BigDecimal conf2_custo) {
        this.conf2_custo = conf2_custo;
    }

    public BigDecimal getConf3_custo() {
        return conf3_custo;
    }

    public void setConf3_custo(BigDecimal conf3_custo) {
        this.conf3_custo = conf3_custo;
    }

    public BigDecimal getConf4_custo() {
        return conf4_custo;
    }

    public void setConf4_custo(BigDecimal conf4_custo) {
        this.conf4_custo = conf4_custo;
    }

    public String getConf1_nome() {
        return conf1_nome;
    }

    public void setConf1_nome(String conf1_nome) {
        this.conf1_nome = conf1_nome;
    }

    public String getConf2_nome() {
        return conf2_nome;
    }

    public void setConf2_nome(String conf2_nome) {
        this.conf2_nome = conf2_nome;
    }

    public String getConf3_nome() {
        return conf3_nome;
    }

    public void setConf3_nome(String conf3_nome) {
        this.conf3_nome = conf3_nome;
    }

    public String getConf4_nome() {
        return conf4_nome;
    }

    public void setConf4_nome(String conf4_nome) {
        this.conf4_nome = conf4_nome;
    }

    public String getConf_name() {
        return conf_name;
    }

    public void setConf_name(String conf_name) {
        this.conf_name = conf_name;
    }

    public int getConf1_qtd() {
        return conf1_qtd;
    }

    public void setConf1_qtd(int conf1_qtd) {
        this.conf1_qtd = conf1_qtd;
    }

    public int getConf2_qtd() {
        return conf2_qtd;
    }

    public void setConf2_qtd(int conf2_qtd) {
        this.conf2_qtd = conf2_qtd;
    }

    public int getConf3_qtd() {
        return conf3_qtd;
    }

    public void setConf3_qtd(int conf3_qtd) {
        this.conf3_qtd = conf3_qtd;
    }

    public int getConf4_qtd() {
        return conf4_qtd;
    }

    public void setConf4_qtd(int conf4_qtd) {
        this.conf4_qtd = conf4_qtd;
    }

    public void setIdConf(long idConf) {
    }

    public void setConfiguracao(ModelFechaMes configuracao) {
    }

    @Override
    public String toString() {
        return "ModelFechaMes{" +
                "id=" + id +
                ", data_fechamento=" + data_fechamento +
                ", formattedDate='" + formattedDate + '\'' +
                ", final_ft_din=" + final_ft_din +
                ", final_ft_deb=" + final_ft_deb +
                ", final_ft_cred=" + final_ft_cred +
                ", final_ft_pix=" + final_ft_pix +
                ", final_enc_din=" + final_enc_din +
                ", final_enc_deb=" + final_enc_deb +
                ", final_enc_cred=" + final_enc_cred +
                ", final_enc_pix=" + final_enc_pix +
                ", final_dig_din=" + final_dig_din +
                ", final_dig_deb=" + final_dig_deb +
                ", final_dig_cred=" + final_dig_cred +
                ", final_dig_pix=" + final_dig_pix +
                ", total_ft=" + total_ft +
                ", total_enc=" + total_enc +
                ", total_dig=" + total_dig +
                ", valor_din_mes=" + valor_din_mes +
                ", valor_din_mes_real=" + valor_din_mes_real +
                ", valor_deb_mes=" + valor_deb_mes +
                ", valor_deb_mes_real=" + valor_deb_mes_real +
                ", valor_cred_mes=" + valor_cred_mes +
                ", valor_cred_mes_real=" + valor_cred_mes_real +
                ", valor_pix_mes=" + valor_pix_mes +
                ", valor_pix_mes_real=" + valor_pix_mes_real +
                ", valor_despesa_total=" + valor_despesa_total +
                ", valor_vale_total=" + valor_vale_total +
                ", desconto_mes=" + desconto_mes +
                ", venda_total_mes=" + venda_total_mes +
                ", final_descontos=" + final_descontos +
                ", final_ribbon_1=" + final_ribbon_1 +
                ", final_ribbon_2=" + final_ribbon_2 +
                ", final_ribbon_3=" + final_ribbon_3 +
                ", final_ribbon_4=" + final_ribbon_4 +
                ", final_ribbon_5=" + final_ribbon_5 +
                ", final_ribbon_6=" + final_ribbon_6 +
                ", total_sobras=" + total_sobras +
                ", resultadoDivisao=" + resultadoDivisao +
                ", conf1_valor=" + conf1_valor +
                ", conf1_valor2=" + conf1_valor2 +
                ", conf2_valor=" + conf2_valor +
                ", conf3_valor=" + conf3_valor +
                ", conf4_valor=" + conf4_valor +
                ", conf1_custo=" + conf1_custo +
                ", conf2_custo=" + conf2_custo +
                ", conf3_custo=" + conf3_custo +
                ", conf4_custo=" + conf4_custo +
                ", conf1_nome='" + conf1_nome + '\'' +
                ", conf2_nome='" + conf2_nome + '\'' +
                ", conf3_nome='" + conf3_nome + '\'' +
                ", conf4_nome='" + conf4_nome + '\'' +
                ", conf_name='" + conf_name + '\'' +
                ", conf1_qtd=" + conf1_qtd +
                ", conf2_qtd=" + conf2_qtd +
                ", conf3_qtd=" + conf3_qtd +
                ", conf4_qtd=" + conf4_qtd +
                ", juros_cartoes=" + juros_cartoes +
                ", mes=" + mes +
                ", ano=" + ano +
                ", total_ribbons=" + total_ribbons +
                ", total_geral=" + total_geral +
                ", valor_total_despesas=" + valor_total_despesas +
                ", valor_total_contas=" + valor_total_contas +
                ", debitoVm=" + debitoVm +
                ", creditoVm=" + creditoVm +
                ", debitoOutros=" + debitoOutros +
                ", creditoOutros=" + creditoOutros +
                '}';
    }
}
