package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;

public class ModelConfDiario implements Serializable {
    private static final long serialVersionUID = 1L;
    private long id;
    private BigDecimal valor_din;
    private BigDecimal valor_din_real;
    private BigDecimal valor_din_dif;
    private BigDecimal valor_deb;
    private BigDecimal valor_deb_real;
    private BigDecimal valor_deb_dif;
    private BigDecimal valor_cred;
    private BigDecimal valor_cred_real;
    private BigDecimal valor_cred_dif;
    private BigDecimal valor_pix;
    private BigDecimal valor_pix_real;
    private BigDecimal valor_pix_dif;
    private BigDecimal valor_despesa_total;
    private BigDecimal valor_despesa_din;
    private BigDecimal valor_vale_total;
    private BigDecimal desconto;
    private BigDecimal venda_total_dia;
    private String observacao;
    private String observacao_ribbon;
    private LocalDate data_fechamento;
    private int total_revelado;
    private int total_informado;
    private BigDecimal valor_deb_24h;
    private BigDecimal valor_cred_24h;

    private int ribbon_1_atual;
    private int ribbon_2_atual;
    private int ribbon_3_atual;
    private int ribbon_4_atual;
    private int ribbon_5_atual;
    private int ribbon_6_atual;
    private int sobras;
    private int dif_ribbon_1;
    private int dif_ribbon_2;
    private int dif_ribbon_3;
    private int dif_ribbon_4;
    private int dif_ribbon_5;
    private int dif_ribbon_6;

    private int old_ribbon_1;
    private int old_ribbon_2;
    private int old_ribbon_3;
    private int old_ribbon_4;
    private int old_ribbon_5;
    private int old_ribbon_6;

    private int rev_ribbon_1;
    private int rev_ribbon_2;
    private int rev_ribbon_3;
    private int rev_ribbon_4;
    private int rev_ribbon_5;
    private int rev_ribbon_6;
    private int total_dif;


    public BigDecimal getValor_despesa_din() {
        return valor_despesa_din;
    }

    public void setValor_despesa_din(BigDecimal valor_despesa_din) {
        this.valor_despesa_din = valor_despesa_din;
    }

    public String getObservacao_ribbon() {
        return observacao_ribbon;
    }

    public void setObservacao_ribbon(String observacao_ribbon) {
        this.observacao_ribbon = observacao_ribbon;
    }

    public int getTotal_dif() {
        return total_dif;
    }

    public void setTotal_dif(int total_dif) {
        this.total_dif = total_dif;
    }

    public int getRev_ribbon_1() {
        return rev_ribbon_1;
    }

    public void setRev_ribbon_1(int rev_ribbon_1) {
        this.rev_ribbon_1 = rev_ribbon_1;
    }

    public int getRev_ribbon_2() {
        return rev_ribbon_2;
    }

    public void setRev_ribbon_2(int rev_ribbon_2) {
        this.rev_ribbon_2 = rev_ribbon_2;
    }

    public int getRev_ribbon_3() {
        return rev_ribbon_3;
    }

    public void setRev_ribbon_3(int rev_ribbon_3) {
        this.rev_ribbon_3 = rev_ribbon_3;
    }

    public int getRev_ribbon_4() {
        return rev_ribbon_4;
    }

    public void setRev_ribbon_4(int rev_ribbon_4) {
        this.rev_ribbon_4 = rev_ribbon_4;
    }

    public int getRev_ribbon_5() {
        return rev_ribbon_5;
    }

    public void setRev_ribbon_5(int rev_ribbon_5) {
        this.rev_ribbon_5 = rev_ribbon_5;
    }

    public int getRev_ribbon_6() {
        return rev_ribbon_6;
    }

    public void setRev_ribbon_6(int rev_ribbon_6) {
        this.rev_ribbon_6 = rev_ribbon_6;
    }

    public int getRibbon_1_atual() {
        return ribbon_1_atual;
    }

    public void setRibbon_1_atual(int ribbon_1_atual) {
        this.ribbon_1_atual = ribbon_1_atual;
    }

    public int getRibbon_2_atual() {
        return ribbon_2_atual;
    }

    public void setRibbon_2_atual(int ribbon_2_atual) {
        this.ribbon_2_atual = ribbon_2_atual;
    }

    public int getRibbon_3_atual() {
        return ribbon_3_atual;
    }

    public void setRibbon_3_atual(int ribbon_3_atual) {
        this.ribbon_3_atual = ribbon_3_atual;
    }

    public int getRibbon_4_atual() {
        return ribbon_4_atual;
    }

    public void setRibbon_4_atual(int ribbon_4_atual) {
        this.ribbon_4_atual = ribbon_4_atual;
    }

    public int getRibbon_5_atual() {
        return ribbon_5_atual;
    }

    public void setRibbon_5_atual(int ribbon_5_atual) {
        this.ribbon_5_atual = ribbon_5_atual;
    }

