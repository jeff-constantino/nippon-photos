package model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;

public class ModelMedidasDisciplinares implements Serializable {

    private static final long serialVersionUID = 1L;

    private long id;
    private String nome;

    private LocalTime atrasos;

    private LocalDate data_falta;
    private LocalDate data_advertencia;
    private String adv_motivo;

    private LocalDate data_suspensao;
    private int susp_dias;
    private String susp_motivo;

}
