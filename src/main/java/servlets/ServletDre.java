package servlets;

import dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelContas;
import model.ModelDespesas;
import model.ModelFechaMes;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet ("/ServletDre")
public class ServletDre extends ServletGenericUtil{
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Redireciona para a página principal se a ação não for fornecida
            response.sendRedirect("principal/dre.jsp");
            // Importante retornar para evitar que o código continue
        }
        if ("relatorioMes".equals(acao)) {
            gerarDRE(request, response);
        }
    }
    private void gerarDRE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");

        DAODre daoDre = new DAODre();
        DAOFechaMes daoFechaMes = new DAOFechaMes();
        DAOFuncionario daoFuncionario = new DAOFuncionario();
        DAOConfiguracao daoConfiguracao = new DAOConfiguracao();
        DAODespesas daoDespesas = new DAODespesas();
        DAOContas daoContas = new DAOContas();

        try {
            // Recupera a lista de vendas do banco de dados
            List<ModelFechaMes> vendasMesList = daoDre.buscarFechamentoMensal(dataInicial, dataFinal);
            // Passa a lista para o JSP
            request.setAttribute("vendasMesList", vendasMesList);
            List<ModelContas> contasMes = daoContas.buscarContasRelMes(dataInicial, dataFinal);
            request.setAttribute("contasMes", contasMes);

            // Para:
            BigDecimal valorContas = BigDecimal.ZERO;
            for (ModelContas contas : contasMes) {
                BigDecimal valorConta = BigDecimal.valueOf(contas.getValor()); // double para BigDecimal
                valorContas = valorContas.add(valorConta);
            }
// Formata com 2 casas decimais
            DecimalFormat df = new DecimalFormat("#,##0.00");
            String valorContasFormatado = df.format(valorContas);
            request.setAttribute("valorTotalContas", valorContasFormatado);


            List<ModelDespesas> despesasMes = daoDespesas.listarDespesasPorPeriodo(dataInicial, dataFinal);
            request.setAttribute("despesasMes", despesasMes);

            // Faça o mesmo para despesas:
            BigDecimal valorDespesas = BigDecimal.ZERO;
            for (ModelDespesas despesa : despesasMes) {
                BigDecimal valorDespesa = BigDecimal.valueOf(despesa.getValor_despesa()); // double para BigDecimal
                valorDespesas = valorDespesas.add(valorDespesa);
            }
            String valorDespesasFormatado = df.format(valorDespesas);
            request.setAttribute("valorTotalDespesas", valorDespesasFormatado);
            // Já vai estar disponível na lista vendasMesList
            if (!vendasMesList.isEmpty()) {
                BigDecimal totalSalarios = vendasMesList.get(0).getTotal_salarios();
                request.setAttribute("valorTotalSalarios", totalSalarios);
            }
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

// Para a sessão, mantenha os BigDecimal originais:
            HttpSession session = request.getSession();
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("valorTotalDespesas", valorDespesas); // BigDecimal sem formatação
            session.setAttribute("valorTotalContas", valorContas);     // BigDecimal sem formatação
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);



            RequestDispatcher rd = request.getRequestDispatcher("principal/dre.jsp");
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
