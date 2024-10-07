package servlets;

import dao.DAOContas;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ServletPrincipal", value = "/ServletPrincipal")
public class ServletPrincipal extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DAOContas daoContas = new DAOContas(); // Instância do DAOContas

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verifica se o usuário está logado
        if (request.getSession().getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/ServletLogin");
            return;
        }

        // Buscar contas vencendo em 7 dias
        List<ModelContas> contasVencendo = null;
        try {
            contasVencendo = daoContas.buscarContasVencendoEm7Dias();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("contasVencendo", contasVencendo);

        // Redireciona para a página principal
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/principal.jsp");
        dispatcher.forward(request, response);
    }
}
