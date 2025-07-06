package servlets;

import dao.DAOControleRibbon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelControleRibbon;
import model.ModelVendas;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/ServletControleRibbon")
public class ServletControleRibbon extends ServletGenericUtil {

    private final DAOControleRibbon daoControleRibbon = new DAOControleRibbon();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String paginaParam = request.getParameter("pagina");
        int pagina = 1; // Página padrão
        int tamanho = 10; // Tamanho padrão para a paginação
        String dataInicial = request.getParameter("dataInicial");
        String dataFinal = request.getParameter("dataFinal");
        try {
            DAOControleRibbon daoControleRibbon = new DAOControleRibbon();
            // Buscar o último controle registrado
            ModelControleRibbon ultimoControle = daoControleRibbon.buscarUltimoControle();
            request.setAttribute("ultimoControle", ultimoControle);


            // Verificar se há uma mensagem na sessão
            String msg = (String) request.getSession().getAttribute("msg");
            if (msg != null) {
                request.setAttribute("msg", msg);
                // Limpar a mensagem da sessão após ser lida
                request.getSession().removeAttribute("msg");
            }
            List<ModelControleRibbon> controleList = new ArrayList<>();
            if ("imprimirRelatorioControle".equals(acao)) {
                int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
                int registrosPorPagina = 10;
                int offset = (paginaAtual - 1) * registrosPorPagina;

                try {
                    controleList = daoControleRibbon.listarControles(dataInicial, dataFinal, offset, registrosPorPagina);

                    // Gerar HTML dos resultados diretamente
                    StringBuilder html = new StringBuilder();
                    for (ModelControleRibbon ctr : controleList) {
                        // Formatar a data para evitar problemas com aspas no JavaScript
                        String dataFormatted = ctr.getData_ribbon() != null ?
                                new SimpleDateFormat("yyyy-MM-dd").format(ctr.getData_ribbon()).replace("'", "\\'") : "";

                        // Corrigir a geração do JavaScript para incluir as aspas na string "INICIO MES"
                        html.append("<tr>")
                                .append("<td>")
                                .append("<button type='button' class='btn btn-primary' onclick='preencherFormularioRibbon(")
                                .append(ctr.getIdControle()).append(", \"")
                                .append(dataFormatted).append("\", ")
                                .append(ctr.getRibbon_1_atual()).append(", ")
                                .append(ctr.getRibbon_2_atual()).append(", ")
                                .append(ctr.getRibbon_3_atual()).append(", ")
                                .append(ctr.getRibbon_4_atual()).append(", ")
                                .append(ctr.getRibbon_5_atual()).append(", ")
                                .append(ctr.getRibbon_6_atual()).append(", ")
                                .append(ctr.getRev_ribbon_1()).append(", ")
                                .append(ctr.getRev_ribbon_2()).append(", ")
                                .append(ctr.getRev_ribbon_3()).append(", ")
                                .append(ctr.getRev_ribbon_4()).append(", ")
                                .append(ctr.getRev_ribbon_5()).append(", ")
                                .append(ctr.getRev_ribbon_6()).append(", ")
                                .append(ctr.getDif_ribbon_1()).append(", ")
                                .append(ctr.getDif_ribbon_2()).append(", ")
                                .append(ctr.getDif_ribbon_3()).append(", ")
                                .append(ctr.getDif_ribbon_4()).append(", ")
                                .append(ctr.getDif_ribbon_5()).append(", ")
                                .append(ctr.getDif_ribbon_6()).append(", ")
                                .append(ctr.getTroca_ribbon_1()).append(", ")
                                .append(ctr.getTroca_ribbon_2()).append(", ")
                                .append(ctr.getTroca_ribbon_3()).append(", ")
                                .append(ctr.getTroca_ribbon_4()).append(", ")
                                .append(ctr.getTroca_ribbon_5()).append(", ")
                                .append(ctr.getTroca_ribbon_6()).append(", ")
                                .append(ctr.getFim_ribbon_1()).append(", ")
                                .append(ctr.getFim_ribbon_2()).append(", ")
                                .append(ctr.getFim_ribbon_3()).append(", ")
                                .append(ctr.getFim_ribbon_4()).append(", ")
                                .append(ctr.getFim_ribbon_5()).append(", ")
                                .append(ctr.getFim_ribbon_6()).append(", ")
                                .append(ctr.getOld_ribbon_1()).append(", ")
                                .append(ctr.getOld_ribbon_2()).append(", ")
                                .append(ctr.getOld_ribbon_3()).append(", ")
                                .append(ctr.getOld_ribbon_4()).append(", ")
                                .append(ctr.getOld_ribbon_5()).append(", ")
                                .append(ctr.getOld_ribbon_6()).append(", ")
                                .append("\"").append(ctr.getObservacao_ribbon()).append("\"")
                                .append(")'>Selecionar</button>")
                                .append("</td>")
                                .append("<td>").append(dataFormatted).append("</td>")
                                .append("<td>").append(ctr.getRibbon_1_atual()).append("</td>")
                                .append("<td>").append(ctr.getRibbon_2_atual()).append("</td>")
                                .append("<td>").append(ctr.getRibbon_3_atual()).append("</td>")
                                .append("<td>").append(ctr.getRibbon_4_atual()).append("</td>")
                                .append("<td>").append(ctr.getRibbon_5_atual()).append("</td>")
                                .append("<td>").append(ctr.getRibbon_6_atual()).append("</td>")
                                .append("<td>").append(ctr.getIdControle()).append("</td>")
                                .append("</tr>");
                    }

                    // Retorna o HTML gerado para o AJAX
                    response.setContentType("text/html");
                    response.getWriter().write(html.toString());

                } catch (SQLException e) {
                    e.printStackTrace();
                    response.getWriter().write("Erro ao buscar controle.");
                }

                return;
            }


            // Exibir página JSP
            request.getRequestDispatcher("principal/controleRibbon.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }




    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");

            if ("atualizarcontrole".equals(acao)) {
                atualizarControle(request, response);
            } else {
                // Manter a lógica existente para outras ações
                String ribbonSelecionado = request.getParameter("ribbon_selecionado");

                if (ribbonSelecionado == null || ribbonSelecionado.isEmpty()) {
                    request.setAttribute("msg", "Selecione um Ribbon válido.");
                    request.getRequestDispatcher("principal/controleRibbon.jsp").forward(request, response);
                    return;
                }

                ModelControleRibbon controle = new ModelControleRibbon();

                // Buscar o último ID antes de gravar
                long ultimoId = daoControleRibbon.buscarUltimoIdControle();
                controle.setIdControle(ultimoId);

                // Mapeia os campos com base no ribbon selecionado
                int fimRibbon = Integer.parseInt(request.getParameter("fim_ribbon"));
                int trocaRibbon = Integer.parseInt(request.getParameter("troca_ribbon"));

                switch (ribbonSelecionado) {
                    case "ribbon1":
                        controle.setFim_ribbon_1(fimRibbon);
                        controle.setTroca_ribbon_1(trocaRibbon);
                        break;
                    case "ribbon2":
                        controle.setFim_ribbon_2(fimRibbon);
                        controle.setTroca_ribbon_2(trocaRibbon);
                        break;
                    case "ribbon3":
                        controle.setFim_ribbon_3(fimRibbon);
                        controle.setTroca_ribbon_3(trocaRibbon);
                        break;
                    case "ribbon4":
                        controle.setFim_ribbon_4(fimRibbon);
                        controle.setTroca_ribbon_4(trocaRibbon);
                        break;
                    case "ribbon5":
                        controle.setFim_ribbon_5(fimRibbon);
                        controle.setTroca_ribbon_5(trocaRibbon);
                        break;
                    case "ribbon6":
                        controle.setFim_ribbon_6(fimRibbon);
                        controle.setTroca_ribbon_6(trocaRibbon);
                        break;
                    default:
                        // Armazenar a mensagem na sessão
                        request.getSession().setAttribute("msg", "Ribbon inválido selecionado.");
                        response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
                        return;
                }

                // Grava no banco
                daoControleRibbon.gravarTrocaRibbon(controle);

                // Armazenar a mensagem de sucesso na sessão
                request.getSession().setAttribute("msg", "Troca de ribbon registrada com sucesso!");
                response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Erro: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
        }
    }


    private void atualizarControle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ModelControleRibbon controle = new ModelControleRibbon();

            // Verificando e mapeando parâmetros do formulário para o modelo
            String idControleStr = request.getParameter("idControle");
            if (idControleStr != null && !idControleStr.isEmpty()) {
                controle.setIdControle(Long.parseLong(idControleStr));
            } else {
                request.getSession().setAttribute("msg", "ID do controle é inválido.");
                response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
                return;
            }

            controle.setData_ribbon(Date.valueOf(request.getParameter("data_ribbon")));

            // Verificar os parâmetros antes de fazer o parse
            try {
                controle.setRibbon_1_atual(Integer.parseInt(request.getParameter("ribbon_1_atual")));
                controle.setRibbon_2_atual(Integer.parseInt(request.getParameter("ribbon_2_atual")));
                controle.setRibbon_3_atual(Integer.parseInt(request.getParameter("ribbon_3_atual")));
                controle.setRibbon_4_atual(Integer.parseInt(request.getParameter("ribbon_4_atual")));
                controle.setRibbon_5_atual(Integer.parseInt(request.getParameter("ribbon_5_atual")));
                controle.setRibbon_6_atual(Integer.parseInt(request.getParameter("ribbon_6_atual")));
                controle.setRev_ribbon_1(Integer.parseInt(request.getParameter("rev_ribbon_1")));
                controle.setRev_ribbon_2(Integer.parseInt(request.getParameter("rev_ribbon_2")));
                controle.setRev_ribbon_3(Integer.parseInt(request.getParameter("rev_ribbon_3")));
                controle.setRev_ribbon_4(Integer.parseInt(request.getParameter("rev_ribbon_4")));
                controle.setRev_ribbon_5(Integer.parseInt(request.getParameter("rev_ribbon_5")));
                controle.setRev_ribbon_6(Integer.parseInt(request.getParameter("rev_ribbon_6")));
                controle.setDif_ribbon_1(Integer.parseInt(request.getParameter("dif_ribbon_1")));
                controle.setDif_ribbon_2(Integer.parseInt(request.getParameter("dif_ribbon_2")));
                controle.setDif_ribbon_3(Integer.parseInt(request.getParameter("dif_ribbon_3")));
                controle.setDif_ribbon_4(Integer.parseInt(request.getParameter("dif_ribbon_4")));
                controle.setDif_ribbon_5(Integer.parseInt(request.getParameter("dif_ribbon_5")));
                controle.setDif_ribbon_6(Integer.parseInt(request.getParameter("dif_ribbon_6")));
                controle.setTroca_ribbon_1(Integer.parseInt(request.getParameter("troca_ribbon_1")));
                controle.setTroca_ribbon_2(Integer.parseInt(request.getParameter("troca_ribbon_2")));
                controle.setTroca_ribbon_3(Integer.parseInt(request.getParameter("troca_ribbon_3")));
                controle.setTroca_ribbon_4(Integer.parseInt(request.getParameter("troca_ribbon_4")));
                controle.setTroca_ribbon_5(Integer.parseInt(request.getParameter("troca_ribbon_5")));
                controle.setTroca_ribbon_6(Integer.parseInt(request.getParameter("troca_ribbon_6")));
                controle.setFim_ribbon_1(Integer.parseInt(request.getParameter("fim_ribbon_1")));
                controle.setFim_ribbon_2(Integer.parseInt(request.getParameter("fim_ribbon_2")));
                controle.setFim_ribbon_3(Integer.parseInt(request.getParameter("fim_ribbon_3")));
                controle.setFim_ribbon_4(Integer.parseInt(request.getParameter("fim_ribbon_4")));
                controle.setFim_ribbon_5(Integer.parseInt(request.getParameter("fim_ribbon_5")));
                controle.setFim_ribbon_6(Integer.parseInt(request.getParameter("fim_ribbon_6")));
                controle.setObservacao_ribbon(request.getParameter("observacao_ribbon"));
                controle.setOld_ribbon_1(Integer.parseInt(request.getParameter("old_ribbon_1")));
                controle.setOld_ribbon_2(Integer.parseInt(request.getParameter("old_ribbon_2")));
                controle.setOld_ribbon_3(Integer.parseInt(request.getParameter("old_ribbon_3")));
                controle.setOld_ribbon_4(Integer.parseInt(request.getParameter("old_ribbon_4")));
                controle.setOld_ribbon_5(Integer.parseInt(request.getParameter("old_ribbon_5")));
                controle.setOld_ribbon_6(Integer.parseInt(request.getParameter("old_ribbon_6")));
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.getSession().setAttribute("msg", "Erro de formatação nos parâmetros numéricos.");
                response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
                return;
            }

            // Atualiza no banco
            daoControleRibbon.atualizarControle(controle);

            request.getSession().setAttribute("msg", "Controle atualizado com sucesso!");
            response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Erro ao atualizar controle: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ServletControleRibbon");
        }
    }




}
