package servlets;

import com.google.gson.Gson;
import dao.DAOConfig;
import dao.DAOFuncionario;
import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelVendas;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ServletRanking")
public class ServletRanking extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOFuncionario relatorio = new DAOFuncionario();
    private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

    private DAOConfig daoConfig;

    @Override
    public void init() throws ServletException {
        super.init();
        daoConfig = new DAOConfig(); // Instanciar o DAOConfig aqui
    }

    @Override
    // Obtendo os parâmetros da requisição
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtendo os parâmetros da requisição
        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            // Instancia o DAO para buscar os funcionários
            DAOFuncionario relatorio = new DAOFuncionario();
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();

            // Adiciona a lista de funcionários ao request
            request.setAttribute("funcionarios", funcionarios);

            // Inicializa a lista de vendas
            List<ModelVendas> vendasList = new ArrayList<>();

            if ("imprimirRelatorioVendas".equals(acao)) {
                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int registrosPorPagina = 10;
                int offset = (paginaAtual - 1) * registrosPorPagina;


                vendasList = relatorio.consultarRanking(dataInicial, dataFinal, offset, registrosPorPagina);

                // Converte vendasList em JSON
                Gson gson = new Gson();
                String vendasJson = gson.toJson(vendasList);

                // Adiciona vendasList e vendasJson ao request
                request.setAttribute("vendasList", vendasList);
                request.setAttribute("vendasJson", vendasJson);

                // Lógica para cálculo de total de páginas
                int totalVendas = relatorio.contarVendas(funcionarioId, dataInicial, dataFinal);
                int totalPaginas = (int) Math.ceil(totalVendas / (double) registrosPorPagina);

                // Adiciona totalPaginas e paginaAtual no request
                request.setAttribute("totalPaginas", totalPaginas);
                request.setAttribute("paginaAtual", paginaAtual);
            }

            // Adiciona os filtros ao request para que sejam preservados no JSP
            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            // Encaminha para o JSP
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






