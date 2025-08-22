package servlets;

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

@WebServlet ("/ServletDre")
public class ServletDre extends ServletGenericUtil{
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Redireciona para a página principal se a ação não for fornecida
            response.sendRedirect("principal/dre.jsp");
            // Importante retornar para evitar que o código continue
        }
        if ("relatorioMes".equals(acao)) {
            gerarDRE(request, response);
        }
    }
    private void gerarDRE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");

        DAORelMes daoRelMes = new DAORelMes();

        try {
            // Recupera a lista de vendas do banco de dados
            List<ModelFechaMes> vendasMesList = daoRelMes.buscarFechamentoMensal(dataInicial, dataFinal);


            // Passa a lista para o JSP
            request.setAttribute("vendasMesList", vendasMesList);

            RequestDispatcher rd = request.getRequestDispatcher("principal/dre.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório mensal", e);
        }
    }
}
