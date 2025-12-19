package servlets;

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

@WebServlet("/ServletRelVenda")
public class ServletRelVenda extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private final DAOFuncionario relatorio = new DAOFuncionario();
    private final DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

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
            // Instancia o DAO para buscar os funcionários (incluindo inativos se necessário)
            DAOFuncionario relatorio = new DAOFuncionario();
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();

            // Adiciona lista de funcionários ao request para que esteja sempre disponível no JSP
            request.setAttribute("funcionarios", funcionarios);

            // Inicializa a lista de vendas
            List<ModelVendas> vendasList = new ArrayList<>();

            if ("imprimirRelatorioVendas".equals(acao)) {
                // Busca TODAS as vendas sem paginação
                vendasList = relatorio.consultarVendasSemPaginacao(funcionarioId, dataInicial, dataFinal);

                // Adiciona vendasList no request para o JSP
                request.setAttribute("vendasList", vendasList);
            }

            // Adiciona os filtros ao request para que sejam preservados no JSP
            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            // Encaminha para o JSP
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






