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

@WebServlet("/ServletRelVenda")
public class ServletRelVenda extends ServletGenericUtil {
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
                vendasList = relatorio.consultarVendasSemPaginacao(funcionarioId, dataInicial, dataFinal);
                request.setAttribute("vendasList", vendasList);
            }

            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/relvendas.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/relvendas.jsp");
            dispatcher.forward(request, response);
        }
    }
}