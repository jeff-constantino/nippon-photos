package servlets;

import dao.DAOContas;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;

import java.io.IOException;
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
        String numeroPedidoStr = request.getParameter("numero_pedido");
        String empresa = request.getParameter("empresa");
        String itens = request.getParameter("itens");
        String valorBrutoStr = request.getParameter("valor"); // Aqui pegamos o valor sem formatação do campo oculto
        String dataDePedidoStr = request.getParameter("data_de_pedido");
        String dataDePagamentoStr = request.getParameter("data_de_pagamento");
        String status = request.getParameter("status");

        // Verificação de campos obrigatórios
        if (numeroPedidoStr == null || numeroPedidoStr.trim().isEmpty()) {
            request.setAttribute("msg", "O campo 'número do pedido' é obrigatório.");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        }

        if (empresa == null || empresa.trim().isEmpty()) {
            request.setAttribute("msg", "O campo 'empresa' é obrigatório.");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        }

        // Verificação do valor
        double valor;
        try {
            valor = Double.parseDouble(valorBrutoStr); // Agora já está no formato correto sem formatação
            if (valor < 0) {
                throw new NumberFormatException("Valor deve ser positivo.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("msg", "O campo 'valor' deve ser um número válido.");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        }

        ModelContas conta = new ModelContas();

        // Convertendo número do pedido
        try {
            conta.setNumero_pedido(Integer.parseInt(numeroPedidoStr));
        } catch (NumberFormatException e) {
            request.setAttribute("msg", "O campo 'número do pedido' deve ser um número inteiro.");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        }

        conta.setEmpresa(empresa);
        conta.setItens(itens);
        conta.setValor(valor);

        // Convertendo datas com verificação
        if (dataDePedidoStr != null && !dataDePedidoStr.trim().isEmpty()) {
            try {
                conta.setData_de_pedido(java.sql.Date.valueOf(dataDePedidoStr));
            } catch (IllegalArgumentException e) {
                request.setAttribute("msg", "Data de pedido inválida.");
                request.getRequestDispatcher("erro.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("msg", "O campo 'data de pedido' é obrigatório.");
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        }

        if (dataDePagamentoStr != null && !dataDePagamentoStr.isEmpty()) {
            try {
                conta.setData_de_pagamento(java.sql.Date.valueOf(dataDePagamentoStr));
            } catch (IllegalArgumentException e) {
                request.setAttribute("msg", "Data de pagamento inválida.");
                request.getRequestDispatcher("erro.jsp").forward(request, response);
                return;
            }
        }

        conta.setStatus(status);

        // Salvar conta no banco
        try {
            daoContas.gravarConta(conta);
            request.setAttribute("msg", "Conta gravada com sucesso!");
            request.getRequestDispatcher("principal/contas.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("msg", "Erro ao gravar conta: " + e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }




    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lista para armazenar as contas a pagar que vencem nos próximos 7 dias
        List<ModelContas> contas;
        try {
            // Chama o método para buscar contas que vencem em 7 dias e estão "A PAGAR"
            contas = daoContas.buscarContasVencendoEm7Dias();
            request.setAttribute("contas", contas); // Passa as contas para o JSP
        } catch (SQLException e) {
            // Em caso de erro, define a mensagem e redireciona para a página de erro
            request.setAttribute("msg", "Erro ao buscar contas: " + e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return; // Retorna para não continuar o processamento
        }

        // Redireciona para o JSP onde a lista de contas será exibida
        request.getRequestDispatcher("/principal/contas.jsp").forward(request, response);
    }


}
