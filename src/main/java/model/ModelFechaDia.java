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

    private BigDecimal desconto;

    private String observacao;

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


    @Override
    public String toString() {
        return "ModelFechaDia{" +
                "id=" + id +
                ", data_fechamento=" + data_fechamento +
                ", total_ft_din=" + total_ft_din +
                ", total_ft_deb=" + total_ft_deb +
                ", total_ft_cred=" + total_ft_cred +
                ", total_ft_pix=" + total_ft_pix +
                ", total_enc_din=" + total_enc_din +
                ", total_enc_deb=" + total_enc_deb +
                ", total_enc_cred=" + total_enc_cred +
                ", total_enc_pix=" + total_enc_pix +
                ", total_dig_din=" + total_dig_din +
                ", total_dig_deb=" + total_dig_deb +
                ", total_dig_cred=" + total_dig_cred +
                ", total_dig_pix=" + total_dig_pix +
                ", total_ribbon_1=" + total_ribbon_1 +
                ", total_ribbon_2=" + total_ribbon_2 +
                ", total_ribbon_3=" + total_ribbon_3 +
                ", total_ribbon_4=" + total_ribbon_4 +
                ", total_ribbon_5=" + total_ribbon_5 +
                ", total_ribbon_6=" + total_ribbon_6 +
                ", sobras=" + sobras +
                ", desconto=" + desconto +
                ", observacao='" + observacao + '\'' +
                '}';
    }
}
