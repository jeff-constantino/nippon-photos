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

    // 🔥 Os DAOs continuam chamando isso sem mudanças!
    public static Connection getConnection() {
        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter conexão do pool", e);
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        HikariConfig config = new HikariConfig();

        // Configurações do banco
        config.setJdbcUrl("jdbc:postgresql://localhost:5432/jeffe6510_nippon?sslmode=disable&tcpKeepAlive=true&socketTimeout=30");
        config.setUsername("jeffe6510_admin");
        config.setPassword("Aplic@tiv0");

        // Configurações do pool
        config.setMaximumPoolSize(10);           // máximo de conexões
        config.setMinimumIdle(2);                // mínimo de conexões ociosas
        config.setConnectionTimeout(30000);      // 30 segundos timeout
        config.setIdleTimeout(600000);           // 10 minutos idle
        config.setMaxLifetime(1800000);          // 30 minutos vida máxima
        config.setAutoCommit(false);             // 🔥 IMPORTANTE: false para controle manual

        // Configurações extras
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

        dataSource = new HikariDataSource(config);
        System.out.println("✅ HikariCP Connection Pool iniciado");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("✅ HikariCP Connection Pool fechado");
        }
    }
}