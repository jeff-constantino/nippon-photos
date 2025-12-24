package model;

import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;

/**
 * Model unificado para todo o sistema de ponto
 * Contém atributos para funcionário, registro, horário, justificativa e resumo mensal
 */
public class Ponto {

    // ===== FUNCIONÁRIO =====
    private Integer funcId;
    private String funcNome;
    private String funcCpf;
    private String funcTelefone;
    private String funcSenha;
    private Boolean funcAtivo;
    private Timestamp funcCriadoEm;

    // ===== REGISTRO DE PONTO =====
    private Integer regId;
    private Date regData;
    private Timestamp regEntrada;
    private Timestamp regSaidaIntervalo;
    private Timestamp regRetornoIntervalo;
    private Timestamp regSaida;
    private String regObservacao;
    private Boolean regEditado;
    private String regEditadoPor;
    private Timestamp regEditadoEm;

    // Campos calculados automaticamente
    private Integer regMinutosTrabalhados;
    private Integer regMinutosAtraso;
    private Integer regMinutosNoturno;

    // ===== HORÁRIO CONFIGURADO =====
    private Integer horId;
    private String horDiaSemana;
    private Time horEntrada;
    private Time horSaida;
    private Integer horTolerancia;
    private Integer horCargaHoraria; // em minutos

    // ===== JUSTIFICATIVA =====
    private Integer justId;
    private String justTipo;
    private String justDescricao;
    private Boolean justAprovado;

    // ===== RESUMO MENSAL =====
    private Integer resumoId;
    private Integer resumoMes;
    private Integer resumoAno;
    private Integer resumoTotalDiasTrabalhados;
    private Integer resumoTotalMinutosTrabalhados;
    private Integer resumoTotalAtrasos;
    private Integer resumoTotalMinutosAtraso;
    private Integer resumoTotalMinutosNoturno;
    private Integer resumoTotalFaltas;
    private Boolean resumoTemDireitoVale;
    private String resumoObservacoes;

    // ===== CAMPOS AUXILIARES (para relatórios) =====
    private String diaSemanaTexto; // ex: "Segunda-feira"
    private Boolean temAtraso;
    private Boolean temFalta;
    private String statusDia; // "Completo", "Incompleto", "Falta", "Justificado"

    // Construtores
    public Ponto() {}

    // ===== GETTERS E SETTERS =====

    // Funcionário
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

    public Timestamp getFuncCriadoEm() { return funcCriadoEm; }
    public void setFuncCriadoEm(Timestamp funcCriadoEm) { this.funcCriadoEm = funcCriadoEm; }

    // Registro
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

    public Timestamp getRegEditadoEm() { return regEditadoEm; }
    public void setRegEditadoEm(Timestamp regEditadoEm) { this.regEditadoEm = regEditadoEm; }

    // Campos calculados
    public Integer getRegMinutosTrabalhados() { return regMinutosTrabalhados; }
    public void setRegMinutosTrabalhados(Integer regMinutosTrabalhados) { this.regMinutosTrabalhados = regMinutosTrabalhados; }

    public Integer getRegMinutosAtraso() { return regMinutosAtraso; }
    public void setRegMinutosAtraso(Integer regMinutosAtraso) { this.regMinutosAtraso = regMinutosAtraso; }

    public Integer getRegMinutosNoturno() { return regMinutosNoturno; }
    public void setRegMinutosNoturno(Integer regMinutosNoturno) { this.regMinutosNoturno = regMinutosNoturno; }

    // Horário
    public Integer getHorId() { return horId; }
    public void setHorId(Integer horId) { this.horId = horId; }

    public String getHorDiaSemana() { return horDiaSemana; }
    public void setHorDiaSemana(String horDiaSemana) { this.horDiaSemana = horDiaSemana; }

    public Time getHorEntrada() { return horEntrada; }
    public void setHorEntrada(Time horEntrada) { this.horEntrada = horEntrada; }

    public Time getHorSaida() { return horSaida; }
    public void setHorSaida(Time horSaida) { this.horSaida = horSaida; }

    public Integer getHorTolerancia() { return horTolerancia; }
    public void setHorTolerancia(Integer horTolerancia) { this.horTolerancia = horTolerancia; }

    public Integer getHorCargaHoraria() { return horCargaHoraria; }
    public void setHorCargaHoraria(Integer horCargaHoraria) { this.horCargaHoraria = horCargaHoraria; }

    // Justificativa
    public Integer getJustId() { return justId; }
    public void setJustId(Integer justId) { this.justId = justId; }

