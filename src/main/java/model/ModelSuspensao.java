package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelSuspensao implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long funcionarioId;
    private String nomeFuncionario;
    private Date dataSuspensao;
    private String motivo;
    private int dias;

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

    public Date getDataSuspensao() {
        return dataSuspensao;
    }

    public void setDataSuspensao(Date dataSuspensao) {
        this.dataSuspensao = dataSuspensao;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public int getDias() {
        return dias;
    }

    public void setDias(int dias) {
        this.dias = dias;
    }
}
