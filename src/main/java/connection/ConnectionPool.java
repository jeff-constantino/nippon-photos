package connection;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionPool {
    private static HikariDataSource dataSource;

    static {
        try {
            HikariConfig config = new HikariConfig();

            // Configurações da conexão
            config.setJdbcUrl("jdbc:postgresql://ic-postgresql-QHPA:5432/jeffe6510_nippon");
            config.setUsername("jeffe6510_admin");
            config.setPassword("Aplic@tiv0");
            config.setDriverClassName("org.postgresql.Driver");

            // Pool settings
            config.setMaximumPoolSize(10);           // Máximo de conexões
            config.setMinimumIdle(2);                // Mínimo de conexões ociosas
            config.setConnectionTimeout(30000);      // 30 segundos timeout
            config.setIdleTimeout(600000);           // 10 minutos idle
            config.setMaxLifetime(1800000);          // 30 minutos max lifetime

            // Configurações PostgreSQL específicas
            config.addDataSourceProperty("tcpKeepAlive", "true");
            config.addDataSourceProperty("socketTimeout", "30");

            // Validação de conexão
            config.setConnectionTestQuery("SELECT 1");
            config.setValidationTimeout(5000);

            // Pool name para debug
            config.setPoolName("NipponPool");

            // Auto commit
            config.setAutoCommit(false);

            dataSource = new HikariDataSource(config);

            System.out.println("✅ HikariCP Pool inicializado com sucesso!");

        } catch (Exception e) {
            System.err.println("❌ Erro ao inicializar HikariCP Pool:");
            e.printStackTrace();
            throw new RuntimeException("Falha ao inicializar connection pool", e);
        }
    }

    /**
     * Obtém uma conexão do pool
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource não inicializado");
        }
        return dataSource.getConnection();
    }

    /**
     * Fecha o pool (usar apenas no shutdown da aplicação)
     */
    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("✅ HikariCP Pool fechado com sucesso!");
        }
    }

    /**
     * Retorna informações do pool para debug
     */
    public static String getPoolStats() {
        if (dataSource != null) {
            return String.format(
                    "Pool Stats - Active: %d, Idle: %d, Total: %d, Waiting: %d",
                    dataSource.getHikariPoolMXBean().getActiveConnections(),
                    dataSource.getHikariPoolMXBean().getIdleConnections(),
                    dataSource.getHikariPoolMXBean().getTotalConnections(),
                    dataSource.getHikariPoolMXBean().getThreadsAwaitingConnection()
            );
        }
        return "Pool não inicializado";
    }
}