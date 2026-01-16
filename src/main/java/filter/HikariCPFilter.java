package filter;

import connection.HikariCPUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;


@WebFilter(filterName = "HikariCPFilter", urlPatterns = {"/*"})
public class HikariCPFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("🔵 Filter inicializado - usando HikariCP");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        Connection connection = null;
        boolean commitSuccess = false;

        try {
            // 1. Obtém Connection do pool HikariCP
            connection = HikariCPUtil.getConnection();

            if (connection == null) {
                throw new ServletException("❌ Não foi possível obter conexão do pool HikariCP");
            }

            // 2. Desabilita autocommit para controle manual de transações
            connection.setAutoCommit(false);

            // 3. Injeta a Connection no request para que todas as Servlets/DAOs possam usar
            request.setAttribute("connection", connection);

            // 4. Continua a cadeia de filtros/servlets
            chain.doFilter(request, response);

            // 5. Se chegou aqui sem exceções, commit da transação
            connection.commit();
            commitSuccess = true;

        } catch (SQLException e) {
            System.err.println("❌ Erro SQL no Filter: " + e.getMessage());
            e.printStackTrace();

            // Tenta fazer rollback
            if (connection != null) {
                try {
                    connection.rollback();
                    System.out.println("🔄 Rollback executado com sucesso");
                } catch (SQLException ex) {
                    System.err.println("❌ Erro ao fazer rollback: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }

            throw new ServletException("Erro de banco de dados", e);

        } catch (Exception e) {
            System.err.println("❌ Erro genérico no Filter: " + e.getMessage());
            e.printStackTrace();

            // Tenta fazer rollback
            if (connection != null) {
                try {
                    connection.rollback();
                    System.out.println("🔄 Rollback executado com sucesso");
                } catch (SQLException ex) {
                    System.err.println("❌ Erro ao fazer rollback: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }

            throw new ServletException("Erro ao processar requisição", e);

        } finally {
            // 6. SEMPRE fecha a Connection (retorna ao pool)
            if (connection != null) {
                try {
                    connection.close();

                    if (!commitSuccess) {
                        System.out.println("⚠️ Connection fechada (houve erro - rollback já foi feito)");
                    }
                } catch (SQLException e) {
                    System.err.println("❌ Erro ao fechar connection: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void destroy() {
        System.out.println("🔴 Filter destruído");
        // O HikariCP será fechado quando a aplicação for encerrada (via ServletContextListener ou shutdown hook)
    }
}