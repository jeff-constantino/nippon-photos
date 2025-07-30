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
import java.util.*;

@WebServlet("/ServletSalarios")
public class ServletSalarios extends ServletGenericUtil{


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        String funcionarioId = request.getParameter("funcionarioId");

        try {
            DAOSalarios relatorio = new DAOSalarios();
            DAOConfiguracao daoConfiguracao = new DAOConfiguracao(); // instância do DAO de config
            DAOConfig daoConfig = new DAOConfig();

            // Carrega INSS e adiciona ao request
            ModelConfiguracao configInss = daoConfiguracao.buscarFaixasInss();
            request.setAttribute("configInss", configInss);
            // Carrega todas as configurações para cálculo de produtos
            List<ModelConfig> listaConfigs = daoConfig.consultarTodasConfigs();
            request.setAttribute("listaConfigs", listaConfigs);

            // Carrega as configurações de salário que contém o FGTS
            List<ModelConfiguracao> configsSalarios = daoConfiguracao.consultarSalarios();
            ModelConfiguracao configSalario = null;
            if (configsSalarios != null && !configsSalarios.isEmpty()) {
                configSalario = configsSalarios.get(0); // pegar primeira config, por exemplo
            }
            request.setAttribute("configSalario", configSalario);

            // Lista de funcionários sempre disponível
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();
            RequestDispatcher dispatcher;

            if ("imprimirVendasFuncionario".equals(acao)) {
                // Conversões
                LocalDate dataIni = LocalDate.parse(dataInicial);
                LocalDate dataFin = LocalDate.parse(dataFinal);
                Long funcId = Long.parseLong(funcionarioId);

                // Busca e soma dos vales
                DAOVales daoVales = new DAOVales();
                BigDecimal totalVales = daoVales.somarValesPorFuncionarioEPeriodo(funcId, dataIni, dataFin);
                request.setAttribute("vales_mes", totalVales);

                // Busca resumo de conduta
                DAOMedidasDisciplinares daoCondutas = new DAOMedidasDisciplinares();
                ModelCondutaResumo resumoConduta = daoCondutas.buscarResumoConduta(funcId, dataIni, dataFin);

                request.setAttribute("resumoConduta", resumoConduta);



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
                System.out.println("Entrou no bloco buscaSalario");

                String funcionarioIdParam = request.getParameter("funcionarioId");
                String mesParam = request.getParameter("mes");
                String anoParam = request.getParameter("ano");

                System.out.println("funcionarioId: " + funcionarioIdParam);
                System.out.println("mes: " + mesParam);
                System.out.println("ano: " + anoParam);

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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String funcionarioIdStr = req.getParameter("funcionarioId");
            if (funcionarioIdStr == null || funcionarioIdStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Funcionário não informado.", "UTF-8"));
                return;
            }

            ModelSalarios model = new ModelSalarios();

            model.setFuncionarioId(Long.parseLong(funcionarioIdStr));
            model.setNomeFuncionario(req.getParameter("nome"));

            String mesAnoStr = req.getParameter("mesAno");
            int mes = 0, ano = 0;

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
            model.setFgts(parseBigDecimal(req.getParameter("fgts")));

            model.setVenda_total(parseBigDecimal(req.getParameter("venda_total")));

            model.setComissao(parseBigDecimal(req.getParameter("comissao")));
            model.setSalario_total(parseBigDecimal(req.getParameter("salario_total")));
            model.setSalario_liquido1(parseBigDecimal(req.getParameter("salario_liquido")));

            model.setComissao2(parseBigDecimal(req.getParameter("comissao2")));
            model.setSalario_total2(parseBigDecimal(req.getParameter("salario_total2")));
            model.setSalario_liquido2(parseBigDecimal(req.getParameter("salario_liquido2")));
            model.setDescontos_mes(parseBigDecimal(req.getParameter("descontos_mes")));
            model.setDescontos_1(parseBigDecimal(req.getParameter("descontos_1")));
            model.setDescontos_2(parseBigDecimal(req.getParameter("descontos_2")));

            // Grava no banco
            DAOSalarios dao = new DAOSalarios();
            dao.gravarSalarios(model);

            resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Salário registrado com sucesso!", "UTF-8"));

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/ServletSalarios?msg=" + URLEncoder.encode("Erro ao gravar salário: " + e.getMessage(), "UTF-8"));
        }
    }


    // Helpers
    private int parseIntOrZero(String str) {
        if (str == null || str.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(str.trim());
        } catch (Exception e) {
            return 0;
        }
    }

    // Método para extrair valores dos elementos da tabela
    private int parseIntFromElement(String str) {
        if (str == null || str.trim().isEmpty()) return 0;
        try {
            // Remove qualquer formatação se houver
            str = str.replace(",", "").replace(".", "").trim();
            return Integer.parseInt(str);
        } catch (Exception e) {
            return 0;
        }
    }

    private BigDecimal parseBigDecimal(String valor) {
        if (valor == null || valor.trim().isEmpty()) return BigDecimal.ZERO;

        valor = valor.trim().replace("R$", "").replace("\u00A0", "").replace(" ", "");

        // Se contém vírgula, trata como formato BR; senão, assume padrão americano
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