    public String getJustTipo() { return justTipo; }
    public void setJustTipo(String justTipo) { this.justTipo = justTipo; }

    public String getJustDescricao() { return justDescricao; }
    public void setJustDescricao(String justDescricao) { this.justDescricao = justDescricao; }

    public Boolean getJustAprovado() { return justAprovado; }
    public void setJustAprovado(Boolean justAprovado) { this.justAprovado = justAprovado; }

    // Resumo Mensal
    public Integer getResumoId() { return resumoId; }
    public void setResumoId(Integer resumoId) { this.resumoId = resumoId; }

    public Integer getResumoMes() { return resumoMes; }
    public void setResumoMes(Integer resumoMes) { this.resumoMes = resumoMes; }

    public Integer getResumoAno() { return resumoAno; }
    public void setResumoAno(Integer resumoAno) { this.resumoAno = resumoAno; }

    public Integer getResumoTotalDiasTrabalhados() { return resumoTotalDiasTrabalhados; }
    public void setResumoTotalDiasTrabalhados(Integer resumoTotalDiasTrabalhados) { this.resumoTotalDiasTrabalhados = resumoTotalDiasTrabalhados; }

    public Integer getResumoTotalMinutosTrabalhados() { return resumoTotalMinutosTrabalhados; }
    public void setResumoTotalMinutosTrabalhados(Integer resumoTotalMinutosTrabalhados) { this.resumoTotalMinutosTrabalhados = resumoTotalMinutosTrabalhados; }

    public Integer getResumoTotalAtrasos() { return resumoTotalAtrasos; }
    public void setResumoTotalAtrasos(Integer resumoTotalAtrasos) { this.resumoTotalAtrasos = resumoTotalAtrasos; }

    public Integer getResumoTotalMinutosAtraso() { return resumoTotalMinutosAtraso; }
    public void setResumoTotalMinutosAtraso(Integer resumoTotalMinutosAtraso) { this.resumoTotalMinutosAtraso = resumoTotalMinutosAtraso; }

    public Integer getResumoTotalMinutosNoturno() { return resumoTotalMinutosNoturno; }
    public void setResumoTotalMinutosNoturno(Integer resumoTotalMinutosNoturno) { this.resumoTotalMinutosNoturno = resumoTotalMinutosNoturno; }

    public Integer getResumoTotalFaltas() { return resumoTotalFaltas; }
    public void setResumoTotalFaltas(Integer resumoTotalFaltas) { this.resumoTotalFaltas = resumoTotalFaltas; }

    public Boolean getResumoTemDireitoVale() { return resumoTemDireitoVale; }
    public void setResumoTemDireitoVale(Boolean resumoTemDireitoVale) { this.resumoTemDireitoVale = resumoTemDireitoVale; }

    public String getResumoObservacoes() { return resumoObservacoes; }
    public void setResumoObservacoes(String resumoObservacoes) { this.resumoObservacoes = resumoObservacoes; }

    // Auxiliares
    public String getDiaSemanaTexto() { return diaSemanaTexto; }
    public void setDiaSemanaTexto(String diaSemanaTexto) { this.diaSemanaTexto = diaSemanaTexto; }

    public Boolean getTemAtraso() { return temAtraso; }
    public void setTemAtraso(Boolean temAtraso) { this.temAtraso = temAtraso; }

    public Boolean getTemFalta() { return temFalta; }
    public void setTemFalta(Boolean temFalta) { this.temFalta = temFalta; }

    public String getStatusDia() { return statusDia; }
    public void setStatusDia(String statusDia) { this.statusDia = statusDia; }

    // ===== MÉTODOS AUXILIARES =====

    /**
     * Converte minutos em formato HH:mm
     */
    public String formatarMinutosEmHoras(Integer minutos) {
        if (minutos == null || minutos == 0) return "00:00";
        int horas = minutos / 60;
        int mins = minutos % 60;
        return String.format("%02d:%02d", horas, mins);
    }

    /**
     * Retorna total de horas trabalhadas formatado
     */
    public String getHorasTrabalhadasFormatado() {
        return formatarMinutosEmHoras(regMinutosTrabalhados);
    }

    /**
     * Retorna total de horas noturnas formatado
     */
    public String getHorasNoturnoFormatado() {
        return formatarMinutosEmHoras(regMinutosNoturno);
    }

    /**
     * Retorna total de atraso formatado
     */
    public String getAtrasoFormatado() {
        return formatarMinutosEmHoras(regMinutosAtraso);
    }
}
