package servlets;

import dao.DAOConfig;
import dao.DAORelatorio;
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
    private DAORelatorio relatorio = new DAORelatorio();
    private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

    private DAOConfig daoConfig;

    @Override
    public void init() throws ServletException {
        super.init();
        daoConfig = new DAOConfig(); // Instanciar o DAOConfig aqui
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtendo os parâmetros da requisição
        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            // Instancia o DAO para buscar os funcionários ativos
            DAORelatorio relatorio = new DAORelatorio();
            List<ModelLogin> funcionariosAtivos = relatorio.buscaFuncionariosAtivos();

            List<ModelVendas> vendasList = new ArrayList<>();
            RequestDispatcher dispatcher;

            if ("imprimirRelatorioVendas".equals(acao)) {
                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int registrosPorPagina = 10;
                int offset = (paginaAtual - 1) * registrosPorPagina;

                // Busca de vendas com paginação
                vendasList = relatorio.consultarVendas(funcionarioId, dataInicial, dataFinal, offset, registrosPorPagina);

                // Adiciona vendasList no request para o JSP
                request.setAttribute("vendasList", vendasList);

                // Lógica para cálculo de total de páginas
                int totalVendas = relatorio.contarVendas(funcionarioId, dataInicial, dataFinal); // Método para contar registros
                int totalPaginas = (int) Math.ceil(totalVendas / (double) registrosPorPagina);

                // Adiciona totalPaginas e paginaAtual no request
                request.setAttribute("totalPaginas", totalPaginas);
                request.setAttribute("paginaAtual", paginaAtual);

                // Redireciona para a página JSP correta
                dispatcher = request.getRequestDispatcher("principal/relvendas.jsp");
            } else {
                // Lógica alternativa caso a ação não seja "imprimirRelatorioVendas"
                // Envia os dados de vendas de volta para o JSP
                request.setAttribute("vendasList", vendasList);
                request.setAttribute("dataInicial", dataInicial);
                request.setAttribute("dataFinal", dataFinal);
                request.setAttribute("funcionarioId", funcionarioId);

                // Envia a lista de funcionários ativos para o JSP
                request.setAttribute("funcionariosAtivos", funcionariosAtivos);

                // Redireciona para a página JSP com os resultados
                dispatcher = request.getRequestDispatcher("principal/relvendas.jsp");
            }

            // Realiza o redirecionamento em um único ponto
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/relvendas.jsp");
            dispatcher.forward(request, response);
        }
    }

}






