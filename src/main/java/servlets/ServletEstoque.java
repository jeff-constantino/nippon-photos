package servlets;

import connection.HikariCPUtil;
import dao.DAOEstoque;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelEstoque;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/ServletEstoque")
public class ServletEstoque extends HttpServlet {
    private DAOEstoque dao = new DAOEstoque();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        Connection conn = null;
        try {
            conn = HikariCPUtil.getConnection();
            conn.setAutoCommit(false);
            if ("cadastrar".equals(acao)) {
                ModelEstoque p = new ModelEstoque();
                p.setCodBarra(request.getParameter("codBarra"));
                p.setNome(request.getParameter("nome"));
                p.setMarca(request.getParameter("marca"));
                p.setPeso(request.getParameter("peso"));
                p.setValorCompra(new BigDecimal(request.getParameter("valorCompra")));
                p.setValorVenda(new BigDecimal(request.getParameter("valorVenda")));
                dao.salvarProduto(p, conn);
                conn.commit();
            } else if ("entrada".equals(acao) || "saida".equals(acao)) {
                ModelEstoque p = dao.buscarPorCodBarra(request.getParameter("codBarra"));
                if (p != null) {
                    p.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
                    p.setTipoMovimento(acao.toUpperCase());
                    p.setMotivo(request.getParameter("motivo"));
                    p.setObservacao(request.getParameter("observacao"));
                    dao.registrarMovimento(p, conn);
                    conn.commit();
                }
            } else if ("troca".equals(acao)) {
                String codSai = request.getParameter("codBarraSaindo");
                String codEntra = request.getParameter("codBarraEntrando");
                String obs = request.getParameter("observacao");
                if (codSai != null && !codSai.isEmpty()) {
                    ModelEstoque pS = dao.buscarPorCodBarra(codSai);
                    if(pS != null) {
                        pS.setQuantidade(1); pS.setTipoMovimento("SAIDA"); pS.setMotivo("TROCA"); pS.setObservacao(obs);
                        dao.registrarMovimento(pS, conn);
                    }
                }
                ModelEstoque pE = dao.buscarPorCodBarra(codEntra);
                if (pE != null) {
                    pE.setQuantidade(1); pE.setTipoMovimento("ENTRADA"); pE.setMotivo("TROCA/DEVOLUCAO"); pE.setObservacao(obs);
                    dao.registrarMovimento(pE, conn);
                }
                conn.commit();
            }
            response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=sucesso");
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=erro");
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Limpa o buffer da resposta para remover cabeçalhos de download residuais de filtros globais
        response.resetBuffer();

        // 2. Define explicitamente o tipo de conteúdo como HTML
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 3. Cabeçalhos extras para garantir que o navegador não faça cache do "erro de download" anterior
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        try {
            String d1 = request.getParameter("dataInicio");
            String d2 = request.getParameter("dataFim");
            String tipo = request.getParameter("filtro");

            if (d1 != null && d1.trim().length() > 0 && d2 != null && d2.trim().length() > 0) {

                if ("RESUMIDO".equals(tipo)) {
                    // Busca a lógica de saldos agrupados
                    request.setAttribute("listaResumida", dao.gerarRelatorioResumido(d1, d2));
                } else {
                    // Busca a lógica detalhada de movimentos
                    request.setAttribute("movimentacoes", dao.listarMovimentacoes(d1, d2, tipo));
                }

                request.setAttribute("tipoRelatorio", tipo);

                // Forward interno para o JSP do relatório
                request.getRequestDispatcher("/estoque/relatorio.jsp").forward(request, response);

            } else {
                // Se não houver datas, volta para o painel com aviso
                response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=informe_datas");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Em caso de erro grave, redireciona para evitar página em branco
            response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=erro_relatorio");
        }
    }
}