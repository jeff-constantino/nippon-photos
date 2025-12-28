package dao;

import connection.SingleConnectionBanco;
import model.Curso;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CursoDAO {
    private Connection connection;
    
    public CursoDAO() {
        connection = SingleConnectionBanco.getConnection();
    }
    
    public List<Curso> listar() throws Exception {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM cursos WHERE ativo = true ORDER BY ordem, ano_conclusao DESC";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        
        while (rs.next()) {
            Curso curso = new Curso();
            curso.setId(rs.getLong("id"));
            curso.setNomeCurso(rs.getString("nome_curso"));
            curso.setInstituicao(rs.getString("instituicao"));
            curso.setAnoConclusao(rs.getInt("ano_conclusao"));
            curso.setCargaHoraria(rs.getInt("carga_horaria"));
            curso.setDescricao(rs.getString("descricao"));
            curso.setCertificadoUrl(rs.getString("certificado_url"));
            curso.setOrdem(rs.getInt("ordem"));
            curso.setAtivo(rs.getBoolean("ativo"));
            curso.setDataCadastro(rs.getTimestamp("data_cadastro"));
            lista.add(curso);
        }
        return lista;
    }
    
    public Curso buscarPorId(Long id) throws Exception {
        String sql = "SELECT * FROM cursos WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);
        ResultSet rs = statement.executeQuery();
        
        if (rs.next()) {
            Curso curso = new Curso();
            curso.setId(rs.getLong("id"));
            curso.setNomeCurso(rs.getString("nome_curso"));
            curso.setInstituicao(rs.getString("instituicao"));
            curso.setAnoConclusao(rs.getInt("ano_conclusao"));
            curso.setCargaHoraria(rs.getInt("carga_horaria"));
            curso.setDescricao(rs.getString("descricao"));
            curso.setCertificadoUrl(rs.getString("certificado_url"));
            curso.setOrdem(rs.getInt("ordem"));
            curso.setAtivo(rs.getBoolean("ativo"));
            curso.setDataCadastro(rs.getTimestamp("data_cadastro"));
            return curso;
        }
        return null;
    }
    
    public void inserir(Curso curso) throws Exception {
        String sql = "INSERT INTO cursos (nome_curso, instituicao, ano_conclusao, " +
                    "carga_horaria, descricao, certificado_url, ordem, ativo) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, curso.getNomeCurso());
        statement.setString(2, curso.getInstituicao());
        statement.setInt(3, curso.getAnoConclusao());
        statement.setInt(4, curso.getCargaHoraria());
        statement.setString(5, curso.getDescricao());
        statement.setString(6, curso.getCertificadoUrl());
        statement.setInt(7, curso.getOrdem());
        statement.setBoolean(8, curso.getAtivo());
        statement.executeUpdate();
        connection.commit();
    }
    
    public void atualizar(Curso curso) throws Exception {
        String sql = "UPDATE cursos SET nome_curso=?, instituicao=?, ano_conclusao=?, " +
                    "carga_horaria=?, descricao=?, certificado_url=?, ordem=?, ativo=? " +
                    "WHERE id=?";
        
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, curso.getNomeCurso());
        statement.setString(2, curso.getInstituicao());
        statement.setInt(3, curso.getAnoConclusao());
        statement.setInt(4, curso.getCargaHoraria());
        statement.setString(5, curso.getDescricao());
        statement.setString(6, curso.getCertificadoUrl());
        statement.setInt(7, curso.getOrdem());
        statement.setBoolean(8, curso.getAtivo());
        statement.setLong(9, curso.getId());
        statement.executeUpdate();
        connection.commit();
    }
    
    public void deletar(Long id) throws Exception {
        String sql = "DELETE FROM cursos WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);
        statement.executeUpdate();
        connection.commit();
    }
    
    public void desativar(Long id) throws Exception {
        String sql = "UPDATE cursos SET ativo = false WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);
        statement.executeUpdate();
        connection.commit();
    }
}
