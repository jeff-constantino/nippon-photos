package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Curso implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Long id;
    private String nomeCurso;
    private String instituicao;
    private Integer anoConclusao;
    private Integer cargaHoraria;
    private String descricao;
    private String certificadoUrl;
    private Integer ordem;
    private Boolean ativo;
    private Timestamp dataCadastro;
    
    public Curso() {}
    
    // Getters e Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getNomeCurso() {
        return nomeCurso;
    }
    
    public void setNomeCurso(String nomeCurso) {
        this.nomeCurso = nomeCurso;
    }
    
    public String getInstituicao() {
        return instituicao;
    }
    
    public void setInstituicao(String instituicao) {
        this.instituicao = instituicao;
    }
    
    public Integer getAnoConclusao() {
        return anoConclusao;
    }
    
    public void setAnoConclusao(Integer anoConclusao) {
        this.anoConclusao = anoConclusao;
    }
    
    public Integer getCargaHoraria() {
        return cargaHoraria;
    }
    
    public void setCargaHoraria(Integer cargaHoraria) {
        this.cargaHoraria = cargaHoraria;
    }
    
    public String getDescricao() {
        return descricao;
    }
    
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    
    public String getCertificadoUrl() {
        return certificadoUrl;
    }
    
    public void setCertificadoUrl(String certificadoUrl) {
        this.certificadoUrl = certificadoUrl;
    }
    
    public Integer getOrdem() {
        return ordem;
    }
    
    public void setOrdem(Integer ordem) {
        this.ordem = ordem;
    }
    
    public Boolean getAtivo() {
        return ativo;
    }
    
    public void setAtivo(Boolean ativo) {
        this.ativo = ativo;
    }
    
    public Timestamp getDataCadastro() {
        return dataCadastro;
    }
    
    public void setDataCadastro(Timestamp dataCadastro) {
        this.dataCadastro = dataCadastro;
    }
}
