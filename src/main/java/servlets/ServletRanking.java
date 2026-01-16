package servlets;

import com.google.gson.Gson;
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

@WebServlet("/ServletRanking")
public class ServletRanking extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: private final DAOFuncionario relatorio
    // ✅ REMOVIDO: private final DAOUsuarioRepository daoUsuarioRepository
    // ✅ REMOVIDO: private DAOConfig daoConfig
    // ✅ REMOVIDO: init()

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");

        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            DAOFuncionario relatorio = new DAOFuncionario(conn);
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();

            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasList = new ArrayList<>();

            if ("imprimirRelatorioVendas".equals(acao)) {
                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int registrosPorPagina = 10;
                int offset = (paginaAtual - 1) * registrosPorPagina;

                vendasList = relatorio.consultarRanking(dataInicial, dataFinal, offset, registrosPorPagina);

                Gson gson = new Gson();
                String vendasJson = gson.toJson(vendasList);

                request.setAttribute("vendasList", vendasList);
                request.setAttribute("vendasJson", vendasJson);

                int totalVendas = relatorio.contarVendas(funcionarioId, dataInicial, dataFinal);
                int totalPaginas = (int) Math.ceil(totalVendas / (double) registrosPorPagina);

                request.setAttribute("totalPaginas", totalPaginas);
                request.setAttribute("paginaAtual", paginaAtual);
            }

            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/ranking.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/ranking.jsp");
            dispatcher.forward(request, response);
        }
    }
}