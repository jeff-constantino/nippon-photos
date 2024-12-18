package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

public class ModelFuncionario implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;
    private String nome;
    private LocalDate data_fecha_mes;

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

    private BigDecimal vales_mes;
    private BigDecimal descontos_mes;
    private BigDecimal inss_mes;
    private BigDecimal fgts_mes;
    private BigDecimal salario_bruto;
    private BigDecimal salario_liquido;

}
