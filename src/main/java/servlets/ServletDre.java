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
import util.ExcelDREGenerator;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
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
        } else if ("exportarExcel".equals(acao)) { // 👈 NOVO BLOCO PARA EXPORTAÇÃO
            exportarDREExcel(request, response);
        }else if ("buscarDre".equals(acao)) {
            buscarDREExistente(request, response);
        }
        else {
            // Ação padrão: Carrega a página DRE
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
    // Método para buscar DRE já gravada
    private void buscarDREExistente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mesParam = request.getParameter("mes");
        String anoParam = request.getParameter("ano");

        if (mesParam == null || anoParam == null || mesParam.isEmpty() || anoParam.isEmpty()) {
            request.setAttribute("msg", "Por favor, selecione o mês e o ano.");
            carregarMesesNaoFechados(request);
            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);
            return;
        }

        int mes = Integer.parseInt(mesParam);
        int ano = Integer.parseInt(anoParam);

        DAODre daoDre = new DAODre();
        DAOFechaMes daoFechaMes = new DAOFechaMes();

        try {
            // 🔍 BUSCA A DRE JÁ GRAVADA
            ModelDre dreExistente = daoDre.buscarDREPorMesAno(mes, ano);

            if (dreExistente == null) {
                request.setAttribute("msg", "Não existe DRE gravada para " + mes + "/" + ano + ". Gere o relatório primeiro.");
                carregarMesesNaoFechados(request);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            // 🔍 BUSCA O FECHAMENTO MENSAL PARA EXIBIR AS TABELAS
            ModelFechaMes fechamento = daoFechaMes.buscarFechamentoPorMesAno(mes, ano);

            if (fechamento == null) {
                request.setAttribute("msg", "Fechamento mensal não encontrado para " + mes + "/" + ano);
                carregarMesesNaoFechados(request);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            // ===== PREPARAR OS DADOS PARA EXIBIÇÃO =====

            // Buscar custos dos materiais
            BigDecimal custoUnitarioRibbon = daoDre.buscarCustoMaterial(1);
            BigDecimal custoUnitarioEncarte = daoDre.buscarCustoMaterial(2);

            // Calcular valores dos materiais
            int totalFt = Optional.ofNullable(fechamento.getTotal_ft()).orElse(0);
            int totalSobras = Optional.ofNullable(fechamento.getTotal_sobras()).orElse(0);
            int quantidadeRibbons = totalFt + totalSobras;
            BigDecimal valorRibbons = custoUnitarioRibbon.multiply(BigDecimal.valueOf(quantidadeRibbons));

            int quantidadeEncartes = totalFt;
            BigDecimal valorEncartes = custoUnitarioEncarte.multiply(BigDecimal.valueOf(quantidadeEncartes));

            // Somar juros dos cartões
            BigDecimal jurosCartoes = Optional.ofNullable(fechamento.getJurosdebvm()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getJuroscredvm()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJurosdeboutros()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJuroscredoutros()).orElse(BigDecimal.ZERO));

            // Configurar valores para o JSP exibir nas tabelas
            fechamento.setValor_din_mes(Optional.ofNullable(fechamento.getValor_din_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_deb_mes(Optional.ofNullable(fechamento.getValor_deb_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_cred_mes(Optional.ofNullable(fechamento.getValor_cred_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_pix_mes(Optional.ofNullable(fechamento.getValor_pix_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setTotal_ribbons(valorRibbons);
            fechamento.setValor_enc(valorEncartes);
            fechamento.setJuros_cartoes(jurosCartoes);

            List<ModelFechaMes> vendasMesList = new ArrayList<>();
            vendasMesList.add(fechamento);

            // Formatação para exibição
            DecimalFormat df = new DecimalFormat("#,##0.00");

            // ===== VALORES FORMATADOS DOS CAMPOS EDITÁVEIS (DA DRE GRAVADA) =====
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

            // Valores readonly (da tabela fecha_mes)
            BigDecimal totalSalarios = Optional.ofNullable(fechamento.getSalarios()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getValor_vale_total()).orElse(BigDecimal.ZERO));
            BigDecimal valorContas = Optional.ofNullable(fechamento.getValor_total_contas()).orElse(BigDecimal.ZERO);
            BigDecimal valorDespesas = Optional.ofNullable(fechamento.getValor_total_despesas()).orElse(BigDecimal.ZERO);

            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));
            request.setAttribute("valorTotalContas", df.format(valorContas));
            request.setAttribute("valorTotalDespesas", df.format(valorDespesas));

            // Formata mês/ano
            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            LocalDate dataRef = LocalDate.of(ano, mes, 1);
            request.setAttribute("mesAno", sdfMesAno.format(java.sql.Date.valueOf(dataRef)));

            // Atributos para JSP
            request.setAttribute("vendasMesList", vendasMesList);
            request.setAttribute("receitaBruta", dreExistente.getReceita_bruta());
            request.setAttribute("totalCustosOperacionais", dreExistente.getCustos_operacionais());
            request.setAttribute("msg", "DRE de " + mes + "/" + ano + " carregada com sucesso! Você pode editar e regravar.");

            // Session para uso posterior (permitir regravação)
            HttpSession session = request.getSession();
            session.setAttribute("receitaBruta", dreExistente.getReceita_bruta());
            session.setAttribute("totalCustosOperacionais", dreExistente.getCustos_operacionais());
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            carregarMesesNaoFechados(request);

            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao buscar DRE", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar DRE: " + e.getMessage());
            carregarMesesNaoFechados(request);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Método para processar a gravação
    private void gravarDRE(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // ===== DADOS DA SESSÃO =====
            BigDecimal receitaBruta = (BigDecimal) session.getAttribute("receitaBruta");
            BigDecimal custosOperacionais = (BigDecimal) session.getAttribute("totalCustosOperacionais");
            Integer mes = (Integer) session.getAttribute("mes");
            Integer ano = (Integer) session.getAttribute("ano");

            // 🆕 BUSCAR A LISTA DE VENDAS DA SESSÃO
            @SuppressWarnings("unchecked")
            List<ModelFechaMes> vendasMesList = (List<ModelFechaMes>) session.getAttribute("vendasMesList");

            // Certifique-se de que os dados necessários existem
            if (receitaBruta == null || custosOperacionais == null || mes == null || ano == null || vendasMesList == null || vendasMesList.isEmpty()) {
                request.setAttribute("msg", "Erro: Dados do DRE não encontrados na sessão. Gere o relatório novamente.");
                carregarMesesNaoFechados(request);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // 🆕 EXTRAIR OS VALORES DAS RECEITAS E CUSTOS DO FECHAMENTO
            ModelFechaMes fechamento = vendasMesList.get(0);

            // Receitas por tipo de pagamento
            BigDecimal receitaDinheiro = Optional.ofNullable(fechamento.getValor_din_mes()).orElse(BigDecimal.ZERO);
            BigDecimal receitaDebito = Optional.ofNullable(fechamento.getValor_deb_mes()).orElse(BigDecimal.ZERO);
            BigDecimal receitaCredito = Optional.ofNullable(fechamento.getValor_cred_mes()).orElse(BigDecimal.ZERO);
            BigDecimal receitaPix = Optional.ofNullable(fechamento.getValor_pix_mes()).orElse(BigDecimal.ZERO);

            // Custos operacionais detalhados
            BigDecimal custosRibbons = Optional.ofNullable(fechamento.getTotal_ribbons()).orElse(BigDecimal.ZERO);
            BigDecimal custosEncartes = Optional.ofNullable(fechamento.getValor_enc()).orElse(BigDecimal.ZERO);
            BigDecimal custosJurosCartoes = Optional.ofNullable(fechamento.getJuros_cartoes()).orElse(BigDecimal.ZERO);

            // ===== VALORES DOS CAMPOS DO FORMULÁRIO =====
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

            // ===== CÁLCULOS =====
            BigDecimal totalImpostos = icms.add(pis).add(cofins).add(inss).add(irpj).add(csll);
            BigDecimal totalDespesasAdm = aluguel.add(salarios).add(contas).add(despesasGerais)
                    .add(bonificacoes).add(prestacoes).add(internet).add(outrasDesp);

            BigDecimal lucroBruto = receitaBruta.subtract(custosOperacionais);
            BigDecimal lucroLiquido = lucroBruto.subtract(totalImpostos).subtract(totalDespesasAdm);

            // ===== CRIAR O OBJETO MODELDRE =====
            ModelDre dre = new ModelDre();
            dre.setMes(mes);
            dre.setAno(ano);
            dre.setReceita_bruta(receitaBruta);
            dre.setCustos_operacionais(custosOperacionais);
            dre.setLucro_bruto(lucroBruto);

            // Impostos
            dre.setIcms(icms);
            dre.setPis(pis);
            dre.setCofins(cofins);
            dre.setInss(inss);
            dre.setIrpj(irpj);
            dre.setCsll(csll);
            dre.setTotal_impostos(totalImpostos);

            // Despesas administrativas
            dre.setAluguel(aluguel);
            dre.setSalarios(salarios);
            dre.setContas(contas);
            dre.setDespesas_gerais(despesasGerais);
            dre.setBonificacoes(bonificacoes);
            dre.setPrestacoes(prestacoes);
            dre.setInternet(internet);
            dre.setOutras_despesas(outrasDesp);
            dre.setTotal_despesas_adm(totalDespesasAdm);

            // Lucro líquido
            dre.setLucro_liquido(lucroLiquido);

            // 🆕 CAMPOS QUE ESTAVAM FALTANDO
            dre.setReceita_dinheiro(receitaDinheiro);
            dre.setReceita_debito(receitaDebito);
            dre.setReceita_credito(receitaCredito);
            dre.setReceita_pix(receitaPix);
            dre.setCustos_ribbons(custosRibbons);
            dre.setCustos_encartes(custosEncartes);
            dre.setCustos_juros_cartoes(custosJurosCartoes);

            // ===== SALVAR NO BANCO =====
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

    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }

        try {
            // Remove espaços em branco
            String cleanedValue = value.trim();

            // Log para debug


            // Remove R$ e espaços
            cleanedValue = cleanedValue.replace("R$", "").trim();

            // Verifica se é um número no formato americano (vindo do JS)
            // Ex: "0.01", "1000.50"
            if (cleanedValue.matches("^\\d+(\\.\\d+)?$")) {
                BigDecimal result = new BigDecimal(cleanedValue);

                return result;
            }

            // Fallback: formato brasileiro (1.000,50)
            // Remove pontos de milhar e troca vírgula por ponto
            cleanedValue = cleanedValue.replace(".", "").replace(",", ".");
            BigDecimal result = new BigDecimal(cleanedValue);

            return result;

        } catch (NumberFormatException e) {
            System.err.println("Erro ao converter valor: [" + value + "]");
            e.printStackTrace();
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

        DAODre daoDre = new DAODre();
        DAOFechaMes daoFechaMes = new DAOFechaMes();

        try {
            // Busca o fechamento mensal diretamente da tabela fecha_mes
            ModelFechaMes fechamento = daoFechaMes.buscarFechamentoPorMesAno(mes, ano);

            if (fechamento == null) {
                request.setAttribute("msg", "Não existe fechamento mensal para a data selecionada.");
                request.setAttribute("vendasMesList", null);
                carregarMesesNaoFechados(request);
                RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
                rd.forward(request, response);
                return;
            }

            // ===== BUSCAR CUSTOS DOS MATERIAIS =====
            // Busca o custo unitário do ribbon e do encarte da tabela conf_materiais
            BigDecimal custoUnitarioRibbon = daoDre.buscarCustoMaterial(1); // id_conf = 1 para ribbon
            BigDecimal custoUnitarioEncarte = daoDre.buscarCustoMaterial(2); // id_conf = 2 para encarte

            // ===== RECEITA BRUTA =====
            // Já vem calculada no campo total_geral
            BigDecimal receitaBruta = Optional.ofNullable(fechamento.getTotal_geral()).orElse(BigDecimal.ZERO);

            // ===== SALÁRIOS TOTAIS =====
            // Soma salarios + valor_vale_total
            BigDecimal totalSalarios = Optional.ofNullable(fechamento.getSalarios()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getValor_vale_total()).orElse(BigDecimal.ZERO));

            // ===== JUROS DOS CARTÕES =====
            // Soma todos os juros: jurosdebvm + juroscredvm + jurosdeboutros + juroscredoutros
            BigDecimal jurosCartoes = Optional.ofNullable(fechamento.getJurosdebvm()).orElse(BigDecimal.ZERO)
                    .add(Optional.ofNullable(fechamento.getJuroscredvm()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJurosdeboutros()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(fechamento.getJuroscredoutros()).orElse(BigDecimal.ZERO));

            // ===== CUSTOS OPERACIONAIS =====
            // Calcula o valor dos ribbons: (total_ft + total_sobras) * custo_unitario_ribbon
            int totalFt = Optional.ofNullable(fechamento.getTotal_ft()).orElse(0);
            int totalSobras = Optional.ofNullable(fechamento.getTotal_sobras()).orElse(0);
            int quantidadeRibbons = totalFt + totalSobras;
            BigDecimal valorRibbons = custoUnitarioRibbon.multiply(BigDecimal.valueOf(quantidadeRibbons));

            // Calcula o valor total dos encartes usando total_ft como quantidade
            int quantidadeEncartes = totalFt; // usa o mesmo total_ft
            BigDecimal valorEncartes = custoUnitarioEncarte.multiply(BigDecimal.valueOf(quantidadeEncartes));

            // Custos Operacionais = valor_ribbons + valor_encartes + juros_cartoes
            BigDecimal custosOperacionais = valorRibbons.add(valorEncartes).add(jurosCartoes);

            // ===== CONTAS E DESPESAS =====
            BigDecimal valorContas = Optional.ofNullable(fechamento.getValor_total_contas()).orElse(BigDecimal.ZERO);
            BigDecimal valorDespesas = Optional.ofNullable(fechamento.getValor_total_despesas()).orElse(BigDecimal.ZERO);

            // Formatação para exibição
            DecimalFormat df = new DecimalFormat("#,##0.00");
            request.setAttribute("valorTotalContas", df.format(valorContas));
            request.setAttribute("valorTotalDespesas", df.format(valorDespesas));
            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));

            // Formata mês/ano
            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            LocalDate dataRef = LocalDate.of(ano, mes, 1);
            request.setAttribute("mesAno", sdfMesAno.format(java.sql.Date.valueOf(dataRef)));

            // ===== PREPARA DADOS PARA O JSP =====
            // Cria uma lista com um único elemento para manter compatibilidade com o JSP
            List<ModelFechaMes> vendasMesList = new ArrayList<>();

            // Configura os valores que o JSP espera nos campos _mes (sem _real)
            fechamento.setValor_din_mes(Optional.ofNullable(fechamento.getValor_din_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_deb_mes(Optional.ofNullable(fechamento.getValor_deb_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_cred_mes(Optional.ofNullable(fechamento.getValor_cred_mes_real()).orElse(BigDecimal.ZERO));
            fechamento.setValor_pix_mes(Optional.ofNullable(fechamento.getValor_pix_mes_real()).orElse(BigDecimal.ZERO));

            // Define o valor calculado dos ribbons (não o valor em kits que está na tabela)
            fechamento.setTotal_ribbons(valorRibbons);

            // Define o valor calculado dos encartes
            fechamento.setValor_enc(valorEncartes);

            // Define os juros calculados
            fechamento.setJuros_cartoes(jurosCartoes);

            vendasMesList.add(fechamento);

            // Atributos para a JSP
            request.setAttribute("vendasMesList", vendasMesList);
            request.setAttribute("receitaBruta", receitaBruta);
            request.setAttribute("totalCustosOperacionais", custosOperacionais);

            // Session para uso posterior
            HttpSession session = request.getSession();
            session.setAttribute("receitaBruta", receitaBruta);
            session.setAttribute("totalCustosOperacionais", custosOperacionais);
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            carregarMesesNaoFechados(request);

            RequestDispatcher rd = request.getRequestDispatcher("/principal/dre.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao gerar relatório DRE", e);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar dados do DRE: " + e.getMessage());
            carregarMesesNaoFechados(request);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/dre.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Adicione este método no seu ServletDre

    private void exportarDREExcel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Recupera dados da sessão
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

        // Pega os valores dos impostos e despesas do request
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

        BigDecimal salarios = Optional.ofNullable(fechamento.getSalarios()).orElse(BigDecimal.ZERO)
                .add(Optional.ofNullable(fechamento.getValor_vale_total()).orElse(BigDecimal.ZERO));
        BigDecimal contas = Optional.ofNullable(fechamento.getValor_total_contas()).orElse(BigDecimal.ZERO);
        BigDecimal despesas = Optional.ofNullable(fechamento.getValor_total_despesas()).orElse(BigDecimal.ZERO);

        BigDecimal totalDespesasAdm = aluguel.add(salarios).add(contas).add(despesas)
                .add(bonificacoes).add(prestacoes).add(internet).add(outrasDespesas);

        // Formata o mês/ano
        SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
        LocalDate dataRef = LocalDate.of(ano, mes, 1);
        String mesAno = sdfMesAno.format(java.sql.Date.valueOf(dataRef));

        try {
            // Gera o Excel
            ExcelDREGenerator generator = new ExcelDREGenerator();
            byte[] excelBytes = generator.gerarDRE(
                    fechamento, mesAno, totalImpostos, totalDespesasAdm,
                    icms, pis, cofins, inss, irpj, csll,
                    aluguel, bonificacoes, prestacoes, internet, outrasDespesas
            );

            // Define o tipo de resposta
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition",
                    "attachment; filename=DRE_" + mes + "_" + ano + ".xlsx");
            response.setContentLength(excelBytes.length);

            // Envia o arquivo
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
