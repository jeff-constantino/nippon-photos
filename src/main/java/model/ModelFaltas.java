package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelFaltas implements  Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long funcionarioId;
    private Date dataFalta;
    private String observacoes;
    private String nomeFuncionario;
    private int dias_falta;
    private int dsr_falta;

    // Getters e Setters


    public int getDias_falta() {
        return dias_falta;
    }

    public void setDias_falta(int dias_falta) {
        this.dias_falta = dias_falta;
    }

    public int getDsr_falta() {
        return dsr_falta;
    }

    public void setDsr_falta(int dsr_falta) {
        this.dsr_falta = dsr_falta;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getFuncionarioId() {
        return funcionarioId;
    }

    public void setFuncionarioId(Long funcionarioId) {
        this.funcionarioId = funcionarioId;
    }

    public Date getDataFalta() {
        return dataFalta;
    }

    public void setDataFalta(Date dataFalta) {
        this.dataFalta = dataFalta;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public String getNomeFuncionario() {
        return nomeFuncionario;
    }

    public void setNomeFuncionario(String nomeFuncionario) {
        this.nomeFuncionario = nomeFuncionario;
    }
}