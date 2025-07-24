package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class ModelSalarios implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idSalario;


    private int mes; //mesAno no jsp
    private int ano; //mesAno no jsp

    private Long funcionarioId;
    private String nomeFuncionario;
    private int qtdFotos;
    private int qtdArquivos;
    private int qtdSobras;
    private int qtdEnc;
    private BigDecimal aproveitamento;

    private double atrasos;
    private  int faltas;
    private int advertencias; //contar quantidades
    private int suspensoes; // contar quantidades
    private int dsr;


    private BigDecimal valorAtrasos; //calcular hora*tempo
    private BigDecimal valorFaltas;
    private BigDecimal valorSuspensoes;
    private BigDecimal vales;
    private BigDecimal inss;
    private BigDecimal fgts;


    private BigDecimal venda_total; //salario_bruto no jsp

    private BigDecimal comissao;
    private BigDecimal salario_total;
    private BigDecimal salario_liquido1;

    private BigDecimal comissao2;
    private BigDecimal salario_total2;
    private BigDecimal salario_liquido2;


    public BigDecimal getAproveitamento() {
        return aproveitamento;
    }

    public void setAproveitamento(BigDecimal aproveitamento) {
        this.aproveitamento = aproveitamento;
    }

    public int getQtdEnc() {
        return qtdEnc;
    }

    public void setQtdEnc(int qtdEnc) {
        this.qtdEnc = qtdEnc;
    }

    public int getIdSalario() {
        return idSalario;
    }

    public void setIdSalario(int idSalario) {
        this.idSalario = idSalario;
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

    public Long getFuncionarioId() {
        return funcionarioId;
    }

    public void setFuncionarioId(Long funcionarioId) {
        this.funcionarioId = funcionarioId;
    }

    public String getNomeFuncionario() {
        return nomeFuncionario;
    }

    public void setNomeFuncionario(String nomeFuncionario) {
        this.nomeFuncionario = nomeFuncionario;
    }

    public int getQtdFotos() {
        return qtdFotos;
    }

    public void setQtdFotos(int qtdFotos) {
        this.qtdFotos = qtdFotos;
    }

    public int getQtdArquivos() {
        return qtdArquivos;
    }

    public void setQtdArquivos(int qtdArquivos) {
        this.qtdArquivos = qtdArquivos;
    }

    public int getQtdSobras() {
        return qtdSobras;
    }

    public void setQtdSobras(int qtdSobras) {
        this.qtdSobras = qtdSobras;
    }

    public double getAtrasos() {
        return atrasos;
    }

    public void setAtrasos(double atrasos) {
        this.atrasos = atrasos;
    }

    public int getFaltas() {
        return faltas;
    }

    public void setFaltas(int faltas) {
        this.faltas = faltas;
    }

    public int getAdvertencias() {
        return advertencias;
    }

    public void setAdvertencias(int advertencias) {
        this.advertencias = advertencias;
    }

    public int getSuspensoes() {
        return suspensoes;
    }

    public void setSuspensoes(int suspensoes) {
        this.suspensoes = suspensoes;
    }

    public int getDsr() {
        return dsr;
    }

    public void setDsr(int dsr) {
        this.dsr = dsr;
    }

    public BigDecimal getValorAtrasos() {
        return valorAtrasos;
    }

    public void setValorAtrasos(BigDecimal valorAtrasos) {
        this.valorAtrasos = valorAtrasos;
    }

    public BigDecimal getValorFaltas() {
        return valorFaltas;
    }

    public void setValorFaltas(BigDecimal valorFaltas) {
        this.valorFaltas = valorFaltas;
    }

    public BigDecimal getValorSuspensoes() {
        return valorSuspensoes;
    }

    public void setValorSuspensoes(BigDecimal valorSuspensoes) {
        this.valorSuspensoes = valorSuspensoes;
    }

    public BigDecimal getVales() {
        return vales;
    }

    public void setVales(BigDecimal vales) {
        this.vales = vales;
    }

    public BigDecimal getInss() {
        return inss;
    }

    public void setInss(BigDecimal inss) {
        this.inss = inss;
    }

    public BigDecimal getFgts() {
        return fgts;
    }

    public void setFgts(BigDecimal fgts) {
        this.fgts = fgts;
    }

    public BigDecimal getVenda_total() {
        return venda_total;
    }

    public void setVenda_total(BigDecimal venda_total) {
        this.venda_total = venda_total;
    }

    public BigDecimal getComissao() {
        return comissao;
    }

    public void setComissao(BigDecimal comissao) {
        this.comissao = comissao;
    }

    public BigDecimal getSalario_total() {
        return salario_total;
    }

    public void setSalario_total(BigDecimal salario_total) {
        this.salario_total = salario_total;
    }

    public BigDecimal getSalario_liquido1() {
        return salario_liquido1;
    }

    public void setSalario_liquido1(BigDecimal salario_liquido1) {
        this.salario_liquido1 = salario_liquido1;
    }

    public BigDecimal getComissao2() {
        return comissao2;
    }

    public void setComissao2(BigDecimal comissao2) {
        this.comissao2 = comissao2;
    }

    public BigDecimal getSalario_total2() {
        return salario_total2;
    }

    public void setSalario_total2(BigDecimal salario_total2) {
        this.salario_total2 = salario_total2;
    }

    public BigDecimal getSalario_liquido2() {
        return salario_liquido2;
    }

    public void setSalario_liquido2(BigDecimal salario_liquido2) {
        this.salario_liquido2 = salario_liquido2;
    }
}
