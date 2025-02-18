package model;

import java.math.BigDecimal;

public class ModelConfiguracao implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

    private Long idConf;
    private String chave;
    private String conf_name;


    //MODEL PARA TABELA PRODUTOS E MATERIAIS
    private BigDecimal valor;

    //MODEL PARA TABELA DE MATERIAIS

    private int qtd;
    private BigDecimal custo;

    //MODEL PARA A TABELA DE SALÁRIOS E COMISSÕES

    private BigDecimal salario;
    private BigDecimal comissao;
    private BigDecimal inss;
    private BigDecimal fgts;


    //MODEL PARA A TABELA DE JUROS DAS FORMAS DE PAGAMENTO

    private BigDecimal debito;
    private BigDecimal credito;
    private BigDecimal pix;

    public Long getIdConf() {
        return idConf;
    }

    public void setIdConf(Long idConf) {
        this.idConf = idConf;
    }

    public String getChave() {
        return chave;
    }

    public void setChave(String chave) {
        this.chave = chave;
    }

    public String getConf_name() {
        return conf_name;
    }

    public void setConf_name(String conf_name) {
        this.conf_name = conf_name;
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

    public BigDecimal getSalario() {
        return salario;
    }

    public void setSalario(BigDecimal salario) {
        this.salario = salario;
    }

    public BigDecimal getComissao() {
        return comissao;
    }

    public void setComissao(BigDecimal comissao) {
        this.comissao = comissao;
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

    public BigDecimal getDebito() {
        return debito;
    }

    public void setDebito(BigDecimal debito) {
        this.debito = debito;
    }

    public BigDecimal getCredito() {
        return credito;
    }

    public void setCredito(BigDecimal credito) {
        this.credito = credito;
    }

    public BigDecimal getPix() {
        return pix;
    }

    public void setPix(BigDecimal pix) {
        this.pix = pix;
    }
}
