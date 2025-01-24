package servlets;

import dao.DAOFechaMes;
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
        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Redireciona para a página principal se a ação não for fornecida
            response.sendRedirect("principal/relmes.jsp");
            return; // Importante retornar para evitar que o código continue
        }

        if ("relatorioMes".equals(acao)) {
            gerarRelatorioMensal(request, response);
        }
    }

    private void gerarRelatorioMensal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");

        DAOFechaMes daoFechaMes = new DAOFechaMes();

        try {
            List<ModelFechaMes> vendasMesList = daoFechaMes.buscarFechamentoMensal(dataInicial, dataFinal);
            request.setAttribute("vendasMesList", vendasMesList);
            RequestDispatcher rd = request.getRequestDispatcher("principal/relmes.jsp"); // Altere o nome do JSP que exibe a tabela
            rd.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório mensal", e);
        }
    }
}
