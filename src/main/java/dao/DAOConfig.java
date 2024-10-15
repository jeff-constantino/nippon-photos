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
        String sql = "INSERT INTO public.configuracao(conf1_valor, conf1_valor2, conf2_valor, conf3_valor, conf1_nome, conf2_nome, conf3_nome, conf_name, conf1_qtd, conf2_qtd, conf3_qtd, conf1_custo, conf2_custo, conf3_custo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedSql.setBigDecimal(1, modelConfig.getConf1_valor());
            preparedSql.setBigDecimal(2, modelConfig.getConf1_valor2());
            preparedSql.setBigDecimal(3, modelConfig.getConf2_valor());
            preparedSql.setBigDecimal(4, modelConfig.getConf3_valor());
            preparedSql.setString(5, modelConfig.getConf1_nome());
            preparedSql.setString(6, modelConfig.getConf2_nome());
            preparedSql.setString(7, modelConfig.getConf3_nome());

            preparedSql.setString(8, modelConfig.getConf_name());
            preparedSql.setInt(9, modelConfig.getConf1_qtd());
            preparedSql.setInt(10, modelConfig.getConf2_qtd());
            preparedSql.setInt(11, modelConfig.getConf3_qtd());
            preparedSql.setBigDecimal(12, modelConfig.getConf1_custo());
            preparedSql.setBigDecimal(13, modelConfig.getConf2_custo());
            preparedSql.setBigDecimal(14, modelConfig.getConf3_custo());



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
        String sql = "UPDATE public.configuracao SET conf1_valor = ?, conf1_valor2 = ?, conf2_valor = ?, conf3_valor = ?, conf1_nome = ?, conf2_nome = ?, conf3_nome = ?, conf_name = ?, conf1_qtd = ?, conf2_qtd = ?, conf3_qtd = ?, conf1_custo = ?, conf2_custo = ?, conf3_custo = ? WHERE \"idConf\" = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setBigDecimal(1, modelConfig.getConf1_valor());
            preparedSql.setBigDecimal(2, modelConfig.getConf1_valor2());
            preparedSql.setBigDecimal(3, modelConfig.getConf2_valor());
            preparedSql.setBigDecimal(4, modelConfig.getConf3_valor());
            preparedSql.setString(5, modelConfig.getConf1_nome());
            preparedSql.setString(6, modelConfig.getConf2_nome());
            preparedSql.setString(7, modelConfig.getConf3_nome());
            preparedSql.setString(8, modelConfig.getConf_name());
            preparedSql.setInt(9, modelConfig.getConf1_qtd());
            preparedSql.setInt(10, modelConfig.getConf2_qtd());
            preparedSql.setInt(11, modelConfig.getConf3_qtd());
            preparedSql.setBigDecimal(12, modelConfig.getConf1_custo());
            preparedSql.setBigDecimal(13, modelConfig.getConf2_custo());
            preparedSql.setBigDecimal(14, modelConfig.getConf3_custo()); // Corrigido

            preparedSql.setLong(15, modelConfig.getIdConf()); // Usando idConf no final

            preparedSql.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new Exception("Erro ao atualizar configuração: " + e.getMessage(), e);
        }

        return modelConfig;
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
                modelConfig.setConf_name(resultSet.getString("conf_name"));

                modelConfig.setConf1_nome(resultSet.getString("conf1_nome"));
                modelConfig.setConf1_valor(resultSet.getBigDecimal("conf1_valor"));
                modelConfig.setConf1_valor2(resultSet.getBigDecimal("conf1_valor2"));
                modelConfig.setConf1_qtd(resultSet.getInt("conf1_qtd"));
                modelConfig.setConf1_custo(resultSet.getBigDecimal("conf1_custo"));


                modelConfig.setConf1_valor2(resultSet.getBigDecimal("conf1_valor2"));
                modelConfig.setConf2_nome(resultSet.getString("conf2_nome"));
                modelConfig.setConf2_valor(resultSet.getBigDecimal("conf2_valor"));
                modelConfig.setConf2_qtd(resultSet.getInt("conf2_qtd"));
                modelConfig.setConf2_custo(resultSet.getBigDecimal("conf2_custo"));


                modelConfig.setConf3_nome(resultSet.getString("conf3_nome"));
                modelConfig.setConf3_valor(resultSet.getBigDecimal("conf3_valor"));
                modelConfig.setConf3_qtd(resultSet.getInt("conf3_qtd"));
                modelConfig.setConf3_custo(resultSet.getBigDecimal("conf3_custo"));
            }
        }

        return modelConfig;
    }



    public List<ModelConfig> consultarTodasConfigs() throws Exception {
        List<ModelConfig> listaConfigs = new ArrayList<>();
        String sql = "SELECT * FROM public.configuracao"; // Certifique-se de que a tabela existe

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultSet = preparedSql.executeQuery()) {

            while (resultSet.next()) {
                ModelConfig modelConfig = new ModelConfig();
                modelConfig.setIdConf(resultSet.getLong("idConf"));
                modelConfig.setConf_name(resultSet.getString("conf_name"));

                modelConfig.setConf1_nome(resultSet.getString("conf1_nome"));
                modelConfig.setConf1_valor(resultSet.getBigDecimal("conf1_valor"));
                modelConfig.setConf1_valor2(resultSet.getBigDecimal("conf1_valor2"));
                modelConfig.setConf1_qtd(resultSet.getInt("conf1_qtd"));
                modelConfig.setConf1_custo(resultSet.getBigDecimal("conf1_custo"));


                modelConfig.setConf1_valor2(resultSet.getBigDecimal("conf1_valor2"));
                modelConfig.setConf2_nome(resultSet.getString("conf2_nome"));
                modelConfig.setConf2_valor(resultSet.getBigDecimal("conf2_valor"));
                modelConfig.setConf2_qtd(resultSet.getInt("conf2_qtd"));
                modelConfig.setConf2_custo(resultSet.getBigDecimal("conf2_custo"));


                modelConfig.setConf3_nome(resultSet.getString("conf3_nome"));
                modelConfig.setConf3_valor(resultSet.getBigDecimal("conf3_valor"));
                modelConfig.setConf3_qtd(resultSet.getInt("conf3_qtd"));
                modelConfig.setConf3_custo(resultSet.getBigDecimal("conf3_custo"));


                listaConfigs.add(modelConfig);
            }

        } catch (SQLException e) {
            System.err.println("Erro ao consultar configurações: " + e.getMessage()); // Captura erros de SQL
            throw e; // Repropaga a exceção para ser tratada na camada superior
        }

        return listaConfigs;
    }
}
