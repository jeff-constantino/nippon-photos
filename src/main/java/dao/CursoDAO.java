package dao;

import connection.ConnectionPool;
import model.Curso;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CursoDAO {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    /**
     * Construtor NOVO - recebe conexão gerenciada pelo Filter
     * USO RECOMENDADO
     */
    public CursoDAO(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false; // Filter gerencia
    }

    /**
     * Construtor LEGADO - busca própria conexão
     * Mantido para compatibilidade temporária
     */
    public CursoDAO() {
        try {
            this.connection = ConnectionPool.getConnection();
            this.gerenciarTransacao = true; // DAO gerencia
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    public List<Curso> listar() throws Exception {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM cursos WHERE ativo = true ORDER BY ordem, ano_conclusao DESC";

        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                lista.add(extrairCursoDoResultSet(rs));
            }

        } catch (SQLException e) {
            throw new Exception("Erro ao listar cursos: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }

        return lista;
    }

    public Curso buscarPorId(Long id) throws Exception {
        String sql = "SELECT * FROM cursos WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return extrairCursoDoResultSet(rs);
                }
            }

        } catch (SQLException e) {
            throw new Exception("Erro ao buscar curso por ID: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }

        return null;
    }

    public void inserir(Curso curso) throws Exception {
        String sql = "INSERT INTO cursos (nome_curso, instituicao, ano_conclusao, " +
                "carga_horaria, descricao, certificado_url, ordem, ativo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, curso.getNomeCurso());
            statement.setString(2, curso.getInstituicao());
            statement.setInt(3, curso.getAnoConclusao());
            statement.setInt(4, curso.getCargaHoraria());
            statement.setString(5, curso.getDescricao());
            statement.setString(6, curso.getCertificadoUrl());
            statement.setInt(7, curso.getOrdem());
            statement.setBoolean(8, curso.getAtivo());

            statement.executeUpdate();

            if (gerenciarTransacao) {
                connection.commit();
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new Exception("Erro ao inserir curso: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public void atualizar(Curso curso) throws Exception {
        String sql = "UPDATE cursos SET nome_curso=?, instituicao=?, ano_conclusao=?, " +
                "carga_horaria=?, descricao=?, certificado_url=?, ordem=?, ativo=? " +
                "WHERE id=?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
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

            if (gerenciarTransacao) {
                connection.commit();
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new Exception("Erro ao atualizar curso: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public void deletar(Long id) throws Exception {
        String sql = "DELETE FROM cursos WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            statement.executeUpdate();

            if (gerenciarTransacao) {
                connection.commit();
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new Exception("Erro ao deletar curso: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    public void desativar(Long id) throws Exception {
        String sql = "UPDATE cursos SET ativo = false WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            statement.executeUpdate();

            if (gerenciarTransacao) {
                connection.commit();
            }

        } catch (SQLException e) {
            if (gerenciarTransacao) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new Exception("Erro ao desativar curso: " + e.getMessage(), e);
        } finally {
            if (gerenciarTransacao) {
                fecharConexao();
            }
        }
    }

    // ===== MÉTODOS AUXILIARES =====

    /**
     * Extrai Curso do ResultSet (DRY - Don't Repeat Yourself)
     */
    private Curso extrairCursoDoResultSet(ResultSet rs) throws SQLException {
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

    /**
     * Fecha a conexão (apenas quando DAO gerencia)
     */
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