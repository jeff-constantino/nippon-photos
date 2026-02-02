package servlets;

import dao.DAOContas;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/ServletFinanContas")
public class ServletFinanContas extends ServletGenericUtil {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOContas daoContas = new DAOContas(conn);

        try {
            String msg = "";

            String conta_id = request.getParameter("idPedido");
            String numero_pedido = request.getParameter("numero_pedido");
            String empresa = request.getParameter("empresa");
            String empresa2 = request.getParameter("empresa2");
            String itens = request.getParameter("itens");
            String valor1 = request.getParameter("conf1_valor");
            String valor2 = request.getParameter("conf1_valor2");
            String data_pedido = request.getParameter("data_de_pedido");
            String data_pagamento = request.getParameter("data_de_pagamento");
            String status = request.getParameter("status");
            String pagamento = request.getParameter("pagamento");
            String codigo = request.getParameter("codigo"); // ⭐ NOVO
            String acao = request.getParameter("acao");

            ModelContas modelContas = new ModelContas();

            if (conta_id != null && !conta_id.isEmpty()) {
                modelContas.setConta_id(Long.parseLong(conta_id));
            }

            modelContas.setNumero_pedido(numero_pedido != null && !numero_pedido.isEmpty() ? Long.parseLong(numero_pedido) : 0L);
            modelContas.setItens(itens);
            modelContas.setCodigo(codigo); // ⭐ NOVO

            double valor1Convertido = valor1 != null && !valor1.isEmpty() ? Double.parseDouble(valor1) : 0.0;
            double valor2Convertido = valor2 != null && !valor2.isEmpty() ? Double.parseDouble(valor2) : 0.0;

            if ("atualizar".equals(acao)) {
                modelContas.setValor(valor2Convertido);
                modelContas.setEmpresa(empresa2);
                msg = "Conta atualizada com sucesso!";
            } else {
                modelContas.setValor(valor1Convertido);
                modelContas.setEmpresa(empresa);
                msg = "Conta gravada com sucesso!";
            }

            modelContas.setStatus(status != null ? status.toUpperCase() : null);
            modelContas.setPagamento(pagamento != null ? pagamento.toUpperCase() : null);

            if (data_pedido != null && !data_pedido.isEmpty()) {
                try {
                    modelContas.setData_de_pedido(Date.valueOf(data_pedido));
                } catch (IllegalArgumentException e) {
                    throw new ServletException("Data de pedido inválida: " + data_pedido);
                }
            }

            if (data_pagamento != null && !data_pagamento.isEmpty()) {
                try {
                    modelContas.setData_de_pagamento(Date.valueOf(data_pagamento));
                } catch (IllegalArgumentException e) {
                    throw new ServletException("Data de pagamento inválida: " + data_pagamento);
                }
            }

            if ("baixar".equals(acao)) {
                String formaPgto = request.getParameter("formaPgto");

                if (numero_pedido != null && !numero_pedido.isEmpty()) {
                    try {
                        daoContas.atualizarStatusPorNumeroPedido(Long.parseLong(numero_pedido), formaPgto);
                        msg = "Conta baixada como PAGO com sucesso!";
                    } catch (NumberFormatException e) {
                        msg = "Número do pedido inválido: " + numero_pedido;
                    } catch (SQLException e) {
                        msg = "Erro ao atualizar a conta: " + e.getMessage();
                    } catch (Exception e) {
                        msg = "Erro geral ao atualizar: " + e.getMessage();
                    }
                } else {
                    msg = "Número do pedido não fornecido para baixar.";
                }

                request.setAttribute("msg", msg);
                response.sendRedirect(request.getContextPath() + "/ServletFinanContas");
                return;
            }

            if (modelContas.getConta_id() != null) {
                if (daoContas.existeContaId(modelContas.getConta_id())) {
                    daoContas.atualizarConta(modelContas);
                } else {
                    daoContas.gravarConta(modelContas);
                }
            } else {
                daoContas.gravarConta(modelContas);
            }

            request.setAttribute("msg", msg);
            request.setAttribute("modelContas", modelContas);

            response.sendRedirect(request.getContextPath() + "/ServletFinanContas");

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Obtém a conexão gerenciada pelo Filter
        Connection conn = (Connection) request.getAttribute("connection");
        DAOContas daoContas = new DAOContas(conn);

        List<ModelContas> contasVencendo;
        List<ModelContas> todasContas;
        List<ModelContas> contasRecentes;
        String acao = request.getParameter("acao");
        String contaId = request.getParameter("conta_id");
        String paginaParam = request.getParameter("pagina");
        int pagina = 1;
        int tamanho = 10;

        if (paginaParam != null && !paginaParam.isEmpty()) {
            try {
                pagina = Integer.parseInt(paginaParam);
            } catch (NumberFormatException e) {
                pagina = 1; // valor padrão em caso de erro
            }
        }

        // ===== AÇÃO: IMPRIMIR RELATÓRIO DE CONTAS (AJAX) =====
        if ("imprimirRelatorioContas".equals(acao)) {
            int paginaAtual = 1;
            int registrosPorPagina = 10;

            if (request.getParameter("pagina") != null) {
                try {
                    paginaAtual = Integer.parseInt(request.getParameter("pagina"));
                } catch (NumberFormatException e) {
                    paginaAtual = 1;
                }
            }

            List<ModelContas> contasList;
            try {
                contasList = daoContas.listarContas(paginaAtual, registrosPorPagina);
            } catch (SQLException e) {
                e.printStackTrace();
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().write("<tr><td colspan='10'>Erro ao buscar contas: " + e.getMessage() + "</td></tr>");
                return;
            }

            StringBuilder html = new StringBuilder();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

            for (ModelContas conta : contasList) {
                html.append("<tr>")
                        .append("<td>").append(conta.getConta_id()).append("</td>")
                        .append("<td>").append(conta.getNumero_pedido()).append("</td>")
                        .append("<td>").append(conta.getEmpresa() != null ? conta.getEmpresa() : "").append("</td>")
                        .append("<td>").append(conta.getItens() != null ? conta.getItens() : "").append("</td>")
                        .append("<td>R$ ").append(String.format("%.2f", conta.getValor())).append("</td>")
                        .append("<td>").append(formatDate(conta.getData_de_pedido())).append("</td>")
                        .append("<td>").append(formatDate(conta.getData_de_pagamento())).append("</td>")
                        .append("<td>").append(conta.getStatus() != null ? conta.getStatus() : "").append("</td>")
                        .append("<td>").append(conta.getPagamento() != null ? conta.getPagamento() : "").append("</td>")
                        .append("</tr>");
            }

            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write(html.toString());
            return;
        }

        // ===== AÇÃO: DELETAR CONTA =====
        if ("deletar".equals(acao)) {
            if (contaId != null && !contaId.isEmpty()) {
                try {
                    long idParaExcluir = Long.parseLong(contaId);
                    daoContas.deleteConta(idParaExcluir);
                    request.setAttribute("msg", "Conta com ID " + idParaExcluir + " excluída com sucesso!");
                } catch (NumberFormatException e) {
                    request.setAttribute("msg", "ID da conta inválido: " + contaId);
                } catch (Exception e) {
                    request.setAttribute("msg", "Erro ao excluir conta: " + e.getMessage());
                }
            } else {
                request.setAttribute("msg", "Erro: o ID da conta não foi encontrado.");
            }

            // Redireciona para evitar reenvio do formulário
            response.sendRedirect(request.getContextPath() + "/ServletFinanContas");
            return;
        }

        // ===== CARREGAMENTO PADRÃO DA PÁGINA =====
        try {
            // 1. Busca contas vencendo em 7 dias
            contasVencendo = daoContas.buscarContasVencendoEm7Dias();
            request.setAttribute("contasVencendo", contasVencendo);

            // 2. Busca todas as contas com paginação
            todasContas = daoContas.listarContas(pagina, tamanho);
            request.setAttribute("todasContas", todasContas);

            // 3. Calcula paginação
            int totalContas = daoContas.contarTotalContas();
            int totalPaginas = (int) Math.ceil((double) totalContas / tamanho);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("paginaAtual", pagina);

            // 4. Busca contas recentes (últimos 60 dias)
            contasRecentes = daoContas.buscarContasRecentes();
            request.setAttribute("contasRecentes", contasRecentes);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao buscar contas: " + e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        }

        // Encaminha para a página JSP
        request.getRequestDispatcher("/principal/contas.jsp").forward(request, response);
    }

    /**
     * Método auxiliar para formatar datas
     */
    private String formatDate(Date date) {
        if (date != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(date);
        }
        return "";
    }
}