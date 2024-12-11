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


    public Boolean isNovo(){
        if(this.id == null){
            return true;
        } else if (this.id != null && this.id > 0) {
            return false;
        }

        return id == null;
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