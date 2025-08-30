package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class ModelDre implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id_dre;
    private int mes;
    private int ano;
    private BigDecimal receita_bruta;
    private BigDecimal custos_operacionais;
    private BigDecimal lucro_bruto;
    private BigDecimal icms;
    private BigDecimal pis;
    private BigDecimal cofins;
    private BigDecimal inss;
    private BigDecimal irpj;
    private BigDecimal csll;
    private BigDecimal total_impostos;
    private BigDecimal aluguel;
    private BigDecimal salarios;
    private BigDecimal contas;
    private BigDecimal despesas_gerais;
    private BigDecimal bonificacoes;
    private BigDecimal prestacoes;
    private BigDecimal internet;
    private BigDecimal outras_despesas;
    private BigDecimal total_despesas_adm;
    private BigDecimal lucro_liquido;
    private Date data_gravacao;

    // Getters e Setters
    public Long getId_dre() {
        return id_dre;
    }
    public void setId_dre(Long id_dre) {
        this.id_dre = id_dre;
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
    public BigDecimal getReceita_bruta() {
        return receita_bruta;
    }
    public void setReceita_bruta(BigDecimal receita_bruta) {
        this.receita_bruta = receita_bruta;
    }
    public BigDecimal getCustos_operacionais() {
        return custos_operacionais;
    }
    public void setCustos_operacionais(BigDecimal custos_operacionais) {
        this.custos_operacionais = custos_operacionais;
    }
    public BigDecimal getLucro_bruto() {
        return lucro_bruto;
    }
    public void setLucro_bruto(BigDecimal lucro_bruto) {
        this.lucro_bruto = lucro_bruto;
    }
    public BigDecimal getIcms() {
        return icms;
    }
    public void setIcms(BigDecimal icms) {
        this.icms = icms;
    }
    public BigDecimal getPis() {
        return pis;
    }
    public void setPis(BigDecimal pis) {
        this.pis = pis;
    }
    public BigDecimal getCofins() {
        return cofins;
    }
    public void setCofins(BigDecimal cofins) {
        this.cofins = cofins;
    }
    public BigDecimal getInss() {
        return inss;
    }
    public void setInss(BigDecimal inss) {
        this.inss = inss;
    }
    public BigDecimal getIrpj() {
        return irpj;
    }
    public void setIrpj(BigDecimal irpj) {
        this.irpj = irpj;
    }
    public BigDecimal getCsll() {
        return csll;
    }
    public void setCsll(BigDecimal csll) {
        this.csll = csll;
    }
    public BigDecimal getTotal_impostos() {
        return total_impostos;
    }
    public void setTotal_impostos(BigDecimal total_impostos) {
        this.total_impostos = total_impostos;
    }
    public BigDecimal getAluguel() {
        return aluguel;
    }
    public void setAluguel(BigDecimal aluguel) {
        this.aluguel = aluguel;
    }
    public BigDecimal getSalarios() {
        return salarios;
    }
    public void setSalarios(BigDecimal salarios) {
        this.salarios = salarios;
    }
    public BigDecimal getContas() {
        return contas;
    }
    public void setContas(BigDecimal contas) {
        this.contas = contas;
    }
    public BigDecimal getDespesas_gerais() {
        return despesas_gerais;
    }
    public void setDespesas_gerais(BigDecimal despesas_gerais) {
        this.despesas_gerais = despesas_gerais;
    }
    public BigDecimal getBonificacoes() {
        return bonificacoes;
    }
    public void setBonificacoes(BigDecimal bonificacoes) {
        this.bonificacoes = bonificacoes;
    }
    public BigDecimal getPrestacoes() {
        return prestacoes;
    }
    public void setPrestacoes(BigDecimal prestacoes) {
        this.prestacoes = prestacoes;
    }
    public BigDecimal getInternet() {
        return internet;
    }
    public void setInternet(BigDecimal internet) {
        this.internet = internet;
    }
    public BigDecimal getOutras_despesas() {
        return outras_despesas;
    }
    public void setOutras_despesas(BigDecimal outras_despesas) {
        this.outras_despesas = outras_despesas;
    }
    public BigDecimal getTotal_despesas_adm() {
        return total_despesas_adm;
    }
    public void setTotal_despesas_adm(BigDecimal total_despesas_adm) {
        this.total_despesas_adm = total_despesas_adm;
    }
    public BigDecimal getLucro_liquido() {
        return lucro_liquido;
    }
    public void setLucro_liquido(BigDecimal lucro_liquido) {
        this.lucro_liquido = lucro_liquido;
    }
    public Date getData_gravacao() {
        return data_gravacao;
    }
    public void setData_gravacao(Date data_gravacao) {
        this.data_gravacao = data_gravacao;
    }

}
