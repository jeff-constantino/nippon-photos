package servlets;

import com.google.gson.Gson;
import dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet("/ServletFechaMes")
public class ServletFechaMes extends ServletGenericUtil {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if (acao == null || acao.isEmpty()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/fechames.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if ("relatorioMes".equals(acao)) {
            gerarRelatorioMensal(request, response);
        }
    }

    private void gerarRelatorioMensal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        DAOFechaMes daoFechaMes = new DAOFechaMes();
        DAOFuncionario daoFuncionario = new DAOFuncionario();
        DAOConfiguracao daoConfiguracao = new DAOConfiguracao();
        DAODespesas daoDespesas = new DAODespesas();
        DAOContas daoContas = new DAOContas();

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

            double valorDespesas = 0;
            for (ModelDespesas despesa : despesasMes) {
                valorDespesas += despesa.getValor_despesa();
            }
            request.setAttribute("valorTotalDespesas", valorDespesas);

            List<ModelFechaMes> vendasMesList = daoFechaMes.buscarFechamentoMensal(dataInicial, dataFinal);
            request.setAttribute("vendasMesList", vendasMesList);

            List<ModelConfiguracao> configsJuros = daoConfiguracao.consultarJuros();
            request.setAttribute("configsJuros", configsJuros);

            List<ModelLogin> funcionarios = daoFuncionario.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
            int registrosPorPagina = 10;
            int offset = (paginaAtual - 1) * registrosPorPagina;

            List<ModelVendas> vendasList = daoFuncionario.consultarRanking(dataInicial, dataFinal, offset, registrosPorPagina);
            request.setAttribute("vendasList", vendasList);

            String vendasJson = new Gson().toJson(vendasList);
            request.setAttribute("vendasJson", vendasJson);

            int totalVendas = daoFuncionario.contarVendas(funcionarioId, dataInicial, dataFinal);
            int totalPaginas = (int) Math.ceil(totalVendas / (double) registrosPorPagina);

            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("paginaAtual", paginaAtual);
            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

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
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("valorTotalDespesas", BigDecimal.valueOf(valorDespesas));
            session.setAttribute("valorTotalContas", BigDecimal.valueOf(valorContas));
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

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

    // ============================
    // doPost: Grava o fechamento
    // ============================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();

            @SuppressWarnings("unchecked")
            List<ModelFechaMes> vendasMesList = (List<ModelFechaMes>) session.getAttribute("vendasMesList");

            BigDecimal valorTotalDespesas = (BigDecimal) session.getAttribute("valorTotalDespesas");
            BigDecimal valorTotalContas = (BigDecimal) session.getAttribute("valorTotalContas");
            int mes = (int) session.getAttribute("mes");
            int ano = (int) session.getAttribute("ano");

            if (vendasMesList == null || vendasMesList.isEmpty()) {
                request.setAttribute("msg", "Não há dados para gravar o fechamento.");
                request.getRequestDispatcher("principal/fechames.jsp").forward(request, response);
                return;
            }

            ModelFechaMes resumo = vendasMesList.get(0);

            BigDecimal totalRibbons = BigDecimal.ZERO;

            if (resumo.getConf1_qtd() > 0) {
                BigDecimal conf1Qtd = BigDecimal.valueOf(resumo.getConf1_qtd());
                BigDecimal totalFt = BigDecimal.valueOf(resumo.getTotal_ft());
                BigDecimal totalSobras = BigDecimal.valueOf(resumo.getTotal_sobras());

                totalRibbons = totalFt.add(totalSobras).divide(conf1Qtd, 2, RoundingMode.HALF_UP);
            }

            BigDecimal valorDin = resumo.getValor_din_mes_real() != null ? resumo.getValor_din_mes_real() : BigDecimal.ZERO;
            BigDecimal valorDeb = resumo.getValor_deb_mes_real() != null ? resumo.getValor_deb_mes_real() : BigDecimal.ZERO;
            BigDecimal valorCred = resumo.getValor_cred_mes_real() != null ? resumo.getValor_cred_mes_real() : BigDecimal.ZERO;
            BigDecimal valorPix = resumo.getValor_pix_mes_real() != null ? resumo.getValor_pix_mes_real() : BigDecimal.ZERO;

            BigDecimal totalGeral = valorDin.add(valorDeb).add(valorCred).add(valorPix);

            BigDecimal jurosDebitoVm = parseBigDecimal(request.getParameter("jurosDebitoVm"));
            BigDecimal jurosCreditoVm = parseBigDecimal(request.getParameter("jurosCreditoVm"));
            BigDecimal jurosDebitoOutros = parseBigDecimal(request.getParameter("jurosDebitoOutros"));
            BigDecimal jurosCreditoOutros = parseBigDecimal(request.getParameter("jurosCreditoOutros"));
            BigDecimal totalJuros = jurosDebitoVm.add(jurosCreditoVm).add(jurosDebitoOutros).add(jurosCreditoOutros);

            BigDecimal debitoVm = parseBigDecimal(request.getParameter("debitoVm"));
            BigDecimal creditoVm = parseBigDecimal(request.getParameter("creditoVm"));
            BigDecimal debitoOutros = parseBigDecimal(request.getParameter("debitoOutros"));
            BigDecimal creditoOutros = parseBigDecimal(request.getParameter("creditoOutros"));

            ModelFechaMes fechamento = new ModelFechaMes();
            fechamento.setMes(mes);
            fechamento.setAno(ano);
            fechamento.setTotal_ft(resumo.getTotal_ft());
            fechamento.setTotal_enc(resumo.getTotal_enc());
            fechamento.setTotal_dig(resumo.getTotal_dig());
            fechamento.setTotal_sobras(resumo.getTotal_sobras());
            fechamento.setTotal_ribbons(totalRibbons);

            fechamento.setValor_din_mes_real(valorDin);
            fechamento.setValor_deb_mes_real(valorDeb);
            fechamento.setValor_cred_mes_real(valorCred);
            fechamento.setValor_pix_mes_real(valorPix);
            fechamento.setTotal_geral(totalGeral);
            fechamento.setJuros_cartoes(totalJuros);

            fechamento.setValor_total_despesas(valorTotalDespesas);
            fechamento.setValor_total_contas(valorTotalContas);
            fechamento.setValor_vale_total(resumo.getValor_vale_total());
            fechamento.setDesconto_mes(resumo.getDesconto_mes());

            fechamento.setDebitoVm(debitoVm);
            fechamento.setCreditoVm(creditoVm);
            fechamento.setDebitoOutros(debitoOutros);
            fechamento.setCreditoOutros(creditoOutros);

            DAOFechaMes dao = new DAOFechaMes();
            dao.gravarFechamentoMes(fechamento);

            request.setAttribute("msg", "Fechamento do mês gravado com sucesso!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao gravar fechamento: " + e.getMessage());
        }

        request.getRequestDispatcher("principal/fechames.jsp").forward(request, response);
    }



    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }
        try {
            // Remove pontos (milhar) e troca vírgula por ponto (decimal)
            String normalized = value.trim().replace(".", "").replace(",", ".");
            return new BigDecimal(normalized);
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }

}

