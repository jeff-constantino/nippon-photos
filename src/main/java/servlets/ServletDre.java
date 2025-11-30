package servlets;

import dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelDre;
import model.ModelFechaMes;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/ServletDre")
public class ServletDre extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("relatorioMes".equals(acao)) {
            gerarDRE(request, response);
        } else {
            // Carrega os meses não fechados ao abrir a página
            carregarMesesNaoFechados(request);
            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);
        }
    }

    // 🆕 MÉTODO DOPOST - Para processar o formulário de gravação
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("gravarDRE".equals(acao)) {
            gravarDRE(request, response);
        } else {
            // Se não tiver ação definida, redireciona para o doGet
            doGet(request, response);
        }
    }

    // Método para processar a gravação
    private void gravarDRE(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Recupere os dados da sessão
            BigDecimal receitaBruta = (BigDecimal) session.getAttribute("receitaBruta");
            BigDecimal custosOperacionais = (BigDecimal) session.getAttribute("totalCustosOperacionais");
            Integer mes = (Integer) session.getAttribute("mes");
            Integer ano = (Integer) session.getAttribute("ano");

            // Certifique-se de que os dados necessários da sessão existam
            if (receitaBruta == null || custosOperacionais == null || mes == null || ano == null) {
                request.setAttribute("msg", "Erro: Dados do DRE não encontrados na sessão. Gere o relatório novamente.");
                carregarMesesNaoFechados(request);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Recupere os valores dos campos de impostos e despesas
            BigDecimal icms = parseBigDecimal(request.getParameter("icms"));
            BigDecimal pis = parseBigDecimal(request.getParameter("pis"));
            BigDecimal cofins = parseBigDecimal(request.getParameter("cofins"));
            BigDecimal inss = parseBigDecimal(request.getParameter("inss"));
            BigDecimal irpj = parseBigDecimal(request.getParameter("irpj"));
            BigDecimal csll = parseBigDecimal(request.getParameter("csll"));

            BigDecimal aluguel = parseBigDecimal(request.getParameter("aluguel"));
            BigDecimal salarios = parseBigDecimal(request.getParameter("salarios"));
            BigDecimal contas = parseBigDecimal(request.getParameter("contas"));
            BigDecimal despesasGerais = parseBigDecimal(request.getParameter("despesasGerais"));
            BigDecimal bonificacoes = parseBigDecimal(request.getParameter("bonificacoes"));
            BigDecimal prestacoes = parseBigDecimal(request.getParameter("prestacoes"));
            BigDecimal internet = parseBigDecimal(request.getParameter("internet"));
            BigDecimal outrasDesp = parseBigDecimal(request.getParameter("outrasDesp"));

            // Calcule os totais
            BigDecimal totalImpostos = icms.add(pis).add(cofins).add(inss).add(irpj).add(csll);
            BigDecimal totalDespesasAdm = aluguel.add(salarios).add(contas).add(despesasGerais)
                    .add(bonificacoes).add(prestacoes).add(internet).add(outrasDesp);

            // Calcule o lucro líquido
            BigDecimal lucroBruto = receitaBruta.subtract(custosOperacionais);
            BigDecimal lucroLiquido = lucroBruto.subtract(totalImpostos).subtract(totalDespesasAdm);

            // Crie o objeto ModelDre
            ModelDre dre = new ModelDre();
            dre.setMes(mes);
            dre.setAno(ano);
            dre.setReceita_bruta(receitaBruta);
            dre.setCustos_operacionais(custosOperacionais);
            dre.setLucro_bruto(lucroBruto);
            dre.setIcms(icms);
            dre.setPis(pis);
            dre.setCofins(cofins);
            dre.setInss(inss);
            dre.setIrpj(irpj);
            dre.setCsll(csll);
            dre.setTotal_impostos(totalImpostos);
            dre.setAluguel(aluguel);
            dre.setSalarios(salarios);
            dre.setContas(contas);
            dre.setDespesas_gerais(despesasGerais);
            dre.setBonificacoes(bonificacoes);
            dre.setPrestacoes(prestacoes);
            dre.setInternet(internet);
            dre.setOutras_despesas(outrasDesp);
            dre.setTotal_despesas_adm(totalDespesasAdm);
            dre.setLucro_liquido(lucroLiquido);

            // Chame o DAO para salvar
            DAODre daoDre = new DAODre();
            daoDre.gravarDRE(dre);

            request.setAttribute("msg", "DRE do mês " + mes + "/" + ano + " gravado com sucesso!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao gravar o DRE: " + e.getMessage());
        }

        // Recarrega a lista e mantém a mesma página DRE
        carregarMesesNaoFechados(request);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
        dispatcher.forward(request, response);
    }

    // Método auxiliar para converter String (com vírgula) para BigDecimal
    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }
        try {
            // Remove R$, pontos e substitui vírgula por ponto
            String cleanedValue = value.replace("R$", "").replace(".", "")
                    .replace(",", ".").trim();
            return new BigDecimal(cleanedValue);
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }

    // Carrega meses não fechados
    private void carregarMesesNaoFechados(HttpServletRequest request) {
        try {
            DAODre daoDre = new DAODre();
            List<Map<String, Object>> mesesNaoFechados = daoDre.buscarMesesNaoFechados();
            request.setAttribute("mesesNaoFechados", mesesNaoFechados);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msgErro", "Erro ao buscar meses pendentes: " + e.getMessage());
        }
    }

    // Gera o relatório DRE
    private void gerarDRE(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mesParam = request.getParameter("mes");
        String anoParam = request.getParameter("ano");

        int mes = Integer.parseInt(mesParam);
        int ano = Integer.parseInt(anoParam);

        LocalDate dataInicio = LocalDate.of(ano, mes, 1);
        LocalDate dataFim = dataInicio.withDayOfMonth(dataInicio.lengthOfMonth());

        String dataInicial = dataInicio.toString();
        String dataFinal = dataFim.toString();

        DAODre daoDre = new DAODre();
        DAOContas daoContas = new DAOContas();
        DAODespesas daoDespesas = new DAODespesas();

        try {
            List<ModelFechaMes> vendasMesList = daoDre.buscarFechamentoMensal(dataInicial, dataFinal);

            if (vendasMesList == null || vendasMesList.isEmpty() ||
                    vendasMesList.get(0).getValor_din_mes() == null) {
                request.setAttribute("msg", "Não existe fechamento mensal para a data selecionada.");
                request.setAttribute("vendasMesList", null);
                carregarMesesNaoFechados(request);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            ModelFechaMes resumo = vendasMesList.get(0);

            BigDecimal valorContas = daoContas.buscarTotalContasPorPeriodo(dataInicial, dataFinal);
            BigDecimal valorDespesas = daoDespesas.buscarTotalDespesasPorPeriodo(dataInicial, dataFinal);
            BigDecimal totalSalarios = Optional.ofNullable(resumo.getTotal_salarios()).orElse(BigDecimal.ZERO);

            BigDecimal receitaBruta = resumo.getValor_din_mes()
                    .add(resumo.getValor_deb_mes())
                    .add(resumo.getValor_cred_mes())
                    .add(resumo.getValor_pix_mes());

            BigDecimal totalRibbons = Optional.ofNullable(resumo.getTotal_ribbons()).orElse(BigDecimal.ZERO);
            BigDecimal valorEnc = Optional.ofNullable(resumo.getValor_enc()).orElse(BigDecimal.ZERO);
            BigDecimal jurosCartoes = Optional.ofNullable(resumo.getJuros_cartoes()).orElse(BigDecimal.ZERO);
            BigDecimal custosOperacionais = totalRibbons.add(valorEnc).add(jurosCartoes);

            DecimalFormat df = new DecimalFormat("#,##0.00");
            request.setAttribute("valorTotalContas", df.format(Optional.ofNullable(valorContas).orElse(BigDecimal.ZERO)));
            request.setAttribute("valorTotalDespesas", df.format(Optional.ofNullable(valorDespesas).orElse(BigDecimal.ZERO)));
            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));

            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            request.setAttribute("mesAno", sdfMesAno.format(java.sql.Date.valueOf(dataInicio)));

            request.setAttribute("vendasMesList", vendasMesList);
            request.setAttribute("receitaBruta", receitaBruta);
            request.setAttribute("totalCustosOperacionais", custosOperacionais);

            HttpSession session = request.getSession();
            session.setAttribute("receitaBruta", receitaBruta);
            session.setAttribute("totalCustosOperacionais", custosOperacionais);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            carregarMesesNaoFechados(request);

            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório mensal", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            carregarMesesNaoFechados(request);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
            dispatcher.forward(request, response);
        }
    }
}