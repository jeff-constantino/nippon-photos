package servlets;

import dao.DAOFechaMes;
import dao.DAORelMes;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelFechaMes;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ServletRelMes")
public class ServletRelMes extends ServletGenericUtil{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if (acao == null || acao.isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/principal/relmes.jsp");
            return;
        }

        if ("relatorioMes".equals(acao)) {
            gerarRelatorioMensal(request, response);
        }
    }

    private void gerarRelatorioMensal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");

        DAORelMes daoRelMes = new DAORelMes();

        try {
            // Recupera a lista de vendas do banco de dados
            List<ModelFechaMes> vendasMesList = daoRelMes.buscarFechamentoMensal(dataInicial, dataFinal);


           // Passa a lista para o JSP
            request.setAttribute("vendasMesList", vendasMesList);

            RequestDispatcher rd = request.getRequestDispatcher("/principal/relmes.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório mensal", e);
        }
    }


}
