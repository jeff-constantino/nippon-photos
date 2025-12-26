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
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import model.ModelMedidasDisciplinaresCompleto;

@WebServlet("/ServletSalarios")
public class ServletSalarios extends ServletGenericUtil { // Mantenha o nome da sua classe

    // =========================================================================================
    // =================================== MÉTODOS GET =========================================
    // =========================================================================================

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            DAOSalarios relatorio = new DAOSalarios();
            DAOConfiguracao daoConfiguracao = new DAOConfiguracao();
            DAOConfig daoConfig = new DAOConfig();

            // Atributo para manter o funcionário selecionado no formulário após a ação
            request.setAttribute("funcionarioIdSelecionado", funcionarioId);

            // Carrega INSS e adiciona ao request
            ModelConfiguracao configInss = daoConfiguracao.buscarFaixasInss();
            request.setAttribute("configInss", configInss);

            // NOVO: Carrega IRRF e adiciona ao request
            ModelConfiguracao configIrrf = daoConfiguracao.buscarFaixasIrrf();
            request.setAttribute("configIrrf", configIrrf);

            // Carrega todas as configurações para cálculo de produtos
            List<ModelConfig> listaConfigs = daoConfig.consultarTodasConfigs();
            request.setAttribute("listaConfigs", listaConfigs);

            System.out.println("=== DEBUG CONFIGS ===");
            if (listaConfigs != null && !listaConfigs.isEmpty()) {
                System.out.println("Qtd configs: " + listaConfigs.size());
                ModelConfig config = listaConfigs.get(0);
                System.out.println("conf1_valor: " + config.getConf1_valor());
                System.out.println("conf2_valor: " + config.getConf2_valor());
                System.out.println("conf3_valor: " + config.getConf3_valor());
            } else {
                System.out.println("listaConfigs está VAZIA ou NULL!");
            }

            // Carrega as configurações de salário que contém o FGTS
            List<ModelConfiguracao> configsSalarios = daoConfiguracao.consultarSalarios();
            ModelConfiguracao configSalario = null;
            if (configsSalarios != null && !configsSalarios.isEmpty()) {
                configSalario = configsSalarios.get(0);
            }
            request.setAttribute("configSalario", configSalario);

            // Lista de funcionários sempre disponível
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();
            RequestDispatcher dispatcher;

            if ("imprimirVendasFuncionario".equals(acao) && dataInicial != null && !dataInicial.isEmpty() && funcionarioId != null && !funcionarioId.isEmpty()) {
                // Conversões
                LocalDate dataIni = LocalDate.parse(dataInicial);
                LocalDate dataFin = LocalDate.parse(dataFinal);
                Long funcId = Long.parseLong(funcionarioId);

                // NOVO: Busca qual comissão o funcionário usa
                String tipoComissao = relatorio.buscarComissaoFuncionario(funcId);

                // Busca o valor da comissão correspondente
                BigDecimal valorComissao = BigDecimal.ZERO;
                if (configSalario != null) {
                    if ("COMISSÃO 1".equalsIgnoreCase(tipoComissao)) {
                        valorComissao = configSalario.getComissao();
                    } else if ("COMISSÃO 2".equalsIgnoreCase(tipoComissao)) {
                        valorComissao = configSalario.getComissao2();
                    }
                }

                request.setAttribute("tipoComissao", tipoComissao);
                request.setAttribute("valorComissaoAtiva", valorComissao);

                System.out.println("=== COMISSÃO DO FUNCIONÁRIO ===");
                System.out.println("Tipo de comissão: " + tipoComissao);
                System.out.println("Valor da comissão: " + valorComissao);

                // Busca e soma dos vales
                DAOVales daoVales = new DAOVales();
                BigDecimal totalVales = daoVales.somarValesPorFuncionarioEPeriodo(funcId, dataIni, dataFin);
                request.setAttribute("vales_mes", totalVales);

                // Busca resumo de conduta
                DAOMedidasDisciplinares daoCondutas = new DAOMedidasDisciplinares();
                ModelCondutaResumo resumoConduta = daoCondutas.buscarResumoConduta(funcId, dataIni, dataFin);
                request.setAttribute("resumoConduta", resumoConduta);
                // Busca medidas disciplinares detalhadas
                DAOMedidasDisciplinares daoMedidas = new DAOMedidasDisciplinares();
                List<ModelMedidasDisciplinaresCompleto> listaMedidas =
                        daoMedidas.buscarMedidasPorFuncionarioEPeriodo(funcId, dataIni, dataFin);
                request.setAttribute("listaMedidasDisciplinares", listaMedidas);

                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int resultadosPorPagina = 10;
                int offset = (paginaAtual - 1) * resultadosPorPagina;

                vendasFuncionarioList = relatorio.consultarVendasFuncionario(funcionarioId, dataInicial, dataFinal, offset, resultadosPorPagina);
                int totalResultados = relatorio.contarVendasFuncionario(funcionarioId, dataInicial, dataFinal);
                int totalPaginas = (int) Math.ceil((double) totalResultados / resultadosPorPagina);

                request.setAttribute("vendasFuncionarioList", vendasFuncionarioList);
                request.setAttribute("paginaAtual", paginaAtual);
                request.setAttribute("totalPaginas", totalPaginas);
            }

