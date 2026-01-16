package dao;

import connection.ConnectionPool;
import model.ModelConfDiario;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOConfDiario {

    private final Connection connection;
    private final boolean gerenciarTransacao;

    /**
     * Construtor NOVO - recebe conexão gerenciada pelo Filter
     * USO RECOMENDADO
     */
    public DAOConfDiario(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false; // Filter gerencia
    }

    /**
     * Construtor LEGADO - busca própria conexão
     * Mantido para compatibilidade temporária
     */
    public DAOConfDiario() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true; // DAO gerencia
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    public List<Date> buscarConfNaoFechadas() throws SQLException {
        List<Date> confNaoFechadas = new ArrayList<>();

        // Nova consulta para verificar se valor_din_real é NULL
        String sql = "SELECT DISTINCT f.data_fechamento " +
                "FROM conf_dia f " +
                "WHERE f.valor_din_real IS NULL " +
                "ORDER BY f.data_fechamento DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                confNaoFechadas.add(rs.getDate("data_fechamento"));
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar conferências não fechadas: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }

        return confNaoFechadas;
    }

    public boolean existeConferenciaParaData(Date dataFechamento) {
        String query = "SELECT COUNT(*) FROM conf_dia WHERE data_fechamento = ? AND valor_din_real IS NOT NULL";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, dataFechamento);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next() && resultSet.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }

        return false;
    }

    public void atualizarConfiguracao(ModelConfDiario confDiario) throws SQLException {
        String sqlConfDia = "UPDATE conf_dia SET " +
                "valor_din = ?, valor_din_real = ?, valor_din_dif = ?, " +
                "valor_deb = ?, valor_deb_real = ?, valor_deb_dif = ?, " +
                "valor_cred = ?, valor_cred_real = ?, valor_cred_dif = ?, " +
                "valor_pix = ?, valor_pix_real = ?, valor_pix_dif = ?, " +
                "valor_despesa_total = ?, valor_vale_total = ?, desconto = ?, " +
                "venda_total_dia = ?, observacao = UPPER(?), total_revelado = ?, total_informado = ?, " +
                "ribbon_1_atual = ?, ribbon_2_atual = ?, ribbon_3_atual = ?, " +
                "ribbon_4_atual = ?, ribbon_5_atual = ?, ribbon_6_atual = ?, sobras = ?, dif_ribbon_1 = ?, dif_ribbon_2 = ?, " +
                "dif_ribbon_3 = ?, dif_ribbon_4 = ?, dif_ribbon_5 = ?, dif_ribbon_6 = ?, " +
                "old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, old_ribbon_4 = ?, old_ribbon_5 = ?, old_ribbon_6 = ?, " +
                "rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, rev_ribbon_4 = ?, rev_ribbon_5 = ?, rev_ribbon_6 = ?, " +
                "total_dif = ?, observacao_ribbon = UPPER(?) " +
                "WHERE data_fechamento = ? ";

        String sqlControleRibbon = "UPDATE controle_ribbon SET " +
                "observacao_ribbon = UPPER(?), total_dif = ?, ribbon_1_atual = ?, ribbon_2_atual = ?, ribbon_3_atual = ?," +
                "ribbon_4_atual = ?, ribbon_5_atual = ?, ribbon_6_atual = ?, sobras = ?," +
                "dif_ribbon_1 = ?, dif_ribbon_2 = ?, dif_ribbon_3 = ?, dif_ribbon_4 = ?, dif_ribbon_5 = ?, dif_ribbon_6 = ?," +
                "old_ribbon_1 = ?, old_ribbon_2 = ?, old_ribbon_3 = ?, old_ribbon_4 = ?, old_ribbon_5 = ?, old_ribbon_6 = ?," +
                "rev_ribbon_1 = ?, rev_ribbon_2 = ?, rev_ribbon_3 = ?, rev_ribbon_4 = ?, rev_ribbon_5 = ?, rev_ribbon_6 = ? " +
                "WHERE data_ribbon = ? ";

        try (PreparedStatement psConfDia = connection.prepareStatement(sqlConfDia);
             PreparedStatement psControleRibbon = connection.prepareStatement(sqlControleRibbon)) {

            // Configuração para conf_dia
            psConfDia.setBigDecimal(1, confDiario.getValor_din());
            psConfDia.setBigDecimal(2, confDiario.getValor_din_real());
            psConfDia.setBigDecimal(3, confDiario.getValor_din_dif());
            psConfDia.setBigDecimal(4, confDiario.getValor_deb());
            psConfDia.setBigDecimal(5, confDiario.getValor_deb_real());
            psConfDia.setBigDecimal(6, confDiario.getValor_deb_dif());
            psConfDia.setBigDecimal(7, confDiario.getValor_cred());
            psConfDia.setBigDecimal(8, confDiario.getValor_cred_real());
            psConfDia.setBigDecimal(9, confDiario.getValor_cred_dif());
            psConfDia.setBigDecimal(10, confDiario.getValor_pix());
            psConfDia.setBigDecimal(11, confDiario.getValor_pix_real());
            psConfDia.setBigDecimal(12, confDiario.getValor_pix_dif());
            psConfDia.setBigDecimal(13, confDiario.getValor_despesa_total());

            psConfDia.setBigDecimal(14, confDiario.getValor_vale_total());
            psConfDia.setBigDecimal(15, confDiario.getDesconto());
            psConfDia.setBigDecimal(16, confDiario.getVenda_total_dia());
            psConfDia.setString(17, confDiario.getObservacao());
            psConfDia.setInt(18, confDiario.getTotal_revelado());
            psConfDia.setInt(19, confDiario.getTotal_informado());

            psConfDia.setInt(20, confDiario.getRibbon_1_atual());
            psConfDia.setInt(21, confDiario.getRibbon_2_atual());
            psConfDia.setInt(22, confDiario.getRibbon_3_atual());
            psConfDia.setInt(23, confDiario.getRibbon_4_atual());
            psConfDia.setInt(24, confDiario.getRibbon_5_atual());
            psConfDia.setInt(25, confDiario.getRibbon_6_atual());
            psConfDia.setInt(26, confDiario.getSobras());
            psConfDia.setInt(27, confDiario.getDif_ribbon_1());
            psConfDia.setInt(28, confDiario.getDif_ribbon_2());
            psConfDia.setInt(29, confDiario.getDif_ribbon_3());
            psConfDia.setInt(30, confDiario.getDif_ribbon_4());
            psConfDia.setInt(31, confDiario.getDif_ribbon_5());
            psConfDia.setInt(32, confDiario.getDif_ribbon_6());
            psConfDia.setInt(33, confDiario.getOld_ribbon_1());
            psConfDia.setInt(34, confDiario.getOld_ribbon_2());
            psConfDia.setInt(35, confDiario.getOld_ribbon_3());
            psConfDia.setInt(36, confDiario.getOld_ribbon_4());
            psConfDia.setInt(37, confDiario.getOld_ribbon_5());
            psConfDia.setInt(38, confDiario.getOld_ribbon_6());
            psConfDia.setInt(39, confDiario.getRev_ribbon_1());
            psConfDia.setInt(40, confDiario.getRev_ribbon_2());
            psConfDia.setInt(41, confDiario.getRev_ribbon_3());
            psConfDia.setInt(42, confDiario.getRev_ribbon_4());
            psConfDia.setInt(43, confDiario.getRev_ribbon_5());
            psConfDia.setInt(44, confDiario.getRev_ribbon_6());
            psConfDia.setInt(45, confDiario.getTotal_dif());
            psConfDia.setString(46, confDiario.getObservacao_ribbon());
            psConfDia.setDate(47, Date.valueOf(confDiario.getData_fechamento()));

            psConfDia.executeUpdate();

            // Configuração para controle_ribbon
            psControleRibbon.setString(1, confDiario.getObservacao_ribbon());
            psControleRibbon.setInt(2, confDiario.getTotal_dif());
            psControleRibbon.setInt(3, confDiario.getRibbon_1_atual());
            psControleRibbon.setInt(4, confDiario.getRibbon_2_atual());
            psControleRibbon.setInt(5, confDiario.getRibbon_3_atual());
            psControleRibbon.setInt(6, confDiario.getRibbon_4_atual());
            psControleRibbon.setInt(7, confDiario.getRibbon_5_atual());
            psControleRibbon.setInt(8, confDiario.getRibbon_6_atual());
            psControleRibbon.setInt(9, confDiario.getSobras());
            psControleRibbon.setInt(10, confDiario.getDif_ribbon_1());
            psControleRibbon.setInt(11, confDiario.getDif_ribbon_2());
            psControleRibbon.setInt(12, confDiario.getDif_ribbon_3());
            psControleRibbon.setInt(13, confDiario.getDif_ribbon_4());
            psControleRibbon.setInt(14, confDiario.getDif_ribbon_5());
            psControleRibbon.setInt(15, confDiario.getDif_ribbon_6());
            psControleRibbon.setInt(16, confDiario.getOld_ribbon_1());
            psControleRibbon.setInt(17, confDiario.getOld_ribbon_2());
            psControleRibbon.setInt(18, confDiario.getOld_ribbon_3());
            psControleRibbon.setInt(19, confDiario.getOld_ribbon_4());
            psControleRibbon.setInt(20, confDiario.getOld_ribbon_5());
            psControleRibbon.setInt(21, confDiario.getOld_ribbon_6());
            psControleRibbon.setInt(22, confDiario.getRev_ribbon_1());
            psControleRibbon.setInt(23, confDiario.getRev_ribbon_2());
            psControleRibbon.setInt(24, confDiario.getRev_ribbon_3());
            psControleRibbon.setInt(25, confDiario.getRev_ribbon_4());
            psControleRibbon.setInt(26, confDiario.getRev_ribbon_5());
            psControleRibbon.setInt(27, confDiario.getRev_ribbon_6());
            psControleRibbon.setDate(28, Date.valueOf(confDiario.getData_fechamento()));

            psControleRibbon.executeUpdate();

            // Commit apenas se DAO está gerenciando
            if (gerenciarTransacao) {
                connection.commit();
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new SQLException("Erro ao atualizar as tabelas conf_dia e controle_ribbon: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public ModelConfDiario buscarPorData(Date dataFechamento) throws SQLException {
        // Criando um objeto para armazenar os dados
        ModelConfDiario conf = null;

        try {
            // 1ª Consulta: Buscar dados da tabela conf_dia
            String sqlConfDia = "SELECT * FROM conf_dia WHERE data_fechamento = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlConfDia)) {
                stmt.setDate(1, new Date(dataFechamento.getTime()));

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        conf = new ModelConfDiario();

                        // Preenchendo os dados da tabela conf_dia
                        conf.setId(rs.getLong("id"));
                        conf.setValor_din(rs.getBigDecimal("valor_din"));
                        conf.setValor_din_real(rs.getBigDecimal("valor_din_real"));
                        conf.setValor_din_dif(rs.getBigDecimal("valor_din_dif"));
                        conf.setValor_deb(rs.getBigDecimal("valor_deb"));
                        conf.setValor_deb_real(rs.getBigDecimal("valor_deb_real"));
                        conf.setValor_deb_dif(rs.getBigDecimal("valor_deb_dif"));
                        conf.setValor_cred(rs.getBigDecimal("valor_cred"));
                        conf.setValor_cred_real(rs.getBigDecimal("valor_cred_real"));
                        conf.setValor_cred_dif(rs.getBigDecimal("valor_cred_dif"));
                        conf.setValor_pix(rs.getBigDecimal("valor_pix"));
                        conf.setValor_pix_real(rs.getBigDecimal("valor_pix_real"));
                        conf.setValor_pix_dif(rs.getBigDecimal("valor_pix_dif"));
                        conf.setDesconto(rs.getBigDecimal("desconto"));
                        conf.setVenda_total_dia(rs.getBigDecimal("venda_total_dia"));
                        conf.setObservacao(rs.getString("observacao"));
                        conf.setData_fechamento(rs.getDate("data_fechamento").toLocalDate());
                        conf.setTotal_revelado(rs.getInt("total_revelado"));
                        conf.setTotal_informado(rs.getInt("total_informado"));
                    }
                }
            }

            // 2ª Consulta: Buscar dados da tabela controle_ribbon
            String sqlControleRibbon = "SELECT * FROM controle_ribbon WHERE data_ribbon = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlControleRibbon)) {
                stmt.setDate(1, new Date(dataFechamento.getTime()));

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && conf != null) {
                        conf.setRibbon_1_atual(rs.getInt("ribbon_1_atual"));
                        conf.setRibbon_2_atual(rs.getInt("ribbon_2_atual"));
                        conf.setRibbon_3_atual(rs.getInt("ribbon_3_atual"));
                        conf.setRibbon_4_atual(rs.getInt("ribbon_4_atual"));
                        conf.setRibbon_5_atual(rs.getInt("ribbon_5_atual"));
                        conf.setRibbon_6_atual(rs.getInt("ribbon_6_atual"));
                        conf.setSobras(rs.getInt("sobras"));
                        conf.setDif_ribbon_1(rs.getInt("dif_ribbon_1"));
                        conf.setDif_ribbon_2(rs.getInt("dif_ribbon_2"));
                        conf.setDif_ribbon_3(rs.getInt("dif_ribbon_3"));
                        conf.setDif_ribbon_4(rs.getInt("dif_ribbon_4"));
                        conf.setDif_ribbon_5(rs.getInt("dif_ribbon_5"));
                        conf.setDif_ribbon_6(rs.getInt("dif_ribbon_6"));
                        conf.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
                        conf.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
                        conf.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
                        conf.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
                        conf.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
                        conf.setOld_ribbon_6(rs.getInt("old_ribbon_6"));
                        conf.setRev_ribbon_1(rs.getInt("rev_ribbon_1"));
                        conf.setRev_ribbon_2(rs.getInt("rev_ribbon_2"));
                        conf.setRev_ribbon_3(rs.getInt("rev_ribbon_3"));
                        conf.setRev_ribbon_4(rs.getInt("rev_ribbon_4"));
                        conf.setRev_ribbon_5(rs.getInt("rev_ribbon_5"));
                        conf.setRev_ribbon_6(rs.getInt("rev_ribbon_6"));
                        conf.setTotal_dif(rs.getInt("total_dif"));
                        conf.setObservacao_ribbon(rs.getString("observacao_ribbon"));
                    }
                }
            }

            // 3ª Consulta: Buscar soma das despesas para o mesmo dia
            String sqlDespesa = "SELECT SUM(valor_despesa) AS valor_despesa_total FROM despesas WHERE data_despesa = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlDespesa)) {
                stmt.setDate(1, new Date(dataFechamento.getTime()));

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && conf != null) {
                        BigDecimal valorDespesaTotal = rs.getBigDecimal("valor_despesa_total");
                        conf.setValor_despesa_total(valorDespesaTotal == null ? BigDecimal.ZERO : valorDespesaTotal);
                    }
                }
            }

            // Consulta: Buscar soma das despesas para o mesmo dia em dinheiro
            String sqlDespesaDin = "SELECT SUM(valor_despesa) AS valor_despesa_din FROM despesas WHERE data_despesa = ? AND pagamento_despesa = 'DINHEIRO'";
            try (PreparedStatement stmt = connection.prepareStatement(sqlDespesaDin)) {
                stmt.setDate(1, new Date(dataFechamento.getTime()));

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && conf != null) {
                        BigDecimal valorDespesaDin = rs.getBigDecimal("valor_despesa_din");
                        conf.setValor_despesa_din(valorDespesaDin == null ? BigDecimal.ZERO : valorDespesaDin);
                    }
                }
            }

            // 4ª Consulta: Buscar soma dos vales para o mesmo dia
            String sqlVale = "SELECT SUM(valor) AS valor_vale_total FROM vales WHERE data = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlVale)) {
                stmt.setDate(1, new Date(dataFechamento.getTime()));

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && conf != null) {
                        BigDecimal valorValeTotal = rs.getBigDecimal("valor_vale_total");
                        conf.setValor_vale_total(valorValeTotal == null ? BigDecimal.ZERO : valorValeTotal);
                    }
                }
            }

        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar dados por data: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }

        return conf;
    }

    public ModelConfDiario buscarConferenciaPorData(Date dataFechamento) throws SQLException {
        // Criando um objeto para armazenar os dados
        ModelConfDiario conf = null;

        String sqlConfDia = "SELECT * FROM conf_dia WHERE data_fechamento = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sqlConfDia)) {
            stmt.setDate(1, new Date(dataFechamento.getTime()));

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    conf = new ModelConfDiario();

                    // Preenchendo os dados da tabela conf_dia
                    conf.setId(rs.getLong("id"));
                    conf.setValor_din(rs.getBigDecimal("valor_din"));
                    conf.setValor_din_real(rs.getBigDecimal("valor_din_real"));
                    conf.setValor_din_dif(rs.getBigDecimal("valor_din_dif"));
                    conf.setValor_deb(rs.getBigDecimal("valor_deb"));
                    conf.setValor_deb_real(rs.getBigDecimal("valor_deb_real"));
                    conf.setValor_deb_dif(rs.getBigDecimal("valor_deb_dif"));
                    conf.setValor_cred(rs.getBigDecimal("valor_cred"));
                    conf.setValor_cred_real(rs.getBigDecimal("valor_cred_real"));
                    conf.setValor_cred_dif(rs.getBigDecimal("valor_cred_dif"));
                    conf.setValor_pix(rs.getBigDecimal("valor_pix"));
                    conf.setValor_pix_real(rs.getBigDecimal("valor_pix_real"));
                    conf.setValor_pix_dif(rs.getBigDecimal("valor_pix_dif"));
                    conf.setValor_despesa_total(rs.getBigDecimal("valor_despesa_total"));
                    conf.setValor_vale_total(rs.getBigDecimal("valor_vale_total"));
                    conf.setDesconto(rs.getBigDecimal("desconto"));
                    conf.setVenda_total_dia(rs.getBigDecimal("venda_total_dia"));
                    conf.setObservacao(rs.getString("observacao"));
                    conf.setData_fechamento(rs.getDate("data_fechamento").toLocalDate());
                    conf.setTotal_revelado(rs.getInt("total_revelado"));
                    conf.setTotal_informado(rs.getInt("total_informado"));

                    conf.setRibbon_1_atual(rs.getInt("ribbon_1_atual"));
                    conf.setRibbon_2_atual(rs.getInt("ribbon_2_atual"));
                    conf.setRibbon_3_atual(rs.getInt("ribbon_3_atual"));
                    conf.setRibbon_4_atual(rs.getInt("ribbon_4_atual"));
                    conf.setRibbon_5_atual(rs.getInt("ribbon_5_atual"));
                    conf.setRibbon_6_atual(rs.getInt("ribbon_6_atual"));
                    conf.setSobras(rs.getInt("sobras"));
                    conf.setDif_ribbon_1(rs.getInt("dif_ribbon_1"));
                    conf.setDif_ribbon_2(rs.getInt("dif_ribbon_2"));
                    conf.setDif_ribbon_3(rs.getInt("dif_ribbon_3"));
                    conf.setDif_ribbon_4(rs.getInt("dif_ribbon_4"));
                    conf.setDif_ribbon_5(rs.getInt("dif_ribbon_5"));
                    conf.setDif_ribbon_6(rs.getInt("dif_ribbon_6"));
                    conf.setOld_ribbon_1(rs.getInt("old_ribbon_1"));
                    conf.setOld_ribbon_2(rs.getInt("old_ribbon_2"));
                    conf.setOld_ribbon_3(rs.getInt("old_ribbon_3"));
                    conf.setOld_ribbon_4(rs.getInt("old_ribbon_4"));
                    conf.setOld_ribbon_5(rs.getInt("old_ribbon_5"));
                    conf.setOld_ribbon_6(rs.getInt("old_ribbon_6"));
                    conf.setRev_ribbon_1(rs.getInt("rev_ribbon_1"));
                    conf.setRev_ribbon_2(rs.getInt("rev_ribbon_2"));
                    conf.setRev_ribbon_3(rs.getInt("rev_ribbon_3"));
                    conf.setRev_ribbon_4(rs.getInt("rev_ribbon_4"));
                    conf.setRev_ribbon_5(rs.getInt("rev_ribbon_5"));
                    conf.setRev_ribbon_6(rs.getInt("rev_ribbon_6"));
                    conf.setTotal_dif(rs.getInt("total_dif"));
                    conf.setObservacao_ribbon(rs.getString("observacao_ribbon"));
                    conf.setValor_despesa_total(rs.getBigDecimal("valor_despesa_total"));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar conferência por data: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }

        return conf;
    }

    /**
     * Fecha a conexão (apenas quando DAO gerencia)
     */
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