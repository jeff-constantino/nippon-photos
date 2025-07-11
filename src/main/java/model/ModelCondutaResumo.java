package model;

import java.io.Serializable;

public class ModelCondutaResumo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private int totalAdvertencias;
    private int totalFaltas;
    private int totalDiasSuspensao;
    private int totalDsrSuspensao;

    // Getters e setters
    public int getTotalAdvertencias() { return totalAdvertencias; }
    public void setTotalAdvertencias(int totalAdvertencias) { this.totalAdvertencias = totalAdvertencias; }

    public int getTotalFaltas() { return totalFaltas; }
    public void setTotalFaltas(int totalFaltas) { this.totalFaltas = totalFaltas; }

    public int getTotalDiasSuspensao() { return totalDiasSuspensao; }
    public void setTotalDiasSuspensao(int totalDiasSuspensao) { this.totalDiasSuspensao = totalDiasSuspensao; }

    public int getTotalDsrSuspensao() { return totalDsrSuspensao; }
    public void setTotalDsrSuspensao(int totalDsrSuspensao) { this.totalDsrSuspensao = totalDsrSuspensao; }
}

