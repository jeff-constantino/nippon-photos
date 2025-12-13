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

    private static Connection connection;

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        connection = SingleConnectionBanco.getConnection();
        try {
            connection.setAutoCommit(false);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try {
            HttpServletRequest req = (HttpServletRequest) request;

            // 🔧 AJUSTE CRÍTICO 1: não cria sessão automaticamente
            HttpSession session = req.getSession(false);

            String usuarioLogado = (session != null)
                    ? (String) session.getAttribute("usuario")
                    : null;

            String urlParaAutenticar = req.getServletPath();

            // 🔧 AJUSTE CRÍTICO 2: URLs públicas
            boolean urlPublica =
                    urlParaAutenticar.equals("/principal/ServletLogin") ||
                            urlParaAutenticar.equals("/principal/paginaPublica.jsp");

            if (usuarioLogado == null && !urlPublica) {

                RequestDispatcher redireciona =
                        request.getRequestDispatcher("/crediario.jsp?url=" + urlParaAutenticar);

                request.setAttribute("msg", "Por favor realize o login!");
                redireciona.forward(request, response);
                return; // 🔧 AJUSTE CRÍTICO 3: garante parada do fluxo
            }

            connection.setAutoCommit(false);
            chain.doFilter(request, response);
            connection.commit();

        } catch (Exception e) {

            try {
                connection.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }

            e.printStackTrace();
            RequestDispatcher redireciona = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redireciona.forward(request, response);
        }
    }

    @Override
    public void destroy() {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
