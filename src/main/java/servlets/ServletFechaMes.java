package servlets;

import com.google.gson.Gson;
import dao.DAOFechaMes;
import dao.DAOFuncionario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelFechaMes;
import model.ModelLogin;
import model.ModelVendas;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet("/ServletFechaMes")
public class ServletFechaMes  extends ServletGenericUtil{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Redireciona para a página principal se a ação não for fornecida
            response.sendRedirect("principal/fechames.jsp");
            return; // Importante retornar para evitar que o código continue
        }

        if ("relatorioMes".equals(acao)) {
            gerarRelatorioMensal(request, response);
        }
    }



    private void gerarRelatorioMensal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId"); // Se necessário
        String acao = request.getParameter("acao");

        DAOFechaMes daoFechaMes = new DAOFechaMes();
        DAOFuncionario daoFuncionario = new DAOFuncionario();

        try {
            // Buscar fechamento do mês
            List<ModelFechaMes> vendasMesList = daoFechaMes.buscarFechamentoMensal(dataInicial, dataFinal);
            request.setAttribute("vendasMesList", vendasMesList);

            // Buscar lista de funcionários
            List<ModelLogin> funcionarios = daoFuncionario.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            // Buscar ranking de funcionários SEMPRE
            int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
            int registrosPorPagina = 10;
            int offset = (paginaAtual - 1) * registrosPorPagina;

            List<ModelVendas> vendasList = daoFuncionario.consultarRanking(dataInicial, dataFinal, offset, registrosPorPagina);
            request.setAttribute("vendasList", vendasList);

            // Converter vendasList para JSON (caso seja necessário para AJAX)
            Gson gson = new Gson();
            String vendasJson = gson.toJson(vendasList);
            request.setAttribute("vendasJson", vendasJson);

            // Calcular total de páginas
            int totalVendas = daoFuncionario.contarVendas(funcionarioId, dataInicial, dataFinal);
            int totalPaginas = (int) Math.ceil(totalVendas / (double) registrosPorPagina);

            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("paginaAtual", paginaAtual);

            // Preservar os filtros no request
            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

            // --- Adicionando o nome do mês e ano ---
            if (dataInicial != null && !dataInicial.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(dataInicial);

                SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
                String mesAnoFormatado = sdfMesAno.format(date);

                request.setAttribute("mesAno", mesAnoFormatado);
            }

            // Encaminha para fechames.jsp SEM redirecionamento para ranking.jsp
            RequestDispatcher rd = request.getRequestDispatcher("principal/fechames.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório mensal", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechames.jsp");
            dispatcher.forward(request, response);
        }
    }




}
