

package dao;

import connection.SingleConnectionBanco;
import model.ModelLogin;
import model.ModelVendas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DAOUsuarioRepository {

    private final Connection connection;

    public DAOUsuarioRepository() {
        connection = SingleConnectionBanco.getConnection();

    }

    public ModelLogin gravarUsuario(ModelLogin objeto, Long userLogado) throws Exception {

        if (objeto.isNovo()) {

            String sql = "INSERT INTO model_login (nome, status, comissao, usuario_id, rg, cpf, pis, telefone, endereco, fotouser, extensaofotouser, apelido) VALUES (UPPER(?), UPPER(?), UPPER(?), ?, ?, ?, ?, ?, UPPER(?), ?, ?, UPPER(?))";
            PreparedStatement preparedSql = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            preparedSql.setString(1, objeto.getNome());
            preparedSql.setString(2, objeto.getStatus());
            preparedSql.setString(3, objeto.getComissao());
            preparedSql.setLong(4, userLogado);
            preparedSql.setString(5, objeto.getRg());
            preparedSql.setString(6, objeto.getCpf());
            preparedSql.setString(7, objeto.getPis());
            preparedSql.setString(8, objeto.getTelefone());
            preparedSql.setString(9, objeto.getEndereco());
            preparedSql.setString(10, objeto.getFotouser());
            preparedSql.setString(11, objeto.getExtensaofotouser());
            preparedSql.setString(12,objeto.getApelido());

            preparedSql.execute();

            // RECUPERA O ID GERADO
            ResultSet rs = preparedSql.getGeneratedKeys();
            if (rs.next()) {
                objeto.setId(rs.getLong(1));
            }

            connection.commit();

        } else {


            if (objeto.getFotouser() != null) {
                System.out.println("DEBUG UPDATE - Tamanho da foto: " + objeto.getFotouser().length());
                System.out.println("DEBUG UPDATE - Primeiros 50 chars: " + objeto.getFotouser().substring(0, Math.min(50, objeto.getFotouser().length())));
            }

            String sql = "UPDATE model_login SET nome = UPPER(?), status = UPPER(?), comissao = UPPER(?), rg = UPPER(?), cpf = UPPER(?), pis = UPPER(?), telefone = UPPER(?), endereco = UPPER(?), fotouser = ?, extensaofotouser = ?, apelido = UPPER(?) WHERE id = " + objeto.getId();
            PreparedStatement preparedSql = connection.prepareStatement(sql);

            preparedSql.setString(1, objeto.getNome());
            preparedSql.setString(2, objeto.getStatus());
            preparedSql.setString(3, objeto.getComissao());
            preparedSql.setString(4, objeto.getRg());
            preparedSql.setString(5, objeto.getCpf());
            preparedSql.setString(6, objeto.getPis());
            preparedSql.setString(7, objeto.getTelefone());
            preparedSql.setString(8, objeto.getEndereco());
            preparedSql.setString(9, objeto.getFotouser());
            preparedSql.setString(10, objeto.getExtensaofotouser());
            preparedSql.setString(11, objeto.getApelido());

            int linhasAfetadas = preparedSql.executeUpdate();
            System.out.println("DEBUG UPDATE - Linhas atualizadas: " + linhasAfetadas);

            connection.commit();
        }

        return this.consultarUsuario(objeto.getNome(), userLogado);
    }





    public List<ModelLogin> consultaUsuarioListPaginada(Long userLogado, Integer offset) throws Exception {
        List<ModelLogin> retorno = new ArrayList<>();
        String sql = "SELECT * FROM model_login WHERE useradmin IS FALSE AND usuario_id = ? AND status = 'ATIVO' ORDER BY id OFFSET ? LIMIT 6";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, userLogado);
        preparedSql.setInt(2, offset);
        ResultSet resultSet = preparedSql.executeQuery();

        while (resultSet.next()) {
            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setId(resultSet.getLong("id"));
            modelLogin.setNome(resultSet.getString("nome"));
            modelLogin.setStatus(resultSet.getString("status"));
            modelLogin.setRg(resultSet.getString("rg"));
            modelLogin.setCpf(resultSet.getString("cpf"));
            modelLogin.setPis(resultSet.getString("pis"));
            modelLogin.setTelefone(resultSet.getString("telefone"));
            modelLogin.setEndereco(resultSet.getString("endereco"));
            modelLogin.setApelido(resultSet.getString("apelido"));

            retorno.add(modelLogin);
        }

        return retorno;
    }



    public List<ModelLogin> consultaUsuarioList(Long userLogado) throws Exception {

        List <ModelLogin> retorno = new ArrayList<ModelLogin>();
        String sql = "SELECT * FROM model_login WHERE useradmin IS FALSE AND usuario_id = ? AND status = 'ATIVO' ORDER BY id";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1,userLogado);
        ResultSet resultSet = preparedSql.executeQuery();
        while (resultSet.next()) {
            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setId(resultSet.getLong("id"));
            modelLogin.setNome(resultSet.getString("nome"));
            modelLogin.setStatus(resultSet.getString("status"));
            modelLogin.setRg(resultSet.getString("rg"));
            modelLogin.setCpf(resultSet.getString("cpf"));
            modelLogin.setPis(resultSet.getString("pis"));
            modelLogin.setTelefone(resultSet.getString("telefone"));
            modelLogin.setEndereco(resultSet.getString("endereco"));
            modelLogin.setApelido(resultSet.getString("apelido"));
            retorno.add(modelLogin);
        }
        return retorno;
    }




    public int totalPagina(Long userLogado) throws Exception {
        String sql = "SELECT count(1) as total FROM model_login WHERE usuario_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, userLogado); // Substituir diretamente o valor de userLogado
        ResultSet resultSet = preparedSql.executeQuery();
        resultSet.next();

        Double cadastro = resultSet.getDouble("total");
        Double porpagina = 6.0;

        // Calcular o total de páginas
        int totalPaginas = (int) Math.ceil(cadastro / porpagina); // Usar Math.ceil para arredondar para cima

        return totalPaginas;
    }






    public List <ModelLogin> consultaUsuarioList(String nome, Long userLogado) throws Exception {
        List <ModelLogin> retorno = new ArrayList<ModelLogin>();
        String sql = "SELECT * FROM model_login WHERE UPPER (nome) LIKE UPPER(?) and useradmin is false and usuario_id=? order by status";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setString(1,"%" + nome + "%");
        preparedSql.setLong(2,userLogado);
        ResultSet resultSet = preparedSql.executeQuery();
        while(resultSet.next()) {
            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setId(resultSet.getLong("id"));
            modelLogin.setNome(resultSet.getString("nome"));
            modelLogin.setApelido(resultSet.getString("apelido"));
            retorno.add(modelLogin);

        }


        return  retorno;
    }

    public ModelLogin consultarUsuarioLogado(String login) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE upper(login) = upper('"+login+"')";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultado = statement.executeQuery();

        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));
            modelLogin.setStatus(resultado.getString("status"));
            modelLogin.setComissao(resultado.getString("comissao"));
            modelLogin.setRg(resultado.getString("rg"));
            modelLogin.setCpf(resultado.getString("cpf"));
            modelLogin.setPis(resultado.getString("pis"));
            modelLogin.setTelefone(resultado.getString("telefone"));
            modelLogin.setEndereco(resultado.getString("endereco"));
            modelLogin.setFotouser(resultado.getString("fotouser"));
            modelLogin.setApelido(resultado.getString("apelido"));



        }
        return modelLogin;
    }





    public ModelLogin consultarUsuarioLogin(String login) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE upper(login) = upper('"+login+"') and useradmin is false ";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultado = statement.executeQuery();

        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));
            modelLogin.setStatus(resultado.getString("status"));
            modelLogin.setComissao(resultado.getString("comissao"));
            modelLogin.setRg(resultado.getString("rg"));
            modelLogin.setCpf(resultado.getString("cpf"));
            modelLogin.setPis(resultado.getString("pis"));
            modelLogin.setTelefone(resultado.getString("telefone"));
            modelLogin.setEndereco(resultado.getString("endereco"));
            modelLogin.setFotouser(resultado.getString("fotouser"));
            modelLogin.setApelido(resultado.getString("apelido"));




        }
        return modelLogin;
    }






    public ModelLogin consultarUsuarioLogin(String login, Long userLogado) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE upper(login) = upper('"+login+"') and useradmin is false and usuario_id="+userLogado;
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultado = statement.executeQuery();

        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));
            modelLogin.setStatus(resultado.getString("status"));
            modelLogin.setComissao(resultado.getString("comissao"));
            modelLogin.setRg(resultado.getString("rg"));
            modelLogin.setCpf(resultado.getString("cpf"));
            modelLogin.setPis(resultado.getString("pis"));
            modelLogin.setTelefone(resultado.getString("telefone"));
            modelLogin.setEndereco(resultado.getString("endereco"));
            modelLogin.setFotouser(resultado.getString("fotouser"));
            modelLogin.setApelido(resultado.getString("apelido"));



        }
        return modelLogin;
    }






    public ModelLogin consultarUsuario(String nome, Long userLogado) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE upper(nome) = upper(?) and useradmin is false";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultado = statement.executeQuery();
        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));
            modelLogin.setStatus(resultado.getString("status"));
            modelLogin.setComissao(resultado.getString("comissao"));
            modelLogin.setRg(resultado.getString("rg"));
            modelLogin.setCpf(resultado.getString("cpf"));
            modelLogin.setPis(resultado.getString("pis"));
            modelLogin.setTelefone(resultado.getString("telefone"));
            modelLogin.setEndereco(resultado.getString("endereco"));
            modelLogin.setFotouser(resultado.getString("fotouser"));
            modelLogin.setApelido(resultado.getString("apelido"));



        }
        return modelLogin;
    }


    public ModelLogin consultarUsuarioID(Long id) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE id = ? and useradmin is false ";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);

        ResultSet resultado = statement.executeQuery();
        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));
            modelLogin.setStatus(resultado.getString("status"));
            modelLogin.setComissao(resultado.getString("comissao"));
            modelLogin.setRg(resultado.getString("rg"));
            modelLogin.setCpf(resultado.getString("cpf"));
            modelLogin.setPis(resultado.getString("pis"));
            modelLogin.setTelefone(resultado.getString("telefone"));
            modelLogin.setEndereco(resultado.getString("endereco"));
            modelLogin.setFotouser(resultado.getString("fotouser"));
            modelLogin.setApelido(resultado.getString("apelido"));



        }
        return modelLogin;
    }






    public ModelLogin consultarUsuarioID(String id, Long userLogado) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE id = ? and useradmin is false and usuario_id=?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, Long.parseLong(id));
        statement.setLong(2, userLogado);
        ResultSet resultado = statement.executeQuery();
        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));
            modelLogin.setStatus(resultado.getString("status"));
            modelLogin.setRg(resultado.getString("rg"));
            modelLogin.setCpf(resultado.getString("cpf"));
            modelLogin.setPis(resultado.getString("pis"));
            modelLogin.setTelefone(resultado.getString("telefone"));
            modelLogin.setEndereco(resultado.getString("endereco"));
            modelLogin.setComissao(resultado.getString("comissao"));
            modelLogin.setFotouser(resultado.getString("fotouser"));
            modelLogin.setApelido(resultado.getString("apelido"));



        }
        return modelLogin;
    }

    public boolean validarLogin(String nome) throws Exception {
        String sql= "SELECT COUNT (1) > 0 AS EXISTE FROM model_login WHERE UPPER(nome) = UPPER (?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultado = statement.executeQuery();
        resultado.next();
        return resultado.getBoolean("existe");

    }

    public void deletarUser(String idUser) throws Exception {
        String sql = "DELETE FROM model_login WHERE id = ? and useradmin is false";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, Long.parseLong(idUser));
        preparedSql.executeUpdate();
        connection.commit();
    }
}
