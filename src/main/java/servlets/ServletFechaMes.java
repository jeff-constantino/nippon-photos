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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

        // Processar o nome do mês e o ano
        String nomeMesAno = "";
        if (dataInicial != null && !dataInicial.isEmpty()) {
            LocalDate data = LocalDate.parse(dataInicial);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy", new Locale("pt", "BR"));
            nomeMesAno = data.format(formatter);
        }


        request.setAttribute("nomeMesAno", nomeMesAno); // Enviar para o JSP

        DAOFechaMes daoFechaMes = new DAOFechaMes();
        DAOFuncionario daoFuncionario = new DAOFuncionario();

        try {
            // Buscar fechamento do mês
            List<ModelFechaMes> vendasMesList = daoFechaMes.buscarFechamentoMensal(dataInicial, dataFinal);
            request.setAttribute("vendasMesList", vendasMesList);

            // Buscar lista de funcionários
            List<ModelLogin> funcionarios = daoFuncionario.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            // Encaminha para fechames.jsp
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
