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
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

@WebServlet("/ServletSalarios")
public class ServletSalarios extends ServletGenericUtil {
    // ✅ Não tinha campos DAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");

        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            DAOSalarios relatorio = new DAOSalarios(conn);
            DAOConfiguracao daoConfiguracao = new DAOConfiguracao(conn);
            DAOConfig daoConfig = new DAOConfig(conn);

            request.setAttribute("funcionarioIdSelecionado", funcionarioId);

            ModelConfiguracao configInss = daoConfiguracao.buscarFaixasInss();
            request.setAttribute("configInss", configInss);

            ModelConfiguracao configIrrf = daoConfiguracao.buscarFaixasIrrf();
            request.setAttribute("configIrrf", configIrrf);

            List<ModelConfig> listaConfigs = daoConfig.consultarTodasConfigs();
            request.setAttribute("listaConfigs", listaConfigs);

            List<ModelConfiguracao> configsSalarios = daoConfiguracao.consultarSalarios();
            ModelConfiguracao configSalario = null;
            if (configsSalarios != null && !configsSalarios.isEmpty()) {
                configSalario = configsSalarios.get(0);
            }
            request.setAttribute("configSalario", configSalario);

            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();
            RequestDispatcher dispatcher;

            if ("imprimirVendasFuncionario".equals(acao) && dataInicial != null && !dataInicial.isEmpty() && funcionarioId != null && !funcionarioId.isEmpty()) {
                LocalDate dataIni = LocalDate.parse(dataInicial);
                LocalDate dataFin = LocalDate.parse(dataFinal);
                Long funcId = Long.parseLong(funcionarioId);

                String tipoComissao = relatorio.buscarComissaoFuncionario(funcId);

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

                DAOVales daoVales = new DAOVales(conn);
                BigDecimal totalVales = daoVales.somarValesPorFuncionarioEPeriodo(funcId, dataIni, dataFin);
                request.setAttribute("vales_mes", totalVales);

                DAOMedidasDisciplinares daoCondutas = new DAOMedidasDisciplinares(conn);
                ModelCondutaResumo resumoConduta = daoCondutas.buscarResumoConduta(funcId, dataIni, dataFin);
                request.setAttribute("resumoConduta", resumoConduta);

                List<ModelMedidasDisciplinaresCompleto> listaMedidas = daoCondutas.buscarMedidasPorFuncionarioEPeriodo(funcId, dataIni, dataFin);
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

                        DAOSalarios dao = new DAOSalarios(conn);
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("connection");

        String acao = req.getParameter("acao");

        if ("editarSalario".equals(acao)) {
            editarSalario(req, resp, conn);
            return;
        }

        try {
            String funcionarioIdStr = req.getParameter("funcionarioId");
            if (funcionarioIdStr == null || funcionarioIdStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Funcionário não informado.", "UTF-8"));
                return;
            }

            ModelSalarios model = new ModelSalarios();
            model.setFuncionarioId(Long.parseLong(funcionarioIdStr));
            model.setNomeFuncionario(req.getParameter("nome"));

            int mes = 0, ano = 0;
            String mesAnoStr = req.getParameter("mesAno");
            if (mesAnoStr != null && !mesAnoStr.isEmpty()) {
                try {
                    Date data = new SimpleDateFormat("MMMM yyyy", new Locale("pt", "BR")).parse(mesAnoStr);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(data);
                    mes = cal.get(Calendar.MONTH) + 1;
                    ano = cal.get(Calendar.YEAR);
                } catch (Exception e) {
                    System.out.println("Erro ao converter mesAno: " + mesAnoStr + " -> " + e.getMessage());
                }
            }

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
            model.setAdcNoturno(parseBigDecimal(req.getParameter("adc_noturno")));
            model.setBonificacoes(parseBigDecimal(req.getParameter("bonificacoes")));

            model.setVenda_total(parseBigDecimal(req.getParameter("venda_total")));
            model.setComissao(parseBigDecimal(req.getParameter("comissao")));
            model.setSalario_total(parseBigDecimal(req.getParameter("salario_total")));
            model.setSalario_liquido1(parseBigDecimal(req.getParameter("salario_liquido")));

            model.setDescontos_mes(parseBigDecimal(req.getParameter("descontos_mes")));
            model.setDescontos_1(parseBigDecimal(req.getParameter("descontos_total")));

            model.setTipoComissao(req.getParameter("tipo_comissao"));

            DAOSalarios dao = new DAOSalarios(conn);
            dao.gravarSalarios(model);

            String dataIniStr = PrimeiroDiaDoMes(mes, ano);
            String dataFinStr = UltimoDiaDoMes(mes, ano);

            String urlRedirecionamento = req.getContextPath() + "/ServletSalarios?"
                    + "acao=imprimirVendasFuncionario&"
                    + "funcionarioId=" + funcionarioIdStr + "&"
                    + "dataInicial=" + URLEncoder.encode(dataIniStr, "UTF-8") + "&"
                    + "dataFinal=" + URLEncoder.encode(dataFinStr, "UTF-8") + "&"
                    + "msg=" + URLEncoder.encode("Salário registrado com sucesso!", "UTF-8");

            resp.sendRedirect(urlRedirecionamento);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Erro ao gravar salário: " + e.getMessage(), "UTF-8"));
        }
    }

