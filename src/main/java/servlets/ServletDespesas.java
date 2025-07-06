package servlets;

import dao.DAODespesas;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelDespesas;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/ServletDespesas")
public class ServletDespesas extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;

    private final DAODespesas daoDespesas;

    // Inicializa o DAODespesas no construtor
    public ServletDespesas() {
        daoDespesas = new DAODespesas();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String paginaParam = request.getParameter("pagina");
        List<ModelDespesas> todasDespesas;
        int pagina = 1; // Página padrão
        int tamanho = 10; // Tamanho padrão para a paginação

        if (paginaParam != null && !paginaParam.isEmpty()) {
            pagina = Integer.parseInt(paginaParam); // Pega a página solicitada
        }

        if ("imprimirRelatorioDespesas".equals(acao)) {
            int paginaAtual = paginaParam != null ? Integer.parseInt(paginaParam) : 1;
            int registrosPorPagina = 10; // Defina a quantidade de registros por página

            List<ModelDespesas> todasDespesasList;
            try {
                todasDespesasList = daoDespesas.listarTodasDespesas(paginaAtual, registrosPorPagina);
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().write("Erro ao buscar contas.");
                return;
            }

            // Gera o HTML da tabela
            StringBuilder html = new StringBuilder();
            html.append("<table class='table table-striped table-bordered' style='color: #f2a654;'>")
                    .append("<thead>")
                    .append("<tr>")
                    .append("</tr>")
                    .append("</thead>")
                    .append("<tbody>");

            for (ModelDespesas despesas : todasDespesasList) {
                html.append("<tr>")
                        .append("<td>").append(despesas.getId_despesa()).append("</td>")
                        .append("<td>").append(despesas.getNome_despesa()).append("</td>")
                        .append("<td>").append(despesas.getDescricao_despesa()).append("</td>")
                        .append("<td>").append(despesas.getValor_despesa()).append("</td>")
                        .append("<td>").append(formatDate(despesas.getData_despesa())).append("</td>")
                        .append("<td>").append(despesas.getPagamento_despesa()).append("</td>")
                        .append("<td>")
                        .append("<form method='get' action='").append(request.getContextPath()).append("/ServletDespesas'>")
                        .append("<input type='hidden' name='acao' value='excluirDespesa' />")
                        .append("<input type='hidden' name='id_despesa' value='").append(despesas.getId_despesa()).append("' />")
                        .append("<button type='submit' class='btn btn-danger'>Excluir</button>")
                        .append("</form>")
                        .append("</td>")
                        .append("</tr>");
            }

            html.append("</tbody>")
                    .append("</table>");

            // Escreve o HTML gerado na resposta
            response.setContentType("text/html");
            response.getWriter().write(html.toString());
            return; // Encerra o fluxo após a resposta
        }

        if ("excluirDespesa".equals(acao)) {
            try {
                Long idDespesa = Long.parseLong(request.getParameter("id_despesa"));
                daoDespesas.excluirDespesa(idDespesa);
                request.getSession().setAttribute("msg", "Despesa excluída com sucesso!");
            } catch (Exception e) {
                request.getSession().setAttribute("msg", "Erro ao excluir a despesa: " + e.getMessage());
            }
            // Redireciona de volta para a servlet para mostrar a lista de despesas após a exclusão
            response.sendRedirect(request.getContextPath() + "/ServletDespesas");

            return;
        }

        try {
            // Chama o método para listar todas as contas com paginação
            todasDespesas = daoDespesas.listarTodasDespesas(pagina, tamanho);
            request.setAttribute("todasDespesas", todasDespesas); // Passa todas as contas para o JSP

            // Contar total de contas para a paginação
            int totalContas = daoDespesas.contarTotalDespesas();
            int totalPaginas = (int) Math.ceil((double) totalContas / tamanho);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("paginaAtual", pagina);

            // Busca a lista de despesas dos últimos 60 dias
            List<ModelDespesas> despesasList = daoDespesas.listarDespesasUltimos60Dias();

            // Adiciona a lista como atributo da requisição para a JSP
            request.setAttribute("despesasList", despesasList);

            // Encaminha para a página JSP que exibe a lista de despesas
            request.getRequestDispatcher("principal/despesas.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Erro ao listar despesas", e);
        }
    }

    // Método para formatar a data
    private String formatDate(Date date) {
        if (date != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(date);
        }
        return ""; // Retorna uma string vazia se a data for nula
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String msg = "";

        try {
            if ("gravarDespesa".equals(acao)) {
                String nomeDespesa = request.getParameter("nome_despesa");
                String descricaoDespesa = request.getParameter("descricao_despesa");
                double valorDespesa = Double.parseDouble(request.getParameter("valor_despesa"));
                String dataString = request.getParameter("data_despesa");
                String pagamentoDespesa = request.getParameter("pagamento_despesa");

                // Converter a string da data para java.util.Date
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date dataUtil = format.parse(dataString);

                // Converte java.util.Date para java.sql.Date
                java.sql.Date dataDespesa = new java.sql.Date(dataUtil.getTime());

                ModelDespesas novaDespesa = new ModelDespesas();
                novaDespesa.setNome_despesa(nomeDespesa);
                novaDespesa.setDescricao_despesa(descricaoDespesa);
                novaDespesa.setValor_despesa(valorDespesa);
                novaDespesa.setData_despesa(dataDespesa);
                novaDespesa.setPagamento_despesa(pagamentoDespesa);

                daoDespesas.gravarDespesa(novaDespesa);
                msg = "Despesa gravada com sucesso!";
            } else if ("editarDespesa".equals(acao)) {
                // Código para editar a despesa
            }
        } catch (Exception e) {
            msg = "Erro ao processar a despesa: " + e.getMessage();
        }

        // Configura a mensagem no request e redireciona de volta para a página de despesas
        request.getSession().setAttribute("msg", msg);
//        response.sendRedirect(request.getContextPath() + "/principal/despesas.jsp");
        response.sendRedirect(request.getContextPath() + "/ServletDespesas");
    }
}