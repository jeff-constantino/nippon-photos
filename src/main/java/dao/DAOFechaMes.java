package dao;

import connection.SingleConnectionBanco;
import model.ModelFechaDia;
import model.ModelFechaMes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DAOFechaMes {

    private Connection connection;

    public DAOFechaMes() {
        this.connection = SingleConnectionBanco.getConnection();
    }

    public List<ModelFechaMes> buscarFechamentoMensal(String dataInicial, String dataFinal) throws SQLException {
        List<ModelFechaMes> fechamentosDiarios = new ArrayList<>();

        // Converte as strings para LocalDate
        LocalDate dataInicio = LocalDate.parse(dataInicial);
        LocalDate dataFim = LocalDate.parse(dataFinal);

        String sql = "SELECT data_fechamento, " +
                "SUM(total_ft_din + total_ft_deb + total_ft_cred + total_ft_pix) AS total_ft, " +
                "SUM(total_enc_din + total_enc_deb + total_enc_cred + total_enc_pix) AS total_enc, " +
                "SUM(total_dig_din + total_dig_deb + total_dig_cred + total_dig_pix) AS total_dig, " +
                "SUM(sobras) AS total_sobras " +
                "FROM fecha_dia " +
                "WHERE data_fechamento >= ? AND data_fechamento <= ? " +
                "GROUP BY data_fechamento " +
                "ORDER BY data_fechamento";

        try (PreparedStatement pst = connection.prepareStatement(sql)) {
            pst.setDate(1, java.sql.Date.valueOf(dataInicio));
            pst.setDate(2, java.sql.Date.valueOf(dataFim));

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    ModelFechaMes fechaMes = new ModelFechaMes();
                    fechaMes.setData_fechamento(LocalDate.parse(rs.getString("data_fechamento")));
                    fechaMes.setTotal_ft(rs.getInt("total_ft"));
                    fechaMes.setTotal_enc(rs.getInt("total_enc"));
                    fechaMes.setTotal_dig(rs.getInt("total_dig"));
                    fechaMes.setTotal_sobras(rs.getInt("total_sobras"));
                    fechamentosDiarios.add(fechaMes);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao executar a consulta: " + e.getMessage());
            throw e;
        }

        return fechamentosDiarios;
    }
}

