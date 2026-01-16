package dao;

import connection.ConnectionPool;
import model.ModelConfig;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOConfig {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public DAOConfig(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public DAOConfig() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    public ModelConfig gravarConfig(ModelConfig modelConfig) throws Exception {
        if (modelConfig.getIdconf() != null && modelConfig.getIdconf() > 0 && existeConfig(modelConfig.getIdconf())) {
            return atualizarConfig(modelConfig);
        } else {
            return inserirConfig(modelConfig);
        }
    }

    private boolean existeConfig(Long idconf) throws SQLException {
        String sql = "SELECT 1 FROM public.configuracao WHERE idconf = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, idconf);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    private ModelConfig inserirConfig(ModelConfig modelConfig) throws Exception {
        String sql = "INSERT INTO public.configuracao(conf1_valor, conf2_valor, conf3_valor, conf1_nome, conf2_nome, conf3_nome, conf_name) VALUES (?, ?, ?, UPPER(?), UPPER(?), UPPER(?), UPPER(?))";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedSql.setBigDecimal(1, modelConfig.getConf1_valor() != null ? modelConfig.getConf1_valor() : BigDecimal.ZERO);
            preparedSql.setBigDecimal(2, modelConfig.getConf2_valor() != null ? modelConfig.getConf2_valor() : BigDecimal.ZERO);
            preparedSql.setBigDecimal(3, modelConfig.getConf3_valor() != null ? modelConfig.getConf3_valor() : BigDecimal.ZERO);
            preparedSql.setString(4, modelConfig.getConf1_nome());
            preparedSql.setString(5, modelConfig.getConf2_nome());
            preparedSql.setString(6, modelConfig.getConf3_nome());
            preparedSql.setString(7, modelConfig.getConf_name());
            preparedSql.executeUpdate();
            if (gerenciarTransacao) connection.commit();
            try (ResultSet generatedKeys = preparedSql.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    modelConfig.setIdconf(generatedKeys.getLong(1));
                }
            }
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return modelConfig;
    }

    private ModelConfig atualizarConfig(ModelConfig modelConfig) throws Exception {
        String sql = "UPDATE public.configuracao SET conf1_valor = ?, conf2_valor = ?, conf3_valor = ?, conf1_nome = UPPER(?), conf2_nome = UPPER(?), conf3_nome = UPPER(?), conf_name = UPPER(?) WHERE idconf = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setBigDecimal(1, modelConfig.getConf1_valor());
            preparedSql.setBigDecimal(2, modelConfig.getConf2_valor());
            preparedSql.setBigDecimal(3, modelConfig.getConf3_valor());
            preparedSql.setString(4, modelConfig.getConf1_nome());
            preparedSql.setString(5, modelConfig.getConf2_nome());
            preparedSql.setString(6, modelConfig.getConf3_nome());
            preparedSql.setString(7, modelConfig.getConf_name());
            preparedSql.setLong(8, modelConfig.getIdconf());
            preparedSql.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw new Exception("Erro ao atualizar configuração: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return modelConfig;
    }

    public void salvarMateriaisFixos(String nome1, String valor1, String qtd1, String custo1,
                                     String nome2, String valor2, String qtd2, String custo2,
                                     String nome3, String valor3, String qtd3, String custo3) throws Exception {
        try {
            salvarMaterialPorId(1L, nome1, valor1, qtd1, custo1);
            salvarMaterialPorId(2L, nome2, valor2, qtd2, custo2);
            salvarMaterialPorId(3L, nome3, valor3, qtd3, custo3);
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw new Exception("Erro ao salvar materiais fixos: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    private void salvarMaterialPorId(Long id, String nome, String valor, String qtd, String custo) throws SQLException {
        if (nome == null || nome.trim().isEmpty()) return;
        BigDecimal valorDecimal = parseBigDecimal(valor);
        BigDecimal custoDecimal = parseBigDecimal(custo);
        int qtdInt = parseIntOrDefault(qtd);
        String sqlCheck = "SELECT COUNT(*) FROM public.conf_materiais WHERE id_conf = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(sqlCheck)) {
            checkStmt.setLong(1, id);
            try (ResultSet rs = checkStmt.executeQuery()) {
                rs.next();
                boolean existe = rs.getInt(1) > 0;
                if (existe) {
                    String sqlUpdate = "UPDATE public.conf_materiais SET conf_name = UPPER(?), valor = ?, qtd = ?, custo = ? WHERE id_conf = ?";
                    try (PreparedStatement updateStmt = connection.prepareStatement(sqlUpdate)) {
                        updateStmt.setString(1, nome);
                        updateStmt.setBigDecimal(2, valorDecimal);
                        updateStmt.setInt(3, qtdInt);
                        updateStmt.setBigDecimal(4, custoDecimal);
                        updateStmt.setLong(5, id);
                        updateStmt.executeUpdate();
                    }
                } else {
                    String sqlInsert = "INSERT INTO public.conf_materiais (id_conf, conf_name, valor, qtd, custo) VALUES (?, UPPER(?), ?, ?, ?)";
                    try (PreparedStatement insertStmt = connection.prepareStatement(sqlInsert)) {
                        insertStmt.setLong(1, id);
                        insertStmt.setString(2, nome);
                        insertStmt.setBigDecimal(3, valorDecimal);
                        insertStmt.setInt(4, qtdInt);
                        insertStmt.setBigDecimal(5, custoDecimal);
                        insertStmt.executeUpdate();
                    }
                }
            }
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) return BigDecimal.ZERO;
        try {
            return new BigDecimal(value.trim().replace(",", "."));
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }

    private int parseIntOrDefault(String value) {
        if (value == null || value.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public List<ModelConfig> carregarMateriaisFixos() throws Exception {
        List<ModelConfig> materiais = new ArrayList<>();
        String sql = "SELECT id_conf, conf_name, valor, qtd, custo FROM public.conf_materiais WHERE id_conf IN (1, 2, 3) ORDER BY id_conf";
        try (PreparedStatement preparedStmt = connection.prepareStatement(sql);
             ResultSet rs = preparedStmt.executeQuery()) {
            while (rs.next()) {
                ModelConfig material = new ModelConfig();
                material.setIdconf(rs.getLong("id_conf"));
                material.setConf_name(rs.getString("conf_name"));
                material.setConf1_valor(rs.getBigDecimal("valor"));
                material.setConf1_qtd(rs.getInt("qtd"));
                material.setConf1_custo(rs.getBigDecimal("custo"));
                materiais.add(material);
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao carregar materiais fixos: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return materiais;
    }

    public void gravarMateriais(List<ModelConfig> materiais) throws Exception {
        if (materiais == null || materiais.isEmpty()) {
            throw new IllegalArgumentException("Lista de materiais não pode ser vazia");
        }
        try {
            String sqlInsert = "INSERT INTO public.conf_materiais (conf_name, valor, qtd, custo) VALUES (UPPER(?), ?, ?, ?)";
            try (PreparedStatement preparedStmt = connection.prepareStatement(sqlInsert, PreparedStatement.RETURN_GENERATED_KEYS)) {
                for (ModelConfig material : materiais) {
                    if (material.getConf_name() != null && !material.getConf_name().trim().isEmpty()) {
                        preparedStmt.setString(1, material.getConf_name());
                        preparedStmt.setBigDecimal(2, material.getConf1_valor() != null ? material.getConf1_valor() : BigDecimal.ZERO);
                        preparedStmt.setInt(3, material.getConf1_qtd());
                        preparedStmt.setBigDecimal(4, material.getConf1_custo() != null ? material.getConf1_custo() : BigDecimal.ZERO);
                        preparedStmt.addBatch();
                    }
                }
                preparedStmt.executeBatch();
            }
            if (gerenciarTransacao) connection.commit();
        } catch (SQLException e) {
            if (gerenciarTransacao) connection.rollback();
            throw new Exception("Erro ao gravar materiais: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public List<ModelConfig> buscarMateriaisPorConfName(String confName) throws Exception {
        List<ModelConfig> materiais = new ArrayList<>();
        String sql = "SELECT id_conf, conf_name, valor, qtd, custo FROM public.conf_materiais WHERE UPPER(conf_name) = UPPER(?) ORDER BY id_conf";
        try (PreparedStatement preparedStmt = connection.prepareStatement(sql)) {
            preparedStmt.setString(1, confName);
            try (ResultSet rs = preparedStmt.executeQuery()) {
                while (rs.next()) {
                    ModelConfig material = new ModelConfig();
                    material.setConf_name(rs.getString("conf_name"));
                    material.setConf1_valor(rs.getBigDecimal("valor"));
                    material.setConf1_qtd(rs.getInt("qtd"));
                    material.setConf1_custo(rs.getBigDecimal("custo"));
                    materiais.add(material);
                }
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao buscar materiais: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return materiais;
    }

    public List<ModelConfig> listarTodosMateriais() throws Exception {
        List<ModelConfig> materiais = new ArrayList<>();
        String sql = "SELECT id_conf, conf_name, valor, qtd, custo FROM public.conf_materiais ORDER BY conf_name, id_conf";
        try (PreparedStatement preparedStmt = connection.prepareStatement(sql);
             ResultSet rs = preparedStmt.executeQuery()) {
            while (rs.next()) {
                ModelConfig material = new ModelConfig();
                material.setConf_name(rs.getString("conf_name"));
                material.setConf1_valor(rs.getBigDecimal("valor"));
                material.setConf1_qtd(rs.getInt("qtd"));
                material.setConf1_custo(rs.getBigDecimal("custo"));
                materiais.add(material);
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao listar materiais: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return materiais;
    }

    public void excluirMaterial(Long idconf) throws Exception {
        String sql = "DELETE FROM public.conf_materiais WHERE id_conf = ?";
        try (PreparedStatement preparedStmt = connection.prepareStatement(sql)) {
            preparedStmt.setLong(1, idconf);
            int rowsAffected = preparedStmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new Exception("Material não encontrado para exclusão");
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao excluir material: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public ModelConfig consultarConfig(long idconf) throws Exception {
        ModelConfig modelConfig = null;
        String sql = "SELECT * FROM public.configuracao WHERE idconf = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setLong(1, idconf);
            ResultSet resultSet = preparedSql.executeQuery();
            if (resultSet.next()) {
                modelConfig = new ModelConfig();
                modelConfig.setIdconf(resultSet.getLong("idconf"));
                modelConfig.setConf_name(resultSet.getString("conf_name"));
                modelConfig.setConf1_nome(resultSet.getString("conf1_nome"));
                modelConfig.setConf1_valor(resultSet.getBigDecimal("conf1_valor"));
                modelConfig.setConf1_valor2(resultSet.getBigDecimal("conf1_valor2"));
                modelConfig.setConf1_qtd(resultSet.getInt("conf1_qtd"));
                modelConfig.setConf1_custo(resultSet.getBigDecimal("conf1_custo"));
                modelConfig.setConf2_nome(resultSet.getString("conf2_nome"));
                modelConfig.setConf2_valor(resultSet.getBigDecimal("conf2_valor"));
                modelConfig.setConf2_qtd(resultSet.getInt("conf2_qtd"));
                modelConfig.setConf2_custo(resultSet.getBigDecimal("conf2_custo"));
                modelConfig.setConf3_nome(resultSet.getString("conf3_nome"));
                modelConfig.setConf3_valor(resultSet.getBigDecimal("conf3_valor"));
                modelConfig.setConf3_qtd(resultSet.getInt("conf3_qtd"));
                modelConfig.setConf3_custo(resultSet.getBigDecimal("conf3_custo"));
                modelConfig.setConf4_nome(resultSet.getString("conf4_nome"));
                modelConfig.setConf4_valor(resultSet.getBigDecimal("conf4_valor"));
                modelConfig.setConf4_qtd(resultSet.getInt("conf4_qtd"));
                modelConfig.setConf4_custo(resultSet.getBigDecimal("conf4_custo"));
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return modelConfig;
    }

    public List<ModelConfig> consultarTodasConfigs() throws Exception {
        List<ModelConfig> listaConfigs = new ArrayList<>();
        String sql = "SELECT * FROM public.configuracao";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {
            while (resultSet.next()) {
                ModelConfig modelConfig = new ModelConfig();
                modelConfig.setIdconf(resultSet.getLong("idconf"));
                modelConfig.setConf_name(resultSet.getString("conf_name"));
                modelConfig.setConf1_nome(resultSet.getString("conf1_nome"));
                modelConfig.setConf1_valor(resultSet.getBigDecimal("conf1_valor"));
                modelConfig.setConf2_nome(resultSet.getString("conf2_nome"));
                modelConfig.setConf2_valor(resultSet.getBigDecimal("conf2_valor"));
                modelConfig.setConf3_nome(resultSet.getString("conf3_nome"));
                modelConfig.setConf3_valor(resultSet.getBigDecimal("conf3_valor"));
                listaConfigs.add(modelConfig);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage());
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return listaConfigs;
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