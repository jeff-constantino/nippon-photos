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
import java.text.DecimalFormat;
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
            List<ModelContas> contasMes = daoContas.buscarContasRelMes(dataInicial, dataFinal);
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

            // 🆕 BUSCAR SALÁRIOS QUE JÁ VEM NO ModelFechaMes
            BigDecimal totalSalarios = BigDecimal.ZERO;
            if (vendasMesList != null && !vendasMesList.isEmpty()) {
                ModelFechaMes resumo = vendasMesList.get(0);
                totalSalarios = resumo.getTotal_salarios();
                if (totalSalarios == null) {
                    totalSalarios = BigDecimal.ZERO;
                }
            }

            DecimalFormat df = new DecimalFormat("#,##0.00");
            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));

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
            session.setAttribute("valorTotalSalarios", totalSalarios); // 🆕 Salva salários na sessão

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

            BigDecimal valorTotalDespesas = (BigDecimal) session.getAttribute("despesas");
            BigDecimal valorTotalContas = (BigDecimal) session.getAttribute("contas");
            int mes = (int) session.getAttribute("mes");
            int ano = (int) session.getAttribute("ano");

            if (vendasMesList == null || vendasMesList.isEmpty()) {
                request.setAttribute("msg", "Não há dados para gravar o fechamento.");
                request.getRequestDispatcher("principal/fechames.jsp").forward(request, response);
                return;
            }

            ModelFechaMes resumo = vendasMesList.get(0);

            BigDecimal totalRibbons = BigDecimal.ZERO;

            if (resumo.getQtd_ribbon() > 0) {
                BigDecimal qtdRibbon = BigDecimal.valueOf(resumo.getQtd_ribbon());
                BigDecimal totalFt = BigDecimal.valueOf(resumo.getTotal_ft());
                BigDecimal totalSobras = BigDecimal.valueOf(resumo.getTotal_sobras());

                totalRibbons = totalFt.add(totalSobras).divide(qtdRibbon, 2, RoundingMode.HALF_UP);
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

            BigDecimal receitas = parseBigDecimal(request.getParameter("receitas"));
            BigDecimal salarios = parseBigDecimal(request.getParameter("salarios"));
            BigDecimal sangria = parseBigDecimal(request.getParameter("sangria"));
            BigDecimal despesasdin = parseBigDecimal(request.getParameter("despesasdin"));
            BigDecimal saldo = parseBigDecimal(request.getParameter("saldo"));
            BigDecimal receitadin = parseBigDecimal(request.getParameter("receitadin"));
            BigDecimal desconto = parseBigDecimal(request.getParameter("descontos"));

            BigDecimal contas= parseBigDecimal(request.getParameter("contas"));
            BigDecimal despesas = parseBigDecimal(request.getParameter("despesas"));


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
            fechamento.setJurosdebvm(jurosDebitoVm);
            fechamento.setJuroscredvm(jurosCreditoVm);
            fechamento.setJurosdeboutros(jurosDebitoOutros);
            fechamento.setJuroscredoutros(jurosCreditoOutros);
            fechamento.setJuros_cartoes(totalJuros);

            fechamento.setValor_total_despesas(despesas);
            fechamento.setValor_total_contas(contas);
            fechamento.setValor_vale_total(resumo.getValor_vale_total());
            fechamento.setDesconto_mes(desconto);

            fechamento.setDebitoVm(debitoVm);
            fechamento.setCreditoVm(creditoVm);
            fechamento.setDebitoOutros(debitoOutros);
            fechamento.setCreditoOutros(creditoOutros);
            fechamento.setDespesasdin(despesasdin);
            fechamento.setSalarios(salarios);
            fechamento.setSangria(sangria);
            fechamento.setReceitas(receitas);
            fechamento.setSaldo(saldo);
            fechamento.setReceitadin(receitadin);

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
            String normalized = value.trim();

            // Remove "R$" e espaços
            normalized = normalized.replace("R$", "").trim();

            // Remove espaços internos
            normalized = normalized.replace(" ", "");

            // Se está vazio após limpeza
            if (normalized.isEmpty()) {
                return BigDecimal.ZERO;
            }

            // Conta pontos e vírgulas
            long pontos = normalized.chars().filter(ch -> ch == '.').count();
            long virgulas = normalized.chars().filter(ch -> ch == ',').count();

            // Formato brasileiro com vírgula decimal: 1.234,56 ou 1234,56
            if (virgulas > 0) {
                normalized = normalized.replace(".", "").replace(",", ".");
            }
            // Formato com múltiplos pontos (milhar): 1.234.567
            else if (pontos > 1) {
                normalized = normalized.replace(".", "");
            }
            // Formato com um ponto - precisa verificar se é decimal ou milhar
            else if (pontos == 1) {
                int pontoPos = normalized.indexOf(".");
                int digitosDepois = normalized.length() - pontoPos - 1;

                // Se tem 1 ou 2 dígitos após o ponto, é decimal (ex: 123.45)
                // Se tem 3+ dígitos, é milhar (ex: 1.234)
                if (digitosDepois > 2) {
                    normalized = normalized.replace(".", "");
                }
                // Senão, já está no formato correto (decimal com ponto)
            }

            return new BigDecimal(normalized);

        } catch (NumberFormatException e) {
            System.err.println("Erro ao converter valor: '" + value + "' -> normalized tentou ser: " + value.trim().replace("R$", "").trim());
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }

}

