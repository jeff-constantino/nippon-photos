package dao;

import connection.SingleConnectionBanco;
import model.ModelLogin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DAOUsuarioRepository {

   private Connection connection;

    public DAOUsuarioRepository() {
    connection = SingleConnectionBanco.getConnection();

    }

    public ModelLogin gravarUsuario(ModelLogin objeto) throws Exception {

if(objeto.isNovo()) {

    String sql = "INSERT INTO model_login (nome) VALUES (?);";
    PreparedStatement preparedSql = connection.prepareStatement(sql);
    preparedSql.setString(1, objeto.getNome());
    preparedSql.execute();

    connection.commit();
} else {
    String sql = "UPDATE model_login SET nome = ? WHERE id = "+objeto.getId()+";";

    PreparedStatement preparedSql = connection.prepareStatement(sql);

    preparedSql.setString(1, objeto.getNome());

    preparedSql.executeUpdate();
    connection.commit();
}
       return this.consultarUsuario(objeto.getNome());


    }

    public ModelLogin consultarUsuario(String nome) throws Exception {

        ModelLogin modelLogin = new ModelLogin();
        String sql = "SELECT * FROM model_login WHERE upper(nome) = upper(?);";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultado = statement.executeQuery();
        while (resultado.next()) {
            modelLogin.setId(resultado.getLong("id"));
            modelLogin.setNome(resultado.getString("nome"));


        }
        return modelLogin;
    }

    public boolean validarLogin(String nome) throws Exception {
        String sql= "SELECT COUNT (1) > 0 AS EXISTE FROM model_login WHERE UPPER(nome) = UPPER (?);";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultado = statement.executeQuery();
        resultado.next();
            return resultado.getBoolean("existe");

    }

    public void deletarUser(String idUser) throws Exception {
        String sql = "DELETE FROM model_login WHERE id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, Long.parseLong(idUser));
        preparedSql.executeUpdate();
        connection.commit();
    }
}
