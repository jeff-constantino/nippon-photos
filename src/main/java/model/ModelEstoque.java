package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ModelEstoque implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long produtoId;
    private String nome;
    private String marca;
    private String peso;
    private String codBarra;
    private BigDecimal valorCompra;
    private BigDecimal valorVenda;
    private Integer estoqueAtual;

    // Movimentação
    private Integer quantidade;
    private String tipoMovimento;
    private String motivo;
    private String observacao;
    private LocalDateTime dataMovimento;

    // Helpers para o Relatório Resumido
    private Integer entradasNoPeriodo;
    private Integer saidasNoPeriodo;
    private Integer estoqueInicialNoPeriodo;

    public java.util.Date getDataMovimentoDate() {
        return this.dataMovimento != null ? java.sql.Timestamp.valueOf(this.dataMovimento) : null;
    }

    // Getters e Setters
    public Long getProdutoId() { return produtoId; }
    public void setProdutoId(Long produtoId) { this.produtoId = produtoId; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }
    public String getPeso() { return peso; }
    public void setPeso(String peso) { this.peso = peso; }
    public String getCodBarra() { return codBarra; }
    public void setCodBarra(String codBarra) { this.codBarra = codBarra; }
    public BigDecimal getValorCompra() { return valorCompra; }
    public void setValorCompra(BigDecimal valorCompra) { this.valorCompra = valorCompra; }
    public BigDecimal getValorVenda() { return valorVenda; }
    public void setValorVenda(BigDecimal valorVenda) { this.valorVenda = valorVenda; }
    public Integer getEstoqueAtual() { return estoqueAtual; }
    public void setEstoqueAtual(Integer estoqueAtual) { this.estoqueAtual = estoqueAtual; }
    public Integer getQuantidade() { return quantidade; }
    public void setQuantidade(Integer quantidade) { this.quantidade = quantidade; }
    public String getTipoMovimento() { return tipoMovimento; }
    public void setTipoMovimento(String tipoMovimento) { this.tipoMovimento = tipoMovimento; }
    public String getMotivo() { return motivo; }
    public void setMotivo(String motivo) { this.motivo = motivo; }
    public String getObservacao() { return observacao; }
    public void setObservacao(String observacao) { this.observacao = observacao; }
    public LocalDateTime getDataMovimento() { return dataMovimento; }
    public void setDataMovimento(LocalDateTime dataMovimento) { this.dataMovimento = dataMovimento; }
    public Integer getEntradasNoPeriodo() { return entradasNoPeriodo; }
    public void setEntradasNoPeriodo(Integer entradasNoPeriodo) { this.entradasNoPeriodo = entradasNoPeriodo; }
    public Integer getSaidasNoPeriodo() { return saidasNoPeriodo; }
    public void setSaidasNoPeriodo(Integer saidasNoPeriodo) { this.saidasNoPeriodo = saidasNoPeriodo; }
    public Integer getEstoqueInicialNoPeriodo() { return estoqueInicialNoPeriodo; }
    public void setEstoqueInicialNoPeriodo(Integer estoqueInicialNoPeriodo) { this.estoqueInicialNoPeriodo = estoqueInicialNoPeriodo; }
}