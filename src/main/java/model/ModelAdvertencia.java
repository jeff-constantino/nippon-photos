package model;

import java.io.Serializable;

public class ModelAdvertencia implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private Long funcionarioId;
    private java.sql.Date dataAdvertencia;
    private String motivo;
    private String nomeFuncionario;
    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getFuncionarioId() { return funcionarioId; }
    public void setFuncionarioId(Long funcionarioId) { this.funcionarioId = funcionarioId; }
    public java.sql.Date getDataAdvertencia() { return dataAdvertencia; }
    public void setDataAdvertencia(java.sql.Date dataAdvertencia) { this.dataAdvertencia = dataAdvertencia; }
    public String getMotivo() { return motivo; }
    public void setMotivo(String motivo) { this.motivo = motivo; }

    public String getNomeFuncionario() {
        return nomeFuncionario;
    }

    public void setNomeFuncionario(String nomeFuncionario) {
        this.nomeFuncionario = nomeFuncionario;
    }
}