            if ("buscaSalario".equals(acao)) {
                String funcionarioIdParam = request.getParameter("funcionarioId");
                String mesParam = request.getParameter("mes");
                String anoParam = request.getParameter("ano");

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                try (PrintWriter out = response.getWriter()) {
                    if (funcionarioIdParam == null || funcionarioIdParam.isEmpty() ||
                            mesParam == null || mesParam.isEmpty() ||
                            anoParam == null || anoParam.isEmpty()) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.write("{\"erro\": \"Parâmetros obrigatórios ausentes ou inválidos.\"}");
                        out.flush();
                        return;
                    }

                    try {
                        int mes = Integer.parseInt(mesParam);
                        int ano = Integer.parseInt(anoParam);
                        long funcId = Long.parseLong(funcionarioIdParam);

                        DAOSalarios dao = new DAOSalarios();
                        List<ModelSalarios> listaSalarios = dao.buscarSalariosPorMesAnoFuncionario(mes, ano, funcId);

                        Gson gson = new Gson();
                        if (listaSalarios != null && !listaSalarios.isEmpty()) {
                            String json = gson.toJson(listaSalarios);
                            out.print(json);
                        } else {
                            out.print("[]");
                        }
                        out.flush();
                    } catch (NumberFormatException e) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.write("{\"erro\": \"Formato inválido nos parâmetros numéricos.\"}");
                        out.flush();
                    } catch (Exception e) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        String mensagemErro = e.getMessage().replace("\"", "\\\"");
                        out.write("{\"erro\": \"Erro ao buscar salários: " + mensagemErro + "\"}");
                        out.flush();
                    }
                } catch (IOException ioEx) {
                    ioEx.printStackTrace();
                }
                return;
            }

            request.setAttribute("dataInicial", dataInicial);
            request.setAttribute("dataFinal", dataFinal);
            request.setAttribute("funcionarioId", funcionarioId);

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

            HttpSession session = request.getSession();
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            String msg = request.getParameter("msg");
            if (msg != null && !msg.isEmpty()) {
                request.setAttribute("msg", msg);
            }

            dispatcher = request.getRequestDispatcher("principal/salarios.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar vendas: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/salarios.jsp");
            dispatcher.forward(request, response);
        }
    }

    // =========================================================================================
    // =================================== MÉTODOS POST =========================================
    // =========================================================================================

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acao = req.getParameter("acao");

        if ("editarSalario".equals(acao)) {
            editarSalario(req, resp);
            return;
        }

        // Código original para gravar novo salário
        try {
            String funcionarioIdStr = req.getParameter("funcionarioId");
            if (funcionarioIdStr == null || funcionarioIdStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Funcionário não informado.", "UTF-8"));
                return;
            }

            ModelSalarios model = new ModelSalarios();
            model.setFuncionarioId(Long.parseLong(funcionarioIdStr));
            model.setNomeFuncionario(req.getParameter("nome"));

            // --- INÍCIO DO CÁLCULO DE MÊS/ANO PARA REDIRECIONAMENTO ---
            int mes = 0, ano = 0;
            String mesAnoStr = req.getParameter("mesAno");
            if (mesAnoStr != null && !mesAnoStr.isEmpty()) {
                try {
                    // Assume que o formato do input é "Outubro 2025"
                    Date data = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR")).parse(mesAnoStr);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(data);
                    mes = cal.get(Calendar.MONTH) + 1; // Mês baseado em 1
                    ano = cal.get(Calendar.YEAR);
                } catch (Exception e) {
                    System.out.println("Erro ao converter mesAno: " + mesAnoStr + " -> " + e.getMessage());
                }
            }
            // --- FIM DO CÁLCULO DE MÊS/ANO PARA REDIRECIONAMENTO ---

            model.setMes(mes);
            model.setAno(ano);
            model.setQtdFotos(parseIntFromElement(req.getParameter("ft_total")));
            model.setQtdEnc(parseIntFromElement(req.getParameter("enc_total")));
            model.setQtdArquivos(parseIntFromElement(req.getParameter("dig_total")));
            model.setQtdSobras(parseIntFromElement(req.getParameter("sobras")));
            model.setAproveitamento(parseBigDecimal(req.getParameter("aproveitamento")));

            model.setAdvertencias(parseIntOrZero(req.getParameter("advertencias")));
            model.setFaltas(parseIntOrZero(req.getParameter("faltas")));
            model.setSuspensoes(parseIntOrZero(req.getParameter("suspensoes")));
            model.setDsr(parseIntOrZero(req.getParameter("dsr")));

            String atrasos = req.getParameter("atrasos_horas");
            model.setAtrasos(convertHorasParaDecimal(atrasos));

            model.setValorFaltas(parseBigDecimal(req.getParameter("inputFaltas")));
            model.setValorSuspensoes(parseBigDecimal(req.getParameter("inputSuspensoes")));
            model.setValorAtrasos(parseBigDecimal(req.getParameter("valor_desconto_atrasos")));

            model.setVales(parseBigDecimal(req.getParameter("vales_mes")));
            model.setInss(parseBigDecimal(req.getParameter("inss")));
            model.setParcela(parseBigDecimal(req.getParameter("parcela")));
            model.setFgts(parseBigDecimal(req.getParameter("fgts")));
            // NOVO: Adicional Noturno e Bonificações
            model.setAdcNoturno(parseBigDecimal(req.getParameter("adc_noturno")));
            model.setBonificacoes(parseBigDecimal(req.getParameter("bonificacoes")));


            model.setVenda_total(parseBigDecimal(req.getParameter("venda_total")));
            model.setComissao(parseBigDecimal(req.getParameter("comissao")));
            model.setSalario_total(parseBigDecimal(req.getParameter("salario_total")));
            model.setSalario_liquido1(parseBigDecimal(req.getParameter("salario_liquido")));

            model.setDescontos_mes(parseBigDecimal(req.getParameter("descontos_mes")));
            model.setDescontos_1(parseBigDecimal(req.getParameter("descontos_total")));

            // NOVO: Captura o tipo de comissão
            model.setTipoComissao(req.getParameter("tipo_comissao"));

            // Grava no banco
            DAOSalarios dao = new DAOSalarios();
            dao.gravarSalarios(model);

            // --- INÍCIO DA CORREÇÃO DE REDIRECIONAMENTO ---
            // Recarrega o contexto completo da página
            String dataIniStr = PrimeiroDiaDoMes(mes, ano);
            String dataFinStr = UltimoDiaDoMes(mes, ano);

            String urlRedirecionamento = req.getContextPath() + "/ServletSalarios?"
                    + "acao=imprimirVendasFuncionario&" // Força o doGet a carregar todos os dados (vendas, vales, etc.)
                    + "funcionarioId=" + funcionarioIdStr + "&"
                    + "dataInicial=" + URLEncoder.encode(dataIniStr, "UTF-8") + "&"
                    + "dataFinal=" + URLEncoder.encode(dataFinStr, "UTF-8") + "&"
                    + "msg=" + URLEncoder.encode("Salário registrado com sucesso!", "UTF-8");

            resp.sendRedirect(urlRedirecionamento);
            // --- FIM DA CORREÇÃO DE REDIRECIONAMENTO ---


        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Erro ao gravar salário: " + e.getMessage(), "UTF-8"));
        }
    }

    // Método para editar salário (mantido o original)
    private void editarSalario(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // ... (implementação original do editarSalario) ...
            String idSalarioStr = req.getParameter("idSalario");
            if (idSalarioStr == null || idSalarioStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("ID do salário não informado.", "UTF-8"));
                return;
            }

            ModelSalarios model = new ModelSalarios();
            model.setIdSalario(Integer.parseInt(idSalarioStr));
            String funcionarioIdStr = req.getParameter("funcionarioId");
            model.setFuncionarioId(Long.parseLong(funcionarioIdStr));
            model.setNomeFuncionario(req.getParameter("nome"));

            // Recalcula mes/ano para o redirecionamento
            int mes = Integer.parseInt(req.getParameter("mes"));
            int ano = Integer.parseInt(req.getParameter("ano"));

            model.setMes(mes);
            model.setAno(ano);

            // --- INÍCIO DA CORREÇÃO: CAPTURA DO TIPO DE COMISSÃO ---
            model.setTipoComissao(req.getParameter("tipo_comissao"));
            // --- FIM DA CORREÇÃO ---

            model.setQtdFotos(parseIntFromElement(req.getParameter("ft_total")));
            model.setQtdArquivos(parseIntFromElement(req.getParameter("dig_total")));
            model.setQtdSobras(parseIntFromElement(req.getParameter("sobras")));
            model.setAproveitamento(parseBigDecimal(req.getParameter("aproveitamento")));

            model.setAdvertencias(parseIntOrZero(req.getParameter("advertencias")));
            model.setFaltas(parseIntOrZero(req.getParameter("faltas")));
            model.setSuspensoes(parseIntOrZero(req.getParameter("suspensoes")));
            model.setDsr(parseIntOrZero(req.getParameter("dsr")));

            String atrasos = req.getParameter("atrasos_horas");
            model.setAtrasos(convertHorasParaDecimal(atrasos));

            model.setValorFaltas(parseBigDecimal(req.getParameter("inputFaltas")));
            model.setValorSuspensoes(parseBigDecimal(req.getParameter("inputSuspensoes")));
            model.setValorAtrasos(parseBigDecimal(req.getParameter("valor_desconto_atrasos")));

            model.setVenda_total(parseBigDecimal(req.getParameter("venda_total")));
            model.setVales(parseBigDecimal(req.getParameter("vales_mes")));
            model.setInss(parseBigDecimal(req.getParameter("inss")));
            model.setParcela(parseBigDecimal(req.getParameter("parcela")));
            model.setFgts(parseBigDecimal(req.getParameter("fgts")));
            // NOVO: Adicional Noturno e Bonificações
            model.setAdcNoturno(parseBigDecimal(req.getParameter("adc_noturno")));
            model.setBonificacoes(parseBigDecimal(req.getParameter("bonificacoes")));

            model.setDescontos_mes(parseBigDecimal(req.getParameter("descontos_mes")));

            model.setComissao(parseBigDecimal(req.getParameter("comissao")));
            model.setSalario_total(parseBigDecimal(req.getParameter("salario_total")));
            model.setDescontos_1(parseBigDecimal(req.getParameter("descontos_total")));
            model.setSalario_liquido1(parseBigDecimal(req.getParameter("salario_liquido")));

            // Note: Comissao2, Salario_total2 e Descontos_2 não estavam aqui, mas se existirem no formulário
            // e no Model, devem ser adicionados aqui também, assim como no DAO.
            // Se eles não existirem no formulário de edição, os valores no banco não serão alterados
            // se o DAO não exigir um setter para eles, mas o seu DAO atualiza eles.
            // Se você precisar dos campos 2, adicione-os aqui:
            // model.setComissao2(parseBigDecimal(req.getParameter("comissao2")));
            // model.setSalario_total2(parseBigDecimal(req.getParameter("salario_total2")));
            // model.setDescontos_2(parseBigDecimal(req.getParameter("descontos_2")));
            // model.setSalario_liquido2(parseBigDecimal(req.getParameter("salario_liquido2")));

            DAOSalarios dao = new DAOSalarios();
            dao.atualizarSalario(model);

            // --- INÍCIO DA CORREÇÃO DE REDIRECIONAMENTO PARA EDIÇÃO ---
            String dataIniStr = PrimeiroDiaDoMes(mes, ano);
            String dataFinStr = UltimoDiaDoMes(mes, ano);

            String urlRedirecionamento = req.getContextPath() + "/ServletSalarios?"
                    + "acao=imprimirVendasFuncionario&" // Força o doGet a carregar todos os dados
                    + "funcionarioId=" + funcionarioIdStr + "&"
                    + "dataInicial=" + URLEncoder.encode(dataIniStr, "UTF-8") + "&"
                    + "dataFinal=" + URLEncoder.encode(dataFinStr, "UTF-8") + "&"
                    + "msg=" + URLEncoder.encode("Salário atualizado com sucesso!", "UTF-8");

            resp.sendRedirect(urlRedirecionamento);
            // --- FIM DA CORREÇÃO DE REDIRECIONAMENTO PARA EDIÇÃO ---

        } catch (Exception e) {
            System.out.println("=== ERRO NO SERVLET ===");
            System.out.println("Tipo do erro: " + e.getClass().getSimpleName());
            System.out.println("Mensagem: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Erro ao atualizar salário: " + e.getMessage(), "UTF-8"));
        }
    }

    // =========================================================================================
    // =================================== MÉTODOS HELPERS =====================================
    // =========================================================================================

    // MÉTODOS ADICIONADOS PARA RECARREGAR O CONTEXTO CORRETAMENTE
    private String PrimeiroDiaDoMes(int mes, int ano) {
        if (mes <= 0 || ano <= 0) return "";
        try {
            LocalDate data = LocalDate.of(ano, mes, 1);
            return data.toString(); // Formato yyyy-MM-dd
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    private String UltimoDiaDoMes(int mes, int ano) {
        if (mes <= 0 || ano <= 0) return "";
        try {
            LocalDate data = LocalDate.of(ano, mes, 1).with(TemporalAdjusters.lastDayOfMonth());
            return data.toString(); // Formato yyyy-MM-dd
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    private int parseIntOrZero(String str) {
        if (str == null || str.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(str.trim());
        } catch (Exception e) {
            return 0;
        }
    }

    private int parseIntFromElement(String str) {
        if (str == null || str.trim().isEmpty()) return 0;
        try {
            // Remove vírgulas, pontos e espaços para parsear um número inteiro (ex: 1.000 -> 1000)
            str = str.replace(",", "").replace(".", "").trim();
            return Integer.parseInt(str);
        } catch (Exception e) {
            return 0;
        }
    }

    private BigDecimal parseBigDecimal(String valor) {
        if (valor == null || valor.trim().isEmpty()) return BigDecimal.ZERO;
        valor = valor.trim().replace("R$", "").replace("\u00A0", "").replace(" ", "");

        // Trata formato brasileiro (1.000,50 -> 1000.50)
        if (valor.contains(",")) {
            valor = valor.replace(".", "").replace(",", ".");
        }
        try {
            return new BigDecimal(valor);
        } catch (Exception e) {
            System.out.println("Erro ao converter BigDecimal: " + valor + " - " + e.getMessage());
            return BigDecimal.ZERO;
        }
    }

    private double convertHorasParaDecimal(String horasMinutos) {
        if (horasMinutos == null || horasMinutos.trim().isEmpty()) return 0;
        try {
            String[] partes = horasMinutos.split(":");
            int horas = Integer.parseInt(partes[0].trim());
            int minutos = partes.length > 1 ? Integer.parseInt(partes[1].trim()) : 0;
            return horas + (minutos / 60.0);
        } catch (Exception e) {
            System.out.println("Erro ao converter horas: " + horasMinutos + " - " + e.getMessage());
            return 0;
        }
    }
}
