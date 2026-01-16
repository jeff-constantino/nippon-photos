package connection;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;


public class HikariCPUtil {

    private static HikariDataSource dataSource;

    static {
        try {
            System.out.println("🔵 Inicializando HikariCP...");

            HikariConfig config = new HikariConfig();

            // ✅ CONFIGURAÇÃO DO DRIVER (OBRIGATÓRIO)
            config.setDriverClassName("org.postgresql.Driver");

            // ✅ SUAS CONFIGURAÇÕES DE BANCO DE DADOS
            config.setJdbcUrl("jdbc:postgresql://localhost:5432/jeffe6510_nippon?sslmode=disable&tcpKeepAlive=true&socketTimeout=30");
            config.setUsername("jeffe6510_admin");
            config.setPassword("Aplic@tiv0");

            // Configurações do pool
            config.setMaximumPoolSize(20);           // Máximo de conexões no pool
            config.setMinimumIdle(5);                // Mínimo de conexões ociosas
            config.setConnectionTimeout(30000);      // Timeout para obter conexão (30s)
            config.setIdleTimeout(600000);           // Tempo que conexão pode ficar ociosa (10min)
            config.setMaxLifetime(1800000);          // Tempo máximo de vida da conexão (30min)

            // Configurações adicionais recomendadas
            config.setConnectionTestQuery("SELECT 1");
            config.setPoolName("HikariCP-Pool");

            // Propriedades do PostgreSQL
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

            dataSource = new HikariDataSource(config);

            System.out.println("✅ HikariCP inicializado com sucesso!");
            System.out.println("📊 Pool configurado: max=" + config.getMaximumPoolSize() + ", min=" + config.getMinimumIdle());
            System.out.println("🔗 Conectado ao banco: " + config.getJdbcUrl());

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