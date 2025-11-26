package dao;

import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelConfig;
import model.ModelConfiguracao;

public class DAOConfiguracao {
    private final Connection connection;

    public DAOConfiguracao() {
        connection = SingleConnectionBanco.getConnection();
    }

    public ModelConfiguracao gravarConfig(ModelConfiguracao model) throws SQLException {
        try {
            String sql;

            if (model.getIdconf() == null) {
                sql = "INSERT INTO conf_salarios (salario, comissao, fgts, comissao2) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getComissao());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getComissao2());
                    stmt.executeUpdate();

                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            model.setIdconf(rs.getLong(1));
                        }
                    }
                }
            } else {
                sql = "UPDATE conf_salarios SET salario=?, comissao=?, fgts=?, comissao2=? WHERE idconf =?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getComissao());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getComissao2());
                    stmt.setLong(5, model.getIdconf());
                    stmt.executeUpdate();
                }
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }

        return model;
    }
    public void gravarIrrf(ModelConfiguracao model) throws SQLException {
        try {
            // Lógica para a Faixa 1
            gravarFaixaIrrf(model.getId_irrf_1(), model.getIrrf_1(), model.getParcela_irrf_1(), model.getMin_irrf_1(), model.getMax_irrf_1());

            // Lógica para a Faixa 2
            gravarFaixaIrrf(model.getId_irrf_2(), model.getIrrf_2(), model.getParcela_irrf_2(), model.getMin_irrf_2(), model.getMax_irrf_2());

            // Lógica para a Faixa 3
            gravarFaixaIrrf(model.getId_irrf_3(), model.getIrrf_3(), model.getParcela_irrf_3(), model.getMin_irrf_3(), model.getMax_irrf_3());

            // Lógica para a Faixa 4
            gravarFaixaIrrf(model.getId_irrf_4(), model.getIrrf_4(), model.getParcela_irrf_4(), model.getMin_irrf_4(), model.getMax_irrf_4());

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }

    // Crie este método auxiliar para evitar repetição de código
    private void gravarFaixaIrrf(Long id, BigDecimal irrf, BigDecimal parcela, BigDecimal min, BigDecimal max) throws SQLException {
        String sql;

        if (id == null || id == 0) { // Verifica se é um novo registro
            sql = "INSERT INTO conf_irrf (irrf, parcela_irrf, min_salario, max_salario) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setBigDecimal(1, irrf);
                stmt.setBigDecimal(2, parcela);
                stmt.setBigDecimal(3, min);
                stmt.setBigDecimal(4, max);
                stmt.executeUpdate();
            }
        } else { // Atualiza um registro existente
            sql = "UPDATE conf_irrf SET irrf=?, parcela_irrf=?, min_salario=?, max_salario=? WHERE id_irrf = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setBigDecimal(1, irrf);
                stmt.setBigDecimal(2, parcela);
                stmt.setBigDecimal(3, min);
                stmt.setBigDecimal(4, max);
                stmt.setLong(5, id);
                stmt.executeUpdate();
            }
        }
    }
    public ModelConfiguracao buscarFaixasIrrf() throws SQLException {
        ModelConfiguracao model = new ModelConfiguracao();
        String sql = "SELECT id_irrf, irrf, parcela_irrf, min_salario, max_salario FROM conf_irrf ORDER BY min_salario";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            int i = 0;
            while (rs.next() && i < 4) {
                if (i == 0) {
                    model.setId_irrf_1(rs.getLong("id_irrf"));
                    model.setIrrf_1(rs.getBigDecimal("irrf"));
                    model.setParcela_irrf_1(rs.getBigDecimal("parcela_irrf"));
                    model.setMin_irrf_1(rs.getBigDecimal("min_salario"));
                    model.setMax_irrf_1(rs.getBigDecimal("max_salario"));
                } else if (i == 1) {
                    model.setId_irrf_2(rs.getLong("id_irrf"));
                    model.setIrrf_2(rs.getBigDecimal("irrf"));
                    model.setParcela_irrf_2(rs.getBigDecimal("parcela_irrf"));
                    model.setMin_irrf_2(rs.getBigDecimal("min_salario"));
                    model.setMax_irrf_2(rs.getBigDecimal("max_salario"));
                } else if (i == 2) {
                    model.setId_irrf_3(rs.getLong("id_irrf"));
                    model.setIrrf_3(rs.getBigDecimal("irrf"));
                    model.setParcela_irrf_3(rs.getBigDecimal("parcela_irrf"));
                    model.setMin_irrf_3(rs.getBigDecimal("min_salario"));
                    model.setMax_irrf_3(rs.getBigDecimal("max_salario"));
                } else if (i == 3) {
                    model.setId_irrf_4(rs.getLong("id_irrf"));
                    model.setIrrf_4(rs.getBigDecimal("irrf"));
                    model.setParcela_irrf_4(rs.getBigDecimal("parcela_irrf"));
                    model.setMin_irrf_4(rs.getBigDecimal("min_salario"));
                    model.setMax_irrf_4(rs.getBigDecimal("max_salario"));
                }
                i++;
            }
        }
        return model;
    }

    public ModelConfiguracao gravarConfigCartao(ModelConfiguracao model) throws SQLException {
        try {
            String sql;

            if (model.getIdconf() == null) {
                sql = "INSERT INTO conf_juros_cartao (deb_visa_master, cred_visa_master, deb_outros, cred_outros) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setBigDecimal(1, model.getDeb_visa_master());
                    stmt.setBigDecimal(2, model.getCred_visa_master());
                    stmt.setBigDecimal(3, model.getDeb_outros());
                    stmt.setBigDecimal(4, model.getCred_outros());
                    stmt.executeUpdate();

                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            model.setIdconf(rs.getLong(1));
                        }
                    }
                }
            } else {
                sql = "UPDATE conf_juros_cartao SET deb_visa_master=?, cred_visa_master=?, deb_outros=?, cred_outros=? WHERE idconf =?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setBigDecimal(1, model.getDeb_visa_master());
                    stmt.setBigDecimal(2, model.getCred_visa_master());
                    stmt.setBigDecimal(3, model.getDeb_outros());
                    stmt.setBigDecimal(4, model.getCred_outros());
                    stmt.setLong(5, model.getIdconf());
                    stmt.executeUpdate();
                }
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }

        return model;
    }


    public List<ModelConfiguracao> consultarSalarios() throws Exception {
        List<ModelConfiguracao> listaSalarios = new ArrayList<>();
        String sql = "SELECT * FROM public.conf_salarios"; // Certifique-se de que a tabela existe

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
                modelConfiguracao.setIdconf(resultSet.getLong("idconf"));
                modelConfiguracao.setSalario(resultSet.getBigDecimal("salario"));
                modelConfiguracao.setComissao(resultSet.getBigDecimal("comissao"));
                modelConfiguracao.setFgts(resultSet.getBigDecimal("fgts"));
                modelConfiguracao.setComissao2(resultSet.getBigDecimal("comissao2"));




                listaSalarios.add(modelConfiguracao);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage()); // Captura erros de SQL
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaSalarios;
    }

    public ModelConfiguracao buscarFaixasInss() throws Exception {
        ModelConfiguracao configInss = new ModelConfiguracao();

        String sql = "SELECT id_inss, inss, min_inss, max_inss, parcela FROM inss ORDER BY id_inss";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet rs = preparedSql.executeQuery()) {

            int faixa = 1;
            while (rs.next() && faixa <= 4) {
                Long id = rs.getLong("id_inss");
                BigDecimal inss = rs.getBigDecimal("inss");
                BigDecimal min = rs.getBigDecimal("min_inss");
                BigDecimal max = rs.getBigDecimal("max_inss");
                BigDecimal parcela = rs.getBigDecimal("parcela");

                switch (faixa) {
                    case 1:
                        configInss.setId_inss_1(id);
                        configInss.setInss_1(inss);
                        configInss.setMin_inss_1(min);
                        configInss.setMax_inss_1(max);
                        configInss.setParcela_1(parcela);
                        break;
                    case 2:
                        configInss.setId_inss_2(id);
                        configInss.setInss_2(inss);
                        configInss.setMin_inss_2(min);
                        configInss.setMax_inss_2(max);
                        configInss.setParcela_2(parcela);
                        break;
                    case 3:
                        configInss.setId_inss_3(id);
                        configInss.setInss_3(inss);
                        configInss.setMin_inss_3(min);
                        configInss.setMax_inss_3(max);
                        configInss.setParcela_3(parcela);
                        break;
                    case 4:
                        configInss.setId_inss_4(id);
                        configInss.setInss_4(inss);
                        configInss.setMin_inss_4(min);
                        configInss.setMax_inss_4(max);
                        configInss.setParcela_4(parcela);
                        break;
                }

                faixa++;
            }
        }



        return configInss;
    }
    public void salvarOuAtualizarFaixaInss(Long id, BigDecimal inss, BigDecimal min, BigDecimal max, BigDecimal parcela) throws SQLException {
        String sql;
        boolean isUpdate = (id != null && id > 0);

        if (isUpdate) {
            sql = "UPDATE inss SET inss = ?, min_inss = ?, max_inss = ?, parcela = ? WHERE id_inss = ?";
        } else {
            sql = "INSERT INTO inss (inss, min_inss, max_inss, parcela) VALUES (?, ?, ?, ?)";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBigDecimal(1, inss);
            ps.setBigDecimal(2, min);
            ps.setBigDecimal(3, max);
            ps.setBigDecimal(4, parcela);

            if (isUpdate) {
                ps.setLong(5, id);
            }

            ps.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        }
    }




    public List<ModelConfiguracao> consultarJuros() throws Exception {
        List<ModelConfiguracao> listaJuros = new ArrayList<>();
        String sql = "SELECT * FROM public.conf_juros_cartao"; // Certifique-se de que a tabela existe

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
                modelConfiguracao.setIdconf(resultSet.getLong("idconf"));

                // Divide os valores por 100 diretamente no Java
                BigDecimal debVisaMaster = resultSet.getBigDecimal("deb_visa_master").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
                BigDecimal credVisaMaster = resultSet.getBigDecimal("cred_visa_master").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
                BigDecimal debOutros = resultSet.getBigDecimal("deb_outros").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
                BigDecimal credOutros = resultSet.getBigDecimal("cred_outros").divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);

                modelConfiguracao.setDeb_visa_master(debVisaMaster);
                modelConfiguracao.setCred_visa_master(credVisaMaster);
                modelConfiguracao.setDeb_outros(debOutros);
                modelConfiguracao.setCred_outros(credOutros);

                listaJuros.add(modelConfiguracao);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage()); // Captura erros de SQL
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaJuros;
    }



}
