package dao;

import connection.SingleConnectionBanco;
import model.ModelLogin;
import model.ModelVendas;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOVendasRepository {

    private Connection connection;



    public DAOVendasRepository() {
        connection = SingleConnectionBanco.getConnection();

    }

    public ModelVendas gravarVenda(ModelVendas modelVendas) throws Exception {
        // Verifica se já existe uma venda com o mesmo vendedor_id e nome
        ModelVendas vendaExistente = consultaVendaPorNome(modelVendas.getNome());

        if (vendaExistente != null && vendaExistente.getVenda_id() != null) {
            // Atualiza a venda existente
            return atualizarVenda(vendaExistente.getVenda_id(), modelVendas);
        } else {
            // Insere uma nova venda
            String sql = "INSERT INTO vendas(vendedor_id, nome) VALUES (?, ?)";
            PreparedStatement preparedSql = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            preparedSql.setLong(1, modelVendas.getVendedor_id());
            preparedSql.setString(2, modelVendas.getNome());

            preparedSql.executeUpdate(); // Use executeUpdate para inserção

            // Recupera o ID gerado automaticamente
            ResultSet generatedKeys = preparedSql.getGeneratedKeys();
            if (generatedKeys.next()) {
                long generatedId = generatedKeys.getLong(1); // Primeiro coluna retorna o ID
                modelVendas.setVenda_id(generatedId); // Define o ID gerado no modelo
            } else {
                throw new SQLException("Falha ao obter o ID gerado.");
            }

            connection.commit();

            // Agora que o venda_id está definido, podemos consultar
            return this.consultaVenda(modelVendas.getVenda_id());
        }
    }


    public ModelVendas consultaVenda(Long venda_id) throws Exception {
        // Verifica se o venda_id é nulo antes de prosseguir
        if (venda_id == null) {
            throw new IllegalArgumentException("venda_id não pode ser nulo.");
        }

        ModelVendas modelVendas = new ModelVendas();

        String sql = "SELECT * FROM vendas WHERE venda_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, venda_id); // Usar setLong diretamente

        ResultSet resultado = preparedSql.executeQuery();
        if (resultado.next()) { // Verifica se há resultados
            modelVendas.setVendedor_id(resultado.getLong("vendedor_id")); // Aqui assume-se que você quer pegar vendedor_id
            modelVendas.setVenda_id(resultado.getLong("venda_id"));
            modelVendas.setNome(resultado.getString("nome"));
        } else {
            // Se não houver resultados, retornar um modelo vazio ou lançar uma exceção
            modelVendas = null; // Ou criar um novo ModelVendas se preferir
        }
        return modelVendas;
    }


    private ModelVendas consultaVendaPorNome(String nome) throws Exception {
        ModelVendas modelVendas = null;

        String sql = "SELECT * FROM vendas WHERE nome = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setString(1, nome);

        ResultSet resultado = preparedSql.executeQuery();
        if (resultado.next()) { // Verifica se há resultados
            modelVendas = new ModelVendas();
            modelVendas.setVendedor_id(resultado.getLong("vendedor_id")); // Pega vendedor_id
            modelVendas.setVenda_id(resultado.getLong("venda_id")); // Pega venda_id
            modelVendas.setNome(resultado.getString("nome")); // Pega nome
        }
        return modelVendas;
    }

    private ModelVendas atualizarVenda(Long venda_id, ModelVendas modelVendas) throws Exception {
        String sql = "UPDATE vendas SET vendedor_id = ?, nome = ? WHERE venda_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);

        preparedSql.setLong(1, modelVendas.getVendedor_id());
        preparedSql.setString(2, modelVendas.getNome());
        preparedSql.setLong(3, venda_id);

        preparedSql.executeUpdate(); // Atualiza a venda existente
        connection.commit();

        return consultaVenda(venda_id); // Retorna a venda atualizada
    }



    public ModelVendas consultaUsuario (String nome) throws Exception{
        ModelVendas modelVendas = new ModelVendas();

        String sql = "SELECT * FROM model_login WHERE UPPER(nome) = UPPER (?)";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setString(1, nome);

        ResultSet resultado = preparedSql.executeQuery();
        while (resultado.next()) {
            modelVendas.setVendedor_id (resultado.getLong("id"));
            modelVendas.setNome(resultado.getString("nome"));
        }
        return modelVendas;
    }


    public void deleteVenda(long id) throws Exception{
        String sql = "delete from vendas where venda_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, id);
        preparedSql.executeUpdate();
        connection.commit();
    }



    public boolean validarVenda(String nome) throws Exception {
        String sql= "SELECT COUNT (1) > 0 AS EXISTE FROM vendas WHERE UPPER(nome) = UPPER (?) and DATE  = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultado = statement.executeQuery();
        resultado.next();
        return resultado.getBoolean("existe");

    }




    public List<ModelVendas> listaVendas(Long idVendedorPai) throws Exception {
        String sql = "select * from Vendas where id_vendedor_pai = ?";
        List<ModelVendas> retorno = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            ModelVendas modelVendas = new ModelVendas();

            modelVendas.setNome(rs.getString("nome"));

            modelVendas.setProd1_din(rs.getInt("prod1_din"));
            modelVendas.setProd1_deb(rs.getInt("prod1_deb"));
            modelVendas.setProd1_cred(rs.getInt("prod1_cred"));
            modelVendas.setProd1_pix(rs.getInt("prod1_pix"));

            modelVendas.setProd2_din(rs.getInt("prod2_din"));
            modelVendas.setProd2_deb(rs.getInt("prod2_deb"));
            modelVendas.setProd2_cred(rs.getInt("prod2_cred"));
            modelVendas.setProd2_pix(rs.getInt("prod2_pix"));

            modelVendas.setProd3_din(rs.getInt("prod3_din"));
            modelVendas.setProd3_deb(rs.getInt("prod3_deb"));
            modelVendas.setProd3_cred(rs.getInt("prod3_cred"));
            modelVendas.setProd3_pix(rs.getInt("prod3_pix"));

            modelVendas.setSobras(rs.getInt("sobras"));
            modelVendas.setUsuario_cad_id(rs.getLong("usuario_cad_id"));
            modelVendas.setVendedor_id(rs.getLong("vendedor_id"));




            retorno.add(modelVendas);
        }
        return retorno;

    }
}

