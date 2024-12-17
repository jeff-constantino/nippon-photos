package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalTime;

public class ModelFuncionario implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;
    private String nome;

    private LocalTime atrasos;
    private int faltas;
    private int advertencias;
    private int suspensoes;

    private int total_fotos;
    private int total_encartes;
    private int total_digitais;
    private int total_sobras;

    private BigDecimal vendas_fotos;
    private BigDecimal vendas_encartes;
    private BigDecimal vendas_digitais;
    private BigDecimal vendas_total;

    private BigDecimal vales;
    private BigDecimal descontos;
    private BigDecimal inss;
    private BigDecimal fgts;
    private BigDecimal total_salario;

}
