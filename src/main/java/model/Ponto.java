package model;

import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;

public class Ponto {

    // ===== FUNCIONARIO =====
    private Integer funcId;
    private String funcNome;
    private String funcCpf;
    private String funcTelefone;
    private String funcSenha;
    private Boolean funcAtivo;

    // ===== REGISTRO =====
    private Integer regId;
    private Date regData;
    private Timestamp regEntrada;
    private Timestamp regSaidaIntervalo;
    private Timestamp regRetornoIntervalo;
    private Timestamp regSaida;
    private String regObservacao;
    private Boolean regEditado;
    private String regEditadoPor;

    // ===== HORARIO =====
    private Integer horId;
    private String horDiaSemana;
    private Time horEntrada;
    private Integer horTolerancia;

    // Construtores
    public Ponto() {}

    // Getters e Setters
    public Integer getFuncId() { return funcId; }
    public void setFuncId(Integer funcId) { this.funcId = funcId; }

    public String getFuncNome() { return funcNome; }
    public void setFuncNome(String funcNome) { this.funcNome = funcNome; }

    public String getFuncCpf() { return funcCpf; }
    public void setFuncCpf(String funcCpf) { this.funcCpf = funcCpf; }

    public String getFuncTelefone() { return funcTelefone; }
    public void setFuncTelefone(String funcTelefone) { this.funcTelefone = funcTelefone; }

    public String getFuncSenha() { return funcSenha; }
    public void setFuncSenha(String funcSenha) { this.funcSenha = funcSenha; }

    public Boolean getFuncAtivo() { return funcAtivo; }
    public void setFuncAtivo(Boolean funcAtivo) { this.funcAtivo = funcAtivo; }

    public Integer getRegId() { return regId; }
    public void setRegId(Integer regId) { this.regId = regId; }

    public Date getRegData() { return regData; }
    public void setRegData(Date regData) { this.regData = regData; }

    public Timestamp getRegEntrada() { return regEntrada; }
    public void setRegEntrada(Timestamp regEntrada) { this.regEntrada = regEntrada; }

    public Timestamp getRegSaidaIntervalo() { return regSaidaIntervalo; }
    public void setRegSaidaIntervalo(Timestamp regSaidaIntervalo) { this.regSaidaIntervalo = regSaidaIntervalo; }

    public Timestamp getRegRetornoIntervalo() { return regRetornoIntervalo; }
    public void setRegRetornoIntervalo(Timestamp regRetornoIntervalo) { this.regRetornoIntervalo = regRetornoIntervalo; }

    public Timestamp getRegSaida() { return regSaida; }
    public void setRegSaida(Timestamp regSaida) { this.regSaida = regSaida; }

    public String getRegObservacao() { return regObservacao; }
    public void setRegObservacao(String regObservacao) { this.regObservacao = regObservacao; }

    public Boolean getRegEditado() { return regEditado; }
    public void setRegEditado(Boolean regEditado) { this.regEditado = regEditado; }

    public String getRegEditadoPor() { return regEditadoPor; }
    public void setRegEditadoPor(String regEditadoPor) { this.regEditadoPor = regEditadoPor; }

    public Integer getHorId() { return horId; }
    public void setHorId(Integer horId) { this.horId = horId; }

    public String getHorDiaSemana() { return horDiaSemana; }
    public void setHorDiaSemana(String horDiaSemana) { this.horDiaSemana = horDiaSemana; }

    public Time getHorEntrada() { return horEntrada; }
    public void setHorEntrada(Time horEntrada) { this.horEntrada = horEntrada; }

    public Integer getHorTolerancia() { return horTolerancia; }
    public void setHorTolerancia(Integer horTolerancia) { this.horTolerancia = horTolerancia; }
}