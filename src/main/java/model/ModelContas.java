package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelContas implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long conta_id;
    private Long numero_pedido;
    private String empresa;
    private String itens;
    private double valor;
    private Date data_de_pedido;
    private Date data_de_pagamento;
    private String status;
    private String dataDePedidoFormatada; // Adicionando o campo para data formatada
    private String dataDePagamentoFormatada; // Adicionando o campo para data formatada

    // Getters and Setters
    public Long getConta_id() {
        return conta_id;
    }

    public void setConta_id(Long conta_id) {
        this.conta_id = conta_id;
    }

    public Long getNumero_pedido() {
        return numero_pedido;
    }

    public void setNumero_pedido(Long numero_pedido) {
        this.numero_pedido = numero_pedido;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getItens() {
        return itens;
    }

    public void setItens(String itens) {
        this.itens = itens;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public Date getData_de_pedido() {
        return data_de_pedido;
    }

    public void setData_de_pedido(Date data_de_pedido) {
        this.data_de_pedido = data_de_pedido;
    }

    public Date getData_de_pagamento() {
        return data_de_pagamento;
    }

    public void setData_de_pagamento(Date data_de_pagamento) {
        this.data_de_pagamento = data_de_pagamento;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDataDePedidoFormatada() {
        return dataDePedidoFormatada;
    }

    public void setDataDePedidoFormatada(String dataDePedidoFormatada) {
        this.dataDePedidoFormatada = dataDePedidoFormatada;
    }

    public String getDataDePagamentoFormatada() {
        return dataDePagamentoFormatada;
    }

    public void setDataDePagamentoFormatada(String dataDePagamentoFormatada) {
        this.dataDePagamentoFormatada = dataDePagamentoFormatada;
    }
}
