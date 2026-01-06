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

    // 🔥 Inicializa o pool (lazy)
    private static void inicializarPool() {
        synchronized (LOCK) {
            if (dataSource == null || dataSource.isClosed()) {
                HikariConfig config = new HikariConfig();

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
            }
        }
    }

    // 🔥 Seus DAOs chamam isso (nada muda neles)
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