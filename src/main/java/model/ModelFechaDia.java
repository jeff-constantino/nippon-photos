package model;
import java.io.Serializable;
import java.sql.Date;
public class ModelFechaDia implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;

    private Date data_fechamento;

    private int total_ft_din;
    private int total_ft_deb;
    private int total_ft_cred;
    private int total_ft_pix;

    private int total_enc_din;
    private int total_enc_deb;
    private int total_enc_cred;
    private int total_enc_pix;

    private int total_dig_din;
    private int total_dig_deb;
    private int total_dig_cred;
    private int total_dig_pix;

    private int total_ribbon_1;
    private int total_ribbon_2;
    private int total_ribbon_3;
    private int total_ribbon_4;
    private int total_ribbon_5;

    private double desconto;

    private String observacao;




}
