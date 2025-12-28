package dao;

import connection.SingleConnectionBanco;
import model.Projeto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjetoDAO {
    private Connection connection;
    
    public ProjetoDAO() {
        connection = SingleConnectionBanco.getConnection();
    }
    
    public List<Projeto> listar() throws Exception {
        List<Projeto> lista = new ArrayList<>();
        String sql = "SELECT * FROM projetos WHERE ativo = true ORDER BY ordem";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();
        
        while (rs.next()) {
            Projeto projeto = mapResultSetToProjeto(rs);
            // Carregar funcionalidades
            projeto.setFuncionalidades(listarFuncionalidades(projeto.getId()));
            lista.add(projeto);
        }
        return lista;
    }
    
    public Projeto buscarPorId(Long id) throws Exception {
        String sql = "SELECT * FROM projetos WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);
        ResultSet rs = statement.executeQuery();
        
        if (rs.next()) {
            Projeto projeto = mapResultSetToProjeto(rs);
            projeto.setFuncionalidades(listarFuncionalidades(id));
            return projeto;
        }
        return null;
    }
    
    public void inserir(Projeto projeto) throws Exception {
        String sql = "INSERT INTO projetos (nome, descricao_curta, descricao_completa, " +
                    "icone, tecnologias, url_acesso, url_github, imagem_url, ordem, " +
                    "ativo, destaque) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, projeto.getNome());
        statement.setString(2, projeto.getDescricaoCurta());
        statement.setString(3, projeto.getDescricaoCompleta());
        statement.setString(4, projeto.getIcone());
        statement.setString(5, projeto.getTecnologias());
        statement.setString(6, projeto.getUrlAcesso());
        statement.setString(7, projeto.getUrlGithub());
        statement.setString(8, projeto.getImagemUrl());
        statement.setInt(9, projeto.getOrdem());
        statement.setBoolean(10, projeto.getAtivo());
        statement.setBoolean(11, projeto.getDestaque());
        statement.executeUpdate();
        
        // Pegar ID gerado
        ResultSet rs = statement.getGeneratedKeys();
        if (rs.next()) {
            Long projetoId = rs.getLong(1);
            // Inserir funcionalidades
            if (projeto.getFuncionalidades() != null) {
                inserirFuncionalidades(projetoId, projeto.getFuncionalidades());
            }
        }
        connection.commit();
    }
    
    public void atualizar(Projeto projeto) throws Exception {
        String sql = "UPDATE projetos SET nome=?, descricao_curta=?, descricao_completa=?, " +
                    "icone=?, tecnologias=?, url_acesso=?, url_github=?, imagem_url=?, " +
                    "ordem=?, ativo=?, destaque=? WHERE id=?";
        
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, projeto.getNome());
        statement.setString(2, projeto.getDescricaoCurta());
        statement.setString(3, projeto.getDescricaoCompleta());
        statement.setString(4, projeto.getIcone());
        statement.setString(5, projeto.getTecnologias());
        statement.setString(6, projeto.getUrlAcesso());
        statement.setString(7, projeto.getUrlGithub());
        statement.setString(8, projeto.getImagemUrl());
        statement.setInt(9, projeto.getOrdem());
        statement.setBoolean(10, projeto.getAtivo());
        statement.setBoolean(11, projeto.getDestaque());
        statement.setLong(12, projeto.getId());
        statement.executeUpdate();
        
        // Atualizar funcionalidades
        deletarFuncionalidades(projeto.getId());
        if (projeto.getFuncionalidades() != null) {
            inserirFuncionalidades(projeto.getId(), projeto.getFuncionalidades());
        }
        connection.commit();
    }
    
    public void deletar(Long id) throws Exception {
        // As funcionalidades serão deletadas automaticamente por CASCADE
        String sql = "DELETE FROM projetos WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);
        statement.executeUpdate();
        connection.commit();
    }
    
    public void desativar(Long id) throws Exception {
        String sql = "UPDATE projetos SET ativo = false WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, id);
        statement.executeUpdate();
        connection.commit();
    }
    
    // Métodos auxiliares para funcionalidades
    private List<String> listarFuncionalidades(Long projetoId) throws Exception {
        List<String> funcionalidades = new ArrayList<>();
        String sql = "SELECT funcionalidade FROM projeto_funcionalidades " +
                    "WHERE projeto_id = ? ORDER BY ordem";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, projetoId);
        ResultSet rs = statement.executeQuery();
        
        while (rs.next()) {
            funcionalidades.add(rs.getString("funcionalidade"));
        }
        return funcionalidades;
    }
    
    private void inserirFuncionalidades(Long projetoId, List<String> funcionalidades) throws Exception {
        String sql = "INSERT INTO projeto_funcionalidades (projeto_id, funcionalidade, ordem) " +
                    "VALUES (?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        
        int ordem = 1;
        for (String funcionalidade : funcionalidades) {
            statement.setLong(1, projetoId);
            statement.setString(2, funcionalidade);
            statement.setInt(3, ordem++);
            statement.executeUpdate();
        }
    }
    
    private void deletarFuncionalidades(Long projetoId) throws Exception {
        String sql = "DELETE FROM projeto_funcionalidades WHERE projeto_id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setLong(1, projetoId);
        statement.executeUpdate();
    }
    
    private Projeto mapResultSetToProjeto(ResultSet rs) throws SQLException {
        Projeto projeto = new Projeto();
        projeto.setId(rs.getLong("id"));
        projeto.setNome(rs.getString("nome"));
        projeto.setDescricaoCurta(rs.getString("descricao_curta"));
        projeto.setDescricaoCompleta(rs.getString("descricao_completa"));
        projeto.setIcone(rs.getString("icone"));
        projeto.setTecnologias(rs.getString("tecnologias"));
        projeto.setUrlAcesso(rs.getString("url_acesso"));
        projeto.setUrlGithub(rs.getString("url_github"));
        projeto.setImagemUrl(rs.getString("imagem_url"));
        projeto.setOrdem(rs.getInt("ordem"));
        projeto.setAtivo(rs.getBoolean("ativo"));
        projeto.setDestaque(rs.getBoolean("destaque"));
        projeto.setDataCadastro(rs.getTimestamp("data_cadastro"));
        return projeto;
    }
}
