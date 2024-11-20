package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class ModelConfDiario implements Serializable {
    private long id;
    private BigDecimal valor_din;
    private BigDecimal valor_din_real;
    private BigDecimal valor_din_dif;
    private BigDecimal valor_deb;
    private BigDecimal valor_deb_real;
    private BigDecimal valor_deb_dif;
    private BigDecimal valor_cred;
    private BigDecimal valor_cred_real;
    private BigDecimal valor_cred_dif;
    private BigDecimal valor_pix;
    private BigDecimal valor_pix_real;
    private BigDecimal valor_pix_dif;
    private BigDecimal valor_despesa_total;
    private BigDecimal valor_vale_total;
    private BigDecimal valor_descontos;
    private BigDecimal valor_total_dia;
    private String observacao;

}
