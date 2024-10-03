package model;

import java.math.BigDecimal;

public class ModelConfig {
    private Long idConf;  // Adicionado o atributo id
    private BigDecimal prod1_valor;
    private BigDecimal prod2_valor;
    private BigDecimal prod3_valor;
    private BigDecimal comissao;
    private String prod1_nome;
    private String prod2_nome;
    private String prod3_nome;

    @Override
    public String toString() {
        return "ModelConfig{" +
                "idConf=" + idConf +
                ", prod1_valor=" + prod1_valor +
                ", prod2_valor=" + prod2_valor +
                ", prod3_valor=" + prod3_valor +
                ", comissao=" + comissao +
                ", prod1_nome='" + prod1_nome + '\'' +
                ", prod2_nome='" + prod2_nome + '\'' +
                ", prod3_nome='" + prod3_nome + '\'' +
                '}';
    }


// Getters e Setters


    public Long getIdConf() {
        return idConf;
    }

    public void setIdConf(Long idConf) {
        this.idConf = idConf;
    }

    public BigDecimal getProd1_valor() {
        return prod1_valor;
    }

    public void setProd1_valor(BigDecimal prod1_valor) {
        this.prod1_valor = prod1_valor;
    }

    public BigDecimal getProd2_valor() {
        return prod2_valor;
    }

    public void setProd2_valor(BigDecimal prod2_valor) {
        this.prod2_valor = prod2_valor;
    }

    public BigDecimal getProd3_valor() {
        return prod3_valor;
    }

    public void setProd3_valor(BigDecimal prod3_valor) {
        this.prod3_valor = prod3_valor;
    }

    public BigDecimal getComissao() {
        return comissao;
    }

    public void setComissao(BigDecimal comissao) {
        this.comissao = comissao;
    }

    public String getProd1_nome() {
        return prod1_nome;
    }

    public void setProd1_nome(String prod1_nome) {
        this.prod1_nome = prod1_nome;
    }

    public String getProd2_nome() {
        return prod2_nome;
    }

    public void setProd2_nome(String prod2_nome) {
        this.prod2_nome = prod2_nome;
    }

    public String getProd3_nome() {
        return prod3_nome;
    }

    public void setProd3_nome(String prod3_nome) {
        this.prod3_nome = prod3_nome;
    }
}
