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

    private int ribbon_1_atual;
    private int ribbon_2_atual;
    private int ribbon_3_atual;
    private int ribbon_4_atual;
    private int ribbon_5_atual;
    private int ribbon_6_atual;
    private int sobras;

    private int old_ribbon_1;
    private int old_ribbon_2;
    private int old_ribbon_3;
    private int old_ribbon_4;
    private int old_ribbon_5;
    private int old_ribbon_6;

    private int rev_ribbon_1;
    private int rev_ribbon_2;
    private int rev_ribbon_3;
    private int rev_ribbon_4;
    private int rev_ribbon_5;
    private int rev_ribbon_6;


    private int dif_ribbon_1;
    private int dif_ribbon_2;
    private int dif_ribbon_3;
    private int dif_ribbon_4;
    private int dif_ribbon_5;
    private int dif_ribbon_6;

    private BigDecimal desconto;
    private BigDecimal valor_din;
    private BigDecimal valor_deb;
    private BigDecimal valor_cred;
    private BigDecimal valor_pix;



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

    public int getRev_ribbon_1() {
        return rev_ribbon_1;
    }

    public void setRev_ribbon_1(int rev_ribbon_1) {
        this.rev_ribbon_1 = rev_ribbon_1;
    }

    public int getRev_ribbon_2() {
        return rev_ribbon_2;
    }

    public void setRev_ribbon_2(int rev_ribbon_2) {
        this.rev_ribbon_2 = rev_ribbon_2;
    }

    public int getRev_ribbon_3() {
        return rev_ribbon_3;
    }

    public void setRev_ribbon_3(int rev_ribbon_3) {
        this.rev_ribbon_3 = rev_ribbon_3;
    }

    public int getRev_ribbon_4() {
        return rev_ribbon_4;
    }

    public void setRev_ribbon_4(int rev_ribbon_4) {
        this.rev_ribbon_4 = rev_ribbon_4;
    }

    public int getRev_ribbon_5() {
        return rev_ribbon_5;
    }

    public void setRev_ribbon_5(int rev_ribbon_5) {
        this.rev_ribbon_5 = rev_ribbon_5;
    }

    public int getRev_ribbon_6() {
        return rev_ribbon_6;
    }

    public void setRev_ribbon_6(int rev_ribbon_6) {
        this.rev_ribbon_6 = rev_ribbon_6;
    }

    public int getDif_ribbon_1() {
        return dif_ribbon_1;
    }

    public void setDif_ribbon_1(int dif_ribbon_1) {
        this.dif_ribbon_1 = dif_ribbon_1;
    }

    public int getDif_ribbon_2() {
        return dif_ribbon_2;
    }

    public void setDif_ribbon_2(int dif_ribbon_2) {
        this.dif_ribbon_2 = dif_ribbon_2;
    }

    public int getDif_ribbon_3() {
        return dif_ribbon_3;
    }

    public void setDif_ribbon_3(int dif_ribbon_3) {
        this.dif_ribbon_3 = dif_ribbon_3;
    }

    public int getDif_ribbon_4() {
        return dif_ribbon_4;
    }

    public void setDif_ribbon_4(int dif_ribbon_4) {
        this.dif_ribbon_4 = dif_ribbon_4;
    }

    public int getDif_ribbon_5() {
        return dif_ribbon_5;
    }

    public void setDif_ribbon_5(int dif_ribbon_5) {
        this.dif_ribbon_5 = dif_ribbon_5;
    }

    public int getDif_ribbon_6() {
        return dif_ribbon_6;
    }

    public void setDif_ribbon_6(int dif_ribbon_6) {
        this.dif_ribbon_6 = dif_ribbon_6;
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



    public int getSobras() {
        return sobras;
    }

    public void setSobras(int sobras) {
        this.sobras = sobras;
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


    public int getRibbon_1_atual() {
        return ribbon_1_atual;
    }

    public void setRibbon_1_atual(int ribbon_1_atual) {
        this.ribbon_1_atual = ribbon_1_atual;
    }

    public int getRibbon_2_atual() {
        return ribbon_2_atual;
    }

    public void setRibbon_2_atual(int ribbon_2_atual) {
        this.ribbon_2_atual = ribbon_2_atual;
    }

    public int getRibbon_3_atual() {
        return ribbon_3_atual;
    }

    public void setRibbon_3_atual(int ribbon_3_atual) {
        this.ribbon_3_atual = ribbon_3_atual;
    }

    public int getRibbon_4_atual() {
        return ribbon_4_atual;
    }

    public void setRibbon_4_atual(int ribbon_4_atual) {
        this.ribbon_4_atual = ribbon_4_atual;
    }

    public int getRibbon_5_atual() {
        return ribbon_5_atual;
    }

    public void setRibbon_5_atual(int ribbon_5_atual) {
        this.ribbon_5_atual = ribbon_5_atual;
    }

    public int getRibbon_6_atual() {
        return ribbon_6_atual;
    }

    public void setRibbon_6_atual(int ribbon_6_atual) {
        this.ribbon_6_atual = ribbon_6_atual;
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
                ", ribbon_1_atual=" + ribbon_1_atual +
                ", ribbon_2_atual=" + ribbon_2_atual +
                ", ribbon_3_atual=" + ribbon_3_atual +
                ", ribbon_4_atual=" + ribbon_4_atual +
                ", ribbon_5_atual=" + ribbon_5_atual +
                ", ribbon_6_atual=" + ribbon_6_atual +
                ", sobras=" + sobras +
                ", old_ribbon_1=" + old_ribbon_1 +
                ", old_ribbon_2=" + old_ribbon_2 +
                ", old_ribbon_3=" + old_ribbon_3 +
                ", old_ribbon_4=" + old_ribbon_4 +
                ", old_ribbon_5=" + old_ribbon_5 +
                ", old_ribbon_6=" + old_ribbon_6 +
                ", rev_ribbon_1=" + rev_ribbon_1 +
                ", rev_ribbon_2=" + rev_ribbon_2 +
                ", rev_ribbon_3=" + rev_ribbon_3 +
                ", rev_ribbon_4=" + rev_ribbon_4 +
                ", rev_ribbon_5=" + rev_ribbon_5 +
                ", rev_ribbon_6=" + rev_ribbon_6 +
                ", dif_ribbon_1=" + dif_ribbon_1 +
                ", dif_ribbon_2=" + dif_ribbon_2 +
                ", dif_ribbon_3=" + dif_ribbon_3 +
                ", dif_ribbon_4=" + dif_ribbon_4 +
                ", dif_ribbon_5=" + dif_ribbon_5 +
                ", dif_ribbon_6=" + dif_ribbon_6 +
                ", desconto=" + desconto +
                ", valor_din=" + valor_din +
                ", valor_deb=" + valor_deb +
                ", valor_cred=" + valor_cred +
                ", valor_pix=" + valor_pix +
                ", observacao='" + observacao + '\'' +
                ", total_revelado=" + total_revelado +
                ", total_informado=" + total_informado +
                '}';
    }
}
