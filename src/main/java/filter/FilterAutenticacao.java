package filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import connection.SingleConnectionBanco;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/principal/*"})
public class FilterAutenticacao implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        Connection connection = null;

        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpSession session = req.getSession(false);

            String usuarioLogado = (session != null)
                    ? (String) session.getAttribute("usuario")
                    : null;

            String urlParaAutenticar = req.getServletPath();
            boolean urlPublica = urlParaAutenticar.equals("/principal/ServletLogin");

            if (usuarioLogado == null && !urlPublica) {
                RequestDispatcher redireciona =
                        request.getRequestDispatcher("/index.jsp?url=" + urlParaAutenticar);
                request.setAttribute("msg", "Por favor realize o login!");
                redireciona.forward(request, response);
                return;
            }

            connection = SingleConnectionBanco.getConnection();
            request.setAttribute("connection", connection);

            chain.doFilter(request, response);

            // ❌ REMOVIDO: connection.commit();
            // Os DAOs já fazem commit()

        } catch (Exception e) {
            // Rollback em caso de erro
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }

            e.printStackTrace();
            RequestDispatcher redireciona = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redireciona.forward(request, response);

        } finally {
            // 🔥 CRÍTICO: Devolve conexão ao pool
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void destroy() {
        // Não precisa fazer nada
    }
}