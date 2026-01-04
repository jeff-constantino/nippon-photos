package model;

import java.io.Serializable;

public class ModelLogin implements Serializable{


    private static final long serialVersionUID = 1L;

    private Long id;
    private String Nome;
    private String Email;
    private String login;
    private String senha;
    private String status;
    private String vendas;
    private String vales;
    private long id_funcionario;
    private String comissao;
    private String rg;
    private String cpf;
    private String pis;
    private String telefone;
    private String endereco;
    private String fotouser;
    private String extensaofotouser;
    private String apelido;

    public String getApelido() {
        return apelido;
    }

    public void setApelido(String apelido) {
        this.apelido = apelido;
    }

    public String getFotouser() {
        return fotouser;
    }

    public void setFotouser(String fotouser) {
        this.fotouser = fotouser;
    }

    public String getExtensaofotouser() {
        return extensaofotouser;
    }

    public void setExtensaofotouser(String extensaofotouser) {
        this.extensaofotouser = extensaofotouser;
    }

    public String getRg() {
        return rg;
    }

    public void setRg(String rg) {
        this.rg = rg;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getPis() {
        return pis;
    }

    public void setPis(String pis) {
        this.pis = pis;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public void setVendas(String vendas) {
        this.vendas = vendas;
    }

    public String getComissao() {
        return comissao;
    }

    public void setComissao(String comissao) {
        this.comissao = comissao;
    }

    public Boolean isNovo(){
        if(this.id == null){
            return true;
        } else if (this.id != null && this.id > 0) {
            return false;
        }

        return id == null;
    }


    public long getId_funcionario() {
        return id_funcionario;
    }

    public void setId_funcionario(long id_funcionario) {
        this.id_funcionario = id_funcionario;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String nome) {
        Nome = nome;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLogin() {
        return login;
    }
    public void setLogin(String login) {
        this.login = login;
    }
    public String getSenha() {
        return senha;
    }
    public void setSenha(String senha) {
        this.senha = senha;
    }


    public String getVendas() {
        return vendas;
    }

    public void setVendas() {
        this.vendas = vendas;
    }

    public String getVales() {
        return vales;
    }

    public void setVales(String vales) {
        this.vales = vales;
    }


    @Override
    public String toString() {
        return "ModelLogin{" +
                "id=" + id +
                ", Nome='" + Nome + '\'' +
                ", Email='" + Email + '\'' +
                ", login='" + login + '\'' +
                ", senha='" + senha + '\'' +
                ", status='" + status + '\'' +
                ", vendas='" + vendas + '\'' +
                ", vales='" + vales + '\'' +
                '}';
    }
}