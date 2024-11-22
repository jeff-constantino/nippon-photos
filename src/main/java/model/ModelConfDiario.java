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
