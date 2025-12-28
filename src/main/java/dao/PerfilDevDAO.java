package dao;

import connection.SingleConnectionBanco;
import model.PerfilDev;

import java.sql.*;

public class PerfilDevDAO {
    private Connection connection;
    
    public PerfilDevDAO() {
        connection = SingleConnectionBanco.getConnection();
    }
    
    public PerfilDev getPerfil() throws Exception {
        String sql = "SELECT * FROM perfil_dev LIMIT 1";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        
        if (rs.next()) {
            PerfilDev perfil = new PerfilDev();
            perfil.setId(rs.getLong("id"));
            perfil.setNome(rs.getString("nome"));
            perfil.setTitulo(rs.getString("titulo"));
            perfil.setDescricao(rs.getString("descricao"));
            perfil.setFotoUrl(rs.getString("foto_url"));
            perfil.setEmail(rs.getString("email"));
            perfil.setTelefone(rs.getString("telefone"));
            perfil.setLinkedin(rs.getString("linkedin"));
            perfil.setGithub(rs.getString("github"));
            perfil.setEscolaridade(rs.getString("escolaridade"));
            perfil.setDataAtualizacao(rs.getTimestamp("data_atualizacao"));
            return perfil;
        }
        return null;
    }
    
    public void updatePerfil(PerfilDev perfil) throws Exception {
        String sql = "UPDATE perfil_dev SET nome=?, titulo=?, descricao=?, " +
                    "foto_url=?, email=?, telefone=?, linkedin=?, github=?, " +
                    "escolaridade=?, data_atualizacao=CURRENT_TIMESTAMP WHERE id=?";
        
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, perfil.getNome());
        statement.setString(2, perfil.getTitulo());
        statement.setString(3, perfil.getDescricao());
        statement.setString(4, perfil.getFotoUrl());
        statement.setString(5, perfil.getEmail());
        statement.setString(6, perfil.getTelefone());
        statement.setString(7, perfil.getLinkedin());
        statement.setString(8, perfil.getGithub());
        statement.setString(9, perfil.getEscolaridade());
        statement.setLong(10, perfil.getId());
        statement.executeUpdate();
        connection.commit();
    }
}
