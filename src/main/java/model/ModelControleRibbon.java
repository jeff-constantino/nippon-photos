package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelControleRibbon implements Serializable {

    private long idControle;
    private Date data_ribbon;
    private int ribbon_1_atual;
    private int ribbon_2_atual;
    private int ribbon_3_atual;
    private int ribbon_4_atual;
    private int ribbon_5_atual;
    private int ribbon_6_atual;

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

    private int troca_ribbon_1;
    private int troca_ribbon_2;
    private int troca_ribbon_3;
    private int troca_ribbon_4;
    private int troca_ribbon_5;
    private int troca_ribbon_6;
private String observacao_ribbon;


    public String getObservacao_ribbon() {
        return observacao_ribbon;
    }

    public void setObservacao_ribbon(String observacao_ribbon) {
        this.observacao_ribbon = observacao_ribbon;
    }

    public long getIdControle() {
        return idControle;
    }

    public void setIdControle(long idControle) {
        this.idControle = idControle;
    }

    public Date getData_ribbon() {
        return data_ribbon;
    }

    public void setData_ribbon(Date data_ribbon) {
        this.data_ribbon = data_ribbon;
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

    public int getTroca_ribbon_1() {
        return troca_ribbon_1;
    }

    public void setTroca_ribbon_1(int troca_ribbon_1) {
        this.troca_ribbon_1 = troca_ribbon_1;
    }

    public int getTroca_ribbon_2() {
        return troca_ribbon_2;
    }

    public void setTroca_ribbon_2(int troca_ribbon_2) {
        this.troca_ribbon_2 = troca_ribbon_2;
    }

    public int getTroca_ribbon_3() {
        return troca_ribbon_3;
    }

    public void setTroca_ribbon_3(int troca_ribbon_3) {
        this.troca_ribbon_3 = troca_ribbon_3;
    }

    public int getTroca_ribbon_4() {
        return troca_ribbon_4;
    }

    public void setTroca_ribbon_4(int troca_ribbon_4) {
        this.troca_ribbon_4 = troca_ribbon_4;
    }

    public int getTroca_ribbon_5() {
        return troca_ribbon_5;
    }

    public void setTroca_ribbon_5(int troca_ribbon_5) {
        this.troca_ribbon_5 = troca_ribbon_5;
    }

    public int getTroca_ribbon_6() {
        return troca_ribbon_6;
    }

    public void setTroca_ribbon_6(int troca_ribbon_6) {
        this.troca_ribbon_6 = troca_ribbon_6;
    }
}
