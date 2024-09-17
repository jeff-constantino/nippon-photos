package model;

import java.io.Serializable;

public class ModelLogin implements Serializable{


    private static final long serialVersionUID = 1L;

    private Long id;
    private String Nome;
    private String Email;
    private String login;

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

    private String senha;

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







}