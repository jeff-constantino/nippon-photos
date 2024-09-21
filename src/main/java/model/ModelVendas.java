package model;

import java.io.Serializable;
import java.util.Objects;

public class ModelVendas implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String prod1_din;
    private String prod1_deb;
    private String prod1_cred;
    private String prod1_pix;

    private String prod2_din;
    private String prod2_deb;
    private String prod2_cred;
    private String prod2_pix;

    private String prod3_din;
    private String prod3_deb;
    private String prod3_cred;
    private String prod3_pix;


    private String sobras;

    private ModelLogin vendedor_pai_id;
    private ModelLogin usuario_cad_id;


    public String getProd1_din() {
        return prod1_din;
    }

    public void setProd1_din(String prod1_din) {
        this.prod1_din = prod1_din;
    }

    public String getProd1_deb() {
        return prod1_deb;
    }

    public void setProd1_deb(String prod1_deb) {
        this.prod1_deb = prod1_deb;
    }

    public String getProd1_cred() {
        return prod1_cred;
    }

    public void setProd1_cred(String prod1_cred) {
        this.prod1_cred = prod1_cred;
    }

    public String getProd1_pix() {
        return prod1_pix;
    }

    public void setProd1_pix(String prod1_pix) {
        this.prod1_pix = prod1_pix;
    }

    public String getProd2_din() {
        return prod2_din;
    }

    public void setProd2_din(String prod2_din) {
        this.prod2_din = prod2_din;
    }

    public String getProd2_deb() {
        return prod2_deb;
    }

    public void setProd2_deb(String prod2_deb) {
        this.prod2_deb = prod2_deb;
    }

    public String getProd2_cred() {
        return prod2_cred;
    }

    public void setProd2_cred(String prod2_cred) {
        this.prod2_cred = prod2_cred;
    }

    public String getProd2_pix() {
        return prod2_pix;
    }

    public void setProd2_pix(String prod2_pix) {
        this.prod2_pix = prod2_pix;
    }

    public String getProd3_din() {
        return prod3_din;
    }

    public void setProd3_din(String prod3_din) {
        this.prod3_din = prod3_din;
    }

    public String getProd3_deb() {
        return prod3_deb;
    }

    public void setProd3_deb(String prod3_deb) {
        this.prod3_deb = prod3_deb;
    }

    public String getProd3_cred() {
        return prod3_cred;
    }

    public void setProd3_cred(String prod3_cred) {
        this.prod3_cred = prod3_cred;
    }

    public String getProd3_pix() {
        return prod3_pix;
    }

    public void setProd3_pix(String prod3_pix) {
        this.prod3_pix = prod3_pix;
    }

    public String getSobras() {
        return sobras;
    }

    public void setSobras(String sobras) {
        this.sobras = sobras;
    }

    public ModelLogin getVendedor_pai_id() {
        return vendedor_pai_id;
    }

    public void setVendedor_pai_id(ModelLogin vendedor_pai_id) {
        this.vendedor_pai_id = vendedor_pai_id;
    }

    public ModelLogin getUsuario_cad_id() {
        return usuario_cad_id;
    }

    public void setUsuario_cad_id(ModelLogin usuario_cad_id) {
        this.usuario_cad_id = usuario_cad_id;
    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        ModelVendas other = (ModelVendas) obj;
        return Objects.equals(id, other.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
