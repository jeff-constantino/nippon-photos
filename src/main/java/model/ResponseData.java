package model;

import model.ModelContas;

import java.util.List;

public class ResponseData {
    private List<ModelContas> todasContas;
    private int totalPaginas;

    public ResponseData(List<ModelContas> todasContas, int totalPaginas) {
        this.todasContas = todasContas;
        this.totalPaginas = totalPaginas;
    }

    public List<ModelContas> getTodasContas() {
        return todasContas;
    }

    public int getTotalPaginas() {
        return totalPaginas;
    }
}