package model;

import java.math.BigDecimal;

public class ModelConfig {
    private Long idconf;  // Adicionado o atributo id
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
    private String confName;
    private int qtd;
    private BigDecimal valor;
    private BigDecimal custo;

    @Override
    public String toString() {
        return "ModelConfig{" +
                "conf4_qtd=" + conf4_qtd +
                ", conf3_qtd=" + conf3_qtd +
                ", conf2_qtd=" + conf2_qtd +
                ", conf1_qtd=" + conf1_qtd +
                ", conf_name='" + conf_name + '\'' +
                ", conf4_nome='" + conf4_nome + '\'' +
                ", conf3_nome='" + conf3_nome + '\'' +
                ", conf2_nome='" + conf2_nome + '\'' +
                ", conf1_nome='" + conf1_nome + '\'' +
                ", conf4_custo=" + conf4_custo +
                ", conf3_custo=" + conf3_custo +
                ", conf2_custo=" + conf2_custo +
                ", conf1_custo=" + conf1_custo +
                ", conf4_valor=" + conf4_valor +
                ", conf3_valor=" + conf3_valor +
                ", conf2_valor=" + conf2_valor +
                ", conf1_valor2=" + conf1_valor2 +
                ", conf1_valor=" + conf1_valor +
                ", idconf=" + idconf +
                '}';
    }

    public String getConfName() {
        return confName;
    }

    public void setConfName(String confName) {
        this.confName = confName;
    }

    public int getQtd() {
        return qtd;
    }

    public void setQtd(int qtd) {
        this.qtd = qtd;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public BigDecimal getCusto() {
        return custo;
    }

    public void setCusto(BigDecimal custo) {
        this.custo = custo;
    }

    public Long getidconf() {
        return idconf;
    }

    public void setidconf(Long idconf) {
        this.idconf = idconf;
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
}
