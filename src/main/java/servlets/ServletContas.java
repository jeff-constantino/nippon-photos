package servlets;

import dao.DAOContas;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;
import util.DateUtil;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ServletContas")
public class ServletContas extends HttpServlet {
    private DAOContas daoContas;

    @Override
    public void init() throws ServletException {
        daoContas = new DAOContas();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String msg;

            // Obtém os parâmetros do request
            String conta_id = request.getParameter("idPedido"); // Altere para o nome correto, se necessário
            String numero_pedido = request.getParameter("numero_pedido");
            String empresa = request.getParameter("empresa");
            String itens = request.getParameter("itens");
            String valor = request.getParameter("valor");
            String valor2 = request.getParameter("valor2");
            String data_pedido = request.getParameter("data_de_pedido");
            String data_pagamento = request.getParameter("data_de_pagamento");
            String status = request.getParameter("status");
            String acao = request.getParameter("acao");

            ModelContas modelContas = new ModelContas();

            // Seta os dados da conta
            if (conta_id != null && !conta_id.isEmpty()) {
                modelContas.setConta_id(Long.parseLong(conta_id));
            }

            modelContas.setNumero_pedido(numero_pedido != null && !numero_pedido.isEmpty() ? Integer.parseInt(numero_pedido) : 0);
            modelContas.setEmpresa(empresa);
            modelContas.setItens(itens);

            // Converte os valores, removendo formatações
            double valorConvertido = converterValorParaDouble(valor);
            double valor2Convertido = converterValorParaDouble(valor2);

            // Seta o valor dependendo da ação
            if ("atualizar".equals(acao)) {
                modelContas.setValor(valor2Convertido);
                msg = "Conta atualizada com sucesso!";
            } else {
                modelContas.setValor(valorConvertido);
                msg = "Conta gravada com sucesso!";
            }

            modelContas.setStatus(status != null ? status.toUpperCase() : null);

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

            // Verifica se o ID da conta é válido
            if (modelContas.getConta_id() != null) {
                System.out.println("ID da conta: " + modelContas.getConta_id());
                System.out.println("Verificando se a conta existe no banco...");
                if (daoContas.existeContaId(modelContas.getConta_id())) {
                    System.out.println("Conta existe, atualizando...");
                    daoContas.atualizarConta(modelContas);
                } else {
                    System.out.println("Conta não existe, gravando nova conta...");
                    daoContas.gravarConta(modelContas);
                }
            } else {
                System.out.println("ID da conta é nulo, gravando nova conta...");
                daoContas.gravarConta(modelContas);
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

    // Função para converter valor formatado para double
    private double converterValorParaDouble(String valorFormatado) {
        if (valorFormatado == null || valorFormatado.isEmpty()) {
            return 0.0;
        }

        // Remove os pontos e substitui a vírgula por ponto
        valorFormatado = valorFormatado.replace(".", "").replace(",", ".");
        try {
            return Double.parseDouble(valorFormatado);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Valor inválido: " + valorFormatado);
        }
    }





    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ModelContas> contasVencendo;
        List<ModelContas> todasContas;
        List<ModelContas> contasRecentes;
        String acao = request.getParameter("acao");
        String contaId = request.getParameter("conta_id");

        try {
            // Chama o método para buscar contas que vencem em 7 dias e estão "A PAGAR"
            contasVencendo = daoContas.buscarContasVencendoEm7Dias();
            request.setAttribute("contasVencendo", contasVencendo); // Passa as contas vencendo para o JSP

            // Chama o método para listar todas as contas
            todasContas = daoContas.listarContas();
            request.setAttribute("todasContas", todasContas); // Passa todas as contas para o JSP

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


}