    public int getRibbon_6_atual() {
        return ribbon_6_atual;
    }

    public void setRibbon_6_atual(int ribbon_6_atual) {
        this.ribbon_6_atual = ribbon_6_atual;
    }



    public int getSobras() {
        return sobras;
    }

    public void setSobras(int sobras) {
        this.sobras = sobras;
    }

    public int getDif_ribbon_1() {
        return dif_ribbon_1;
    }

    public void setDif_ribbon_1(int dif_ribbon_1) {
        this.dif_ribbon_1 = dif_ribbon_1;
    }

    public int getDif_ribbon_2() {
        return dif_ribbon_2;
    }

    public void setDif_ribbon_2(int dif_ribbon_2) {
        this.dif_ribbon_2 = dif_ribbon_2;
    }

    public int getDif_ribbon_3() {
        return dif_ribbon_3;
    }

    public void setDif_ribbon_3(int dif_ribbon_3) {
        this.dif_ribbon_3 = dif_ribbon_3;
    }

    public int getDif_ribbon_4() {
        return dif_ribbon_4;
    }

    public void setDif_ribbon_4(int dif_ribbon_4) {
        this.dif_ribbon_4 = dif_ribbon_4;
    }

    public int getDif_ribbon_5() {
        return dif_ribbon_5;
    }

    public void setDif_ribbon_5(int dif_ribbon_5) {
        this.dif_ribbon_5 = dif_ribbon_5;
    }

    public int getDif_ribbon_6() {
        return dif_ribbon_6;
    }

    public void setDif_ribbon_6(int dif_ribbon_6) {
        this.dif_ribbon_6 = dif_ribbon_6;
    }

    public int getOld_ribbon_1() {
        return old_ribbon_1;
    }

    public void setOld_ribbon_1(int old_ribbon_1) {
        this.old_ribbon_1 = old_ribbon_1;
    }

    public int getOld_ribbon_2() {
        return old_ribbon_2;
    }

    public void setOld_ribbon_2(int old_ribbon_2) {
        this.old_ribbon_2 = old_ribbon_2;
    }

    public int getOld_ribbon_3() {
        return old_ribbon_3;
    }

    public void setOld_ribbon_3(int old_ribbon_3) {
        this.old_ribbon_3 = old_ribbon_3;
    }

    public int getOld_ribbon_4() {
        return old_ribbon_4;
    }

    public void setOld_ribbon_4(int old_ribbon_4) {
        this.old_ribbon_4 = old_ribbon_4;
    }

    public int getOld_ribbon_5() {
        return old_ribbon_5;
    }

    public void setOld_ribbon_5(int old_ribbon_5) {
        this.old_ribbon_5 = old_ribbon_5;
    }

    public int getOld_ribbon_6() {
        return old_ribbon_6;
    }

    public void setOld_ribbon_6(int old_ribbon_6) {
        this.old_ribbon_6 = old_ribbon_6;
    }

    public BigDecimal getValor_deb_24h() {
        return valor_deb_24h;
    }

    public void setValor_deb_24h(BigDecimal valor_deb_24h) {
        this.valor_deb_24h = valor_deb_24h;
    }

    public BigDecimal getValor_cred_24h() {
        return valor_cred_24h;
    }

    public void setValor_cred_24h(BigDecimal valor_cred_24h) {
        this.valor_cred_24h = valor_cred_24h;
    }

    public int getTotal_revelado() {
        return total_revelado;
    }

    public void setTotal_revelado(int total_revelado) {
        this.total_revelado = total_revelado;
    }

    public int getTotal_informado() {
        return total_informado;
    }

