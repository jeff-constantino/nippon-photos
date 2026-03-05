package connection;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppShutdownListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🟢 Aplicação iniciada");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🔴 Aplicação sendo encerrada - fechando pools...");

        try {
            HikariCPUtil.close();
            System.out.println("✅ Pool HikariCP fechado com sucesso");
        } catch (Exception e) {
            System.err.println("❌ Erro ao fechar HikariCP: " + e.getMessage());
        }

        try {
            ConnectionPool.closePool();
            System.out.println("✅ Pool NipponPool fechado com sucesso");
        } catch (Exception e) {
            System.err.println("❌ Erro ao fechar NipponPool: " + e.getMessage());
        }
    }
}