package dao;

import connection.HikariCPUtil; // Importe a classe que você corrigiu a URL
import model.ModelLogin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOLoginRepository {
    private final Connection connection;
    private final boolean gerenciarTransacao;

    /**
     * Construtor RECOMENDADO - Recebe a conexão do Filter
     */
    public DAOLoginRepository(Connection connection) {
        this.connection = connection;
        this.gerenciarTransacao = false;
    }

    /**
     * Construtor de SEGURANÇA - Caso a Servlet não passe a conexão,
     * ele busca na classe HikariCPUtil (ajustada para o banco oficial)
     */
    public DAOLoginRepository() {
        try {
            this.connection = HikariCPUtil.getConnection();
            this.gerenciarTransacao = true;
        } catch (SQLException e) {
            System.err.println("❌ Erro fatal: DAO não conseguiu conexão com o banco oficial.");
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    public boolean validarAutenticacao(ModelLogin modelLogin) throws Exception {
        // Log para conferir no servidor oficial se os dados estão chegando
        System.out.println("🔍 Verificando login para: " + modelLogin.getLogin());

        // IMPORTANTE: Verifique se no banco oficial o nome da tabela é exatamente model_login
        String sql = "SELECT * FROM model_login WHERE UPPER(login) = UPPER(?) AND senha = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, modelLogin.getLogin());
            ps.setString(2, modelLogin.getSenha());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("✅ Usuário " + modelLogin.getLogin() + " autenticado com sucesso!");
                    return true;
                } else {
                    System.out.println("⚠️ Login ou senha incorretos para: " + modelLogin.getLogin());
                    return false;
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Erro de SQL no banco oficial: " + e.getMessage());
            throw new Exception("Erro ao validar autenticação: " + e.getMessage(), e);
        } finally {
            // Se o DAO abriu a conexão sozinho, ele fecha. Se veio do Filter, o Filter fecha.
            if (gerenciarTransacao && connection != null) {
                fecharConexao();
            }
        }
    }

    private void fecharConexao() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao devolver conexão para o pool: " + e.getMessage());
            }
        }
    }
}