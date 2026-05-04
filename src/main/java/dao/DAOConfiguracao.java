package dao;

import connection.ConnectionPool;
import model.ModelConfiguracao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOConfiguracao {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAOConfiguracao(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAOConfiguracao() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    public void atualizarJurosCartao(ModelConfiguracao model) throws SQLException {
        try {
            String sql = "UPDATE conf_juros_cartao SET deb_visa_master=?, cred_visa_master=?, deb_outros=?, cred_outros=? WHERE idconf=?";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setBigDecimal(1, model.getDeb_visa_master());
                stmt.setBigDecimal(2, model.getCred_visa_master());
                stmt.setBigDecimal(3, model.getDeb_outros());
                stmt.setBigDecimal(4, model.getCred_outros());
                stmt.setLong(5, model.getIdconf());
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) throw new SQLException("Nenhum registro foi atualizado.");
                if (gerenciarTransacao) connection.commit();
            }
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public ModelConfiguracao gravarConfig(ModelConfiguracao model) throws SQLException {
        try {
            String sql;
            if (model.getIdconf() == null) {
                sql = "INSERT INTO conf_salarios (salario, clt, fgts, mei) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getClt());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getMei());
                    stmt.executeUpdate();
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) model.setIdconf(rs.getLong(1));
                    }
                }
            } else {
                sql = "UPDATE conf_salarios SET salario=?, clt=?, fgts=?, mei=? WHERE idconf =?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setBigDecimal(1, model.getSalario());
                    stmt.setBigDecimal(2, model.getClt());
                    stmt.setBigDecimal(3, model.getFgts());
                    stmt.setBigDecimal(4, model.getMei());
                    stmt.setLong(5, model.getIdconf());
                    stmt.executeUpdate();
                }
            }
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return model;
    }

    public void gravarIrrf(ModelConfiguracao model) throws SQLException {
        try {
            gravarFaixaIrrf(model.getId_irrf_1(), model.getIrrf_1(), model.getParcela_irrf_1(), model.getMin_irrf_1(), model.getMax_irrf_1());
            gravarFaixaIrrf(model.getId_irrf_2(), model.getIrrf_2(), model.getParcela_irrf_2(), model.getMin_irrf_2(), model.getMax_irrf_2());
            gravarFaixaIrrf(model.getId_irrf_3(), model.getIrrf_3(), model.getParcela_irrf_3(), model.getMin_irrf_3(), model.getMax_irrf_3());
            gravarFaixaIrrf(model.getId_irrf_4(), model.getIrrf_4(), model.getParcela_irrf_4(), model.getMin_irrf_4(), model.getMax_irrf_4());
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    private void gravarFaixaIrrf(Long id, BigDecimal irrf, BigDecimal parcela, BigDecimal min, BigDecimal max) throws SQLException {
        String sql;
        if (id == null || id == 0) {
            sql = "INSERT INTO conf_irrf (irrf, parcela_irrf, min_salario, max_salario) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setBigDecimal(1, irrf);
                stmt.setBigDecimal(2, parcela);
                stmt.setBigDecimal(3, min);
                stmt.setBigDecimal(4, max);
                stmt.executeUpdate();
            }
        } else {
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
        } finally {
            if (gerenciarTransacao) fecharConexao();
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
                        if (rs.next()) model.setIdconf(rs.getLong(1));
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
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return model;
    }

    public List<ModelConfiguracao> consultarSalarios() throws Exception {
        List<ModelConfiguracao> listaSalarios = new ArrayList<>();
        String sql = "SELECT * FROM public.conf_salarios";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {
            while (resultSet.next()) {
                ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
                modelConfiguracao.setIdconf(resultSet.getLong("idconf"));
                modelConfiguracao.setSalario(resultSet.getBigDecimal("salario"));
                modelConfiguracao.setClt(resultSet.getBigDecimal("clt"));
                modelConfiguracao.setFgts(resultSet.getBigDecimal("fgts"));
                modelConfiguracao.setMei(resultSet.getBigDecimal("mei"));
                listaSalarios.add(modelConfiguracao);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
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
        } finally {
            if (gerenciarTransacao) fecharConexao();
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
            if (isUpdate) ps.setLong(5, id);
            ps.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public List<ModelConfiguracao> consultarJuros() throws Exception {
        List<ModelConfiguracao> listaJuros = new ArrayList<>();
        String sql = "SELECT * FROM public.conf_juros_cartao";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {
            while (resultSet.next()) {
                ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
                modelConfiguracao.setIdconf(resultSet.getLong("idconf"));
                modelConfiguracao.setDeb_visa_master(resultSet.getBigDecimal("deb_visa_master"));
                modelConfiguracao.setCred_visa_master(resultSet.getBigDecimal("cred_visa_master"));
                modelConfiguracao.setDeb_outros(resultSet.getBigDecimal("deb_outros"));
                modelConfiguracao.setCred_outros(resultSet.getBigDecimal("cred_outros"));
                listaJuros.add(modelConfiguracao);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return listaJuros;
    }

    private void fecharConexao() {
        if (connection != null && gerenciarTransacao) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
}