    private void editarSalario(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws ServletException, IOException {
        try {
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

            int mes = Integer.parseInt(req.getParameter("mes"));
            int ano = Integer.parseInt(req.getParameter("ano"));

            model.setMes(mes);
            model.setAno(ano);

            model.setTipoComissao(req.getParameter("tipo_comissao"));

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
            model.setAdcNoturno(parseBigDecimal(req.getParameter("adc_noturno")));
            model.setBonificacoes(parseBigDecimal(req.getParameter("bonificacoes")));

            model.setDescontos_mes(parseBigDecimal(req.getParameter("descontos_mes")));

            model.setComissao(parseBigDecimal(req.getParameter("comissao")));
            model.setSalario_total(parseBigDecimal(req.getParameter("salario_total")));
            model.setDescontos_1(parseBigDecimal(req.getParameter("descontos_total")));
            model.setSalario_liquido1(parseBigDecimal(req.getParameter("salario_liquido")));

            DAOSalarios dao = new DAOSalarios(conn);
            dao.atualizarSalario(model);

            String dataIniStr = PrimeiroDiaDoMes(mes, ano);
            String dataFinStr = UltimoDiaDoMes(mes, ano);

            String urlRedirecionamento = req.getContextPath() + "/ServletSalarios?"
                    + "acao=imprimirVendasFuncionario&"
                    + "funcionarioId=" + funcionarioIdStr + "&"
                    + "dataInicial=" + URLEncoder.encode(dataIniStr, "UTF-8") + "&"
                    + "dataFinal=" + URLEncoder.encode(dataFinStr, "UTF-8") + "&"
                    + "msg=" + URLEncoder.encode("Salário atualizado com sucesso!", "UTF-8");

            resp.sendRedirect(urlRedirecionamento);

        } catch (Exception e) {
            System.out.println("=== ERRO NO SERVLET ===");
            System.out.println("Tipo do erro: " + e.getClass().getSimpleName());
            System.out.println("Mensagem: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Erro ao atualizar salário: " + e.getMessage(), "UTF-8"));
        }
    }

    private String PrimeiroDiaDoMes(int mes, int ano) {
        if (mes <= 0 || ano <= 0) return "";
        try {
            LocalDate data = LocalDate.of(ano, mes, 1);
            return data.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    private String UltimoDiaDoMes(int mes, int ano) {
        if (mes <= 0 || ano <= 0) return "";
        try {
            LocalDate data = LocalDate.of(ano, mes, 1).with(TemporalAdjusters.lastDayOfMonth());
            return data.toString();
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
            str = str.replace(",", "").replace(".", "").trim();
            return Integer.parseInt(str);
        } catch (Exception e) {
            return 0;
        }
    }

    private BigDecimal parseBigDecimal(String valor) {
        if (valor == null || valor.trim().isEmpty()) return BigDecimal.ZERO;
        valor = valor.trim().replace("R$", "").replace("\u00A0", "").replace(" ", "");

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