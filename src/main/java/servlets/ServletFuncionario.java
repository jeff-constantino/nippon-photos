package servlets;

import dao.DAOFuncionario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelVendas;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ServletFuncionario")
public class ServletFuncionario extends ServletGenericUtil {
    // ✅ Não tinha campos DAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOFuncionario relatorio = new DAOFuncionario(conn);

        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();

            RequestDispatcher dispatcher;

            if ("imprimirVendasFuncionario".equals(acao)) {
                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int resultadosPorPagina = 10;
                int offset = (paginaAtual - 1) * resultadosPorPagina;

                vendasFuncionarioList = relatorio.consultarVendasFuncionario(funcionarioId, dataInicial, dataFinal, offset, resultadosPorPagina);

                int totalResultados = relatorio.contarVendasFuncionario(funcionarioId, dataInicial, dataFinal);
                int totalPaginas = (int) Math.ceil((double) totalResultados / resultadosPorPagina);

                request.setAttribute("vendasFuncionarioList", vendasFuncionarioList);
                request.setAttribute("paginaAtual", paginaAtual);
                request.setAttribute("totalPaginas", totalPaginas);
            }

            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);
            request.setAttribute("funcionarios", funcionarios);

            dispatcher = request.getRequestDispatcher("principal/relfunc.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/relfunc.jsp");
            dispatcher.forward(request, response);
        }
    }
}