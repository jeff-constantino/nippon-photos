package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelMedidasDisciplinaresCompleto implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long funcionarioId;
    private String nomeFuncionario;
    private String tipoMedida; // "ADVERTÊNCIA", "FALTA", "SUSPENSÃO"
    private Date dataMedida;
    private String motivo;
    private Integer dias;
    private Integer dsr;

    // Getters e Setters
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

    public String getNomeFuncionario() {
        return nomeFuncionario;
    }

    public void setNomeFuncionario(String nomeFuncionario) {
        this.nomeFuncionario = nomeFuncionario;
    }

    public String getTipoMedida() {
        return tipoMedida;
    }

    public void setTipoMedida(String tipoMedida) {
        this.tipoMedida = tipoMedida;
    }

    public Date getDataMedida() {
        return dataMedida;
    }

    public void setDataMedida(Date dataMedida) {
        this.dataMedida = dataMedida;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Integer getDias() {
        return dias;
    }

    public void setDias(Integer dias) {
        this.dias = dias;
    }

    public Integer getDsr() {
        return dsr;
    }

    public void setDsr(Integer dsr) {
        this.dsr = dsr;
    }
}
