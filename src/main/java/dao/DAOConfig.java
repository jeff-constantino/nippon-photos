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
        // Se idConf não for nulo, executa um UPDATE, caso contrário, um INSERT
        if (modelConfig.getIdConf() != null) {
            return atualizarConfig(modelConfig);
        } else {
            return inserirConfig(modelConfig);
        }
    }

    private ModelConfig inserirConfig(ModelConfig modelConfig) throws Exception {
        String sql = "INSERT INTO public.configuracao(prod1_valor,prod1_valor2, prod2_valor, prod3_valor, comissao, prod1_nome, prod2_nome, prod3_nome) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedSql.setBigDecimal(1, modelConfig.getProd1_valor());
            preparedSql.setBigDecimal(2, modelConfig.getProd1_valor2());
            preparedSql.setBigDecimal(3, modelConfig.getProd2_valor());
            preparedSql.setBigDecimal(4, modelConfig.getProd3_valor());
            preparedSql.setBigDecimal(5, modelConfig.getComissao());
            preparedSql.setString(6, modelConfig.getProd1_nome());
            preparedSql.setString(7, modelConfig.getProd2_nome());
            preparedSql.setString(8, modelConfig.getProd3_nome());

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

    private ModelConfig atualizarConfig(ModelConfig modelConfig) throws Exception {
        String sql = "UPDATE public.configuracao SET prod1_valor = ?, prod1_valor2 = ?, prod2_valor = ?, prod3_valor = ?, comissao = ?, prod1_nome = ?, prod2_nome = ?, prod3_nome = ? WHERE \"idConf\" = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setBigDecimal(1, modelConfig.getProd1_valor()); // prod1_valor
            preparedSql.setBigDecimal(2, modelConfig.getProd1_valor2()); // prod1_valor2
            preparedSql.setBigDecimal(3, modelConfig.getProd2_valor()); // prod2_valor
            preparedSql.setBigDecimal(4, modelConfig.getProd3_valor()); // prod3_valor
            preparedSql.setBigDecimal(5, modelConfig.getComissao()); // comissao
            preparedSql.setString(6, modelConfig.getProd1_nome()); // prod1_nome
            preparedSql.setString(7, modelConfig.getProd2_nome()); // prod2_nome
            preparedSql.setString(8, modelConfig.getProd3_nome()); // prod3_nome
            preparedSql.setLong(9, modelConfig.getIdConf()); // idConf

            preparedSql.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback(); // Faz rollback em caso de erro
            throw new Exception("Erro ao atualizar configuração: " + e.getMessage(), e);
        }

        return modelConfig; // Retorna o modelo atualizado
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
                modelConfig.setProd1_valor2(resultSet.getBigDecimal("prod1_valor2"));
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
    public ModelConfig obterConfiguracaoAtual() throws Exception {
        String sql = "SELECT * FROM public.configuracao LIMIT 1"; // ou algum critério para obter a configuração atual
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                ModelConfig modelConfig = new ModelConfig();
                modelConfig.setIdConf(resultSet.getLong("idConf"));
                modelConfig.setProd1_nome(resultSet.getString("prod1_nome"));
                modelConfig.setProd1_valor(resultSet.getBigDecimal("prod1_valor"));
                modelConfig.setProd1_valor2(resultSet.getBigDecimal("prod1_valor2"));
                modelConfig.setProd2_nome(resultSet.getString("prod2_nome"));
                modelConfig.setProd2_valor(resultSet.getBigDecimal("prod2_valor"));
                modelConfig.setProd3_nome(resultSet.getString("prod3_nome"));
                modelConfig.setProd3_valor(resultSet.getBigDecimal("prod3_valor"));
                modelConfig.setComissao(resultSet.getBigDecimal("comissao"));
                return modelConfig;
            }
        }
        return null; // Retorne null se não encontrar
    }


    public List<ModelConfig> consultarTodasConfigs() throws Exception {
        List<ModelConfig> listaConfigs = new ArrayList<>();
        String sql = "SELECT * FROM public.configuracao"; // Certifique-se de que a tabela existe

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfig modelConfig = new ModelConfig();
                modelConfig.setIdConf(resultSet.getLong("idConf"));
                modelConfig.setProd1_nome(resultSet.getString("prod1_nome"));
                modelConfig.setProd1_valor(resultSet.getBigDecimal("prod1_valor"));
                modelConfig.setProd1_valor2(resultSet.getBigDecimal("prod1_valor2"));
                modelConfig.setProd2_nome(resultSet.getString("prod2_nome"));
                modelConfig.setProd2_valor(resultSet.getBigDecimal("prod2_valor"));
                modelConfig.setProd3_nome(resultSet.getString("prod3_nome"));
                modelConfig.setProd3_valor(resultSet.getBigDecimal("prod3_valor"));
                modelConfig.setComissao(resultSet.getBigDecimal("comissao"));

                listaConfigs.add(modelConfig);
            }


        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage()); // Captura erros de SQL
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaConfigs;
    }

}
