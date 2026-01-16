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
    // ✅ REMOVIDO: private DAOContas daoContas;
    // ✅ REMOVIDO: init()

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
            String acao = request.getParameter("acao");

            ModelContas modelContas = new ModelContas();

            if (conta_id != null && !conta_id.isEmpty()) {
                modelContas.setConta_id(Long.parseLong(conta_id));
            }

            modelContas.setNumero_pedido(numero_pedido != null && !numero_pedido.isEmpty() ? Long.parseLong(numero_pedido) : 0L);
            modelContas.setEmpresa(empresa);
            modelContas.setItens(itens);

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            pagina = Integer.parseInt(paginaParam);
        }

        if ("imprimirRelatorioContas".equals(acao)) {
            int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
            int registrosPorPagina = 10;

            List<ModelContas> contasList;
            try {
                contasList = daoContas.listarContas(paginaAtual, registrosPorPagina);
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().write("Erro ao buscar contas.");
                return;
            }

            StringBuilder html = new StringBuilder();
            html.append("<table class='table table-striped table-bordered' style='color: #f2a654;'>")
                    .append("<thead>")
                    .append("<tr>")
                    .append("</tr>")
                    .append("</thead>")
                    .append("<tbody>");

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            for (ModelContas conta : contasList) {
                html.append("<tr>")
                        .append("<td>").append(conta.getConta_id()).append("</td>")
                        .append("<td>").append(conta.getNumero_pedido()).append("</td>")
                        .append("<td>").append(conta.getEmpresa()).append("</td>")
                        .append("<td>").append(conta.getItens()).append("</td>")
                        .append("<td>").append(conta.getValor()).append("</td>")
                        .append("<td>").append(formatDate(conta.getData_de_pedido())).append("</td>")
                        .append("<td>").append(formatDate(conta.getData_de_pagamento())).append("</td>")
                        .append("<td>").append(conta.getStatus()).append("</td>")
                        .append("<td>").append(conta.getPagamento()).append("</td>")
                        .append("</tr>");
            }

            html.append("</tbody>")
                    .append("</table>");

            response.setContentType("text/html");
            response.getWriter().write(html.toString());
            return;
        }

        try {
            contasVencendo = daoContas.buscarContasVencendoEm7Dias();
            request.setAttribute("contasVencendo", contasVencendo);

            todasContas = daoContas.listarContas(pagina, tamanho);
            request.setAttribute("todasContas", todasContas);

            int totalContas = daoContas.contarTotalContas();
            int totalPaginas = (int) Math.ceil((double) totalContas / tamanho);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("paginaAtual", pagina);

            contasRecentes = daoContas.buscarContasRecentes();
            request.setAttribute("contasRecentes", contasRecentes);

            if (acao != null && acao.equals("deletar")) {
                if (contaId != null && !contaId.isEmpty()) {
                    long idParaExcluir = Long.parseLong(contaId);
                    try {
                        daoContas.deleteConta(idParaExcluir);
                        request.setAttribute("msg", "Conta com ID " + idParaExcluir + " excluída com sucesso!");
                    } catch (Exception e) {
                        request.setAttribute("msg", "Erro ao excluir conta: " + e.getMessage());
                    }
                } else {
                    request.setAttribute("msg", "Erro: o ID da conta não foi encontrado.");
                }
            }

        } catch (SQLException e) {
            request.setAttribute("msg", "Erro ao buscar contas: " + e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        request.getRequestDispatcher("/principal/contas.jsp").forward(request, response);
    }

    private String formatDate(Date date) {
        if (date != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(date);
        }
        return "";
    }
}