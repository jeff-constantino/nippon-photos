package connection;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.SQLException;

@WebListener
public class SingleConnectionBanco implements ServletContextListener {

    private static HikariDataSource dataSource;
    private static final Object LOCK = new Object();

    private static void inicializarPool() {
        synchronized (LOCK) {
            if (dataSource == null || dataSource.isClosed()) {
                try {
                    // 🔥 ADICIONE ISSO: Carrega o driver antes
                    Class.forName("org.postgresql.Driver");

                    HikariConfig config = new HikariConfig();

                    // 🔥 OU adicione o driver no config
                    config.setDriverClassName("org.postgresql.Driver");

                    config.setJdbcUrl("jdbc:postgresql://localhost:5432/jeffe6510_nippon?sslmode=disable&tcpKeepAlive=true&socketTimeout=30");
                    config.setUsername("jeffe6510_admin");
                    config.setPassword("Aplic@tiv0");

                    config.setMaximumPoolSize(10);
                    config.setMinimumIdle(2);
                    config.setConnectionTimeout(30000);
                    config.setIdleTimeout(600000);
                    config.setMaxLifetime(1800000);
                    config.setAutoCommit(false);

                    config.addDataSourceProperty("cachePrepStmts", "true");
                    config.addDataSourceProperty("prepStmtCacheSize", "250");
                    config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

                    dataSource = new HikariDataSource(config);
                    System.out.println("✅ HikariCP Connection Pool inicializado");

                } catch (ClassNotFoundException e) {
                    throw new RuntimeException("Driver PostgreSQL não encontrado!", e);
                }
            }
        }
    }

    public static Connection getConnection() {
        if (dataSource == null || dataSource.isClosed()) {
            inicializarPool();
        }

        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🚀 Inicializando Connection Pool...");
        inicializarPool();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("✅ HikariCP fechado");
        }
    }
}