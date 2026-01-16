package servlets;

import dao.DAOContas;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ModelContas;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet(name = "ServletPrincipal", value = "/ServletPrincipal")
public class ServletPrincipal extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: private final DAOContas daoContas

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOContas daoContas = new DAOContas(conn);

        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/ServletLogin");
            return;
        }

        List<ModelContas> contasVencendo = null;
        try {
            contasVencendo = daoContas.buscarContasVencendoEm7Dias();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("contasVencendo", contasVencendo);

        List<ModelContas> contasVencidas = null;
        try {
            contasVencidas = daoContas.buscarContasVencidas();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("contasVencidas", contasVencidas);

        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/principal.jsp");
        dispatcher.forward(request, response);
    }
}