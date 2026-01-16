package servlets;

import dao.DAOContas;
import dao.DAODespesas;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;
import model.ModelDespesas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet("/ServletContasDespesasRel")
public class ServletContasDespesasRel extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: campos de DAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        String acao = request.getParameter("acao");

        if (acao == null || acao.isEmpty()) {
            response.sendRedirect("principal/contasDespesasRel.jsp");
            return;
        }

        if (acao.equals("gerarRelatorioMensal")) {
            gerarRelatorioMensal(request, response, conn);
        }
    }

    private void gerarRelatorioMensal(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");

        DAODespesas daoDespesas = new DAODespesas(conn);
        DAOContas daoContas = new DAOContas(conn);

        try {
            List<ModelContas> contasMes = daoContas.buscarContasMes(dataInicial, dataFinal);
            request.setAttribute("contasMes", contasMes);

            double valorContas = 0;
            for (ModelContas contas : contasMes) {
                valorContas += contas.getValor();
            }
            request.setAttribute("valorTotalContas", valorContas);

            List<ModelDespesas> despesasMes = daoDespesas.listarDespesasPorPeriodo(dataInicial, dataFinal);
            request.setAttribute("despesasMes", despesasMes);

            double valorTotal = 0;
            for (ModelDespesas despesa : despesasMes) {
                valorTotal += despesa.getValor_despesa();
            }
            request.setAttribute("valorTotalDespesas", valorTotal);

            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);

            if (dataInicial != null && !dataInicial.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(dataInicial);
                SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
                String mesAnoFormatado = sdfMesAno.format(date);
                request.setAttribute("mesAno", mesAnoFormatado);
            }

            RequestDispatcher rd = request.getRequestDispatcher("principal/contasDespesasRel.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório mensal", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/contasDespesasRel.jsp");
            dispatcher.forward(request, response);
        }
    }
}