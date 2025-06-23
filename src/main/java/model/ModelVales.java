package model;

import model.ModelLogin;
import util.DateConverter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

public class ModelVales implements Serializable {
    private long id_vale;
    private long id_funcionario;
    private ModelLogin funcionario; // Referência ao funcionário
    private String nome_funcionario;
    private LocalDate data; // Alterado para LocalDate
    private String observacao;
    private BigDecimal valor;
    private String forma_pagamento;


    public Date getDataFormatadaParaFmt() {
        return DateConverter.toUtilDate(this.data);
    }


    public String getForma_pagamento() {
        return forma_pagamento;
    }

    public void setForma_pagamento(String forma_pagamento) {
        this.forma_pagamento = forma_pagamento;
    }

    public long getId_funcionario() {
        return id_funcionario;
    }

    public void setId_funcionario(long id_funcionario) {
        this.id_funcionario = id_funcionario;
    }

    // Getters e Setters
    public long getId_vale() {
        return id_vale;
    }

    public void setId_vale(long id_vale) {
        this.id_vale = id_vale;
    }



    public ModelLogin getFuncionario() {
        return funcionario;
    }

    public void setFuncionario(ModelLogin funcionario) {
        this.funcionario = funcionario;
    }

    public String getNome_funcionario() {
        return nome_funcionario;
    }

    public void setNome_funcionario(String nome_funcionario) {
        this.nome_funcionario = nome_funcionario;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public BigDecimal getValor() {
        return valor;
    }

    // Setter com verificação para evitar valor negativo
    public void setValor(BigDecimal valor) {
        if (valor.compareTo(BigDecimal.ZERO) < 0) {
            this.valor = BigDecimal.ZERO; // Se valor for negativo, ajusta para 0
        } else {
            this.valor = valor;
        }
    }
}
