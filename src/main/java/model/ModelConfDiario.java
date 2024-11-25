package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class ModelConfDiario implements Serializable {
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
    private BigDecimal valor_vale_total;
    private BigDecimal valor_descontos;
    private BigDecimal valor_total_dia;
    private String observacao;
    private Date data_fechamento;
    private int total_revelado;
    private int total_informado;
    private BigDecimal valor_deb_24h;
    private BigDecimal valor_cred_24h;

    private int total_ribbon_1;
    private int total_ribbon_2;
    private int total_ribbon_3;
    private int total_ribbon_4;
    private int total_ribbon_5;
    private int total_ribbon_6;
    private int sobras;
    private int difRibbon1;
    private int difRibbon2;
    private int difRibbon3;
    private int difRibbon4;
    private int difRibbon5;
    private int difRibbon6;

    private int old_ribbon_1;
    private int old_ribbon_2;
    private int old_ribbon_3;
    private int old_ribbon_4;
    private int old_ribbon_5;
    private int old_ribbon_6;


    public int getTotal_ribbon_1() {
        return total_ribbon_1;
    }

    public void setTotal_ribbon_1(int total_ribbon_1) {
        this.total_ribbon_1 = total_ribbon_1;
    }

    public int getTotal_ribbon_2() {
        return total_ribbon_2;
    }

    public void setTotal_ribbon_2(int total_ribbon_2) {
        this.total_ribbon_2 = total_ribbon_2;
    }

    public int getTotal_ribbon_3() {
        return total_ribbon_3;
    }

    public void setTotal_ribbon_3(int total_ribbon_3) {
        this.total_ribbon_3 = total_ribbon_3;
    }

    public int getTotal_ribbon_4() {
        return total_ribbon_4;
    }

    public void setTotal_ribbon_4(int total_ribbon_4) {
        this.total_ribbon_4 = total_ribbon_4;
    }

    public int getTotal_ribbon_5() {
        return total_ribbon_5;
    }

    public void setTotal_ribbon_5(int total_ribbon_5) {
        this.total_ribbon_5 = total_ribbon_5;
    }

    public int getTotal_ribbon_6() {
        return total_ribbon_6;
    }

    public void setTotal_ribbon_6(int total_ribbon_6) {
        this.total_ribbon_6 = total_ribbon_6;
    }

    public int getSobras() {
        return sobras;
    }

    public void setSobras(int sobras) {
        this.sobras = sobras;
    }

    public int getDifRibbon1() {
        return difRibbon1;
    }

    public void setDifRibbon1(int difRibbon1) {
        this.difRibbon1 = difRibbon1;
    }

    public int getDifRibbon2() {
        return difRibbon2;
    }

    public void setDifRibbon2(int difRibbon2) {
        this.difRibbon2 = difRibbon2;
    }

    public int getDifRibbon3() {
        return difRibbon3;
    }

    public void setDifRibbon3(int difRibbon3) {
        this.difRibbon3 = difRibbon3;
    }

    public int getDifRibbon4() {
        return difRibbon4;
    }

    public void setDifRibbon4(int difRibbon4) {
        this.difRibbon4 = difRibbon4;
    }

    public int getDifRibbon5() {
        return difRibbon5;
    }

    public void setDifRibbon5(int difRibbon5) {
        this.difRibbon5 = difRibbon5;
    }

    public int getDifRibbon6() {
        return difRibbon6;
    }

    public void setDifRibbon6(int difRibbon6) {
        this.difRibbon6 = difRibbon6;
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

    public BigDecimal getValor_descontos() {
        return valor_descontos;
    }

    public void setValor_descontos(BigDecimal valor_descontos) {
        this.valor_descontos = valor_descontos;
    }

    public BigDecimal getValor_total_dia() {
        return valor_total_dia;
    }

    public void setValor_total_dia(BigDecimal valor_total_dia) {
        this.valor_total_dia = valor_total_dia;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Date getData_fechamento() {
        return data_fechamento;
    }

    public void setData_fechamento(Date data_fechamento) {
        this.data_fechamento = data_fechamento;
    }
}
