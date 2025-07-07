package servlets;

import dao.DAOSalarios;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelLogin;
import model.ModelVendas;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/ServletSalarios")
public class ServletSalarios extends ServletGenericUtil{


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtendo os parâmetros da requisição
        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            // Instancia o DAO para buscar os funcionários
            DAOSalarios relatorio = new DAOSalarios();
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            // Adiciona lista de funcionários ao request para que esteja sempre disponível no JSP
            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();


            RequestDispatcher dispatcher;

            // Verifica se a ação é imprimir as vendas do funcionário
            if ("imprimirVendasFuncionario".equals(acao)) {
                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int resultadosPorPagina = 10; // ou qualquer número que você preferir
                int offset = (paginaAtual - 1) * resultadosPorPagina;

                // Busque as vendas com base nos filtros, passando o offset e o limit
                vendasFuncionarioList = relatorio.consultarVendasFuncionario(funcionarioId, dataInicial, dataFinal, offset, resultadosPorPagina);

                // Obtenha o total de resultados para a paginação
                int totalResultados = relatorio.contarVendasFuncionario(funcionarioId, dataInicial, dataFinal);
                int totalPaginas = (int) Math.ceil((double) totalResultados / resultadosPorPagina);

                // Adiciona as listas e as informações de paginação no request
                request.setAttribute("vendasFuncionarioList", vendasFuncionarioList);
                request.setAttribute("paginaAtual", paginaAtual);
                request.setAttribute("totalPaginas", totalPaginas);
            }

            // Envia os dados de vendas de volta para o JSP
            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            // Envia a lista de funcionários  para o JSP
            request.setAttribute("funcionarios", funcionarios);

            // Adiciona nome do mês e ano + grava mês/ano na sessão
            int mes = 0, ano = 0;
            if (dataInicial != null && !dataInicial.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(dataInicial);

                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                mes = cal.get(Calendar.MONTH) + 1;
                ano = cal.get(Calendar.YEAR);

                SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
                String mesAnoFormatado = sdfMesAno.format(date);
                request.setAttribute("mesAno", mesAnoFormatado);
            }

            // Salva na sessão para reutilizar no doPost
            HttpSession session = request.getSession();
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            // Redireciona para a página JSP com os resultados
            dispatcher = request.getRequestDispatcher("principal/salarios.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Envia uma mensagem de erro para o JSP
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/salarios.jsp");
            dispatcher.forward(request, response);
        }
    }


}
