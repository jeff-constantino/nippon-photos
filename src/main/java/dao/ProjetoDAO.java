package dao;

import connection.ConnectionPool;
import model.Projeto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProjetoDAO {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    public ProjetoDAO(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    public ProjetoDAO() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão", e);
        }
    }

    public List<Projeto> listar() throws Exception {
        List<Projeto> lista = new ArrayList<>();
        String sql = "SELECT * FROM projetos WHERE ativo = true ORDER BY ordem, id";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                Projeto projeto = new Projeto();
                projeto.setId(rs.getLong("id"));
                projeto.setNome(rs.getString("nome"));
                projeto.setDescricao_curta(rs.getString("descricao_curta"));
                projeto.setDescricao_completa(rs.getString("descricao_completa"));
                projeto.setTecnologias(rs.getString("tecnologias"));
                projeto.setIcone(rs.getString("icone"));
                projeto.setUrl_acesso(rs.getString("url_acesso"));
                projeto.setStatus(rs.getString("status"));
                projeto.setFuncionalidades(rs.getString("funcionalidades"));
                projeto.setOrdem(rs.getInt("ordem"));
                projeto.setAtivo(rs.getBoolean("ativo"));
                projeto.setDataCadastro(rs.getTimestamp("data_cadastro"));
                lista.add(projeto);
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return lista;
    }

    public Projeto buscarPorId(Long id) throws Exception {
        String sql = "SELECT * FROM projetos WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Projeto projeto = new Projeto();
                projeto.setId(rs.getLong("id"));
                projeto.setNome(rs.getString("nome"));
                projeto.setDescricao_curta(rs.getString("descricao_curta"));
                projeto.setDescricao_completa(rs.getString("descricao_completa"));
                projeto.setTecnologias(rs.getString("tecnologias"));
                projeto.setIcone(rs.getString("icone"));
                projeto.setUrl_acesso(rs.getString("url_acesso"));
                projeto.setStatus(rs.getString("status"));
                projeto.setFuncionalidades(rs.getString("funcionalidades"));
                projeto.setOrdem(rs.getInt("ordem"));
                projeto.setAtivo(rs.getBoolean("ativo"));
                projeto.setDataCadastro(rs.getTimestamp("data_cadastro"));
                return projeto;
            }
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
        return null;
    }

    public void inserir(Projeto projeto) throws Exception {
        String sql = "INSERT INTO projetos (nome, descricao_curta, descricao_completa, tecnologias, icone, url_acesso, status, funcionalidades, ordem, ativo) VALUES (?, ?, ?, ?, ?, ?, ?, ?::jsonb, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, projeto.getNome());
            statement.setString(2, projeto.getDescricao_curta());
            statement.setString(3, projeto.getDescricao_completa());
            statement.setString(4, projeto.getTecnologias());
            statement.setString(5, projeto.getIcone());
            statement.setString(6, projeto.getUrl_acesso());
            statement.setString(7, projeto.getStatus() != null ? projeto.getStatus() : "ativo");
            statement.setString(8, projeto.getFuncionalidades());
            statement.setInt(9, projeto.getOrdem() != null ? projeto.getOrdem() : 0);
            statement.setBoolean(10, projeto.getAtivo());
            statement.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (Exception e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public void atualizar(Projeto projeto) throws Exception {
        String sql = "UPDATE projetos SET nome=?, descricao_curta=?, descricao_completa=?, tecnologias=?, icone=?, url_acesso=?, status=?, funcionalidades=?::jsonb, ordem=?, ativo=? WHERE id=?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, projeto.getNome());
            statement.setString(2, projeto.getDescricao_curta());
            statement.setString(3, projeto.getDescricao_completa());
            statement.setString(4, projeto.getTecnologias());
            statement.setString(5, projeto.getIcone());
            statement.setString(6, projeto.getUrl_acesso());
            statement.setString(7, projeto.getStatus() != null ? projeto.getStatus() : "ativo");
            statement.setString(8, projeto.getFuncionalidades());
            statement.setInt(9, projeto.getOrdem() != null ? projeto.getOrdem() : 0);
            statement.setBoolean(10, projeto.getAtivo());
            statement.setLong(11, projeto.getId());
            statement.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (Exception e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public void deletar(Long id) throws Exception {
        String sql = "DELETE FROM projetos WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            statement.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (Exception e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    public void desativar(Long id) throws Exception {
        String sql = "UPDATE projetos SET ativo = false WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            statement.executeUpdate();
            if (gerenciarTransacao) connection.commit();
        } catch (Exception e) {
            if (gerenciarTransacao) connection.rollback();
            throw e;
        } finally {
            if (gerenciarTransacao) fecharConexao();
        }
    }

    private void fecharConexao() {
        if (connection != null && gerenciarTransacao) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
}