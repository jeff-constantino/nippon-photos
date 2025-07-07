package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class ModelSalarios implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idSalario;
    private Long funcionarioId;
    private String nomeFuncionario;
    private int qtdFotos;
    private int qtdArquivos;

    //conduta
    private double atrasos;
    private  int faltas;
    private int advertencias; //contar quantidades
    private int suspensoes; // contar quantidades


    //financeiro

    private BigDecimal valorAtrasos; //calcular hora*tempo
    private BigDecimal valorFaltas;
    private BigDecimal valorSuspensoes;

    private int mes;
    private int ano;

}
