package servlets;

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
                System.out.println("Resumo Conduta:");
                System.out.println("Advertências: " + resumoConduta.getTotalAdvertencias());
                System.out.println("Faltas: " + resumoConduta.getTotalFaltas());
                System.out.println("Dias de Suspensão: " + resumoConduta.getTotalDiasSuspensao());
                System.out.println("DSRs: " + resumoConduta.getTotalDsrSuspensao());


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
                req.setAttribute("msg", "Funcionário não informado.");
                req.getRequestDispatcher("principal/salarios.jsp").forward(req, resp);
                return;
            }

            ModelSalarios model = new ModelSalarios();

            // Dados básicos
            model.setFuncionarioId(Long.parseLong(funcionarioIdStr));
            model.setNomeFuncionario(req.getParameter("nomeFuncionario"));

            // Mês e ano - usar valor de mesAno se presente
            String mesAnoStr = req.getParameter("mesAno"); // Ex: "março 2025"
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


            // Quantidades - buscar pelos nomes corretos dos campos JSP
            model.setQtdFotos(parseIntFromElement(req.getParameter("qtdFotos")));
            model.setQtdArquivos(parseIntFromElement(req.getParameter("qtdArquivos")));
            model.setQtdSobras(parseIntFromElement(req.getParameter("qtdSobras")));

            // Conduta - buscar dados do resumoConduta
            model.setAdvertencias(parseIntOrZero(req.getParameter("advertencias")));
            model.setFaltas(parseIntOrZero(req.getParameter("faltas")));
            model.setSuspensoes(parseIntOrZero(req.getParameter("suspensoes")));
            model.setDsr(parseIntOrZero(req.getParameter("dsr")));

            // Atrasos - buscar pelo nome correto do campo
            String atrasos = req.getParameter("atrasos_horas"); // Nome correto do campo
            model.setAtrasos(convertHorasParaDecimal(atrasos));

            // Valores - buscar pelos nomes corretos dos campos
            model.setValorFaltas(parseBigDecimal(req.getParameter("inputFaltas")));
            model.setValorSuspensoes(parseBigDecimal(req.getParameter("inputSuspensoes")));
            model.setValorAtrasos(parseBigDecimal(req.getParameter("valor_desconto_atrasos")));
            model.setVales(parseBigDecimal(req.getParameter("vales")));
            model.setInss(parseBigDecimal(req.getParameter("inss")));
            model.setFgts(parseBigDecimal(req.getParameter("fgts")));

            // CORREÇÃO: buscar venda_total ao invés de venda_total
            model.setVenda_total(parseBigDecimal(req.getParameter("venda_total")));

            // Salários
            model.setComissao(parseBigDecimal(req.getParameter("comissao")));
            model.setSalario_total(parseBigDecimal(req.getParameter("salario_total")));
            model.setSalario_liquido1(parseBigDecimal(req.getParameter("salario_liquido1")));

            model.setComissao2(parseBigDecimal(req.getParameter("comissao2")));
            model.setSalario_total2(parseBigDecimal(req.getParameter("salario_total2")));
            model.setSalario_liquido2(parseBigDecimal(req.getParameter("salario_liquido2")));

            // Debug - imprimir valores recebidos
            System.out.println("=== DEBUG SERVLET ===");
            System.out.println("Mês: " + model.getMes()); //deveria ser 3 pela busca que eu fiz, gravou 7
            System.out.println("Ano: " + model.getAno());
            System.out.println("Funcionario ID:" + model.getFuncionarioId());
            System.out.println("Nome: " + model.getNomeFuncionario());
            System.out.println("Qtd Fotos: " + model.getQtdFotos());
            System.out.println("Qtd Arquivos: " + model.getQtdArquivos());
            System.out.println("Qtd Sobras: " + model.getQtdSobras());
            System.out.println("Advertencias: " + model.getAdvertencias());
            System.out.println("Faltas: " + model.getFaltas());
            System.out.println("Suspensoes: " + model.getSuspensoes());
            System.out.println("Dsr: " + model.getDsr());
            System.out.println("Atrasos: " + model.getAtrasos());
            System.out.println("Valor dos Atrasos: " + model.getValorAtrasos());
            System.out.println("Valor dos Faltas: " + model.getValorFaltas());
            System.out.println("Valor das Suspensões: " + model.getValorSuspensoes());
            System.out.println("Valor dos Vales: " +model.getVales());
            System.out.println("Venda Total: " + model.getVenda_total());

            System.out.println("INSS: " + model.getInss());
            System.out.println("FGTS: " + model.getFgts());

            System.out.println("Comissão: " + model.getComissao());
            System.out.println("Salario Total: " + model.getSalario_total());
            System.out.println("Salario Liquido1: " + model.getSalario_liquido1());

            System.out.println("Comissão2: " + model.getComissao2());
            System.out.println("Salario Total2: " + model.getSalario_total2());
            System.out.println("Salario Liquido2: " + model.getSalario_liquido2());


            System.out.println("=====================");

            // Grava no banco
            DAOSalarios dao = new DAOSalarios();
            dao.gravarSalarios(model);

            req.setAttribute("msg", "Salário registrado com sucesso!");
            req.getRequestDispatcher("principal/salarios.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "Erro ao gravar salário: " + e.getMessage());
            req.getRequestDispatcher("principal/salarios.jsp").forward(req, resp);
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

        valor = valor.replace("R$", "")
                .replace("\u00A0", "") // <- remove espaço especial (non-breaking space)
                .replace(" ", "")
                .replace(".", "")
                .replace(",", ".");

        valor = valor.trim();

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
