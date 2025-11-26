package model;

import java.math.BigDecimal;

public class ModelConfiguracao implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

    private Long idconf;
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
    private BigDecimal comissao2;
    private BigDecimal inss;
    private BigDecimal fgts;


    //MODEL PARA A TABELA DE JUROS DAS FORMAS DE PAGAMENTO

    private BigDecimal deb_visa_master;
    private BigDecimal cred_visa_master;
    private BigDecimal deb_outros;
    private BigDecimal cred_outros;

    private  Long id_inss_1;
    private  BigDecimal inss_1;
    private BigDecimal min_inss_1;
    private BigDecimal max_inss_1;
    private BigDecimal parcela_1;

    private Long id_inss_2;
    private BigDecimal inss_2;
    private BigDecimal min_inss_2;
    private BigDecimal max_inss_2;
    private BigDecimal parcela_2;

    private Long id_inss_3;
    private BigDecimal inss_3;
    private BigDecimal min_inss_3;
    private BigDecimal max_inss_3;
    private BigDecimal parcela_3;

    private Long id_inss_4;
    private BigDecimal inss_4;
    private BigDecimal min_inss_4;
    private BigDecimal max_inss_4;
    private BigDecimal parcela_4;

    // MODEL PARA A TABELA DE IRRF
    private Long id_irrf_1;
    private BigDecimal irrf_1;
    private BigDecimal parcela_irrf_1;
    private BigDecimal min_irrf_1;
    private BigDecimal max_irrf_1;

    private Long id_irrf_2;
    private BigDecimal irrf_2;
    private BigDecimal parcela_irrf_2;
    private BigDecimal min_irrf_2;
    private BigDecimal max_irrf_2;

    private Long id_irrf_3;
    private BigDecimal irrf_3;
    private BigDecimal parcela_irrf_3;
    private BigDecimal min_irrf_3;
    private BigDecimal max_irrf_3;

    private Long id_irrf_4;
    private BigDecimal irrf_4;
    private BigDecimal parcela_irrf_4;
    private BigDecimal min_irrf_4;
    private BigDecimal max_irrf_4;


    public Long getIdconf() {
        return idconf;
    }

    public void setIdconf(Long idconf) {
        this.idconf = idconf;
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

    public BigDecimal getComissao2() {
        return comissao2;
    }

    public void setComissao2(BigDecimal comissao2) {
        this.comissao2 = comissao2;
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

    public BigDecimal getDeb_visa_master() {
        return deb_visa_master;
    }

    public void setDeb_visa_master(BigDecimal deb_visa_master) {
        this.deb_visa_master = deb_visa_master;
    }

    public BigDecimal getCred_visa_master() {
        return cred_visa_master;
    }

    public void setCred_visa_master(BigDecimal cred_visa_master) {
        this.cred_visa_master = cred_visa_master;
    }

    public BigDecimal getDeb_outros() {
        return deb_outros;
    }

    public void setDeb_outros(BigDecimal deb_outros) {
        this.deb_outros = deb_outros;
    }

    public BigDecimal getCred_outros() {
        return cred_outros;
    }

    public void setCred_outros(BigDecimal cred_outros) {
        this.cred_outros = cred_outros;
    }

    public Long getId_inss_1() {
        return id_inss_1;
    }

    public void setId_inss_1(Long id_inss_1) {
        this.id_inss_1 = id_inss_1;
    }

    public BigDecimal getInss_1() {
        return inss_1;
    }

    public void setInss_1(BigDecimal inss_1) {
        this.inss_1 = inss_1;
    }

    public BigDecimal getMin_inss_1() {
        return min_inss_1;
    }

    public void setMin_inss_1(BigDecimal min_inss_1) {
        this.min_inss_1 = min_inss_1;
    }

    public BigDecimal getMax_inss_1() {
        return max_inss_1;
    }

    public void setMax_inss_1(BigDecimal max_inss_1) {
        this.max_inss_1 = max_inss_1;
    }

    public BigDecimal getParcela_1() {
        return parcela_1;
    }

    public void setParcela_1(BigDecimal parcela_1) {
        this.parcela_1 = parcela_1;
    }

    public Long getId_inss_2() {
        return id_inss_2;
    }

    public void setId_inss_2(Long id_inss_2) {
        this.id_inss_2 = id_inss_2;
    }

    public BigDecimal getInss_2() {
        return inss_2;
    }

    public void setInss_2(BigDecimal inss_2) {
        this.inss_2 = inss_2;
    }

    public BigDecimal getMin_inss_2() {
        return min_inss_2;
    }

    public void setMin_inss_2(BigDecimal min_inss_2) {
        this.min_inss_2 = min_inss_2;
    }

    public BigDecimal getMax_inss_2() {
        return max_inss_2;
    }

    public void setMax_inss_2(BigDecimal max_inss_2) {
        this.max_inss_2 = max_inss_2;
    }

    public BigDecimal getParcela_2() {
        return parcela_2;
    }

    public void setParcela_2(BigDecimal parcela_2) {
        this.parcela_2 = parcela_2;
    }

    public Long getId_inss_3() {
        return id_inss_3;
    }

    public void setId_inss_3(Long id_inss_3) {
        this.id_inss_3 = id_inss_3;
    }

    public BigDecimal getInss_3() {
        return inss_3;
    }

    public void setInss_3(BigDecimal inss_3) {
        this.inss_3 = inss_3;
    }

    public BigDecimal getMin_inss_3() {
        return min_inss_3;
    }

    public void setMin_inss_3(BigDecimal min_inss_3) {
        this.min_inss_3 = min_inss_3;
    }

    public BigDecimal getMax_inss_3() {
        return max_inss_3;
    }

    public void setMax_inss_3(BigDecimal max_inss_3) {
        this.max_inss_3 = max_inss_3;
    }

    public BigDecimal getParcela_3() {
        return parcela_3;
    }

    public void setParcela_3(BigDecimal parcela_3) {
        this.parcela_3 = parcela_3;
    }

    public Long getId_inss_4() {
        return id_inss_4;
    }

    public void setId_inss_4(Long id_inss_4) {
        this.id_inss_4 = id_inss_4;
    }

    public BigDecimal getInss_4() {
        return inss_4;
    }

    public void setInss_4(BigDecimal inss_4) {
        this.inss_4 = inss_4;
    }

    public BigDecimal getMin_inss_4() {
        return min_inss_4;
    }

    public void setMin_inss_4(BigDecimal min_inss_4) {
        this.min_inss_4 = min_inss_4;
    }

    public BigDecimal getMax_inss_4() {
        return max_inss_4;
    }

    public void setMax_inss_4(BigDecimal max_inss_4) {
        this.max_inss_4 = max_inss_4;
    }

    public BigDecimal getParcela_4() {
        return parcela_4;
    }

    public void setParcela_4(BigDecimal parcela_4) {
        this.parcela_4 = parcela_4;
    }

    public Long getId_irrf_1() {
        return id_irrf_1;
    }

    public void setId_irrf_1(Long id_irrf_1) {
        this.id_irrf_1 = id_irrf_1;
    }

    public BigDecimal getIrrf_1() {
        return irrf_1;
    }

    public void setIrrf_1(BigDecimal irrf_1) {
        this.irrf_1 = irrf_1;
    }

    public BigDecimal getParcela_irrf_1() {
        return parcela_irrf_1;
    }

    public void setParcela_irrf_1(BigDecimal parcela_irrf_1) {
        this.parcela_irrf_1 = parcela_irrf_1;
    }

    public BigDecimal getMin_irrf_1() {
        return min_irrf_1;
    }

    public void setMin_irrf_1(BigDecimal min_irrf_1) {
        this.min_irrf_1 = min_irrf_1;
    }

    public BigDecimal getMax_irrf_1() {
        return max_irrf_1;
    }

    public void setMax_irrf_1(BigDecimal max_irrf_1) {
        this.max_irrf_1 = max_irrf_1;
    }

    public Long getId_irrf_2() {
        return id_irrf_2;
    }

    public void setId_irrf_2(Long id_irrf_2) {
        this.id_irrf_2 = id_irrf_2;
    }

    public BigDecimal getIrrf_2() {
        return irrf_2;
    }

    public void setIrrf_2(BigDecimal irrf_2) {
        this.irrf_2 = irrf_2;
    }

    public BigDecimal getParcela_irrf_2() {
        return parcela_irrf_2;
    }

    public void setParcela_irrf_2(BigDecimal parcela_irrf_2) {
        this.parcela_irrf_2 = parcela_irrf_2;
    }

    public BigDecimal getMin_irrf_2() {
        return min_irrf_2;
    }

    public void setMin_irrf_2(BigDecimal min_irrf_2) {
        this.min_irrf_2 = min_irrf_2;
    }

    public BigDecimal getMax_irrf_2() {
        return max_irrf_2;
    }

    public void setMax_irrf_2(BigDecimal max_irrf_2) {
        this.max_irrf_2 = max_irrf_2;
    }

    public Long getId_irrf_3() {
        return id_irrf_3;
    }

    public void setId_irrf_3(Long id_irrf_3) {
        this.id_irrf_3 = id_irrf_3;
    }

    public BigDecimal getIrrf_3() {
        return irrf_3;
    }

    public void setIrrf_3(BigDecimal irrf_3) {
        this.irrf_3 = irrf_3;
    }

    public BigDecimal getParcela_irrf_3() {
        return parcela_irrf_3;
    }

    public void setParcela_irrf_3(BigDecimal parcela_irrf_3) {
        this.parcela_irrf_3 = parcela_irrf_3;
    }

    public BigDecimal getMin_irrf_3() {
        return min_irrf_3;
    }

    public void setMin_irrf_3(BigDecimal min_irrf_3) {
        this.min_irrf_3 = min_irrf_3;
    }

    public BigDecimal getMax_irrf_3() {
        return max_irrf_3;
    }

    public void setMax_irrf_3(BigDecimal max_irrf_3) {
        this.max_irrf_3 = max_irrf_3;
    }

    public Long getId_irrf_4() {
        return id_irrf_4;
    }

    public void setId_irrf_4(Long id_irrf_4) {
        this.id_irrf_4 = id_irrf_4;
    }

    public BigDecimal getIrrf_4() {
        return irrf_4;
    }

    public void setIrrf_4(BigDecimal irrf_4) {
        this.irrf_4 = irrf_4;
    }

    public BigDecimal getParcela_irrf_4() {
        return parcela_irrf_4;
    }

    public void setParcela_irrf_4(BigDecimal parcela_irrf_4) {
        this.parcela_irrf_4 = parcela_irrf_4;
    }

    public BigDecimal getMin_irrf_4() {
        return min_irrf_4;
    }

    public void setMin_irrf_4(BigDecimal min_irrf_4) {
        this.min_irrf_4 = min_irrf_4;
    }

    public BigDecimal getMax_irrf_4() {
        return max_irrf_4;
    }

    public void setMax_irrf_4(BigDecimal max_irrf_4) {
        this.max_irrf_4 = max_irrf_4;
    }
}
