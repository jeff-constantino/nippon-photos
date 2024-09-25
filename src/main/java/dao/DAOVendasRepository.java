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

    public int totalPagina(Long userLogado) throws Exception {
        String sql = "SELECT count(1) as total FROM vendas where venda_id= " +userLogado;
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        ResultSet resultSet = preparedSql.executeQuery();
        resultSet.next();

        Double cadastro = resultSet.getDouble("total");
        Double porpagina = 6.0;
        Double pagina = cadastro/porpagina;
        Double resto = pagina % 2;
        if (resto >0){
            pagina++;
        }
        return pagina.intValue();
    }

    public ModelVendas gravarVenda(ModelVendas modelVendas, Long userLogado) throws Exception {
        // Verifica se o venda_id não é nulo e tenta consultar a venda existente
        if (modelVendas.getVenda_id() != null) {
            // Tenta consultar a venda existente com o venda_id e userLogado
            ModelVendas vendaExistente = consultaVenda(modelVendas.getVenda_id(), userLogado);

            if (vendaExistente != null) {
                // Se a venda existir, atualiza e retorna o objeto atualizado
                return atualizarVenda(vendaExistente.getVenda_id(), modelVendas, userLogado);
            } else {
                // Se a venda não existir, lança uma exceção ou lida conforme necessário
                throw new Exception("Venda com o ID " + modelVendas.getVenda_id() + " não encontrada.");
            }
        } else {
            // Caso venda_id seja nulo, insere uma nova venda
            String sql = "INSERT INTO vendas(vendedor_id, nome) VALUES (?, ?)";
            PreparedStatement preparedSql = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Configura os parâmetros para a inserção
            preparedSql.setLong(1, modelVendas.getVendedor_id());
            preparedSql.setString(2, modelVendas.getNome());

            // Executa a inserção
            preparedSql.executeUpdate();

            // Recupera o ID gerado automaticamente
            ResultSet generatedKeys = preparedSql.getGeneratedKeys();
            if (generatedKeys.next()) {
                long generatedId = generatedKeys.getLong(1); // Primeiro coluna retorna o ID
                modelVendas.setVenda_id(generatedId); // Define o ID gerado no modelo
            } else {
                throw new SQLException("Falha ao obter o ID gerado.");
            }

            // Confirma a transação
            connection.commit();

            // Retorna o ModelVendas recém-criado
            return modelVendas;
        }
    }



    private ModelVendas atualizarVenda(Long venda_id, ModelVendas modelVendas, Long userLogado) throws Exception {
        String sql = "UPDATE vendas SET vendedor_id = ?, nome = ? WHERE venda_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);

        // Configura os parâmetros do PreparedStatement
        preparedSql.setLong(1, modelVendas.getVendedor_id());
        preparedSql.setString(2, modelVendas.getNome());
        preparedSql.setLong(3, venda_id);

        // Executa a atualização
        int linhasAfetadas = preparedSql.executeUpdate();
        connection.commit(); // Confirma a transação

        // Retorna o ModelVendas atualizado ou lança uma exceção se não houver linhas afetadas
        if (linhasAfetadas > 0) {
            return consultaVenda(venda_id, userLogado); // Passa o segundo parâmetro
        } else {
            throw new Exception("Erro ao atualizar a venda. A venda pode não existir.");
        }
    }





    public ModelVendas consultaVenda(Long venda_id,  Long userLogado) throws Exception {
        // Verifica se o venda_id é nulo antes de prosseguir
        if (venda_id == null) {
            throw new IllegalArgumentException("venda_id não pode ser nulo.");
        }

        ModelVendas modelVendas = null;

        String sql = "SELECT * FROM vendas WHERE venda_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1,venda_id); // Usar setLong diretamente

        ResultSet resultado = preparedSql.executeQuery();
        if (resultado.next()) { // Verifica se há resultados
            modelVendas = new ModelVendas();
            modelVendas.setVenda_id(resultado.getLong("venda_id"));
            modelVendas.setVendedor_id(resultado.getLong("vendedor_id"));
            modelVendas.setNome(resultado.getString("nome"));
        } else {
            // Se não houver resultados, retornar null ou lançar uma exceção
            modelVendas = null; // Retorna null se a venda não existir
        }
        return modelVendas;
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