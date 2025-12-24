package servlets;

import dao.PontoDAO;
import model.Ponto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/ponto-registrar")
public class PontoRegistrarServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Ponto func = (Ponto) session.getAttribute("pontoFunc");

        if (func == null) {
            resp.sendRedirect("ponto/registroponto.jsp");
            return;
        }

        try {
            PontoDAO dao = new PontoDAO();
            Date hoje = new Date(System.currentTimeMillis());
            dao.registrarPonto(func.getFuncId(), hoje);

            req.setAttribute("sucesso", "Ponto registrado!");
            req.getRequestDispatcher("ponto/registroponto.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro ao registrar: " + e.getMessage());
            req.getRequestDispatcher("ponto/registroponto.jsp").forward(req, resp);
        }
    }
}