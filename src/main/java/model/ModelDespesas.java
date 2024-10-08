package model;
import java.io.Serializable;
import java.sql.Date;

public class ModelDespesas {
    private static final long serialVersionUID = 1L;

    private Long id_despesa;
    private String nome_despesa;
    private String descricao_despesa;
    private double valor_despesa;
    private Date data_despesa;


    public Date getData_despesa() {
        return data_despesa;
    }

    public void setData_despesa(Date data_despesa) {
        this.data_despesa = data_despesa;
    }

    public Long getId_despesa() {
        return id_despesa;
    }

    public void setId_despesa(Long id_despesa) {
        this.id_despesa = id_despesa;
    }

    public String getNome_despesa() {
        return nome_despesa;
    }

    public void setNome_despesa(String nome_despesa) {
        this.nome_despesa = nome_despesa;
    }

    public String getDescricao_despesa() {
        return descricao_despesa;
    }

    public void setDescricao_despesa(String descricao_despesa) {
        this.descricao_despesa = descricao_despesa;
    }

    public double getValor_despesa() {
        return valor_despesa;
    }

    public void setValor_despesa(double valor_despesa) {
        this.valor_despesa = valor_despesa;
    }
}
