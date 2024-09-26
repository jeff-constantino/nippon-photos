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
        if (modelVendas.getVenda_id() != null) {
            ModelVendas vendaExistente = consultaVenda(modelVendas.getVenda_id(), userLogado);

            if (vendaExistente != null) {
                return atualizarVenda(vendaExistente.getVenda_id(), modelVendas, userLogado);
            } else {
                throw new Exception("Venda com o ID " + modelVendas.getVenda_id() + " não encontrada.");
            }
        } else {
            String sql = "INSERT INTO vendas(vendedor_id, nome, prod1_din, prod1_deb, prod1_cred, prod1_pix, "
                    + "prod2_din, prod2_deb, prod2_cred, prod2_pix, prod3_din, prod3_deb, prod3_cred, prod3_pix, sobras) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement preparedSql = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            preparedSql.setLong(1, modelVendas.getVendedor_id());
            preparedSql.setString(2, modelVendas.getNome());
            preparedSql.setInt(3, modelVendas.getProd1_din());
            preparedSql.setInt(4, modelVendas.getProd1_deb());
            preparedSql.setInt(5, modelVendas.getProd1_cred());
            preparedSql.setInt(6, modelVendas.getProd1_pix());
            preparedSql.setInt(7, modelVendas.getProd2_din());
            preparedSql.setInt(8, modelVendas.getProd2_deb());
            preparedSql.setInt(9, modelVendas.getProd2_cred());
            preparedSql.setInt(10, modelVendas.getProd2_pix());
            preparedSql.setInt(11, modelVendas.getProd3_din());
            preparedSql.setInt(12, modelVendas.getProd3_deb());
            preparedSql.setInt(13, modelVendas.getProd3_cred());
            preparedSql.setInt(14, modelVendas.getProd3_pix());
            preparedSql.setInt(15, modelVendas.getSobras());

            preparedSql.executeUpdate();

            ResultSet generatedKeys = preparedSql.getGeneratedKeys();
            if (generatedKeys.next()) {
                long generatedId = generatedKeys.getLong(1);
                modelVendas.setVenda_id(generatedId);
            } else {
                throw new SQLException("Falha ao obter o ID gerado.");
            }

            connection.commit();
            return this.consultaVenda(modelVendas.getVenda_id(), userLogado);
        }
    }




    private ModelVendas atualizarVenda(Long venda_id, ModelVendas modelVendas, Long userLogado) throws Exception {
        String sql = "UPDATE vendas SET vendedor_id = ?, nome = ?, prod1_din = ?, prod1_deb = ?, prod1_cred = ?, prod1_pix = ?, "
                + "prod2_din = ?, prod2_deb = ?, prod2_cred = ?, prod2_pix = ?, prod3_din = ?, prod3_deb = ?, prod3_cred = ?, prod3_pix = ?, sobras = ? "
                + "WHERE venda_id = ?";

        PreparedStatement preparedSql = connection.prepareStatement(sql);

        preparedSql.setLong(1, modelVendas.getVendedor_id());
        preparedSql.setString(2, modelVendas.getNome());
        preparedSql.setInt(3, modelVendas.getProd1_din());
        preparedSql.setInt(4, modelVendas.getProd1_deb());
        preparedSql.setInt(5, modelVendas.getProd1_cred());
        preparedSql.setInt(6, modelVendas.getProd1_pix());
        preparedSql.setInt(7, modelVendas.getProd2_din());
        preparedSql.setInt(8, modelVendas.getProd2_deb());
        preparedSql.setInt(9, modelVendas.getProd2_cred());
        preparedSql.setInt(10, modelVendas.getProd2_pix());
        preparedSql.setInt(11, modelVendas.getProd3_din());
        preparedSql.setInt(12, modelVendas.getProd3_deb());
        preparedSql.setInt(13, modelVendas.getProd3_cred());
        preparedSql.setInt(14, modelVendas.getProd3_pix());
        preparedSql.setInt(15, modelVendas.getSobras());
        preparedSql.setLong(16, venda_id);

        int linhasAfetadas = preparedSql.executeUpdate();
        connection.commit();

        if (linhasAfetadas > 0) {
            return consultaVenda(venda_id, userLogado);
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
    public List<ModelLogin> consultaFuncionarioList(String nome) throws Exception {
        List<ModelLogin> retorno = new ArrayList<ModelLogin>();
        String sql = "SELECT * FROM model_login WHERE UPPER(nome) LIKE UPPER(?) AND useradmin IS FALSE ORDER BY status";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setString(1, "%" + nome + "%");
            ResultSet resultSet = preparedSql.executeQuery();

            while (resultSet.next()) {
                ModelLogin modelLogin = new ModelLogin();
                modelLogin.setId(resultSet.getLong("id"));
                modelLogin.setNome(resultSet.getString("nome"));
                retorno.add(modelLogin);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao executar a consulta: " + e.getMessage());
            throw e; // Lança a exceção novamente para ser tratada na servlet
        }

        return retorno;
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