package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ModelLogin;
import model.ModelVendas;
import connection.SingleConnectionBanco;

public class DAORelatorio {


    private Connection connection;

    public DAORelatorio() {
        connection = SingleConnectionBanco.getConnection();
    }

    // Método para buscar vendas com filtros de ID de funcionário e intervalo de datas
    public List<ModelVendas> consultarVendas(String funcionarioId, String dataInicial, String dataFinal) throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();

        // Constrói a consulta SQL base
        StringBuilder sql = new StringBuilder("SELECT v.*, l.nome FROM vendas v ")
                .append("INNER JOIN model_login l ON v.vendedor_id = l.id ")
                .append("WHERE l.status = 'Ativo'");

        // Adiciona a condição para o ID do funcionário, se fornecido
        if (funcionarioId != null && !funcionarioId.isEmpty()) {
            sql.append(" AND l.id = ?"); // Filtrando pelo ID do funcionário
        }

        // Adiciona as condições de data, se fornecidas
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')");
        }

        sql.append(" ORDER BY v.venda_id DESC");

        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;

            // Define o parâmetro do ID do funcionário, se necessário
            if (funcionarioId != null && !funcionarioId.isEmpty()) {
                preparedSql.setLong(index++, Long.parseLong(funcionarioId)); // Conversão de String para Long
            }

            // Define os parâmetros de data, se necessário
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            // Executa a consulta
            ResultSet resultado = preparedSql.executeQuery();

            // Processa os resultados
            while (resultado.next()) {
                ModelVendas modelVenda = new ModelVendas();
                modelVenda.setVenda_id(resultado.getLong("venda_id"));
                modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
                modelVenda.setNome(resultado.getString("nome"));

                modelVenda.setProd1_din(resultado.getInt("prod1_din"));
                modelVenda.setProd1_deb(resultado.getInt("prod1_deb"));
                modelVenda.setProd1_cred(resultado.getInt("prod1_cred"));
                modelVenda.setProd1_pix(resultado.getInt("prod1_pix"));

                modelVenda.setProd2_din(resultado.getInt("prod2_din"));
                modelVenda.setProd2_deb(resultado.getInt("prod2_deb"));
                modelVenda.setProd2_cred(resultado.getInt("prod2_cred"));
                modelVenda.setProd2_pix(resultado.getInt("prod2_pix"));

                modelVenda.setProd3_din(resultado.getInt("prod3_din"));
                modelVenda.setProd3_deb(resultado.getInt("prod3_deb"));
                modelVenda.setProd3_cred(resultado.getInt("prod3_cred"));
                modelVenda.setProd3_pix(resultado.getInt("prod3_pix"));

                modelVenda.setSobras(resultado.getInt("sobras"));
                modelVenda.setData_venda(resultado.getDate("data_venda"));

                modelVendasList.add(modelVenda);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro ao consultar vendas: " + e.getMessage());
        }

        return modelVendasList;
    }




    public List<ModelLogin> buscaFuncionariosAtivos() throws Exception {
        List<ModelLogin> funcionariosAtivos = new ArrayList<>();
        String sql = "SELECT id, nome FROM model_login WHERE status = 'Ativo'";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultado = preparedSql.executeQuery()) {

            while (resultado.next()) {
                ModelLogin funcionario = new ModelLogin();
                funcionario.setId(resultado.getLong("id")); // Supondo que você tenha um método setId em ModelLogin
                funcionario.setNome(resultado.getString("nome")); // Supondo que você tenha um método setNome em ModelLogin
                funcionariosAtivos.add(funcionario);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Logar o erro
            throw new Exception("Erro ao buscar funcionários ativos: " + e.getMessage());
        }
        return funcionariosAtivos;
    }
}