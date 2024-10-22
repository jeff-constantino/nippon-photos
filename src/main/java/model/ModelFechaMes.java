package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

public class ModelFechaMes implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;

    private LocalDate data_final;


    private int final_ft_din;
    private int final_ft_deb;
    private int final_ft_cred;
    private int final_ft_pix;

    private int final_enc_din;
    private int final_enc_deb;
    private int final_enc_cred;
    private int final_enc_pix;

    private int final_dig_din;
    private int final_dig_deb;
    private int final_dig_cred;
    private int final_dig_pix;

    private int final_sobras;

    private BigDecimal final_descontos;


    private int final_ribbon_1;
    private int final_ribbon_2;
    private int final_ribbon_3;
    private int final_ribbon_4;
    private int final_ribbon_5;
    private int final_ribbon_6;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LocalDate getData_final() {
        return data_final;
    }

    public void setData_final(LocalDate data_final) {
        this.data_final = data_final;
    }

    public int getFinal_ft_din() {
        return final_ft_din;
    }

    public void setFinal_ft_din(int final_ft_din) {
        this.final_ft_din = final_ft_din;
    }

    public int getFinal_ft_deb() {
        return final_ft_deb;
    }

    public void setFinal_ft_deb(int final_ft_deb) {
        this.final_ft_deb = final_ft_deb;
    }

    public int getFinal_ft_cred() {
        return final_ft_cred;
    }

    public void setFinal_ft_cred(int final_ft_cred) {
        this.final_ft_cred = final_ft_cred;
    }

    public int getFinal_ft_pix() {
        return final_ft_pix;
    }

    public void setFinal_ft_pix(int final_ft_pix) {
        this.final_ft_pix = final_ft_pix;
    }

    public int getFinal_enc_din() {
        return final_enc_din;
    }

    public void setFinal_enc_din(int final_enc_din) {
        this.final_enc_din = final_enc_din;
    }

    public int getFinal_enc_deb() {
        return final_enc_deb;
    }

    public void setFinal_enc_deb(int final_enc_deb) {
        this.final_enc_deb = final_enc_deb;
    }

    public int getFinal_enc_cred() {
        return final_enc_cred;
    }

    public void setFinal_enc_cred(int final_enc_cred) {
        this.final_enc_cred = final_enc_cred;
    }

    public int getFinal_enc_pix() {
        return final_enc_pix;
    }

    public void setFinal_enc_pix(int final_enc_pix) {
        this.final_enc_pix = final_enc_pix;
    }

    public int getFinal_dig_din() {
        return final_dig_din;
    }

    public void setFinal_dig_din(int final_dig_din) {
        this.final_dig_din = final_dig_din;
    }

    public int getFinal_dig_deb() {
        return final_dig_deb;
    }

    public void setFinal_dig_deb(int final_dig_deb) {
        this.final_dig_deb = final_dig_deb;
    }

    public int getFinal_dig_cred() {
        return final_dig_cred;
    }

    public void setFinal_dig_cred(int final_dig_cred) {
        this.final_dig_cred = final_dig_cred;
    }

    public int getFinal_dig_pix() {
        return final_dig_pix;
    }

    public void setFinal_dig_pix(int final_dig_pix) {
        this.final_dig_pix = final_dig_pix;
    }

    public int getFinal_sobras() {
        return final_sobras;
    }

    public void setFinal_sobras(int final_sobras) {
        this.final_sobras = final_sobras;
    }

    public BigDecimal getFinal_descontos() {
        return final_descontos;
    }

    public void setFinal_descontos(BigDecimal final_descontos) {
        this.final_descontos = final_descontos;
    }

    public int getFinal_ribbon_1() {
        return final_ribbon_1;
    }

    public void setFinal_ribbon_1(int final_ribbon_1) {
        this.final_ribbon_1 = final_ribbon_1;
    }

    public int getFinal_ribbon_2() {
        return final_ribbon_2;
    }

    public void setFinal_ribbon_2(int final_ribbon_2) {
        this.final_ribbon_2 = final_ribbon_2;
    }

    public int getFinal_ribbon_3() {
        return final_ribbon_3;
    }

    public void setFinal_ribbon_3(int final_ribbon_3) {
        this.final_ribbon_3 = final_ribbon_3;
    }

    public int getFinal_ribbon_4() {
        return final_ribbon_4;
    }

    public void setFinal_ribbon_4(int final_ribbon_4) {
        this.final_ribbon_4 = final_ribbon_4;
    }

    public int getFinal_ribbon_5() {
        return final_ribbon_5;
    }

    public void setFinal_ribbon_5(int final_ribbon_5) {
        this.final_ribbon_5 = final_ribbon_5;
    }

    public int getFinal_ribbon_6() {
        return final_ribbon_6;
    }

    public void setFinal_ribbon_6(int final_ribbon_6) {
        this.final_ribbon_6 = final_ribbon_6;
    }
}
