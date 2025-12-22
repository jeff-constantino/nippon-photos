package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelAssociado implements Serializable {
    private static final long serialVersionUID = 1L;

    // ========== DADOS DO FUNCIONÁRIO ==========
    private Long id;
    private String nome;
    private String email;
    private String login;
    private String senha;
    private String status;
    private String rg;
    private String cpf;
    private String pis;
    private String telefone;
    private String endereco;
    private String fotouser;
    private String extensaofotouser;
    private long id_funcionario;
    private String comissao;
    private String vendas;
    private String vales;

    // ========== DADOS DA VENDA ==========
    private Long venda_id;
    private Long vendedor_id;
    private Date data_venda;

    // Produto 1 - Fotos
    private int prod1_din;
    private int prod1_deb;
    private int prod1_cred;
    private int prod1_pix;

    // Produto 2 - Encartes
    private int prod2_din;
    private int prod2_deb;
    private int prod2_cred;
    private int prod2_pix;

    // Produto 3 - Digitais
    private int prod3_din;
    private int prod3_deb;
    private int prod3_cred;
    private int prod3_pix;

    // Totais e extras
    private int ft_total;
    private int enc_total;
    private int sobras;
    private int sobras_extras;  // Sobras após atingir limite (sem custo)
    private String ribbon;
    private int ribbon_dif;
    private int ribbon_descontar;
    private int totalFotosVendidas;
    private int totalProducao;
    private int diasTrabalhados;

    // ========== DADOS DE CONFIGURAÇÃO ==========
    private Long idconf;

    // Configuração Produtos
    private String conf1_nome;
    private String conf1_valor;
    private String conf2_nome;
    private String conf2_valor;
    private String conf3_nome;
    private String conf3_valor;

    // Configuração Materiais
    private String mat1_nome;
    private String mat1_valor;
    private Integer mat1_qtd;
    private String mat1_custo;

    private String mat2_nome;
    private String mat2_valor;
    private Integer mat2_qtd;
    private String mat2_custo;

    private String mat3_nome;
    private String mat3_valor;
    private Integer mat3_qtd;
    private String mat3_custo;

    // Configurações Financeiras
    private Integer limite;
    private String percentual_extras;

    // ========== DADOS FINANCEIROS ==========
    private Long id_financeiro;
    private Integer mes_referencia;
    private Integer ano_referencia;

    // Quantidades
    private Integer total_fotos;
    private Integer total_sobras;
    private Integer total_encartes;
    private Integer dig_total;
    private Integer fotos_extras;
    private Integer encartes_extras;

    // Custos
    private String custo_fotos_sobras;
    private String custo_encartes;
    private String fgts;
    private String inss;
    private String parcela_inss;
    private String inss_desc;

    // Financeiro
    private String total_bruto;
    private String valor_extras;
    private String custos_fotos;
    private String restituir;
    private String saldo_liquido;

    // Auditoria
    private Long usuario_cad_id;

    // ========== CONSTRUTORES ==========
    public ModelAssociado() {
        // Construtor padrão
    }

    // ========== MÉTODOS DE UTILIDADE ==========
    public Boolean isNovo() {
        return this.id == null || this.id == 0;
    }

    public Boolean novaVenda() {
        return this.venda_id == null || this.venda_id == 0;
    }

    // ========== GETTERS E SETTERS - FUNCIONÁRIO ==========
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public long getId_funcionario() {
        return id_funcionario;
    }

    public void setId_funcionario(long id_funcionario) {
        this.id_funcionario = id_funcionario;
    }

    public String getComissao() {
        return comissao;
    }

    public void setComissao(String comissao) {
        this.comissao = comissao;
    }

    public String getVendas() {
        return vendas;
    }

    public void setVendas(String vendas) {
        this.vendas = vendas;
    }

    public String getVales() {
        return vales;
    }

    public void setVales(String vales) {
        this.vales = vales;
    }

    // ========== GETTERS E SETTERS - VENDA ==========
    public Long getVenda_id() {
        return venda_id;
    }

    public void setVenda_id(Long venda_id) {
        this.venda_id = venda_id;
    }

    public Long getVendedor_id() {
        return vendedor_id;
    }

    public void setVendedor_id(Long vendedor_id) {
        this.vendedor_id = vendedor_id;
    }

    public void setVendedor_id(String vendedorIdStr) throws Exception {
        if (vendedorIdStr != null && !vendedorIdStr.isEmpty()) {
            try {
                this.vendedor_id = Long.parseLong(vendedorIdStr);
            } catch (NumberFormatException e) {
                throw new Exception("ID do vendedor inválido: " + vendedorIdStr);
            }
        } else {
            this.vendedor_id = null;
        }
    }

    public Date getData_venda() {
        return data_venda;
    }

    public void setData_venda(Date data_venda) {
        this.data_venda = data_venda;
    }

    // Produto 1
    public int getProd1_din() {
        return prod1_din;
    }

    public void setProd1_din(int prod1_din) {
        this.prod1_din = prod1_din;
    }

    public int getProd1_deb() {
        return prod1_deb;
    }

    public void setProd1_deb(int prod1_deb) {
        this.prod1_deb = prod1_deb;
    }

    public int getProd1_cred() {
        return prod1_cred;
    }

    public void setProd1_cred(int prod1_cred) {
        this.prod1_cred = prod1_cred;
    }

    public int getProd1_pix() {
        return prod1_pix;
    }

    public void setProd1_pix(int prod1_pix) {
        this.prod1_pix = prod1_pix;
    }

    // Produto 2
    public int getProd2_din() {
        return prod2_din;
    }

    public void setProd2_din(int prod2_din) {
        this.prod2_din = prod2_din;
    }

    public int getProd2_deb() {
        return prod2_deb;
    }

    public void setProd2_deb(int prod2_deb) {
        this.prod2_deb = prod2_deb;
    }

    public int getProd2_cred() {
        return prod2_cred;
    }

    public void setProd2_cred(int prod2_cred) {
        this.prod2_cred = prod2_cred;
    }

    public int getProd2_pix() {
        return prod2_pix;
    }

    public void setProd2_pix(int prod2_pix) {
        this.prod2_pix = prod2_pix;
    }

    // Produto 3
    public int getProd3_din() {
        return prod3_din;
    }

    public void setProd3_din(int prod3_din) {
        this.prod3_din = prod3_din;
    }

    public int getProd3_deb() {
        return prod3_deb;
    }

    public void setProd3_deb(int prod3_deb) {
        this.prod3_deb = prod3_deb;
    }

    public int getProd3_cred() {
        return prod3_cred;
    }

    public void setProd3_cred(int prod3_cred) {
        this.prod3_cred = prod3_cred;
    }

    public int getProd3_pix() {
        return prod3_pix;
    }

    public void setProd3_pix(int prod3_pix) {
        this.prod3_pix = prod3_pix;
    }

    // Totais
    public int getFt_total() {
        return ft_total;
    }

    public void setFt_total(int ft_total) {
        this.ft_total = ft_total;
    }

    public int getEnc_total() {
        return enc_total;
    }

    public void setEnc_total(int enc_total) {
        this.enc_total = enc_total;
    }

    public int getSobras() {
        return sobras;
    }

    public void setSobras(int sobras) {
        this.sobras = sobras;
    }

    public int getSobras_extras() {
        return sobras_extras;
    }

    public void setSobras_extras(int sobras_extras) {
        this.sobras_extras = sobras_extras;
    }

    public String getRibbon() {
        return ribbon;
    }

    public void setRibbon(String ribbon) {
        this.ribbon = ribbon;
    }

    public int getRibbon_dif() {
        return ribbon_dif;
    }

    public void setRibbon_dif(int ribbon_dif) {
        this.ribbon_dif = ribbon_dif;
    }

    public int getRibbon_descontar() {
        return ribbon_descontar;
    }

    public void setRibbon_descontar(int ribbon_descontar) {
        this.ribbon_descontar = ribbon_descontar;
    }

    public int getTotalFotosVendidas() {
        return totalFotosVendidas;
    }

    public void setTotalFotosVendidas(int totalFotosVendidas) {
        this.totalFotosVendidas = totalFotosVendidas;
    }

    public int getTotalProducao() {
        return totalProducao;
    }

    public void setTotalProducao(int totalProducao) {
        this.totalProducao = totalProducao;
    }

    public int getDiasTrabalhados() {
        return diasTrabalhados;
    }

    public void setDiasTrabalhados(int diasTrabalhados) {
        this.diasTrabalhados = diasTrabalhados;
    }

    // ========== GETTERS E SETTERS - CONFIGURAÇÃO ==========
    public Long getIdconf() {
        return idconf;
    }

    public void setIdconf(Long idconf) {
        this.idconf = idconf;
    }

    // Produtos Config
    public String getConf1_nome() {
        return conf1_nome;
    }

    public void setConf1_nome(String conf1_nome) {
        this.conf1_nome = conf1_nome;
    }

    public String getConf1_valor() {
        return conf1_valor;
    }

    public void setConf1_valor(String conf1_valor) {
        this.conf1_valor = conf1_valor;
    }

    public String getConf2_nome() {
        return conf2_nome;
    }

    public void setConf2_nome(String conf2_nome) {
        this.conf2_nome = conf2_nome;
    }

    public String getConf2_valor() {
        return conf2_valor;
    }

    public void setConf2_valor(String conf2_valor) {
        this.conf2_valor = conf2_valor;
    }

    public String getConf3_nome() {
        return conf3_nome;
    }

    public void setConf3_nome(String conf3_nome) {
        this.conf3_nome = conf3_nome;
    }

    public String getConf3_valor() {
        return conf3_valor;
    }

    public void setConf3_valor(String conf3_valor) {
        this.conf3_valor = conf3_valor;
    }

    // Materiais Config
    public String getMat1_nome() {
        return mat1_nome;
    }

    public void setMat1_nome(String mat1_nome) {
        this.mat1_nome = mat1_nome;
    }

    public String getMat1_valor() {
        return mat1_valor;
    }

    public void setMat1_valor(String mat1_valor) {
        this.mat1_valor = mat1_valor;
    }

    public Integer getMat1_qtd() {
        return mat1_qtd;
    }

    public void setMat1_qtd(Integer mat1_qtd) {
        this.mat1_qtd = mat1_qtd;
    }

    public String getMat1_custo() {
        return mat1_custo;
    }

    public void setMat1_custo(String mat1_custo) {
        this.mat1_custo = mat1_custo;
    }

    public String getMat2_nome() {
        return mat2_nome;
    }

    public void setMat2_nome(String mat2_nome) {
        this.mat2_nome = mat2_nome;
    }

    public String getMat2_valor() {
        return mat2_valor;
    }

    public void setMat2_valor(String mat2_valor) {
        this.mat2_valor = mat2_valor;
    }

    public Integer getMat2_qtd() {
        return mat2_qtd;
    }

    public void setMat2_qtd(Integer mat2_qtd) {
        this.mat2_qtd = mat2_qtd;
    }

    public String getMat2_custo() {
        return mat2_custo;
    }

    public void setMat2_custo(String mat2_custo) {
        this.mat2_custo = mat2_custo;
    }

    public String getMat3_nome() {
        return mat3_nome;
    }

    public void setMat3_nome(String mat3_nome) {
        this.mat3_nome = mat3_nome;
    }

    public String getMat3_valor() {
        return mat3_valor;
    }

    public void setMat3_valor(String mat3_valor) {
        this.mat3_valor = mat3_valor;
    }

    public Integer getMat3_qtd() {
        return mat3_qtd;
    }

    public void setMat3_qtd(Integer mat3_qtd) {
        this.mat3_qtd = mat3_qtd;
    }

    public String getMat3_custo() {
        return mat3_custo;
    }

    public void setMat3_custo(String mat3_custo) {
        this.mat3_custo = mat3_custo;
    }

    public Integer getLimite() {
        return limite;
    }

    public void setLimite(Integer limite) {
        this.limite = limite;
    }

    public String getPercentual_extras() {
        return percentual_extras;
    }

    public void setPercentual_extras(String percentual_extras) {
        this.percentual_extras = percentual_extras;
    }

    // ========== GETTERS E SETTERS - FINANCEIRO ==========
    public Long getId_financeiro() {
        return id_financeiro;
    }

    public void setId_financeiro(Long id_financeiro) {
        this.id_financeiro = id_financeiro;
    }

    public Integer getMes_referencia() {
        return mes_referencia;
    }

    public void setMes_referencia(Integer mes_referencia) {
        this.mes_referencia = mes_referencia;
    }

    public Integer getAno_referencia() {
        return ano_referencia;
    }

    public void setAno_referencia(Integer ano_referencia) {
        this.ano_referencia = ano_referencia;
    }

    public Integer getTotal_fotos() {
        return total_fotos;
    }

    public void setTotal_fotos(Integer total_fotos) {
        this.total_fotos = total_fotos;
    }

    public Integer getTotal_sobras() {
        return total_sobras;
    }

    public void setTotal_sobras(Integer total_sobras) {
        this.total_sobras = total_sobras;
    }

    public Integer getTotal_encartes() {
        return total_encartes;
    }

    public void setTotal_encartes(Integer total_encartes) {
        this.total_encartes = total_encartes;
    }

    public Integer getDig_total() {
        return dig_total;
    }

    public void setDig_total(Integer dig_total) {
        this.dig_total = dig_total;
    }

    public Integer getFotos_extras() {
        return fotos_extras;
    }

    public void setFotos_extras(Integer fotos_extras) {
        this.fotos_extras = fotos_extras;
    }

    public Integer getEncartes_extras() {
        return encartes_extras;
    }

    public void setEncartes_extras(Integer encartes_extras) {
        this.encartes_extras = encartes_extras;
    }

    public String getCusto_fotos_sobras() {
        return custo_fotos_sobras;
    }

    public void setCusto_fotos_sobras(String custo_fotos_sobras) {
        this.custo_fotos_sobras = custo_fotos_sobras;
    }

    public String getCusto_encartes() {
        return custo_encartes;
    }

    public void setCusto_encartes(String custo_encartes) {
        this.custo_encartes = custo_encartes;
    }

    public String getFgts() {
        return fgts;
    }

    public void setFgts(String fgts) {
        this.fgts = fgts;
    }

    public String getInss() {
        return inss;
    }

    public void setInss(String inss) {
        this.inss = inss;
    }

    public String getParcela_inss() {
        return parcela_inss;
    }

    public void setParcela_inss(String parcela_inss) {
        this.parcela_inss = parcela_inss;
    }

    public String getInss_desc() {
        return inss_desc;
    }

    public void setInss_desc(String inss_desc) {
        this.inss_desc = inss_desc;
    }

    public String getTotal_bruto() {
        return total_bruto;
    }

    public void setTotal_bruto(String total_bruto) {
        this.total_bruto = total_bruto;
    }

    public String getValor_extras() {
        return valor_extras;
    }

    public void setValor_extras(String valor_extras) {
        this.valor_extras = valor_extras;
    }

    public String getCustos_fotos() {
        return custos_fotos;
    }

    public void setCustos_fotos(String custos_fotos) {
        this.custos_fotos = custos_fotos;
    }

    public String getRestituir() {
        return restituir;
    }

    public void setRestituir(String restituir) {
        this.restituir = restituir;
    }

    public String getSaldo_liquido() {
        return saldo_liquido;
    }

    public void setSaldo_liquido(String saldo_liquido) {
        this.saldo_liquido = saldo_liquido;
    }

    // ========== AUDITORIA ==========
    public Long getUsuario_cad_id() {
        return usuario_cad_id;
    }

    public void setUsuario_cad_id(Long usuario_cad_id) {
        this.usuario_cad_id = usuario_cad_id;
    }

    @Override
    public String toString() {
        return "ModelAssociado{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", venda_id=" + venda_id +
                ", vendedor_id=" + vendedor_id +
                ", data_venda=" + data_venda +
                ", idconf=" + idconf +
                ", id_financeiro=" + id_financeiro +
                ", mes_referencia=" + mes_referencia +
                ", ano_referencia=" + ano_referencia +
                '}';
    }
}