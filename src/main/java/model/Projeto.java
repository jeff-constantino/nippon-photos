package model;

import java.sql.Timestamp;

public class Projeto {
    private Long id;
    private String nome;
    private String descricao_curta;
    private String descricao_completa;
    private String tecnologias;
    private String icone;
    private String url_acesso;
    private String status;
    private String funcionalidades;
    private Integer ordem;
    private boolean ativo;
    private Timestamp dataCadastro;

    public Projeto() {
        this.ativo = true;
    }

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

    public String getDescricao_curta() {
        return descricao_curta;
    }

    public void setDescricao_curta(String descricao_curta) {
        this.descricao_curta = descricao_curta;
    }

    public String getDescricao_completa() {
        return descricao_completa;
    }

    public void setDescricao_completa(String descricao_completa) {
        this.descricao_completa = descricao_completa;
    }

    public String getTecnologias() {
        return tecnologias;
    }

    public void setTecnologias(String tecnologias) {
        this.tecnologias = tecnologias;
    }

    public String getIcone() {
        return icone;
    }

    public void setIcone(String icone) {
        this.icone = icone;
    }

    public String getUrl_acesso() {
        return url_acesso;
    }

    public void setUrl_acesso(String url_acesso) {
        this.url_acesso = url_acesso;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFuncionalidades() {
        return funcionalidades;
    }

    public void setFuncionalidades(String funcionalidades) {
        this.funcionalidades = funcionalidades;
    }

    public Integer getOrdem() {
        return ordem;
    }

    public void setOrdem(Integer ordem) {
        this.ordem = ordem;
    }

    public boolean getAtivo() {
        return ativo;
    }

    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }

    public Timestamp getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Timestamp dataCadastro) {
        this.dataCadastro = dataCadastro;
    }
}
