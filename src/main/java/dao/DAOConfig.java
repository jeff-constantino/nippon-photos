package dao;

import connection.SingleConnectionBanco;
import model.ModelConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOConfig {
    private Connection connection;

    public DAOConfig() {
        connection = SingleConnectionBanco.getConnection();
    }

    public ModelConfig gravarConfig(ModelConfig modelConfig) throws Exception {
        String sql = "INSERT INTO public.configuracao(prod1_valor, prod2_valor, prod3_valor, comissao, prod1_nome, prod2_nome, prod3_nome) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedSql.setBigDecimal(1, modelConfig.getProd1_valor());
            preparedSql.setBigDecimal(2, modelConfig.getProd2_valor());
            preparedSql.setBigDecimal(3, modelConfig.getProd3_valor());
            preparedSql.setBigDecimal(4, modelConfig.getComissao());
            preparedSql.setString(5, modelConfig.getProd1_nome());
            preparedSql.setString(6, modelConfig.getProd2_nome());
            preparedSql.setString(7, modelConfig.getProd3_nome());

            preparedSql.executeUpdate();
            ResultSet generatedKeys = preparedSql.getGeneratedKeys();
            if (generatedKeys.next()) {
                modelConfig.setIdConf(generatedKeys.getLong(1)); // Definir o id gerado
            }

            connection.commit();
        } catch (SQLException e) {
            connection.rollback(); // Faz rollback em caso de erro
            throw new Exception("Erro ao gravar configuração: " + e.getMessage(), e);
        }

        return modelConfig; // Retorna o modelo atualizado com o idConf
    }

    public boolean validarConfig(Long idConf) throws Exception {
        String sql = "SELECT COUNT(1) > 0 AS existe FROM public.configuracao WHERE \"idConf\" = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setLong(1, idConf);
            ResultSet resultSet = preparedSql.executeQuery();
            resultSet.next();
            return resultSet.getBoolean("existe");
        }
    }

    public ModelConfig consultarConfig(long idConf) throws Exception {
        ModelConfig modelConfig = null;
        String sql = "SELECT * FROM public.configuracao WHERE \"idConf\" = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setLong(1, idConf);
            ResultSet resultSet = preparedSql.executeQuery();
            if (resultSet.next()) {
                modelConfig = new ModelConfig();
                modelConfig.setIdConf(resultSet.getLong("idConf"));
                modelConfig.setProd1_valor(resultSet.getBigDecimal("prod1_valor"));
                modelConfig.setProd2_valor(resultSet.getBigDecimal("prod2_valor"));
                modelConfig.setProd3_valor(resultSet.getBigDecimal("prod3_valor"));
                modelConfig.setComissao(resultSet.getBigDecimal("comissao"));
                modelConfig.setProd1_nome(resultSet.getString("prod1_nome"));
                modelConfig.setProd2_nome(resultSet.getString("prod2_nome"));
                modelConfig.setProd3_nome(resultSet.getString("prod3_nome"));
            }
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
                modelConfig.setIdConf(resultSet.getLong("idConf"));
                modelConfig.setProd1_nome(resultSet.getString("prod1_nome"));
                modelConfig.setProd1_valor(resultSet.getBigDecimal("prod1_valor"));
                modelConfig.setProd2_nome(resultSet.getString("prod2_nome"));
                modelConfig.setProd2_valor(resultSet.getBigDecimal("prod2_valor"));
                modelConfig.setProd3_nome(resultSet.getString("prod3_nome"));
                modelConfig.setProd3_valor(resultSet.getBigDecimal("prod3_valor"));
                modelConfig.setComissao(resultSet.getBigDecimal("comissao"));

                listaConfigs.add(modelConfig);
            }
        }

        System.out.println("Número de configurações retornadas: " + listaConfigs.size());
        return listaConfigs;
    }
}
