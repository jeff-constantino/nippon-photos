package model;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
public class ModelFechaDia implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;

    private Date data_fechamento;

    private int total_ft_din;
    private int total_ft_deb;
    private int total_ft_cred;
    private int total_ft_pix;

    private int total_enc_din;
    private int total_enc_deb;
    private int total_enc_cred;
    private int total_enc_pix;

    private int total_dig_din;
    private int total_dig_deb;
    private int total_dig_cred;
    private int total_dig_pix;

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

    private BigDecimal desconto;
    private BigDecimal valor_din;
    private BigDecimal valor_deb;
    private BigDecimal valor_cred;
    private BigDecimal valor_pix;
    private BigDecimal valor_din_real;
    private BigDecimal valor_deb_real;
    private BigDecimal valor_cred_real;
    private BigDecimal valor_pix_real;


    private String observacao;

    private int total_revelado;
    private int total_informado;


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

    public BigDecimal getValor_din() {
        return valor_din;
    }

    public void setValor_din(BigDecimal valor_din) {
        this.valor_din = valor_din;
    }

    public BigDecimal getValor_deb() {
        return valor_deb;
    }

    public void setValor_deb(BigDecimal valor_deb) {
        this.valor_deb = valor_deb;
    }

    public BigDecimal getValor_cred() {
        return valor_cred;
    }

    public void setValor_cred(BigDecimal valor_cred) {
        this.valor_cred = valor_cred;
    }

    public BigDecimal getValor_pix() {
        return valor_pix;
    }

    public void setValor_pix(BigDecimal valor_pix) {
        this.valor_pix = valor_pix;
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

    public int getSobras() {
        return sobras;
    }

    public void setSobras(int sobras) {
        this.sobras = sobras;
    }

    public int getTotal_ribbon_6() {
        return total_ribbon_6;
    }

    public void setTotal_ribbon_6(int total_ribbon_6) {
        this.total_ribbon_6 = total_ribbon_6;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getData_fechamento() {
        return data_fechamento;
    }

    public void setData_fechamento(Date data_fechamento) {
        this.data_fechamento = data_fechamento;
    }

    public int getTotal_ft_din() {
        return total_ft_din;
    }

    public void setTotal_ft_din(int total_ft_din) {
        this.total_ft_din = total_ft_din;
    }

    public int getTotal_ft_deb() {
        return total_ft_deb;
    }

    public void setTotal_ft_deb(int total_ft_deb) {
        this.total_ft_deb = total_ft_deb;
    }

    public int getTotal_ft_cred() {
        return total_ft_cred;
    }

    public void setTotal_ft_cred(int total_ft_cred) {
        this.total_ft_cred = total_ft_cred;
    }

    public int getTotal_ft_pix() {
        return total_ft_pix;
    }

    public void setTotal_ft_pix(int total_ft_pix) {
        this.total_ft_pix = total_ft_pix;
    }

    public int getTotal_enc_din() {
        return total_enc_din;
    }

    public void setTotal_enc_din(int total_enc_din) {
        this.total_enc_din = total_enc_din;
    }

    public int getTotal_enc_deb() {
        return total_enc_deb;
    }

    public void setTotal_enc_deb(int total_enc_deb) {
        this.total_enc_deb = total_enc_deb;
    }

    public int getTotal_enc_cred() {
        return total_enc_cred;
    }

    public void setTotal_enc_cred(int total_enc_cred) {
        this.total_enc_cred = total_enc_cred;
    }

    public int getTotal_enc_pix() {
        return total_enc_pix;
    }

    public void setTotal_enc_pix(int total_enc_pix) {
        this.total_enc_pix = total_enc_pix;
    }

    public int getTotal_dig_din() {
        return total_dig_din;
    }

    public void setTotal_dig_din(int total_dig_din) {
        this.total_dig_din = total_dig_din;
    }

    public int getTotal_dig_deb() {
        return total_dig_deb;
    }

    public void setTotal_dig_deb(int total_dig_deb) {
        this.total_dig_deb = total_dig_deb;
    }

    public int getTotal_dig_cred() {
        return total_dig_cred;
    }

    public void setTotal_dig_cred(int total_dig_cred) {
        this.total_dig_cred = total_dig_cred;
    }

    public int getTotal_dig_pix() {
        return total_dig_pix;
    }

    public void setTotal_dig_pix(int total_dig_pix) {
        this.total_dig_pix = total_dig_pix;
    }

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

    public BigDecimal getDesconto() {
        return desconto;
    }

    public void setDesconto(BigDecimal desconto) {
        this.desconto = desconto;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public BigDecimal getValor_din_real() {
        return valor_din_real;
    }

    public void setValor_din_real(BigDecimal valor_din_real) {
        this.valor_din_real = valor_din_real;
    }

    public BigDecimal getValor_deb_real() {
        return valor_deb_real;
    }

    public void setValor_deb_real(BigDecimal valor_deb_real) {
        this.valor_deb_real = valor_deb_real;
    }

    public BigDecimal getValor_cred_real() {
        return valor_cred_real;
    }

    public void setValor_cred_real(BigDecimal valor_cred_real) {
        this.valor_cred_real = valor_cred_real;
    }

    public BigDecimal getValor_pix_real() {
        return valor_pix_real;
    }

    public void setValor_pix_real(BigDecimal valor_pix_real) {
        this.valor_pix_real = valor_pix_real;
    }


    @Override
    public String toString() {
        return "ModelFechaDia {" +
                "\nid=" + id +
                ",\ndata_fechamento=" + data_fechamento +
                ",\ntotal_ft_din=" + total_ft_din +
                ",\ntotal_ft_deb=" + total_ft_deb +
                ",\ntotal_ft_cred=" + total_ft_cred +
                ",\ntotal_ft_pix=" + total_ft_pix +
                ",\ntotal_enc_din=" + total_enc_din +
                ",\ntotal_enc_deb=" + total_enc_deb +
                ",\ntotal_enc_cred=" + total_enc_cred +
                ",\ntotal_enc_pix=" + total_enc_pix +
                ",\ntotal_dig_din=" + total_dig_din +
                ",\ntotal_dig_deb=" + total_dig_deb +
                ",\ntotal_dig_cred=" + total_dig_cred +
                ",\ntotal_dig_pix=" + total_dig_pix +
                ",\ntotal_ribbon_1=" + total_ribbon_1 +
                ",\ntotal_ribbon_2=" + total_ribbon_2 +
                ",\ntotal_ribbon_3=" + total_ribbon_3 +
                ",\ntotal_ribbon_4=" + total_ribbon_4 +
                ",\ntotal_ribbon_5=" + total_ribbon_5 +
                ",\ntotal_ribbon_6=" + total_ribbon_6 +
                ",\nsobras=" + sobras +
                ",\ndifRibbon1=" + difRibbon1 +
                ",\ndifRibbon2=" + difRibbon2 +
                ",\ndifRibbon3=" + difRibbon3 +
                ",\ndifRibbon4=" + difRibbon4 +
                ",\ndifRibbon5=" + difRibbon5 +
                ",\ndifRibbon6=" + difRibbon6 +
                ",\nold_ribbon_1=" + old_ribbon_1 +
                ",\nold_ribbon_2=" + old_ribbon_2 +
                ",\nold_ribbon_3=" + old_ribbon_3 +
                ",\nold_ribbon_4=" + old_ribbon_4 +
                ",\nold_ribbon_5=" + old_ribbon_5 +
                ",\nold_ribbon_6=" + old_ribbon_6 +
                ",\ndesconto=" + desconto +
                ",\nvalor_din=" + valor_din +
                ",\nvalor_deb=" + valor_deb +
                ",\nvalor_cred=" + valor_cred +
                ",\nvalor_pix=" + valor_pix +
                ",\nvalor_din_real=" + valor_din_real +
                ",\nvalor_deb_real=" + valor_deb_real +
                ",\nvalor_cred_real=" + valor_cred_real +
                ",\nvalor_pix_real=" + valor_pix_real +
                ",\nobservacao='" + observacao + '\'' +
                ",\ntotal_revelado=" + total_revelado +
                ",\ntotal_informado=" + total_informado +
                "\n}";
    }

}
