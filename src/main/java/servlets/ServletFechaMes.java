package servlets;

import com.google.gson.Gson;
import dao.DAOConfig;
import dao.DAOConfiguracao;
import dao.DAOFechaMes;
import dao.DAOFuncionario;
import dao.DAODespesas;
import dao.DAOContas;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet("/ServletFechaMes")
public class ServletFechaMes  extends ServletGenericUtil{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Encaminha para a página principal sem mudar o endereço no navegador
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/fechames.jsp");
            dispatcher.forward(request, response);
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
        DAOConfiguracao daoConfiguracao = new DAOConfiguracao();
        DAODespesas daoDespesas = new DAODespesas();
        DAOContas daoContas = new DAOContas();

        try {
            List<ModelContas> contasMes = daoContas.buscarContasMes(dataInicial, dataFinal);
            request.setAttribute("contasMes", contasMes);
            // Calcular o total das despesas
            double valorContas = 0;
            for (ModelContas contas : contasMes) {
                valorContas += contas.getValor();  // Adiciona o valor da despesa ao total
            }
            request.setAttribute("valorTotalContas", valorContas);  // Passa o valor total para a JSP

            List<ModelDespesas> despesasMes = daoDespesas.listarDespesasPorPeriodo(dataInicial,dataFinal);
            request.setAttribute("despesasMes", despesasMes);
            // Calcular o total das despesas
            double valorTotal = 0;
            for (ModelDespesas despesa : despesasMes) {
                valorTotal += despesa.getValor_despesa();  // Adiciona o valor da despesa ao total
            }
            request.setAttribute("valorTotalDespesas", valorTotal);  // Passa o valor total para a JSP


            List<ModelFechaMes> vendasMesList = daoFechaMes.buscarFechamentoMensal(dataInicial, dataFinal);
            request.setAttribute("vendasMesList", vendasMesList);

            List<ModelConfiguracao> configsJuros = daoConfiguracao.consultarJuros();
            request.setAttribute("configsJuros", configsJuros);

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