    public void setTotal_informado(int total_informado) {
        this.total_informado = total_informado;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public BigDecimal getValor_din() {
        return valor_din;
    }

    public void setValor_din(BigDecimal valor_din) {
        this.valor_din = valor_din;
    }

    public BigDecimal getValor_din_real() {
        return valor_din_real;
    }

    public void setValor_din_real(BigDecimal valor_din_real) {
        this.valor_din_real = valor_din_real;
    }

    public BigDecimal getValor_din_dif() {
        return valor_din_dif;
    }

    public void setValor_din_dif(BigDecimal valor_din_dif) {
        this.valor_din_dif = valor_din_dif;
    }

    public BigDecimal getValor_deb() {
        return valor_deb;
    }

    public void setValor_deb(BigDecimal valor_deb) {
        this.valor_deb = valor_deb;
    }

    public BigDecimal getValor_deb_real() {
        return valor_deb_real;
    }

    public void setValor_deb_real(BigDecimal valor_deb_real) {
        this.valor_deb_real = valor_deb_real;
    }

    public BigDecimal getValor_deb_dif() {
        return valor_deb_dif;
    }

    public void setValor_deb_dif(BigDecimal valor_deb_dif) {
        this.valor_deb_dif = valor_deb_dif;
    }

    public BigDecimal getValor_cred() {
        return valor_cred;
    }

    public void setValor_cred(BigDecimal valor_cred) {
        this.valor_cred = valor_cred;
    }

    public BigDecimal getValor_cred_real() {
        return valor_cred_real;
    }

    public void setValor_cred_real(BigDecimal valor_cred_real) {
        this.valor_cred_real = valor_cred_real;
    }

    public BigDecimal getValor_cred_dif() {
        return valor_cred_dif;
    }

    public void setValor_cred_dif(BigDecimal valor_cred_dif) {
        this.valor_cred_dif = valor_cred_dif;
    }

    public BigDecimal getValor_pix() {
        return valor_pix;
    }

    public void setValor_pix(BigDecimal valor_pix) {
        this.valor_pix = valor_pix;
    }

    public BigDecimal getValor_pix_real() {
        return valor_pix_real;
    }

    public void setValor_pix_real(BigDecimal valor_pix_real) {
        this.valor_pix_real = valor_pix_real;
    }

    public BigDecimal getValor_pix_dif() {
        return valor_pix_dif;
    }

    public void setValor_pix_dif(BigDecimal valor_pix_dif) {
        this.valor_pix_dif = valor_pix_dif;
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

    public BigDecimal getDesconto() {
        return desconto;
    }

    public void setDesconto(BigDecimal desconto) {
        this.desconto = desconto;
    }

    public BigDecimal getVenda_total_dia() {
        return venda_total_dia;
    }

    public void setVenda_total_dia(BigDecimal venda_total_dia) {
        this.venda_total_dia = venda_total_dia;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public LocalDate getData_fechamento() {
        return data_fechamento;
    }

    public void setData_fechamento(LocalDate data_fechamento) {
        this.data_fechamento = data_fechamento;
    }

    @Override
    public String toString() {
        return "ModelConfDiario{" +
                "id=" + id +
                ", valor_din=" + valor_din +
                ", valor_din_real=" + valor_din_real +
                ", valor_din_dif=" + valor_din_dif +
                ", valor_deb=" + valor_deb +
                ", valor_deb_real=" + valor_deb_real +
                ", valor_deb_dif=" + valor_deb_dif +
                ", valor_cred=" + valor_cred +
                ", valor_cred_real=" + valor_cred_real +
                ", valor_cred_dif=" + valor_cred_dif +
                ", valor_pix=" + valor_pix +
                ", valor_pix_real=" + valor_pix_real +
                ", valor_pix_dif=" + valor_pix_dif +
                ", valor_despesa_total=" + valor_despesa_total +
                ", valor_vale_total=" + valor_vale_total +
                ", desconto=" + desconto +
                ", venda_total_dia=" + venda_total_dia +
                ", observacao='" + observacao + '\'' +
                ", observacao_ribbon='" + observacao_ribbon + '\'' +
                ", data_fechamento=" + data_fechamento +
                ", total_revelado=" + total_revelado +
                ", total_informado=" + total_informado +
                ", valor_deb_24h=" + valor_deb_24h +
                ", valor_cred_24h=" + valor_cred_24h +
                ", ribbon_1_atual=" + ribbon_1_atual +
                ", ribbon_2_atual=" + ribbon_2_atual +
                ", ribbon_3_atual=" + ribbon_3_atual +
                ", ribbon_4_atual=" + ribbon_4_atual +
                ", ribbon_5_atual=" + ribbon_5_atual +
                ", ribbon_6_atual=" + ribbon_6_atual +
                ", sobras=" + sobras +
                ", dif_ribbon_1=" + dif_ribbon_1 +
                ", dif_ribbon_2=" + dif_ribbon_2 +
                ", dif_ribbon_3=" + dif_ribbon_3 +
                ", dif_ribbon_4=" + dif_ribbon_4 +
                ", dif_ribbon_5=" + dif_ribbon_5 +
                ", dif_ribbon_6=" + dif_ribbon_6 +
                ", old_ribbon_1=" + old_ribbon_1 +
                ", old_ribbon_2=" + old_ribbon_2 +
                ", old_ribbon_3=" + old_ribbon_3 +
                ", old_ribbon_4=" + old_ribbon_4 +
                ", old_ribbon_5=" + old_ribbon_5 +
                ", old_ribbon_6=" + old_ribbon_6 +
                ", rev_ribbon_1=" + rev_ribbon_1 +
                ", rev_ribbon_2=" + rev_ribbon_2 +
                ", rev_ribbon_3=" + rev_ribbon_3 +
                ", rev_ribbon_4=" + rev_ribbon_4 +
                ", rev_ribbon_5=" + rev_ribbon_5 +
                ", rev_ribbon_6=" + rev_ribbon_6 +
                ", total_dif=" + total_dif +
                '}';
    }
}
