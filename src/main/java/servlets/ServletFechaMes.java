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
import util.ExcelDREGenerator;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import model.ModelContas;
import model.ModelDespesas;


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
            } else if ("buscarFechamento".equals(acao)) {
                buscarFechamentoGravado(request, response);
            } else if ("exportarExcel".equals(acao)) { // <--- AÇÃO DE EXPORTAÇÃO
                exportarFechamentoExcel(request, response);
            }
        }

    private void gerarRelatorioMensal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        DAOFechaMes daoFechaMes = new DAOFechaMes();

        try {
            int mes = 0, ano = 0;
            if (dataInicial != null && !dataInicial.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(dataInicial);

                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                mes = cal.get(Calendar.MONTH) + 1;
                ano = cal.get(Calendar.YEAR);
            }

            // Verifica se já existe fechamento para o mês/ano
            boolean existeFechamento = daoFechaMes.verificarExistente(mes, ano);
            if (existeFechamento) {
                request.setAttribute("msg", "Fechamento do mês/ano selecionado já existe!");
                RequestDispatcher rd = request.getRequestDispatcher("principal/fechames.jsp");
                rd.forward(request, response);
                return;
            }

            // --- Se não existir, continua com o processamento normal ---
            DAOFuncionario daoFuncionario = new DAOFuncionario();
            DAOConfiguracao daoConfiguracao = new DAOConfiguracao();
            DAODespesas daoDespesas = new DAODespesas();
            DAOContas daoContas = new DAOContas();

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

            double valorDespesasDin = daoDespesas.somarDespesasDinheiroPorPeriodo(dataInicial, dataFinal);
            request.setAttribute("valorDespesasDin", valorDespesasDin);

            List<ModelFechaMes> vendasMesList = daoFechaMes.buscarFechamentoMensal(dataInicial, dataFinal);
            request.setAttribute("vendasMesList", vendasMesList);

            BigDecimal totalSalarios = BigDecimal.ZERO;
            if (vendasMesList != null && !vendasMesList.isEmpty()) {
                ModelFechaMes resumo = vendasMesList.get(0);
                totalSalarios = resumo.getTotal_salarios();
                if (totalSalarios == null) totalSalarios = BigDecimal.ZERO;
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

            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            String mesAnoFormatado = sdfMesAno.format(new SimpleDateFormat("yyyy-MM-dd").parse(dataInicial));
            request.setAttribute("mesAno", mesAnoFormatado);

            HttpSession session = request.getSession();
            session.setAttribute("vendasMesList", vendasMesList);
            session.setAttribute("valorTotalDespesas", BigDecimal.valueOf(valorDespesas));
            session.setAttribute("valorDespesasDin", BigDecimal.valueOf(valorDespesasDin));
            session.setAttribute("valorTotalContas", BigDecimal.valueOf(valorContas));
            session.setAttribute("valorTotalSalarios", totalSalarios);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);
            session.setAttribute("contasMes", contasMes); // Adicionar esta linha
            session.setAttribute("despesasMes", despesasMes); // Adicionar esta linha

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


    private void buscarFechamentoGravado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int mes = Integer.parseInt(request.getParameter("mes"));
            int ano = Integer.parseInt(request.getParameter("ano"));

            DAOFechaMes daoFechaMes = new DAOFechaMes();
            ModelFechaMes fechamentoExistente = daoFechaMes.buscarFechamentoPorMesAno(mes, ano);

            if (fechamentoExistente == null) {
                request.setAttribute("msg", "Nenhum fechamento encontrado para " + mes + "/" + ano);
                RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechames.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Buscar dados complementares usando as datas do mês
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.YEAR, ano);
            cal.set(Calendar.MONTH, mes - 1);
            cal.set(Calendar.DAY_OF_MONTH, 1);
            String dataInicial = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            String dataFinal = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

            DAOContas daoContas = new DAOContas();
            DAODespesas daoDespesas = new DAODespesas();
            DAOFuncionario daoFuncionario = new DAOFuncionario();
            DAOConfiguracao daoConfiguracao = new DAOConfiguracao();

            List<ModelContas> contasMes = daoContas.buscarContasRelMes(dataInicial, dataFinal);
            request.setAttribute("contasMes", contasMes);

            List<ModelDespesas> despesasMes = daoDespesas.listarDespesasPorPeriodo(dataInicial, dataFinal);
            request.setAttribute("despesasMes", despesasMes);

            List<ModelVendas> vendasList = daoFuncionario.consultarRanking(dataInicial, dataFinal, 0, 10);
            request.setAttribute("vendasList", vendasList);

            List<ModelConfiguracao> configsJuros = daoConfiguracao.consultarJuros();
            request.setAttribute("configsJuros", configsJuros);

            // Criar um ModelFechaMes para simular dados do resumo
            ModelFechaMes resumoMes = new ModelFechaMes();
            resumoMes.setTotal_ft(fechamentoExistente.getTotal_ft());
            resumoMes.setTotal_enc(fechamentoExistente.getTotal_enc());
            resumoMes.setTotal_dig(fechamentoExistente.getTotal_dig());
            resumoMes.setTotal_sobras(fechamentoExistente.getTotal_sobras());
            resumoMes.setValor_din_mes_real(fechamentoExistente.getValor_din_mes_real());
            resumoMes.setValor_deb_mes_real(fechamentoExistente.getValor_deb_mes_real());
            resumoMes.setValor_cred_mes_real(fechamentoExistente.getValor_cred_mes_real());
            resumoMes.setValor_pix_mes_real(fechamentoExistente.getValor_pix_mes_real());
            resumoMes.setValor_vale_total(fechamentoExistente.getValor_vale_total());
            resumoMes.setDesconto_mes(fechamentoExistente.getDesconto_mes());

            List<ModelFechaMes> vendasMesList = List.of(resumoMes);
            request.setAttribute("vendasMesList", vendasMesList);

            request.setAttribute("fechamentoExistente", fechamentoExistente);
            request.setAttribute("valorTotalDespesas", fechamentoExistente.getValor_total_despesas());
            request.setAttribute("valorTotalContas", fechamentoExistente.getValor_total_contas());
            request.setAttribute("valorTotalSalarios", fechamentoExistente.getSalarios());

            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            cal.set(Calendar.YEAR, ano);
            cal.set(Calendar.MONTH, mes - 1);
            String mesAnoFormatado = sdfMesAno.format(cal.getTime());
            request.setAttribute("mesAno", mesAnoFormatado);

            HttpSession session = request.getSession();
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);
            session.setAttribute("fechamentoExistenteId", fechamentoExistente.getId());

            request.setAttribute("msg", "Fechamento carregado com sucesso!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechames.jsp");

            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar fechamento: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechames.jsp");
            dispatcher.forward(request, response);
        }
    }
        private void exportarFechamentoExcel(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            HttpSession session = request.getSession();

            // Recupera Mês e Ano da sessão
            Integer mes = (Integer) session.getAttribute("mes");
            Integer ano = (Integer) session.getAttribute("ano");

            if (mes == null || ano == null) {
                request.setAttribute("msg", "Erro: O mês e ano do relatório não foram encontrados. Gere ou busque o fechamento do mês antes de exportar.");
                RequestDispatcher rd = request.getRequestDispatcher("/principal/fechames.jsp");
                rd.forward(request, response);
                return;
            }

            // ===== RECUPERA AS LISTAS DE DESPESAS E CONTAS DA SESSÃO =====
            @SuppressWarnings("unchecked")
            List<ModelContas> contasMes = (List<ModelContas>) session.getAttribute("contasMes");
            @SuppressWarnings("unchecked")
            List<ModelDespesas> despesasMes = (List<ModelDespesas>) session.getAttribute("despesasMes");

            System.out.println("DEBUG EXCEL: Tentativa de exportar mês/ano: " + mes + "/" + ano);
            System.out.println("DEBUG EXCEL: Contas na Sessão (Tamanho): " + (contasMes != null ? contasMes.size() : "NULL"));
            System.out.println("DEBUG EXCEL: Despesas na Sessão (Tamanho): " + (despesasMes != null ? despesasMes.size() : "NULL"));

            // Se as listas não estiverem na sessão, busca do banco
            if (contasMes == null || despesasMes == null) {
                System.out.println("DEBUG EXCEL: LISTAS VAZIAS NA SESSÃO. Tentando recarregar do banco de dados...");

                // Determinar as datas inicial e final do mês
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.YEAR, ano);
                cal.set(Calendar.MONTH, mes - 1);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                String dataInicial = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

                cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                String dataFinal = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());

                try {
                    DAOContas daoContas = new DAOContas();
                    DAODespesas daoDespesas = new DAODespesas();

                    contasMes = daoContas.buscarContasRelMes(dataInicial, dataFinal);
                    despesasMes = daoDespesas.listarDespesasPorPeriodo(dataInicial, dataFinal);

                    // Salvar na sessão
                    session.setAttribute("contasMes", contasMes);
                    session.setAttribute("despesasMes", despesasMes);

                    System.out.println("DEBUG EXCEL: Listas recarregadas - Contas: " + contasMes.size() + ", Despesas: " + despesasMes.size());

                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("msg", "Erro ao recarregar dados detalhados para exportação: " + e.getMessage());
                    RequestDispatcher rd = request.getRequestDispatcher("/principal/fechames.jsp");
                    rd.forward(request, response);
                    return;
                }
            }

            // Se ainda estiver vazio, cria listas vazias para evitar erro
            if (contasMes == null) contasMes = new ArrayList<>();
            if (despesasMes == null) despesasMes = new ArrayList<>();

            System.out.println("DEBUG EXCEL: Recebido da URL: jurosCreditoVm=" + request.getParameter("jurosCreditoVm") +
                    ", contas=" + request.getParameter("contas"));

            // Recupera todos os valores da URL
            BigDecimal debitoVm = parseBigDecimal(request.getParameter("debitoVm"));
            BigDecimal jurosDebitoVm = parseBigDecimal(request.getParameter("jurosDebitoVm"));
            BigDecimal creditoVm = parseBigDecimal(request.getParameter("creditoVm"));
            BigDecimal jurosCreditoVm = parseBigDecimal(request.getParameter("jurosCreditoVm"));
            BigDecimal debitoOutros = parseBigDecimal(request.getParameter("debitoOutros"));
            BigDecimal jurosDebitoOutros = parseBigDecimal(request.getParameter("jurosDebitoOutros"));
            BigDecimal creditoOutros = parseBigDecimal(request.getParameter("creditoOutros"));
            BigDecimal jurosCreditoOutros = parseBigDecimal(request.getParameter("jurosCreditoOutros"));

            // Resumo Financeiro
            BigDecimal receitas = parseBigDecimal(request.getParameter("receitas"));
            BigDecimal receitadin = parseBigDecimal(request.getParameter("receitadin"));
            BigDecimal receitacartoes = parseBigDecimal(request.getParameter("receitacartoes"));
            BigDecimal receitapix = parseBigDecimal(request.getParameter("receitapix"));

            BigDecimal despesas = parseBigDecimal(request.getParameter("despesas"));
            BigDecimal despesasdin = parseBigDecimal(request.getParameter("despesasdin"));
            BigDecimal contas = parseBigDecimal(request.getParameter("contas"));
            BigDecimal salarios = parseBigDecimal(request.getParameter("salarios"));
            BigDecimal vales = parseBigDecimal(request.getParameter("vales"));
            BigDecimal descontos = parseBigDecimal(request.getParameter("descontos"));
            BigDecimal sangria = parseBigDecimal(request.getParameter("sangria"));
            BigDecimal saldo = parseBigDecimal(request.getParameter("saldo"));

            // Cria Map para organizar dados do Resumo
            Map<String, BigDecimal> dadosExportacao = new LinkedHashMap<>();

            SimpleDateFormat sdfMesAno = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR"));
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.YEAR, ano);
            cal.set(Calendar.MONTH, mes - 1);
            String mesAnoFormatado = sdfMesAno.format(cal.getTime());

            // Adiciona dados ao mapa
            dadosExportacao.put("Mês de Referência", null);
            dadosExportacao.put(mesAnoFormatado, null);

            // RECEITAS
            dadosExportacao.put(" ", null);
            dadosExportacao.put("--- RESUMO FINANCEIRO ---", null);
            dadosExportacao.put("Receita Bruta", receitas);
            dadosExportacao.put("Receita Dinheiro", receitadin);
            dadosExportacao.put("Receita Cartões", receitacartoes);
            dadosExportacao.put("Receita Pix", receitapix);

            // DESPESAS
            dadosExportacao.put("  ", null);
            dadosExportacao.put("--- DESPESAS ---", null);
            dadosExportacao.put("Total Despesa", despesas);
            dadosExportacao.put("Despesas em Dinheiro", despesasdin);
            dadosExportacao.put("Contas Pagas", contas);
            dadosExportacao.put("Salários Líquidos", salarios);
            dadosExportacao.put("Vales", vales);
            dadosExportacao.put("Descontos", descontos);
            dadosExportacao.put("Sangria de Caixa", sangria);
            dadosExportacao.put("SALDO EM CAIXA", saldo);

            // VALORES CONTA / JUROS
            dadosExportacao.put("   ", null);
            dadosExportacao.put("--- VALORES CONTA / JUROS ---", null);
            dadosExportacao.put("Débito V/M", debitoVm);
            dadosExportacao.put("Juros Débito V/M", jurosDebitoVm);
            dadosExportacao.put("Crédito V/M", creditoVm);
            dadosExportacao.put("Juros Crédito V/M", jurosCreditoVm);
            dadosExportacao.put("Débito Outros", debitoOutros);
            dadosExportacao.put("Juros Débito Outros", jurosDebitoOutros);
            dadosExportacao.put("Crédito Outros", creditoOutros);
            dadosExportacao.put("Juros Crédito Outros", jurosCreditoOutros);

            try {
                ExcelDREGenerator generator = new ExcelDREGenerator();

                System.out.println("DEBUG EXCEL: Enviando para o Excel - Contas: " + contasMes.size() +
                        ", Despesas: " + despesasMes.size());

                // Gera Excel com as listas detalhadas
                byte[] excelBytes = generator.gerarRelatorioFechaMes(
                        dadosExportacao,
                        mesAnoFormatado,
                        contasMes,      // Lista de Contas
                        despesasMes     // Lista de Despesas
                );

                // Envia o arquivo
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition",
                        "attachment; filename=Fechamento_" + mes + "_" + ano + ".xlsx");
                response.setContentLength(excelBytes.length);

                response.getOutputStream().write(excelBytes);
                response.getOutputStream().flush();

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "Erro ao gerar arquivo Excel: " + e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("/principal/fechames.jsp");
                rd.forward(request, response);
            }
        }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();

            @SuppressWarnings("unchecked")
            List<ModelFechaMes> vendasMesList = (List<ModelFechaMes>) session.getAttribute("vendasMesList");

            int mes = (int) session.getAttribute("mes");
            int ano = (int) session.getAttribute("ano");

            DAOFechaMes dao = new DAOFechaMes();
            ModelFechaMes fechamentoExistente = dao.buscarFechamentoPorMesAno(mes, ano);

            if (vendasMesList == null || vendasMesList.isEmpty()) {
                request.setAttribute("msg", "Não há dados para gravar o fechamento.");
                request.getRequestDispatcher("principal/fechames.jsp").forward(request, response);
                return;
            }

            ModelFechaMes resumo = vendasMesList.get(0);

            BigDecimal totalRibbons = BigDecimal.ZERO;
            if (resumo.getQtd_ribbon() != null && resumo.getQtd_ribbon() > 0) {
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
            BigDecimal contas = parseBigDecimal(request.getParameter("contas"));
            BigDecimal despesas = parseBigDecimal(request.getParameter("despesas"));

            ModelFechaMes fechamento = new ModelFechaMes();
            if (fechamentoExistente != null) {
                fechamento.setId(fechamentoExistente.getId());
            }

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

            if (fechamentoExistente != null) {
                dao.atualizarFechamentoMes(fechamento);
                request.setAttribute("msg", "Fechamento do mês atualizado com sucesso!");
            } else {
                dao.gravarFechamentoMes(fechamento);
                request.setAttribute("msg", "Fechamento do mês gravado com sucesso!");
            }

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
            normalized = normalized.replace("R$", "").trim();
            normalized = normalized.replace(" ", "");

            if (normalized.isEmpty()) {
                return BigDecimal.ZERO;
            }

            long pontos = normalized.chars().filter(ch -> ch == '.').count();
            long virgulas = normalized.chars().filter(ch -> ch == ',').count();

            if (virgulas > 0) {
                normalized = normalized.replace(".", "").replace(",", ".");
            } else if (pontos > 1) {
                normalized = normalized.replace(".", "");
            } else if (pontos == 1) {
                int pontoPos = normalized.indexOf(".");
                int digitosDepois = normalized.length() - pontoPos - 1;
                if (digitosDepois > 2) {
                    normalized = normalized.replace(".", "");
                }
            }

            return new BigDecimal(normalized);

        } catch (NumberFormatException e) {
            System.err.println("Erro ao converter valor: '" + value + "'");
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }
}