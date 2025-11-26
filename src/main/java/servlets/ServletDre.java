package servlets;

import dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelContas;
import model.ModelDespesas;
import model.ModelDre;
import model.ModelFechaMes;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet ("/ServletDre")
public class ServletDre extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if ("relatorioMes".equals(acao)) {
            gerarDRE(request, response);
        } else {
            response.sendRedirect("principal/dre.jsp");
        }
    }

    // Adicionar o método doPost
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if ("gravarDRE".equals(acao)) {
            gravarDRE(request, response);
        } else {
            response.sendRedirect("principal/dre.jsp");
        }
    }

    // Método para processar a gravação
    private void gravarDRE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                RequestDispatcher dispatcher = request.getRequestDispatcher("principal/dre.jsp");
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
            BigDecimal totalDespesasAdm = aluguel.add(salarios).add(contas).add(despesasGerais).add(bonificacoes).add(prestacoes).add(internet).add(outrasDesp);

            // Calcule o lucro líquido (já usando os valores da sessão)
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

        // Mantenha a mesma página DRE
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/dre.jsp");
        dispatcher.forward(request, response);
    }

    // Método auxiliar para converter String (com vírgula) para BigDecimal
    private BigDecimal parseBigDecimal(String value) {
        if (value == null || value.trim().isEmpty()) {
            return BigDecimal.ZERO;
        }
        try {
            // Remove R$, pontos e substitui vírgula por ponto
            String cleanedValue = value.replace("R$", "").replace(".", "").replace(",", ".").trim();
            return new BigDecimal(cleanedValue);
        } catch (NumberFormatException e) {
            // Retorna 0 se a conversão falhar
            return BigDecimal.ZERO;
        }
    }

    private void gerarDRE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");

        DAODre daoDre = new DAODre();
        DAOContas daoContas = new DAOContas();
        DAODespesas daoDespesas = new DAODespesas();

        try {
            List<ModelFechaMes> vendasMesList = daoDre.buscarFechamentoMensal(dataInicial, dataFinal);

            BigDecimal valorContas = daoContas.buscarTotalContasPorPeriodo(dataInicial, dataFinal);
            BigDecimal valorDespesas = daoDespesas.buscarTotalDespesasPorPeriodo(dataInicial, dataFinal);

            // Adicione aqui a lógica para obter os salários, se necessário
            BigDecimal totalSalarios = BigDecimal.ZERO;

            if (!vendasMesList.isEmpty()) {
                totalSalarios = Optional.ofNullable(vendasMesList.get(0).getTotal_salarios())
                        .orElse(BigDecimal.ZERO);
            }


            // Calcule a Receita Bruta e os Custos Operacionais
            BigDecimal receitaBruta = BigDecimal.ZERO;
            BigDecimal custosOperacionais = BigDecimal.ZERO;

            if (!vendasMesList.isEmpty()) {
                ModelFechaMes resumo = vendasMesList.get(0);
                receitaBruta = resumo.getValor_din_mes()
                        .add(resumo.getValor_deb_mes())
                        .add(resumo.getValor_cred_mes())
                        .add(resumo.getValor_pix_mes());

                custosOperacionais = resumo.getTotal_ribbons()
                        .add(resumo.getValor_enc())
                        .add(resumo.getJuros_cartoes());
            }

            // Formate os valores para o JSP
            DecimalFormat df = new DecimalFormat("#,##0.00");
            request.setAttribute("valorTotalContas", df.format(valorContas));
            request.setAttribute("valorTotalDespesas", df.format(valorDespesas));
            request.setAttribute("valorTotalSalarios", df.format(totalSalarios));

            // Adiciona nome do mês e ano
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

            // Passa os valores calculados para o JSP
            request.setAttribute("vendasMesList", vendasMesList);
            request.setAttribute("receitaBruta", receitaBruta);
            request.setAttribute("totalCustosOperacionais", custosOperacionais);

            // Armazene os valores na sessão para uso no doPost
            HttpSession session = request.getSession();
            session.setAttribute("receitaBruta", receitaBruta);
            session.setAttribute("totalCustosOperacionais", custosOperacionais);
            session.setAttribute("mes", mes);
            session.setAttribute("ano", ano);

            RequestDispatcher rd = request.getRequestDispatcher("principal/dre.jsp");
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
}
