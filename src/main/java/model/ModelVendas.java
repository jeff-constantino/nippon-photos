package model;

import java.io.Serializable;
import java.sql.Date;

public class ModelVendas implements Serializable {
    private static final long serialVersionUID = 1L;


    private Long venda_id;
    private String nome;
    private int prod1_din;
    private int prod1_deb;
    private int prod1_cred;
    private int prod1_pix;

    private int prod2_din;
    private int prod2_deb;
    private int prod2_cred;
    private int prod2_pix;

    private int prod3_din;
    private int prod3_deb;
    private int prod3_cred;
    private int prod3_pix;


    private int sobras;

    private Date data_venda;

    private Long vendedor_id;


    private Long usuario_cad_id;

    private String ribbon;

    private int ft_total;

    private int enc_total;

    private int dig_total;

    private int totalFotosVendidas ;
    private int totalProducao;





    public ModelVendas() {
        // Construtor padrão
    }
public Boolean novaVenda(){
        if(this.venda_id==null){
            return true;
        } else if (this.venda_id != null && this.venda_id > 0) {
            return false;

        }
        return venda_id==null;
}



    public int getTotalProducao() {
        return totalProducao;
    }

    public void setTotalProducao(int totalProducao) {
        this.totalProducao = totalProducao;
    }

    public Long getVenda_id() {
        return venda_id;
    }

    public void setVenda_id(Long venda_id) {
        this.venda_id = venda_id;
    }

    public String getRibbon() {
        return ribbon;
    }

    public void setRibbon(String ribbon) {
        this.ribbon = ribbon;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Date getData_venda() {
        return data_venda;
    }

    public void setData_venda(Date data_venda) {
        this.data_venda = data_venda;
    }

    public int getTotalFotosVendidas() {
        return totalFotosVendidas;
    }

    public void setTotalFotosVendidas(int totalFotosVendidas) {
        this.totalFotosVendidas = totalFotosVendidas;
    }

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

    public int getSobras() {
        return sobras;
    }

    public void setSobras(int sobras) {
        this.sobras = sobras;
    }

    public Long getVendedor_id() {
        return vendedor_id;
    }

    // Método para setar vendedor_id
    public void setVendedor_id(String vendedorIdStr) throws Exception {
        if (vendedorIdStr != null && !vendedorIdStr.isEmpty()) {
            try {
                this.vendedor_id = Long.parseLong(vendedorIdStr);
            } catch (NumberFormatException e) {
                throw new Exception("ID do vendedor inválido: " + vendedorIdStr);
            }
        } else {
            this.vendedor_id = null; // Ou você pode decidir lançar uma exceção
        }
    }

    public Long getUsuario_cad_id() {
        return usuario_cad_id;
    }

    public void setUsuario_cad_id(Long usuario_cad_id) {
        this.usuario_cad_id = usuario_cad_id;
    }

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

    public int getDig_total() {
        return dig_total;
    }

    public void setDig_total(int dig_total) {
        this.dig_total = dig_total;
    }


    @Override
    public String toString() {
        return "ModelVendas{" +
                "venda_id=" + venda_id +
                ", nome='" + nome + '\'' +
                ", prod1_din=" + prod1_din +
                ", prod1_deb=" + prod1_deb +
                ", prod1_cred=" + prod1_cred +
                ", prod1_pix=" + prod1_pix +
                ", prod2_din=" + prod2_din +
                ", prod2_deb=" + prod2_deb +
                ", prod2_cred=" + prod2_cred +
                ", prod2_pix=" + prod2_pix +
                ", prod3_din=" + prod3_din +
                ", prod3_deb=" + prod3_deb +
                ", prod3_cred=" + prod3_cred +
                ", prod3_pix=" + prod3_pix +
                ", sobras=" + sobras +
                ", data_venda=" + data_venda +
                ", vendedor_id=" + vendedor_id +
                ", usuario_cad_id=" + usuario_cad_id +
                ", ribbon='" + ribbon + '\'' +
                ", ft_total=" + ft_total +
                ", enc_total=" + enc_total +
                ", dig_total=" + dig_total +
                ", totalFotosVendidas=" + totalFotosVendidas +
                '}';
    }
}