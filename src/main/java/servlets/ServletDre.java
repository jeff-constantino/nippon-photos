package servlets;

import dao.DAODre;
import dao.DAOFechaMes;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelDre;
import model.ModelFechaMes;
import util.ExcelDREGenerator;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/ServletDre")
public class ServletDre extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: campos de DAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        String acao = request.getParameter("acao");

        if ("relatorioMes".equals(acao)) {
            gerarDRE(request, response, conn);
        } else if ("exportarExcel".equals(acao)) {
            exportarDREExcel(request, response, conn);
        } else if ("buscarDre".equals(acao)) {
            buscarDREExistente(request, response, conn);
        } else {
            carregarMesesNaoFechados(request, conn);
            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        String acao = request.getParameter("acao");

        if ("gravarDRE".equals(acao)) {
            gravarDRE(request, response, conn);
        } else {
            doGet(request, response);
        }
    }

    private void buscarDREExistente(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
        String mesParam = request.getParameter("mes");
        String anoParam = request.getParameter("ano");

        if (mesParam == null || anoParam == null || mesParam.isEmpty() || anoParam.isEmpty()) {
            request.setAttribute("msg", "Por favor, selecione o mês e o ano.");
            carregarMesesNaoFechados(request, conn);
            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);
            return;
        }

        int mes = Integer.parseInt(mesParam);
        int ano = Integer.parseInt(anoParam);

        DAODre daoDre = new DAODre(conn);
        DAOFechaMes daoFechaMes = new DAOFechaMes(conn);

        try {
            ModelDre dreExistente = daoDre.buscarDREPorMesAno(mes, ano);

            if (dreExistente == null) {
                request.setAttribute("msg", "Não existe DRE gravada para " + mes + "/" + ano + ". Gere o relatório primeiro.");
                carregarMesesNaoFechados(request, conn);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            ModelFechaMes fechamento = daoFechaMes.buscarFechamentoPorMesAno(mes, ano);

            if (fechamento == null) {
                request.setAttribute("msg", "Fechamento mensal não encontrado para " + mes + "/" + ano);
                carregarMesesNaoFechados(request, conn);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            BigDecimal custoUnitarioRibbon = daoDre.buscarCustoMaterial(1);
            BigDecimal custoUnitarioEncarte = daoDre.buscarCustoMaterial(2);

            int totalFt = Optional.ofNullable(fechamento.getTotal_ft()).orElse(0);
            int totalSobras = Optional.ofNullable(fechamento.getTotal_sobras()).orElse(0);
            int quantidadeRibbons = totalFt + totalSobras;
            BigDecimal valorRibbons = custoUnitarioRibbon.multiply(BigDecimal.valueOf(quantidadeRibbons));

            int quantidadeEncartes = totalFt;
            BigDecimal valorEncartes = custoUnitarioEncarte.multiply(BigDecimal.valueOf(quantidadeEncartes));

            BigDecimal jurosCartoes = Optional.ofNullable(fechamento.getJurosdebvm()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getJuroscredvm()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJurosdeboutros()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJuroscredoutros()).orElse(BigDecimal.ZERO));

            fechamento.setValor_din_mes(Optional.ofNullable(fechamento.getValor_din_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_deb_mes(Optional.ofNullable(fechamento.getValor_deb_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_cred_mes(Optional.ofNullable(fechamento.getValor_cred_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_pix_mes(Optional.ofNullable(fechamento.getValor_pix_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setTotal_ribbons(valorRibbons);
            fechamento.setValor_enc(valorEncartes);
            fechamento.setJuros_cartoes(jurosCartoes);

            List<ModelFechaMes> vendasMesList = new ArrayList<>();
            vendasMesList.add(fechamento);

            DecimalFormat df = new DecimalFormat("#,##0.00");

            request.setAttribute("icmsValue", df.format(dreExistente.getIcms()));
            request.setAttribute("pisValue", df.format(dreExistente.getPis()));
            request.setAttribute("cofinsValue", df.format(dreExistente.getCofins()));
            request.setAttribute("inssValue", df.format(dreExistente.getInss()));
            request.setAttribute("irpjValue", df.format(dreExistente.getIrpj()));
            request.setAttribute("csllValue", df.format(dreExistente.getCsll()));

            request.setAttribute("aluguelValue", df.format(dreExistente.getAluguel()));
            request.setAttribute("bonificacoesValue", df.format(dreExistente.getBonificacoes()));
            request.setAttribute("prestacoesValue", df.format(dreExistente.getPrestacoes()));
            request.setAttribute("internetValue", df.format(dreExistente.getInternet()));
            request.setAttribute("outrasDespValue", df.format(dreExistente.getOutras_despesas()));
            request.setAttribute("obsDespValue", dreExistente.getObsDesp());

            BigDecimal totalSalarios = Optional.ofNullable(fechamento.getSalarios()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getValor_vale_total()).orElse(BigDecimal.ZERO));
            BigDecimal valorContas = Optional.ofNullable(fechamento.getValor_total_contas()).orElse(BigDecimal.ZERO);
            BigDecimal valorDespesas = Optional.ofNullable(fechamento.getValor_total_despesas()).orElse(BigDecimal.ZERO);

            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));
            request.setAttribute("valorTotalContas", df.format(valorContas));
            request.setAttribute("valorTotalDespesas", df.format(valorDespesas));

            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            LocalDate dataRef = LocalDate.of(ano, mes, 1);
            request.setAttribute("mesAno", sdfMesAno.format(java.sql.Date.valueOf(dataRef)));

            request.setAttribute("vendasMesList", vendasMesList);
            request.setAttribute("receitaBruta", dreExistente.getReceita_bruta());
            request.setAttribute("totalCustosOperacionais", dreExistente.getCustos_operacionais());
            request.setAttribute("msg", "DRE de " + mes + "/" + ano + " carregada com sucesso! Você pode editar e regravar.");

            HttpSession session = request.getSession();
            session.setAttribute("receitaBruta", dreExistente.getReceita_bruta());
            session.setAttribute("totalCustosOperacionais", dreExistente.getCustos_operacionais());
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            carregarMesesNaoFechados(request, conn);

            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao buscar DRE", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar DRE: " + e.getMessage());
            carregarMesesNaoFechados(request, conn);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void gravarDRE(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            BigDecimal receitaBruta = (BigDecimal) session.getAttribute("receitaBruta");
            BigDecimal custosOperacionais = (BigDecimal) session.getAttribute("totalCustosOperacionais");
            Integer mes = (Integer) session.getAttribute("mes");
            Integer ano = (Integer) session.getAttribute("ano");

            @SuppressWarnings("unchecked")
            List<ModelFechaMes> vendasMesList = (List<ModelFechaMes>) session.getAttribute("vendasMesList");

            if (receitaBruta == null || custosOperacionais == null || mes == null || ano == null || vendasMesList == null || vendasMesList.isEmpty()) {
                request.setAttribute("msg", "Erro: Dados do DRE não encontrados na sessão. Gere o relatório novamente.");
                carregarMesesNaoFechados(request, conn);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
                dispatcher.forward(request, response);
                return;
            }

            ModelFechaMes fechamento = vendasMesList.get(0);

            BigDecimal receitaDinheiro = Optional.ofNullable(fechamento.getValor_din_mes()).orElse(BigDecimal.ZERO);
            BigDecimal receitaDebito = Optional.ofNullable(fechamento.getValor_deb_mes()).orElse(BigDecimal.ZERO);
            BigDecimal receitaCredito = Optional.ofNullable(fechamento.getValor_cred_mes()).orElse(BigDecimal.ZERO);
            BigDecimal receitaPix = Optional.ofNullable(fechamento.getValor_pix_mes()).orElse(BigDecimal.ZERO);

            BigDecimal custosRibbons = Optional.ofNullable(fechamento.getTotal_ribbons()).orElse(BigDecimal.ZERO);
            BigDecimal custosEncartes = Optional.ofNullable(fechamento.getValor_enc()).orElse(BigDecimal.ZERO);
            BigDecimal custosJurosCartoes = Optional.ofNullable(fechamento.getJuros_cartoes()).orElse(BigDecimal.ZERO);

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
            String obsDesp = Optional.ofNullable(request.getParameter("obsDesp")).orElse("");



            BigDecimal totalImpostos = icms.add(pis).add(cofins).add(inss).add(irpj).add(csll);
            BigDecimal totalDespesasAdm = aluguel.add(salarios).add(contas).add(despesasGerais)
                    .add(bonificacoes).add(prestacoes).add(internet).add(outrasDesp);

            BigDecimal lucroBruto = receitaBruta.subtract(custosOperacionais);
            BigDecimal lucroLiquido = lucroBruto.subtract(totalImpostos).subtract(totalDespesasAdm);

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
            dre.setObsDesp(obsDesp);
            dre.setTotal_despesas_adm(totalDespesasAdm);

            dre.setLucro_liquido(lucroLiquido);

            dre.setReceita_dinheiro(receitaDinheiro);
            dre.setReceita_debito(receitaDebito);
            dre.setReceita_credito(receitaCredito);
            dre.setReceita_pix(receitaPix);
            dre.setCustos_ribbons(custosRibbons);
            dre.setCustos_encartes(custosEncartes);
            dre.setCustos_juros_cartoes(custosJurosCartoes);

            DAODre daoDre = new DAODre(conn);
            daoDre.gravarDRE(dre);

            request.setAttribute("msg", "DRE do mês " + mes + "/" + ano + " gravado com sucesso!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao gravar o DRE: " + e.getMessage());
        }

        carregarMesesNaoFechados(request, conn);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
        dispatcher.forward(request, response);
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }

        try {
            String cleanedValue = value.trim();
            cleanedValue = cleanedValue.replace("R$", "").trim();

            if (cleanedValue.matches("^\\d+(\\.\\d+)?$")) {
                BigDecimal result = new BigDecimal(cleanedValue);
                return result;
            }

            cleanedValue = cleanedValue.replace(".", "").replace(",", ".");
            BigDecimal result = new BigDecimal(cleanedValue);
            return result;

        } catch (NumberFormatException e) {
            System.err.println("Erro ao converter valor: [" + value + "]");
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }

    private void carregarMesesNaoFechados(HttpServletRequest request, Connection conn) {
        try {
            DAODre daoDre = new DAODre(conn);
            List<Map<String, Object>> mesesNaoFechados = daoDre.buscarMesesNaoFechados();
            request.setAttribute("mesesNaoFechados", mesesNaoFechados);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msgErro", "Erro ao buscar meses pendentes: " + e.getMessage());
        }
    }

    private void gerarDRE(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
        String mesParam = request.getParameter("mes");
        String anoParam = request.getParameter("ano");

        int mes = Integer.parseInt(mesParam);
        int ano = Integer.parseInt(anoParam);

        DAODre daoDre = new DAODre(conn);
        DAOFechaMes daoFechaMes = new DAOFechaMes(conn);

        try {
            ModelFechaMes fechamento = daoFechaMes.buscarFechamentoPorMesAno(mes, ano);

            if (fechamento == null) {
                request.setAttribute("msg", "Não existe fechamento mensal para a data selecionada.");
                request.setAttribute("vendasMesList", null);
                carregarMesesNaoFechados(request, conn);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            BigDecimal custoUnitarioRibbon = daoDre.buscarCustoMaterial(1);
            BigDecimal custoUnitarioEncarte = daoDre.buscarCustoMaterial(2);

            BigDecimal receitaBruta = Optional.ofNullable(fechamento.getTotal_geral()).orElse(BigDecimal.ZERO);

            BigDecimal totalSalarios = Optional.ofNullable(fechamento.getSalarios()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getValor_vale_total()).orElse(BigDecimal.ZERO));

            BigDecimal jurosCartoes = Optional.ofNullable(fechamento.getJurosdebvm()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getJuroscredvm()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJurosdeboutros()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJuroscredoutros()).orElse(BigDecimal.ZERO));

            int totalFt = Optional.ofNullable(fechamento.getTotal_ft()).orElse(0);
            int totalSobras = Optional.ofNullable(fechamento.getTotal_sobras()).orElse(0);
            int quantidadeRibbons = totalFt + totalSobras;
            BigDecimal valorRibbons = custoUnitarioRibbon.multiply(BigDecimal.valueOf(quantidadeRibbons));

            int quantidadeEncartes = totalFt;
            BigDecimal valorEncartes = custoUnitarioEncarte.multiply(BigDecimal.valueOf(quantidadeEncartes));

            BigDecimal custosOperacionais = valorRibbons.add(valorEncartes).add(jurosCartoes);

            BigDecimal valorContas = Optional.ofNullable(fechamento.getValor_total_contas()).orElse(BigDecimal.ZERO);
            BigDecimal valorDespesas = Optional.ofNullable(fechamento.getValor_total_despesas()).orElse(BigDecimal.ZERO);

            DecimalFormat df = new DecimalFormat("#,##0.00");
            request.setAttribute("valorTotalContas", df.format(valorContas));
            request.setAttribute("valorTotalDespesas", df.format(valorDespesas));
            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));

            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            LocalDate dataRef = LocalDate.of(ano, mes, 1);
            request.setAttribute("mesAno", sdfMesAno.format(java.sql.Date.valueOf(dataRef)));

            List<ModelFechaMes> vendasMesList = new ArrayList<>();

            fechamento.setValor_din_mes(Optional.ofNullable(fechamento.getValor_din_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_deb_mes(Optional.ofNullable(fechamento.getValor_deb_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_cred_mes(Optional.ofNullable(fechamento.getValor_cred_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_pix_mes(Optional.ofNullable(fechamento.getValor_pix_mes_real()).orElse(BigDecimal.ZERO));

            fechamento.setTotal_ribbons(valorRibbons);
            fechamento.setValor_enc(valorEncartes);
            fechamento.setJuros_cartoes(jurosCartoes);

            vendasMesList.add(fechamento);

            request.setAttribute("vendasMesList", vendasMesList);
            request.setAttribute("receitaBruta", receitaBruta);
            request.setAttribute("totalCustosOperacionais", custosOperacionais);

            HttpSession session = request.getSession();
            session.setAttribute("receitaBruta", receitaBruta);
            session.setAttribute("totalCustosOperacionais", custosOperacionais);
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            carregarMesesNaoFechados(request, conn);

            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório DRE", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar dados do DRE: " + e.getMessage());
            carregarMesesNaoFechados(request, conn);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void exportarDREExcel(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException {
        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        List<ModelFechaMes> vendasMesList = (List<ModelFechaMes>) session.getAttribute("vendasMesList");
        Integer mes = (Integer) session.getAttribute("mes");
        Integer ano = (Integer) session.getAttribute("ano");
        BigDecimal receitaBruta = (BigDecimal) session.getAttribute("receitaBruta");
        BigDecimal totalCustosOperacionais = (BigDecimal) session.getAttribute("totalCustosOperacionais");

        if (vendasMesList == null || vendasMesList.isEmpty() || mes == null || ano == null) {
            request.setAttribute("msg", "Não há dados do DRE para exportar. Gere o relatório primeiro.");
            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);
            return;
        }

        ModelFechaMes fechamento = vendasMesList.get(0);

        BigDecimal icms = parseBigDecimal(request.getParameter("icms"));
        BigDecimal pis = parseBigDecimal(request.getParameter("pis"));
        BigDecimal cofins = parseBigDecimal(request.getParameter("cofins"));
        BigDecimal inss = parseBigDecimal(request.getParameter("inss"));
        BigDecimal irpj = parseBigDecimal(request.getParameter("irpj"));
        BigDecimal csll = parseBigDecimal(request.getParameter("csll"));

        BigDecimal totalImpostos = icms.add(pis).add(cofins).add(inss).add(irpj).add(csll);

        BigDecimal aluguel = parseBigDecimal(request.getParameter("aluguel"));
        BigDecimal bonificacoes = parseBigDecimal(request.getParameter("bonificacoes"));
        BigDecimal prestacoes = parseBigDecimal(request.getParameter("prestacoes"));
        BigDecimal internet = parseBigDecimal(request.getParameter("internet"));
        BigDecimal outrasDespesas = parseBigDecimal(request.getParameter("outrasDesp"));
        String obsDesp = Optional.ofNullable(request.getParameter("obsDesp")).orElse("");


        BigDecimal salarios = Optional.ofNullable(fechamento.getSalarios()).orElse(BigDecimal.ZERO)
                .add(Optional.ofNullable(fechamento.getValor_vale_total()).orElse(BigDecimal.ZERO));
        BigDecimal contas = Optional.ofNullable(fechamento.getValor_total_contas()).orElse(BigDecimal.ZERO);
        BigDecimal despesas = Optional.ofNullable(fechamento.getValor_total_despesas()).orElse(BigDecimal.ZERO);

        BigDecimal totalDespesasAdm = aluguel.add(salarios).add(contas).add(despesas)
                .add(bonificacoes).add(prestacoes).add(internet).add(outrasDespesas);

        SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
        LocalDate dataRef = LocalDate.of(ano, mes, 1);
        String mesAno = sdfMesAno.format(java.sql.Date.valueOf(dataRef));

        try {
            ExcelDREGenerator generator = new ExcelDREGenerator();
            byte[] excelBytes = generator.gerarDRE(
                    fechamento, mesAno, totalImpostos, totalDespesasAdm,
                    icms, pis, cofins, inss, irpj, csll,
                    aluguel, bonificacoes, prestacoes, internet, outrasDespesas, obsDesp
            );

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition",
                    "attachment; filename=DRE_" + mes + "_" + ano + ".xlsx");
            response.setContentLength(excelBytes.length);

            response.getOutputStream().write(excelBytes);
            response.getOutputStream().flush();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao gerar arquivo Excel: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);
        }
    }
}