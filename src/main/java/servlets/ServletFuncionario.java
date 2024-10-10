package servlets;

import dao.DAORelatorio;
import dao.DAOFuncionario;
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

@WebServlet("/ServletFuncionario")
public class ServletFuncionario extends ServletGenericUtil{


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtendo os parâmetros da requisição
        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            // Instancia o DAO para buscar os funcionários ativos
            DAORelatorio relatorio = new DAORelatorio(); // Ou DAO específico de login
            DAOFuncionario funcionario = new DAOFuncionario();
            List<ModelLogin> funcionariosAtivos = relatorio.buscaFuncionariosAtivos();

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();

            // Verifica se a ação é imprimir as vendas do funcionário
            if ("imprimirVendasFuncionario".equals(acao)) {
                // Busca as vendas com base nos filtros
                vendasFuncionarioList = relatorio.consultarVendasFuncionario(funcionarioId, dataInicial, dataFinal);
            }

            // Envia os dados de vendas de volta para o JSP
            request.setAttribute("vendasFuncionarioList", vendasFuncionarioList);
            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            // Envia a lista de funcionários ativos para o JSP
            request.setAttribute("funcionariosAtivos", funcionariosAtivos);

            // Redireciona para a página JSP com os resultados
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/relfunc.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Envia uma mensagem de erro para o JSP
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/relfunc.jsp");
            dispatcher.forward(request, response);
        }
    }

}
