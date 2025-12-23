package dao;

import connection.SingleConnectionBanco;
import model.ModelAssociado;
import model.ModelLogin;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DAOAssociado {
    private final Connection connection;

    public DAOAssociado() {
        connection = SingleConnectionBanco.getConnection();
    }

    // ========== MÉTODOS DE VENDA ==========

    /**
     * Grava uma nova venda do associado
     */
    public ModelAssociado gravarVenda(ModelAssociado modelAssociado, Long userLogado) throws Exception {
        String sql = "INSERT INTO vendasassociado(vendedor_id, nome, prod1_din, prod1_deb, prod1_cred, prod1_pix, "
                + "prod2_din, prod2_deb, prod2_cred, prod2_pix, prod3_din, prod3_deb, prod3_cred, prod3_pix, "
                + "ft_total, enc_total, dig_total, sobras, sobras_extras, data_venda, ribbon, ribbon_dif, usuario_cad_id) "
                + "VALUES (?, UPPER(?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            connection.setAutoCommit(false);

            // Define os parâmetros
            preparedSql.setLong(1, modelAssociado.getVendedor_id());
            preparedSql.setString(2, modelAssociado.getNome());
            preparedSql.setInt(3, modelAssociado.getProd1_din());
            preparedSql.setInt(4, modelAssociado.getProd1_deb());
            preparedSql.setInt(5, modelAssociado.getProd1_cred());
            preparedSql.setInt(6, modelAssociado.getProd1_pix());

            preparedSql.setInt(7, modelAssociado.getProd2_din());
            preparedSql.setInt(8, modelAssociado.getProd2_deb());
            preparedSql.setInt(9, modelAssociado.getProd2_cred());
            preparedSql.setInt(10, modelAssociado.getProd2_pix());

            preparedSql.setInt(11, modelAssociado.getProd3_din());
            preparedSql.setInt(12, modelAssociado.getProd3_deb());
            preparedSql.setInt(13, modelAssociado.getProd3_cred());
            preparedSql.setInt(14, modelAssociado.getProd3_pix());

            // Calcula os totais
            int ft_total = modelAssociado.getProd1_din() + modelAssociado.getProd1_deb() +
                    modelAssociado.getProd1_cred() + modelAssociado.getProd1_pix();
            int enc_total = modelAssociado.getProd2_din() + modelAssociado.getProd2_deb() +
                    modelAssociado.getProd2_cred() + modelAssociado.getProd2_pix();
            int dig_total = modelAssociado.getProd3_din() + modelAssociado.getProd3_deb() +
                    modelAssociado.getProd3_cred() + modelAssociado.getProd3_pix();

            preparedSql.setInt(15, ft_total);
            preparedSql.setInt(16, enc_total);
            preparedSql.setInt(17, dig_total);
            preparedSql.setInt(18, modelAssociado.getSobras());
            preparedSql.setInt(19, modelAssociado.getSobras_extras());

            if (modelAssociado.getData_venda() == null) {
                throw new IllegalArgumentException("O parâmetro 'data_venda' não pode ser nulo.");
            }
            preparedSql.setDate(20, new java.sql.Date(modelAssociado.getData_venda().getTime()));

            preparedSql.setString(21, modelAssociado.getRibbon());
            preparedSql.setInt(22, modelAssociado.getRibbon_dif());
            preparedSql.setLong(23, userLogado);

            preparedSql.executeUpdate();

            // Recupera o ID gerado
            ResultSet generatedKeys = preparedSql.getGeneratedKeys();
            if (generatedKeys.next()) {
                long generatedId = generatedKeys.getLong(1);
                modelAssociado.setVenda_id(generatedId);
            } else {
                throw new SQLException("Falha ao obter o ID gerado.");
            }

            connection.commit();
            return this.consultaVenda(modelAssociado.getVenda_id(), userLogado);
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }
    }

    /**
     * Atualiza uma venda existente
     */
    public ModelAssociado atualizarVenda(Long venda_id, ModelAssociado modelAssociado, Long userLogado) throws Exception {
        String sql = "UPDATE vendasassociado SET nome = UPPER(?), vendedor_id = ?, prod1_din = ?, prod1_deb = ?, "
                + "prod1_cred = ?, prod1_pix = ?, prod2_din = ?, prod2_deb = ?, prod2_cred = ?, prod2_pix = ?, "
                + "prod3_din = ?, prod3_deb = ?, prod3_cred = ?, prod3_pix = ?, ft_total = ?, enc_total = ?, "
                + "dig_total = ?, data_venda = ?, sobras = ?, sobras_extras = ?, ribbon = ?, ribbon_dif = ?, "
                + "data_atualizacao = CURRENT_TIMESTAMP WHERE venda_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);

            statement.setString(1, modelAssociado.getNome());
            statement.setLong(2, modelAssociado.getVendedor_id());
            statement.setInt(3, modelAssociado.getProd1_din());
            statement.setInt(4, modelAssociado.getProd1_deb());
            statement.setInt(5, modelAssociado.getProd1_cred());
            statement.setInt(6, modelAssociado.getProd1_pix());

            statement.setInt(7, modelAssociado.getProd2_din());
            statement.setInt(8, modelAssociado.getProd2_deb());
            statement.setInt(9, modelAssociado.getProd2_cred());
            statement.setInt(10, modelAssociado.getProd2_pix());

            statement.setInt(11, modelAssociado.getProd3_din());
            statement.setInt(12, modelAssociado.getProd3_deb());
            statement.setInt(13, modelAssociado.getProd3_cred());
            statement.setInt(14, modelAssociado.getProd3_pix());

            // Calcula os totais
            int ft_total = modelAssociado.getProd1_din() + modelAssociado.getProd1_deb() +
                    modelAssociado.getProd1_cred() + modelAssociado.getProd1_pix();
            int enc_total = modelAssociado.getProd2_din() + modelAssociado.getProd2_deb() +
                    modelAssociado.getProd2_cred() + modelAssociado.getProd2_pix();
            int dig_total = modelAssociado.getProd3_din() + modelAssociado.getProd3_deb() +
                    modelAssociado.getProd3_cred() + modelAssociado.getProd3_pix();

            statement.setInt(15, ft_total);
            statement.setInt(16, enc_total);
            statement.setInt(17, dig_total);

            if (modelAssociado.getData_venda() == null) {
                throw new IllegalArgumentException("O parâmetro 'data_venda' não pode ser nulo.");
            }
            statement.setDate(18, new java.sql.Date(modelAssociado.getData_venda().getTime()));

            statement.setInt(19, modelAssociado.getSobras());
            statement.setInt(20, modelAssociado.getSobras_extras());
            statement.setString(21, modelAssociado.getRibbon());
            statement.setInt(22, modelAssociado.getRibbon_dif());
            statement.setLong(23, venda_id);

            statement.executeUpdate();
            connection.commit();
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }

        return this.consultaVenda(venda_id, userLogado);
    }

    /**
     * Consulta uma venda por ID
     */
    public ModelAssociado consultaVenda(Long venda_id, Long userLogado) throws Exception {
        if (venda_id == null) {
            throw new IllegalArgumentException("venda_id não pode ser nulo.");
        }

        ModelAssociado modelAssociado = null;
        String sql = "SELECT * FROM vendasassociado WHERE venda_id = ?";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setLong(1, venda_id);
            ResultSet resultado = preparedSql.executeQuery();

            if (resultado.next()) {
                modelAssociado = new ModelAssociado();
                modelAssociado.setVenda_id(resultado.getLong("venda_id"));
                modelAssociado.setVendedor_id(resultado.getLong("vendedor_id"));
                modelAssociado.setNome(resultado.getString("nome"));

                modelAssociado.setProd1_din(resultado.getInt("prod1_din"));
                modelAssociado.setProd1_deb(resultado.getInt("prod1_deb"));
                modelAssociado.setProd1_cred(resultado.getInt("prod1_cred"));
                modelAssociado.setProd1_pix(resultado.getInt("prod1_pix"));

                modelAssociado.setProd2_din(resultado.getInt("prod2_din"));
                modelAssociado.setProd2_deb(resultado.getInt("prod2_deb"));
                modelAssociado.setProd2_cred(resultado.getInt("prod2_cred"));
                modelAssociado.setProd2_pix(resultado.getInt("prod2_pix"));

                modelAssociado.setProd3_din(resultado.getInt("prod3_din"));
                modelAssociado.setProd3_deb(resultado.getInt("prod3_deb"));
                modelAssociado.setProd3_cred(resultado.getInt("prod3_cred"));
                modelAssociado.setProd3_pix(resultado.getInt("prod3_pix"));

                modelAssociado.setFt_total(resultado.getInt("ft_total"));
                modelAssociado.setEnc_total(resultado.getInt("enc_total"));

                modelAssociado.setSobras(resultado.getInt("sobras"));
                modelAssociado.setSobras_extras(resultado.getInt("sobras_extras"));
                modelAssociado.setRibbon(resultado.getString("ribbon"));
                modelAssociado.setRibbon_dif(resultado.getInt("ribbon_dif"));
                modelAssociado.setData_venda(resultado.getDate("data_venda"));
            }
        }

        return modelAssociado;
    }

    /**
     * Busca venda por ID (método alternativo)
     */
    public ModelAssociado buscarVendaPorId(Long idVenda) throws Exception {
        return consultaVenda(idVenda, null);
    }

    /**
     * Lista todas as vendas do dia mais recente
     */
    public List<ModelAssociado> vendaDia() throws Exception {
        List<ModelAssociado> lista = new ArrayList<>();
        String sqlData = "SELECT MAX(data_venda) AS ultima_data FROM vendasassociado";

        try (PreparedStatement preparedSqlData = connection.prepareStatement(sqlData);
             ResultSet resultadoData = preparedSqlData.executeQuery()) {

            if (resultadoData.next()) {
                Date ultimaData = resultadoData.getDate("ultima_data");

                if (ultimaData != null) {
                    String sql = "SELECT * FROM vendasassociado WHERE data_venda = ? ORDER BY venda_id DESC";
                    try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
                        preparedSql.setDate(1, ultimaData);
                        ResultSet resultado = preparedSql.executeQuery();

                        while (resultado.next()) {
                            ModelAssociado model = new ModelAssociado();
                            preencherModelVenda(model, resultado);
                            lista.add(model);
                        }
                    }
                }
            }
        }

        return lista;
    }

    /**
     * Lista vendas com filtros
     */
    public List<ModelAssociado> consultaVendasRel(String nomeFuncionario, String dataInicial, String dataFinal) throws Exception {
        List<ModelAssociado> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT v.* FROM vendasassociado v ")
                .append("INNER JOIN model_login l ON v.vendedor_id = l.id ")
                .append("WHERE UPPER(l.status) = 'ATIVO'");

        if (nomeFuncionario != null && !nomeFuncionario.isEmpty()) {
            sql.append(" AND UPPER(l.nome) LIKE UPPER(?)");
        }

        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN ? AND ?");
        }

        sql.append(" ORDER BY v.venda_id DESC");

        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;

            if (nomeFuncionario != null && !nomeFuncionario.isEmpty()) {
                preparedSql.setString(index++, "%" + nomeFuncionario + "%");
            }

            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            ResultSet resultado = preparedSql.executeQuery();
            while (resultado.next()) {
                ModelAssociado model = new ModelAssociado();
                preencherModelVenda(model, resultado);
                lista.add(model);
            }
        }

        return lista;
    }

    /**
     * Deleta uma venda
     */
    public void deleteVenda(long id) throws Exception {
        String sql = "DELETE FROM vendasassociado WHERE venda_id = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);
            preparedSql.setLong(1, id);
            preparedSql.executeUpdate();
            connection.commit();
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }
    }

    // ========== MÉTODOS DE CONFIGURAÇÃO ==========

    /**
     * Busca configuração por ID
     */
    public ModelAssociado buscarConfiguracaoPorId(Long idconf) throws Exception {
        String sql = "SELECT * FROM configassociado WHERE idconf = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, idconf);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return preencherModelConfig(rs);
                }
            }
        }
        return null;
    }

    /**
     * Salva ou atualiza configuração (sempre usa ID 1)
     */
    public ModelAssociado salvarConfiguracao(ModelAssociado config) throws Exception {
        // Verifica se já existe configuração com ID 1
        ModelAssociado configExistente = buscarConfiguracaoPorId(1L);

        if (configExistente == null) {
            // Se não existe, insere com ID 1
            config.setIdconf(1L);
            return inserirConfiguracao(config);
        } else {
            // Se existe, atualiza o ID 1
            config.setIdconf(1L);
            return atualizarConfiguracao(config);
        }
    }

    private ModelAssociado inserirConfiguracao(ModelAssociado config) throws Exception {
        String sql = "INSERT INTO configassociado (idconf, conf1_nome, conf1_valor, conf2_nome, conf2_valor, "
                + "conf3_nome, conf3_valor, mat1_nome, mat1_valor, mat1_qtd, mat1_custo, mat2_nome, mat2_valor, "
                + "mat2_qtd, mat2_custo, mat3_nome, mat3_valor, mat3_qtd, mat3_custo, limite, percentual_extras) "
                + "VALUES (1, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);

            // Produtos (obrigatórios)
            ps.setString(1, config.getConf1_nome());
            if (config.getConf1_valor() != null && !config.getConf1_valor().isEmpty()) {
                ps.setBigDecimal(2, new java.math.BigDecimal(config.getConf1_valor()));
            } else {
                ps.setBigDecimal(2, java.math.BigDecimal.ZERO);
            }

            ps.setString(3, config.getConf2_nome());
            if (config.getConf2_valor() != null && !config.getConf2_valor().isEmpty()) {
                ps.setBigDecimal(4, new java.math.BigDecimal(config.getConf2_valor()));
            } else {
                ps.setBigDecimal(4, java.math.BigDecimal.ZERO);
            }

            ps.setString(5, config.getConf3_nome());
            if (config.getConf3_valor() != null && !config.getConf3_valor().isEmpty()) {
                ps.setBigDecimal(6, new java.math.BigDecimal(config.getConf3_valor()));
            } else {
                ps.setBigDecimal(6, java.math.BigDecimal.ZERO);
            }

            // Material 1 (obrigatório)
            ps.setString(7, config.getMat1_nome() != null ? config.getMat1_nome() : "");
            if (config.getMat1_valor() != null && !config.getMat1_valor().isEmpty()) {
                ps.setBigDecimal(8, new java.math.BigDecimal(config.getMat1_valor()));
            } else {
                ps.setBigDecimal(8, java.math.BigDecimal.ZERO);
            }
            ps.setInt(9, config.getMat1_qtd() != null ? config.getMat1_qtd() : 0);
            if (config.getMat1_custo() != null && !config.getMat1_custo().isEmpty()) {
                ps.setBigDecimal(10, new java.math.BigDecimal(config.getMat1_custo()));
            } else {
                ps.setBigDecimal(10, java.math.BigDecimal.ZERO);
            }

            // Material 2 (opcional)
            ps.setString(11, config.getMat2_nome() != null ? config.getMat2_nome() : "");
            if (config.getMat2_valor() != null && !config.getMat2_valor().isEmpty()) {
                ps.setBigDecimal(12, new java.math.BigDecimal(config.getMat2_valor()));
            } else {
                ps.setNull(12, java.sql.Types.NUMERIC);
            }
            ps.setInt(13, config.getMat2_qtd() != null ? config.getMat2_qtd() : 0);
            if (config.getMat2_custo() != null && !config.getMat2_custo().isEmpty()) {
                ps.setBigDecimal(14, new java.math.BigDecimal(config.getMat2_custo()));
            } else {
                ps.setNull(14, java.sql.Types.NUMERIC);
            }

            // Material 3 (opcional)
            ps.setString(15, config.getMat3_nome() != null ? config.getMat3_nome() : "");
            if (config.getMat3_valor() != null && !config.getMat3_valor().isEmpty()) {
                ps.setBigDecimal(16, new java.math.BigDecimal(config.getMat3_valor()));
            } else {
                ps.setNull(16, java.sql.Types.NUMERIC);
            }
            ps.setInt(17, config.getMat3_qtd() != null ? config.getMat3_qtd() : 0);
            if (config.getMat3_custo() != null && !config.getMat3_custo().isEmpty()) {
                ps.setBigDecimal(18, new java.math.BigDecimal(config.getMat3_custo()));
            } else {
                ps.setNull(18, java.sql.Types.NUMERIC);
            }

            // Configurações Financeiras
            ps.setInt(19, config.getLimite() != null ? config.getLimite() : 0);
            if (config.getPercentual_extras() != null && !config.getPercentual_extras().isEmpty()) {
                ps.setBigDecimal(20, new java.math.BigDecimal(config.getPercentual_extras()));
            } else {
                ps.setBigDecimal(20, java.math.BigDecimal.ZERO);
            }

            ps.executeUpdate();
            config.setIdconf(1L);

            connection.commit();
            return config;
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }
    }

    private ModelAssociado atualizarConfiguracao(ModelAssociado config) throws Exception {
        String sql = "UPDATE configassociado SET conf1_nome = ?, conf1_valor = ?, conf2_nome = ?, "
                + "conf2_valor = ?, conf3_nome = ?, conf3_valor = ?, mat1_nome = ?, mat1_valor = ?, mat1_qtd = ?, "
                + "mat1_custo = ?, mat2_nome = ?, mat2_valor = ?, mat2_qtd = ?, mat2_custo = ?, mat3_nome = ?, "
                + "mat3_valor = ?, mat3_qtd = ?, mat3_custo = ?, limite = ?, percentual_extras = ?, "
                + "data_atualizacao = CURRENT_TIMESTAMP WHERE idconf = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);

            // Produtos (obrigatórios)
            ps.setString(1, config.getConf1_nome());
            if (config.getConf1_valor() != null && !config.getConf1_valor().isEmpty()) {
                ps.setBigDecimal(2, new java.math.BigDecimal(config.getConf1_valor()));
            } else {
                ps.setBigDecimal(2, java.math.BigDecimal.ZERO);
            }

            ps.setString(3, config.getConf2_nome());
            if (config.getConf2_valor() != null && !config.getConf2_valor().isEmpty()) {
                ps.setBigDecimal(4, new java.math.BigDecimal(config.getConf2_valor()));
            } else {
                ps.setBigDecimal(4, java.math.BigDecimal.ZERO);
            }

            ps.setString(5, config.getConf3_nome());
            if (config.getConf3_valor() != null && !config.getConf3_valor().isEmpty()) {
                ps.setBigDecimal(6, new java.math.BigDecimal(config.getConf3_valor()));
            } else {
                ps.setBigDecimal(6, java.math.BigDecimal.ZERO);
            }

            // Material 1 (obrigatório)
            ps.setString(7, config.getMat1_nome() != null ? config.getMat1_nome() : "");
            if (config.getMat1_valor() != null && !config.getMat1_valor().isEmpty()) {
                ps.setBigDecimal(8, new java.math.BigDecimal(config.getMat1_valor()));
            } else {
                ps.setBigDecimal(8, java.math.BigDecimal.ZERO);
            }
            ps.setInt(9, config.getMat1_qtd() != null ? config.getMat1_qtd() : 0);
            if (config.getMat1_custo() != null && !config.getMat1_custo().isEmpty()) {
                ps.setBigDecimal(10, new java.math.BigDecimal(config.getMat1_custo()));
            } else {
                ps.setBigDecimal(10, java.math.BigDecimal.ZERO);
            }

            // Material 2 (opcional)
            ps.setString(11, config.getMat2_nome() != null ? config.getMat2_nome() : "");
            if (config.getMat2_valor() != null && !config.getMat2_valor().isEmpty()) {
                ps.setBigDecimal(12, new java.math.BigDecimal(config.getMat2_valor()));
            } else {
                ps.setNull(12, java.sql.Types.NUMERIC);
            }
            ps.setInt(13, config.getMat2_qtd() != null ? config.getMat2_qtd() : 0);
            if (config.getMat2_custo() != null && !config.getMat2_custo().isEmpty()) {
                ps.setBigDecimal(14, new java.math.BigDecimal(config.getMat2_custo()));
            } else {
                ps.setNull(14, java.sql.Types.NUMERIC);
            }

            // Material 3 (opcional)
            ps.setString(15, config.getMat3_nome() != null ? config.getMat3_nome() : "");
            if (config.getMat3_valor() != null && !config.getMat3_valor().isEmpty()) {
                ps.setBigDecimal(16, new java.math.BigDecimal(config.getMat3_valor()));
            } else {
                ps.setNull(16, java.sql.Types.NUMERIC);
            }
            ps.setInt(17, config.getMat3_qtd() != null ? config.getMat3_qtd() : 0);
            if (config.getMat3_custo() != null && !config.getMat3_custo().isEmpty()) {
                ps.setBigDecimal(18, new java.math.BigDecimal(config.getMat3_custo()));
            } else {
                ps.setNull(18, java.sql.Types.NUMERIC);
            }

            // Configurações Financeiras
            ps.setInt(19, config.getLimite() != null ? config.getLimite() : 0);
            if (config.getPercentual_extras() != null && !config.getPercentual_extras().isEmpty()) {
                ps.setBigDecimal(20, new java.math.BigDecimal(config.getPercentual_extras()));
            } else {
                ps.setBigDecimal(20, java.math.BigDecimal.ZERO);
            }

            ps.setLong(21, config.getIdconf());

            ps.executeUpdate();
            connection.commit();
            return config;
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }
    }

    /**
     * Busca configuração por ID
     */
    public ModelAssociado buscarConfiguracao(Long idconf) throws Exception {
        String sql = "SELECT * FROM configassociado WHERE idconf = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, idconf);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return preencherModelConfig(rs);
            }
        }

        return null;
    }

    /**
     * Lista todas as configurações
     */
    public List<ModelAssociado> listarConfiguracoes() throws Exception {
        List<ModelAssociado> lista = new ArrayList<>();
        String sql = "SELECT * FROM configassociado ORDER BY idconf DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(preencherModelConfig(rs));
            }
        }

        return lista;
    }

    // ========== MÉTODOS FINANCEIROS ==========

    /**
     * Salva ou atualiza registro financeiro
     */
    public ModelAssociado salvarFinanceiro(ModelAssociado financeiro, Long userLogado) throws Exception {
        // Verifica se já existe registro para o mês/ano
        ModelAssociado existente = buscarFinanceiroPorPeriodo(
                financeiro.getMes_referencia(),
                financeiro.getAno_referencia()
        );

        if (existente != null) {
            financeiro.setId_financeiro(existente.getId_financeiro());
            return atualizarFinanceiro(financeiro);
        } else {
            return inserirFinanceiro(financeiro, userLogado);
        }
    }

    private ModelAssociado inserirFinanceiro(ModelAssociado fin, Long userLogado) throws Exception {
        String sql = "INSERT INTO financeiroassociado (mes_referencia, ano_referencia, total_fotos, total_sobras, "
                + "total_encartes, dig_total, fotos_extras, encartes_extras, custo_fotos_sobras, custo_encartes, fgts, inss, "
                + "total_bruto, total_vendas, valor_extras, custos_fotos, restituir, saldo_liquido, usuario_cad_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            connection.setAutoCommit(false);

            ps.setInt(1, fin.getMes_referencia());
            ps.setInt(2, fin.getAno_referencia());
            ps.setObject(3, fin.getTotal_fotos());
            ps.setObject(4, fin.getTotal_sobras());
            ps.setObject(5, fin.getTotal_encartes());
            ps.setObject(6, fin.getDig_total());
            ps.setObject(7, fin.getFotos_extras());
            ps.setObject(8, fin.getEncartes_extras());
            ps.setBigDecimal(9, fin.getCusto_fotos_sobras());
            ps.setBigDecimal(10, fin.getCusto_encartes());
            ps.setBigDecimal(11, fin.getFgts());
            ps.setBigDecimal(12, fin.getInss());
            ps.setBigDecimal(13, fin.getTotal_bruto());
            ps.setBigDecimal(14, fin.getTotal_vendas());
            ps.setBigDecimal(15, fin.getValor_extras());
            ps.setBigDecimal(16, fin.getCustos_fotos());
            ps.setBigDecimal(17, fin.getRestituir());
            ps.setBigDecimal(18, fin.getSaldo_liquido());
            ps.setLong(19, userLogado);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                fin.setId_financeiro(rs.getLong(1));
            }

            connection.commit();
            return fin;
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }
    }

    private ModelAssociado atualizarFinanceiro(ModelAssociado fin) throws Exception {
        String sql = "UPDATE financeiroassociado SET total_fotos = ?, total_sobras = ?, total_encartes = ?, "
                + "dig_total = ?, fotos_extras = ?, encartes_extras = ?, custo_fotos_sobras = ?, custo_encartes = ?, fgts = ?, "
                + "inss = ?, total_bruto = ?, total_vendas = ?, valor_extras = ?, "
                + "custos_fotos = ?, restituir = ?, saldo_liquido = ?, data_atualizacao = CURRENT_TIMESTAMP "
                + "WHERE id_financeiro = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false);

            ps.setObject(1, fin.getTotal_fotos());
            ps.setObject(2, fin.getTotal_sobras());
            ps.setObject(3, fin.getTotal_encartes());
            ps.setObject(4, fin.getDig_total());
            ps.setObject(5, fin.getFotos_extras());
            ps.setObject(6, fin.getEncartes_extras());
            ps.setBigDecimal(7, fin.getCusto_fotos_sobras());
            ps.setBigDecimal(8, fin.getCusto_encartes());
            ps.setBigDecimal(9, fin.getFgts());
            ps.setBigDecimal(10, fin.getInss());
            ps.setBigDecimal(11, fin.getTotal_bruto());
            ps.setBigDecimal(12, fin.getTotal_vendas());
            ps.setBigDecimal(13, fin.getValor_extras());
            ps.setBigDecimal(14, fin.getCustos_fotos());
            ps.setBigDecimal(15, fin.getRestituir());
            ps.setBigDecimal(16, fin.getSaldo_liquido());
            ps.setLong(17, fin.getId_financeiro());

            ps.executeUpdate();
            connection.commit();
            return fin;
        } catch (Exception e) {
            connection.rollback();
            throw e;
        }
    }

    /**
     * Busca financeiro por período
     */
    public ModelAssociado buscarFinanceiroPorPeriodo(Integer mes, Integer ano) throws Exception {
        String sql = "SELECT * FROM financeiroassociado WHERE mes_referencia = ? AND ano_referencia = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, mes);
            ps.setInt(2, ano);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return preencherModelFinanceiro(rs);
            }
        }

        return null;
    }

    /**
     * Lista todos os registros financeiros
     */
    public List<ModelAssociado> listarFinanceiros() throws Exception {
        List<ModelAssociado> lista = new ArrayList<>();
        String sql = "SELECT * FROM financeiroassociado ORDER BY ano_referencia DESC, mes_referencia DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(preencherModelFinanceiro(rs));
            }
        }

        return lista;
    }

    /**
     * Busca dados para relatório por período
     */
    public List<ModelAssociado> buscarDadosRelatorio(String dataInicial, String dataFinal) throws Exception {
        List<ModelAssociado> lista = new ArrayList<>();

        // Extrai mês e ano das datas
        String[] partesInicial = dataInicial.split("-");
        String[] partesFinal = dataFinal.split("-");

        int anoInicial = Integer.parseInt(partesInicial[0]);
        int mesInicial = Integer.parseInt(partesInicial[1]);
        int anoFinal = Integer.parseInt(partesFinal[0]);
        int mesFinal = Integer.parseInt(partesFinal[1]);

        String sql = "SELECT * FROM financeiroassociado " +
                "WHERE (ano_referencia > ? OR (ano_referencia = ? AND mes_referencia >= ?)) " +
                "AND (ano_referencia < ? OR (ano_referencia = ? AND mes_referencia <= ?)) " +
                "ORDER BY ano_referencia, mes_referencia";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, anoInicial);
            ps.setInt(2, anoInicial);
            ps.setInt(3, mesInicial);
            ps.setInt(4, anoFinal);
            ps.setInt(5, anoFinal);
            ps.setInt(6, mesFinal);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                lista.add(preencherModelFinanceiro(rs));
            }
        }

        return lista;
    }

    // ========== MÉTODOS AUXILIARES ==========

    /**
     * Busca funcionários ativos
     */
    public List<ModelLogin> buscaFuncionariosAtivos() throws Exception {
        List<ModelLogin> lista = new ArrayList<>();
        String sql = "SELECT id, nome FROM model_login WHERE UPPER(status) = 'ATIVO' ORDER BY nome";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ModelLogin funcionario = new ModelLogin();
                funcionario.setId(rs.getLong("id"));
                funcionario.setNome(rs.getString("nome"));
                lista.add(funcionario);
            }
        }

        return lista;
    }

    /**
     * Consulta funcionário por nome (AJAX)
     */
    public List<ModelLogin> consultaFuncionarioList(String nome) throws Exception {
        List<ModelLogin> retorno = new ArrayList<>();

        // Se nome estiver vazio ou null, busca todos os associados
        String sql;
        if (nome == null || nome.trim().isEmpty()) {
            sql = "SELECT * FROM model_login WHERE useradmin IS FALSE AND is_associado = TRUE ORDER BY nome";
        } else {
            sql = "SELECT * FROM model_login WHERE UPPER(nome) LIKE UPPER(?) "
                    + "AND useradmin IS FALSE AND is_associado = TRUE ORDER BY nome";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Só seta o parâmetro se nome não estiver vazio
            if (nome != null && !nome.trim().isEmpty()) {
                ps.setString(1, "%" + nome + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ModelLogin modelLogin = new ModelLogin();
                modelLogin.setId(rs.getLong("id"));
                modelLogin.setNome(rs.getString("nome"));
                retorno.add(modelLogin);
            }
        }

        return retorno;
    }

    /**
     * Busca os valores dos ribbons atuais para os campos do formulário
     */
    public List<java.math.BigDecimal> buscarRibbonAtual() throws Exception {
        List<java.math.BigDecimal> ribbonValues = new ArrayList<>();

        String sql = "SELECT ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, ribbon_4_atual, ribbon_5_atual, ribbon_6_atual, "
                + "troca_ribbon_1, troca_ribbon_2, troca_ribbon_3, troca_ribbon_4, troca_ribbon_5, troca_ribbon_6, "
                + "fim_ribbon_1, fim_ribbon_2, fim_ribbon_3, fim_ribbon_4, fim_ribbon_5, fim_ribbon_6 "
                + "FROM controle_ribbon ORDER BY data_ribbon DESC LIMIT 1";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                // Ribbons atuais (índices 0-5)
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("ribbon_1_atual")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("ribbon_2_atual")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("ribbon_3_atual")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("ribbon_4_atual")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("ribbon_5_atual")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("ribbon_6_atual")));

                // Trocas de ribbon (índices 6-11)
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("troca_ribbon_1")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("troca_ribbon_2")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("troca_ribbon_3")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("troca_ribbon_4")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("troca_ribbon_5")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("troca_ribbon_6")));

                // Fim de ribbon (índices 12-17)
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("fim_ribbon_1")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("fim_ribbon_2")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("fim_ribbon_3")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("fim_ribbon_4")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("fim_ribbon_5")));
                ribbonValues.add(java.math.BigDecimal.valueOf(rs.getDouble("fim_ribbon_6")));
            }
        }

        return ribbonValues;
    }

    /**
     * Consulta dados financeiros por período
     */
    public Map<String, Object> consultarDadosFinanceiros(String dataInicial, String dataFinal) throws Exception {
        Map<String, Object> resultado = new HashMap<>();

        // 1. Buscar totais de vendas do período
        String sqlVendas = "SELECT "
                + "SUM(prod1_din + prod1_deb + prod1_cred + prod1_pix) as ft_total, "
                + "SUM(sobras) as sobras, "
                + "SUM(prod2_din + prod2_deb + prod2_cred + prod2_pix) as enc_total, "
                + "SUM(prod3_din + prod3_deb + prod3_cred + prod3_pix) as dig_total "
                + "FROM vendasassociado "
                + "WHERE data_venda BETWEEN ? AND ?";

        try (PreparedStatement ps = connection.prepareStatement(sqlVendas)) {
            ps.setDate(1, java.sql.Date.valueOf(dataInicial));
            ps.setDate(2, java.sql.Date.valueOf(dataFinal));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                resultado.put("ft_total", rs.getInt("ft_total"));
                resultado.put("sobras", rs.getInt("sobras"));
                resultado.put("enc_total", rs.getInt("enc_total"));
                resultado.put("dig_total", rs.getInt("dig_total"));
            }
        }

        // 2. Buscar configurações (limite, percentual, custos, valores)
        String sqlConfig = "SELECT limite, percentual_extras, "
                + "conf1_valor, conf2_valor, conf3_valor, "
                + "mat1_custo, mat2_custo "
                + "FROM configassociado WHERE idconf = 1";

        try (PreparedStatement ps = connection.prepareStatement(sqlConfig)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                resultado.put("limite", rs.getInt("limite"));
                resultado.put("percentual_extras", rs.getString("percentual_extras"));
                resultado.put("conf1_valor", rs.getString("conf1_valor"));
                resultado.put("conf2_valor", rs.getString("conf2_valor"));
                resultado.put("conf3_valor", rs.getString("conf3_valor"));
                resultado.put("mat1_custo", rs.getString("mat1_custo"));
                resultado.put("mat2_custo", rs.getString("mat2_custo"));
            }
        }

        return resultado;
    }

    /**
     * Busca total de fotos vendidas no mês por um vendedor
     */
    public int buscarTotalFotosVendidasMes(Long vendedorId, int mes, int ano) throws Exception {
        String sql = "SELECT SUM(prod1_din + prod1_deb + prod1_cred + prod1_pix) as total_fotos "
                + "FROM vendasassociado "
                + "WHERE vendedor_id = ? "
                + "AND EXTRACT(MONTH FROM data_venda) = ? "
                + "AND EXTRACT(YEAR FROM data_venda) = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, vendedorId);
            ps.setInt(2, mes);
            ps.setInt(3, ano);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_fotos");
            }
        }

        return 0;
    }

    // ========== MÉTODOS PRIVADOS DE PREENCHIMENTO ==========

    private void preencherModelVenda(ModelAssociado model, ResultSet rs) throws SQLException {
        model.setVenda_id(rs.getLong("venda_id"));
        model.setVendedor_id(rs.getLong("vendedor_id"));
        model.setNome(rs.getString("nome"));

        model.setProd1_din(rs.getInt("prod1_din"));
        model.setProd1_deb(rs.getInt("prod1_deb"));
        model.setProd1_cred(rs.getInt("prod1_cred"));
        model.setProd1_pix(rs.getInt("prod1_pix"));

        model.setProd2_din(rs.getInt("prod2_din"));
        model.setProd2_deb(rs.getInt("prod2_deb"));
        model.setProd2_cred(rs.getInt("prod2_cred"));
        model.setProd2_pix(rs.getInt("prod2_pix"));

        model.setProd3_din(rs.getInt("prod3_din"));
        model.setProd3_deb(rs.getInt("prod3_deb"));
        model.setProd3_cred(rs.getInt("prod3_cred"));
        model.setProd3_pix(rs.getInt("prod3_pix"));

        model.setFt_total(rs.getInt("ft_total"));
        model.setEnc_total(rs.getInt("enc_total"));
        model.setDig_total(rs.getInt("dig_total"));

        model.setSobras(rs.getInt("sobras"));
        model.setSobras_extras(rs.getInt("sobras_extras"));
        model.setRibbon(rs.getString("ribbon"));
        model.setRibbon_dif(rs.getInt("ribbon_dif"));
        model.setData_venda(rs.getDate("data_venda"));
    }

    private ModelAssociado preencherModelConfig(ResultSet rs) throws SQLException {
        ModelAssociado model = new ModelAssociado();

        model.setIdconf(rs.getLong("idconf"));

        model.setConf1_nome(rs.getString("conf1_nome"));
        model.setConf1_valor(rs.getString("conf1_valor"));
        model.setConf2_nome(rs.getString("conf2_nome"));
        model.setConf2_valor(rs.getString("conf2_valor"));
        model.setConf3_nome(rs.getString("conf3_nome"));
        model.setConf3_valor(rs.getString("conf3_valor"));

        model.setMat1_nome(rs.getString("mat1_nome"));
        model.setMat1_valor(rs.getString("mat1_valor"));
        model.setMat1_qtd(rs.getInt("mat1_qtd"));
        model.setMat1_custo(rs.getString("mat1_custo"));

        model.setMat2_nome(rs.getString("mat2_nome"));
        model.setMat2_valor(rs.getString("mat2_valor"));
        model.setMat2_qtd(rs.getInt("mat2_qtd"));
        model.setMat2_custo(rs.getString("mat2_custo"));

        model.setMat3_nome(rs.getString("mat3_nome"));
        model.setMat3_valor(rs.getString("mat3_valor"));
        model.setMat3_qtd(rs.getInt("mat3_qtd"));
        model.setMat3_custo(rs.getString("mat3_custo"));

        // Configurações Financeiras
        model.setLimite(rs.getInt("limite"));
        model.setPercentual_extras(rs.getString("percentual_extras"));

        return model;
    }

    private ModelAssociado preencherModelFinanceiro(ResultSet rs) throws SQLException {
        ModelAssociado model = new ModelAssociado();

        model.setId_financeiro(rs.getLong("id_financeiro"));
        model.setMes_referencia(rs.getInt("mes_referencia"));
        model.setAno_referencia(rs.getInt("ano_referencia"));

        model.setTotal_fotos(rs.getInt("total_fotos"));
        model.setTotal_sobras(rs.getInt("total_sobras"));
        model.setTotal_encartes(rs.getInt("total_encartes"));
        model.setDig_total(rs.getInt("dig_total"));
        model.setFotos_extras(rs.getInt("fotos_extras"));
        model.setEncartes_extras(rs.getInt("encartes_extras"));


        model.setCusto_fotos_sobras(rs.getBigDecimal("custo_fotos_sobras"));
        model.setCusto_encartes(rs.getBigDecimal("custo_encartes"));
        model.setFgts(rs.getBigDecimal("fgts"));
        model.setInss(rs.getBigDecimal("inss"));

        model.setTotal_bruto(rs.getBigDecimal("total_bruto"));
        model.setTotal_vendas(rs.getBigDecimal("total_vendas"));
        model.setValor_extras(rs.getBigDecimal("valor_extras"));
        model.setCustos_fotos(rs.getBigDecimal("custos_fotos"));
        model.setRestituir(rs.getBigDecimal("restituir"));
        model.setSaldo_liquido(rs.getBigDecimal("saldo_liquido"));

        return model;
    }
}