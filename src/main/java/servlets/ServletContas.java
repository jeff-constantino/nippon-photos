package servlets;

import dao.DAOContas;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/ServletContas")
public class ServletContas extends ServletGenericUtil {
    private DAOContas daoContas;

    @Override
    public void init() throws ServletException {
        daoContas = new DAOContas();
    }

    @Override

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String msg = ""; // Inicializa a mensagem

            // Obtém os parâmetros do request
            String conta_id = request.getParameter("idPedido");
            String numero_pedido = request.getParameter("numero_pedido");
            String empresa = request.getParameter("empresa");
            String empresa2 = request.getParameter("empresa2");
            String itens = request.getParameter("itens");
            String valor1 = request.getParameter("conf1_valor"); // valor1 já vem sem máscara
            String valor2 = request.getParameter("conf1_valor2"); // valor2 já vem sem máscara
            String data_pedido = request.getParameter("data_de_pedido");
            String data_pagamento = request.getParameter("data_de_pagamento");
            String status = request.getParameter("status");
            String pagamento = request.getParameter("pagamento");
            String acao = request.getParameter("acao");


            ModelContas modelContas = new ModelContas();

            // Seta os dados da conta
            if (conta_id != null && !conta_id.isEmpty()) {
                modelContas.setConta_id(Long.parseLong(conta_id));
            }

            // Mudar de Integer para Long
            modelContas.setNumero_pedido(numero_pedido != null && !numero_pedido.isEmpty() ? Long.parseLong(numero_pedido) : 0L);
            modelContas.setEmpresa(empresa);
            modelContas.setItens(itens);

            // Converte os valores para double
            double valor1Convertido = valor1 != null && !valor1.isEmpty() ? Double.parseDouble(valor1) : 0.0;
            double valor2Convertido = valor2 != null && !valor2.isEmpty() ? Double.parseDouble(valor2) : 0.0;

            // Seta o valor dependendo da ação (gravar ou atualizar)
            if ("atualizar".equals(acao)) {
                modelContas.setValor(valor2Convertido); // Atualiza com o valor2
                modelContas.setEmpresa(empresa2);
                msg = "Conta atualizada com sucesso!";
            } else {
                modelContas.setValor(valor1Convertido); // Grava com o valor1
                modelContas.setEmpresa(empresa);
                msg = "Conta gravada com sucesso!";
            }

            modelContas.setStatus(status != null ? status.toUpperCase() : null);
            modelContas.setPagamento(pagamento != null ? pagamento.toUpperCase() : null);

            // Converte e seta as datas
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

            // Parte isolada para dar baixa
            if ("baixar".equals(acao)) {
                String formaPgto = request.getParameter("formaPgto"); // <-- novo

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
                response.sendRedirect(request.getContextPath() + "/ServletContas");
                return;
            }


            // Verifica se o ID da conta é válido para decidir entre atualização ou criação
            if (modelContas.getConta_id() != null) {
                if (daoContas.existeContaId(modelContas.getConta_id())) {
                    daoContas.atualizarConta(modelContas); // Atualiza conta existente
                } else {
                    daoContas.gravarConta(modelContas); // Grava nova conta
                }
            } else {
                daoContas.gravarConta(modelContas); // Grava nova conta se não houver ID
            }

            // Mantém os dados e mensagem na tela
            request.setAttribute("msg", msg);
            request.setAttribute("modelContas", modelContas);

            // Redireciona para a servlet ServletContas após gravar ou atualizar
            response.sendRedirect(request.getContextPath() + "/ServletContas");

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ModelContas> contasVencendo;
        List<ModelContas> todasContas;
        List<ModelContas> contasRecentes;
        String acao = request.getParameter("acao");
        String contaId = request.getParameter("conta_id");
        String paginaParam = request.getParameter("pagina");
        int pagina = 1; // Página padrão
        int tamanho = 10; // Tamanho padrão para a paginação

        if (paginaParam != null && !paginaParam.isEmpty()) {
            pagina = Integer.parseInt(paginaParam); // Pega a página solicitada
        }
        if ("imprimirRelatorioContas".equals(acao)) {
            int paginaAtual = request.getParameter("pagina") != null ? Integer.parseInt(request.getParameter("pagina")) : 1;
            int registrosPorPagina = 10; // Defina a quantidade de registros por página

            List<ModelContas> contasList;
            try {
                contasList = daoContas.listarContas(paginaAtual, registrosPorPagina);
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

            // Escreve o HTML gerado na resposta
            response.setContentType("text/html");
            response.getWriter().write(html.toString());
            return; // Evita a execução do código abaixo
        }

        try {
            // Chama o método para buscar contas que vencem em 7 dias e estão "A PAGAR"
            contasVencendo = daoContas.buscarContasVencendoEm7Dias();
            request.setAttribute("contasVencendo", contasVencendo); // Passa as contas vencendo para o JSP

            // Chama o método para listar todas as contas com paginação
            todasContas = daoContas.listarContas(pagina, tamanho);
            request.setAttribute("todasContas", todasContas); // Passa todas as contas para o JSP

            // Contar total de contas para a paginação
            int totalContas = daoContas.contarTotalContas();
            int totalPaginas = (int) Math.ceil((double) totalContas / tamanho);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("paginaAtual", pagina);

            // Busca apenas as contas dos últimos 60 dias
            contasRecentes = daoContas.buscarContasRecentes();
            request.setAttribute("contasRecentes", contasRecentes); // Usa um novo atributo "contasRecentes"

            if (acao != null && acao.equals("deletar")) {
                if (contaId != null && !contaId.isEmpty()) {
                    long idParaExcluir = Long.parseLong(contaId);
                    try {
                        daoContas.deleteConta(idParaExcluir); // Chama o método de exclusão
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

        // Redireciona para o JSP onde a lista de contas será exibida
        request.getRequestDispatcher("/principal/contas.jsp").forward(request, response);
    }

    // Método para formatar a data
    private String formatDate(Date date) {
        if (date != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(date);
        }
        return ""; // Retorna uma string vazia se a data for nula
    }



}



