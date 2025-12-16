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
}