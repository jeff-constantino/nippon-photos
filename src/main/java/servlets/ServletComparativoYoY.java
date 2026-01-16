package servlets;

import com.google.gson.Gson;
import dao.DAOComparativoYoY;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelFechaMes;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ServletComparativoYoY")
public class ServletComparativoYoY extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: private final DAOComparativoYoY dao = new DAOComparativoYoY();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        String acao = request.getParameter("acao");

        if (acao == null || acao.isEmpty()) {
            response.sendRedirect("principal/comparativoYoY.jsp");
            return;
        }

        if ("buscarDados".equals(acao)) {
            buscarDadosPeriodo(request, response, conn);
        }
    }

    private void buscarDadosPeriodo(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
        String mesParam = request.getParameter("mes");
        String anoParam = request.getParameter("ano");
        String periodoParam = request.getParameter("periodo");

        if (mesParam == null || anoParam == null || periodoParam == null) {
            enviarErro(response, "Parâmetros inválidos");
            return;
        }

        try {
            int mes = Integer.parseInt(mesParam);
            int ano = Integer.parseInt(anoParam);
            int periodo = Integer.parseInt(periodoParam);

            DAOComparativoYoY dao = new DAOComparativoYoY(conn);
            ModelFechaMes dados = dao.buscarDadosMesAno(mes, ano);

            Map<String, Object> resultado = new HashMap<>();

            BigDecimal valorTotal = BigDecimal.ZERO;
            if (dados.getValor_din_mes_real() != null) valorTotal = valorTotal.add(dados.getValor_din_mes_real());
            if (dados.getValor_deb_mes_real() != null) valorTotal = valorTotal.add(dados.getValor_deb_mes_real());
            if (dados.getValor_cred_mes_real() != null) valorTotal = valorTotal.add(dados.getValor_cred_mes_real());
            if (dados.getValor_pix_mes_real() != null) valorTotal = valorTotal.add(dados.getValor_pix_mes_real());

            resultado.put("valorTotal", formatarValor(valorTotal));
            resultado.put("fotosVendidas", dados.getTotal_ft());
            resultado.put("sobras", dados.getTotal_sobras());

            BigDecimal ribbons = BigDecimal.ZERO;
            try {
                ribbons = dados.getTotal_ribbons_decimal() != null ? dados.getTotal_ribbons_decimal() : BigDecimal.ZERO;
            } catch (Exception e) {
                System.err.println("ERRO ao buscar ribbons: " + e.getMessage());
                e.printStackTrace();
            }
            resultado.put("ribbons", formatarValor(ribbons));
            resultado.put("vendasDiarias", montarVendasDiarias(dados));

            enviarJSON(response, resultado);

        } catch (NumberFormatException e) {
            enviarErro(response, "Formato de número inválido");
        } catch (SQLException e) {
            enviarErro(response, "Erro ao buscar dados no banco de dados: " + e.getMessage());
        } catch (Exception e) {
            enviarErro(response, "Erro inesperado: " + e.getMessage());
        }
    }

    private Object montarVendasDiarias(ModelFechaMes dados) {
        if (dados.getRelatorioDiario() == null || dados.getRelatorioDiario().isEmpty()) return new Object[0];
        return dados.getRelatorioDiario().stream().map(dia -> {
            Map<String, Object> diaMap = new HashMap<>();
            diaMap.put("dia", dia.getDia());
            diaMap.put("diaSemana", dia.getDiaSemana());
            diaMap.put("totalVendido", formatarValor(dia.getVenda_total_dia()));
            return diaMap;
        }).toArray();
    }

    private String formatarValor(BigDecimal valor) {
        if (valor == null) return "0,00";
        return String.format("%,.2f", valor).replace(",", "X").replace(".", ",").replace("X", ".");
    }

    private void enviarJSON(HttpServletResponse response, Object objeto) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        String json = gson.toJson(objeto);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    private void enviarErro(HttpServletResponse response, String mensagem) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, String> erro = new HashMap<>();
        erro.put("erro", mensagem);
        Gson gson = new Gson();
        String json = gson.toJson(erro);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}