package model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class Projeto implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Long id;
    private String nome;
    private String descricaoCurta;
    private String descricaoCompleta;
    private String icone;
    private String tecnologias; // String separada por vírgulas
    private String urlAcesso;
    private String urlGithub;
    private String imagemUrl;
    private Integer ordem;
    private Boolean ativo;
    private Boolean destaque;
    private Timestamp dataCadastro;
    private List<String> funcionalidades; // Lista de funcionalidades
    
    public Projeto() {}
    
    // Getters e Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getNome() {
        return nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public String getDescricaoCurta() {
        return descricaoCurta;
    }
    
    public void setDescricaoCurta(String descricaoCurta) {
        this.descricaoCurta = descricaoCurta;
    }
    
    public String getDescricaoCompleta() {
        return descricaoCompleta;
    }
    
    public void setDescricaoCompleta(String descricaoCompleta) {
        this.descricaoCompleta = descricaoCompleta;
    }
    
    public String getIcone() {
        return icone;
    }
    
    public void setIcone(String icone) {
        this.icone = icone;
    }
    
    public String getTecnologias() {
        return tecnologias;
    }
    
    public void setTecnologias(String tecnologias) {
        this.tecnologias = tecnologias;
    }
    
    public String getUrlAcesso() {
        return urlAcesso;
    }
    
    public void setUrlAcesso(String urlAcesso) {
        this.urlAcesso = urlAcesso;
    }
    
    public String getUrlGithub() {
        return urlGithub;
    }
    
    public void setUrlGithub(String urlGithub) {
        this.urlGithub = urlGithub;
    }
    
    public String getImagemUrl() {
        return imagemUrl;
    }
    
    public void setImagemUrl(String imagemUrl) {
        this.imagemUrl = imagemUrl;
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
    
    public Boolean getDestaque() {
        return destaque;
    }
    
    public void setDestaque(Boolean destaque) {
        this.destaque = destaque;
    }
    
    public Timestamp getDataCadastro() {
        return dataCadastro;
    }
    
    public void setDataCadastro(Timestamp dataCadastro) {
        this.dataCadastro = dataCadastro;
    }
    
    public List<String> getFuncionalidades() {
        return funcionalidades;
    }
    
    public void setFuncionalidades(List<String> funcionalidades) {
        this.funcionalidades = funcionalidades;
    }
}
