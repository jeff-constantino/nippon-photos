package servlets;

import dao.DAOEstoque;
import model.ModelEstoque;
import connection.HikariCPUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSerializer;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/ServletEstoque")
public class ServletEstoque extends HttpServlet {
    private DAOEstoque dao = new DAOEstoque();

    // Gson configurado para trabalhar com LocalDateTime
    private Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class,
                    (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context) ->
                            context.serialize(src.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)))
            .create();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        Connection conn = null;

        try {
            conn = HikariCPUtil.getConnection();
            conn.setAutoCommit(false);

            if ("cadastrar".equals(acao)) {
                String codBarra = request.getParameter("codBarra");

                // Verifica se já existe produto com este código de barras
                ModelEstoque existente = dao.buscarPorCodBarra(codBarra);
                if (existente != null) {
                    response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=duplicado&nome=" +
                            java.net.URLEncoder.encode(existente.getNome(), "UTF-8") +
                            "&marca=" + java.net.URLEncoder.encode(existente.getMarca() != null ? existente.getMarca() : "", "UTF-8") +
                            "&peso=" + java.net.URLEncoder.encode(existente.getPeso() != null ? existente.getPeso() : "", "UTF-8"));
                    return;
                }

                ModelEstoque p = new ModelEstoque();
                p.setCodBarra(codBarra);
                p.setNome(request.getParameter("nome"));

                // Trata marca: se selecionou "NOVO", pega o campo marcaNova
                String marca = request.getParameter("marca");
                if ("__NOVO__".equals(marca)) {
                    marca = request.getParameter("marcaNova");
                }
                p.setMarca(marca);

                // Trata peso: se selecionou "NOVO", pega o campo pesoNovo
                String peso = request.getParameter("peso");
                if ("__NOVO__".equals(peso)) {
                    peso = request.getParameter("pesoNovo");
                }
                p.setPeso(peso);

                String valorCompra = request.getParameter("valorCompra");
                String valorVenda = request.getParameter("valorVenda");
                String estoqueInicial = request.getParameter("estoqueInicial");

                p.setValorCompra(valorCompra != null && !valorCompra.isEmpty() ? new BigDecimal(valorCompra) : BigDecimal.ZERO);
                p.setValorVenda(valorVenda != null && !valorVenda.isEmpty() ? new BigDecimal(valorVenda) : BigDecimal.ZERO);
                p.setEstoqueAtual(estoqueInicial != null && !estoqueInicial.isEmpty() ? Integer.parseInt(estoqueInicial) : 0);

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
            } else if ("atualizar".equals(acao)) {
                ModelEstoque p = new ModelEstoque();
                p.setProdutoId(Long.parseLong(request.getParameter("produtoId")));
                p.setCodBarra(request.getParameter("codBarra"));
                p.setNome(request.getParameter("nome"));
                p.setMarca(request.getParameter("marca"));
                p.setPeso(request.getParameter("peso"));
                p.setEstoqueAtual(Integer.parseInt(request.getParameter("estoqueAtual")));

                dao.atualizarProduto(p, conn);
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
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");

        // Endpoint AJAX para buscar produto por código de barras
        if ("buscarProduto".equals(acao)) {
            response.setContentType("application/json; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Cache-Control", "no-cache");

            try {
                String codBarra = request.getParameter("codBarra");
                ModelEstoque produto = dao.buscarPorCodBarra(codBarra);

                if (produto != null) {
                    response.getWriter().write(gson.toJson(produto));
                } else {
                    response.getWriter().write("{}");
                }
                response.getWriter().flush();
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("{\"erro\": \"" + e.getMessage() + "\"}");
            }
            return;
        }

        // Endpoint AJAX para listar marcas/pesos
        if ("listarMarcas".equals(acao)) {
            response.setContentType("application/json; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");

            try {
                response.getWriter().write(gson.toJson(dao.listarMarcasDistintas()));
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("[]");
            }
            return;
        }

        if ("listarPesos".equals(acao)) {
            response.setContentType("application/json; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");

            try {
                response.getWriter().write(gson.toJson(dao.listarPesosDistintos()));
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("[]");
            }
            return;
        }

        // Relatórios
        response.resetBuffer();
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        try {
            String tipo = request.getParameter("filtro");

            if ("ESTOQUE_BAIXO".equals(tipo)) {
                request.setAttribute("listaProdutos", dao.listarProdutosEstoqueBaixo());
                request.setAttribute("tipoRelatorio", tipo);
                request.getRequestDispatcher("/estoque/relatorio.jsp").forward(request, response);

            } else if ("TODOS_PRODUTOS".equals(tipo)) {
                request.setAttribute("listaProdutos", dao.listarTodosProdutos());
                request.setAttribute("tipoRelatorio", tipo);
                request.getRequestDispatcher("/estoque/relatorio.jsp").forward(request, response);

            } else {
                // Relatórios que precisam de data
                String d1 = request.getParameter("dataInicio");
                String d2 = request.getParameter("dataFim");

                if (d1 != null && d1.trim().length() > 0 && d2 != null && d2.trim().length() > 0) {
                    if ("RESUMIDO".equals(tipo)) {
                        request.setAttribute("listaResumida", dao.gerarRelatorioResumido(d1, d2));
                    } else {
                        request.setAttribute("movimentacoes", dao.listarMovimentacoes(d1, d2, tipo));
                    }
                    request.setAttribute("tipoRelatorio", tipo);
                    request.getRequestDispatcher("/estoque/relatorio.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=informe_datas");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/estoque/index.jsp?msg=erro_relatorio");
        }
    }
}