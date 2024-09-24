package dao;

import connection.SingleConnectionBanco;
import model.ModelLogin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DAOUsuarioRepository {

    private Connection connection;

    public DAOUsuarioRepository() {
        connection = SingleConnectionBanco.getConnection();

    }

    public ModelLogin gravarUsuario(ModelLogin objeto, Long userLogado) throws Exception {

        if (objeto.isNovo()) {

            String sql = "INSERT INTO model_login (nome,status, usuario_id) VALUES (?, ?, ?)";
            PreparedStatement preparedSql = connection.prepareStatement(sql);
            preparedSql.setString(1, objeto.getNome());
            preparedSql.setString(2, objeto.getStatus());
            preparedSql.setLong(3, userLogado);
            preparedSql.execute();

            connection.commit();
        } else {
            String sql = "UPDATE model_login SET nome = ?, status =? WHERE id = " + objeto.getId() + "";

            PreparedStatement preparedSql = connection.prepareStatement(sql);

            preparedSql.setString(1, objeto.getNome());
            preparedSql.setString(2, objeto.getStatus());


            preparedSql.executeUpdate();
            connection.commit();
        }
        return this.consultarUsuario(objeto.getNome(), userLogado);


    }



    public List<ModelLogin> consultaUsuarioListPaginada(Long userLogado, Integer offset) throws Exception {
        List<ModelLogin> retorno = new ArrayList<ModelLogin>();
//        String sql = "SELECT * FROM model_login where useradmin is false and usuario_id= " + userLogado + "order by status offset "+offset+"limit 6";
        String sql = "SELECT * FROM model_login WHERE useradmin is false and usuario_id=? ORDER BY status offset ? limit 6";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1,userLogado);
        preparedSql.setLong(2,offset);
        ResultSet resultSet = preparedSql.executeQuery();
        while (resultSet.next()) {
            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setId(resultSet.getLong("id"));
            modelLogin.setNome(resultSet.getString("nome"));
            modelLogin.setStatus(resultSet.getString("status"));
            retorno.add(modelLogin);

        }




        return retorno;
    }


    public List<ModelLogin> consultaUsuarioList(Long userLogado) throws Exception {

        List <ModelLogin> retorno = new ArrayList<ModelLogin>();
        String sql = "SELECT * FROM model_login WHERE useradmin is false and usuario_id=? ORDER BY status limit 6";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1,userLogado);
        ResultSet resultSet = preparedSql.executeQuery();
        while (resultSet.next()) {
            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setId(resultSet.getLong("id"));
            modelLogin.setNome(resultSet.getString("nome"));
            modelLogin.setStatus(resultSet.getString("status"));
            retorno.add(modelLogin);
        }
        return retorno;
    }




    public int totalPagina(Long userLogado) throws Exception {
        String sql = "SELECT count(1) as total FROM model_login where usuario_id= " +userLogado;
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
            ;


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
          ;


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
