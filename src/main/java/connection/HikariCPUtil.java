package connection;

import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;


public class HikariCPUtil {

    private static HikariDataSource dataSource;

    static {
        try {
            System.out.println("🔵 Inicializando HikariCP...");

            dataSource = new HikariDataSource();

            // ✅ CONFIGURAÇÃO DO DRIVER (OBRIGATÓRIO)
            dataSource.setDriverClassName("org.postgresql.Driver");

            // ✅ SUAS CONFIGURAÇÕES DE BANCO DE DADOS
            dataSource.setJdbcUrl("jdbc:postgresql://localhost:5432/jeffe6510_nippon?sslmode=disable&tcpKeepAlive=true&socketTimeout=30");
            dataSource.setUsername("jeffe6510_admin");
            dataSource.setPassword("Aplic@tiv0");

            // Configurações do pool
            dataSource.setMaximumPoolSize(20);
            dataSource.setMinimumIdle(5);
            dataSource.setConnectionTimeout(30000);
            dataSource.setIdleTimeout(600000);
            dataSource.setMaxLifetime(1800000);

            // Configurações adicionais recomendadas
            dataSource.setConnectionTestQuery("SELECT 1");
            dataSource.setPoolName("HikariCP-Pool");

            // ✅ CONFIGURAÇÕES DE SHUTDOWN (NOVAS)
            dataSource.setRegisterMbeans(false);
            dataSource.setLeakDetectionThreshold(60000);

            // Propriedades do PostgreSQL
            dataSource.addDataSourceProperty("cachePrepStmts", "true");
            dataSource.addDataSourceProperty("prepStmtCacheSize", "250");
            dataSource.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

            System.out.println("✅ HikariCP inicializado com sucesso!");
            System.out.println("📊 Pool configurado: max=" + dataSource.getMaximumPoolSize() + ", min=" + dataSource.getMinimumIdle());
            System.out.println("🔗 Conectado ao banco: " + dataSource.getJdbcUrl());

        } catch (Exception e) {
            System.err.println("❌ ERRO ao inicializar HikariCP:");
            e.printStackTrace();
            throw new RuntimeException("Falha ao inicializar pool de conexões", e);
        }
    }

    /**
     * Obtém uma conexão do pool HikariCP.
     *
     * IMPORTANTE: A conexão DEVE ser fechada após o uso com connection.close()
     * Isso NÃO fecha a conexão de verdade, apenas a retorna para o pool.
     *
     * @return Connection do pool
     * @throws SQLException se não conseguir obter conexão
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource não inicializado!");
        }

        Connection conn = dataSource.getConnection();

        if (conn == null) {
            throw new SQLException("Não foi possível obter conexão do pool");
        }

        return conn;
    }

    /**
     * Obtém informações sobre o estado atual do pool.
     * Útil para debugging e monitoramento.
     */
    public static String getPoolStatus() {
        if (dataSource == null) {
            return "Pool não inicializado";
        }

        return String.format(
                "Pool Status: Total=%d, Ativa=%d, Ociosa=%d, Aguardando=%d",
                dataSource.getHikariPoolMXBean().getTotalConnections(),
                dataSource.getHikariPoolMXBean().getActiveConnections(),
                dataSource.getHikariPoolMXBean().getIdleConnections(),
                dataSource.getHikariPoolMXBean().getThreadsAwaitingConnection()
        );
    }

    /**
     * Fecha o pool de conexões.
     * Deve ser chamado apenas quando a aplicação for encerrada.
     */
    public static void close() {
        if (dataSource != null && !dataSource.isClosed()) {
            System.out.println("🔴 Fechando pool HikariCP...");
            dataSource.close();
            System.out.println("✅ Pool HikariCP fechado");
        }
    }

    /**
     * Verifica se o pool está funcionando corretamente.
     *
     * @return true se conseguir obter e fechar uma conexão de teste
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (Exception e) {
            System.err.println("❌ Falha no teste de conexão: " + e.getMessage());
            return false;
        }
    }
}