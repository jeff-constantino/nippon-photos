package servlets;

import dao.DAOFuncionario;
import dao.DAOVales;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelVales;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/ServletVales")
public class ServletVales extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Logger logger = Logger.getLogger(ServletVales.class.getName());


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Verifica se a ação é para excluir um vale
            String acao = request.getParameter("acao");

            if ("excluirVale".equals(acao)) {
                // Obtém o idVale da URL
                String idValeStr = request.getParameter("idVale");
                if (idValeStr != null && !idValeStr.isEmpty()) {
                    long idVale = Long.parseLong(idValeStr);

                    // Chama o método excluirVale do DAO
                    DAOVales daoVales = new DAOVales();
                    boolean excluiu = daoVales.excluirVale(idVale);

                    if (excluiu) {
                        request.setAttribute("msg", "Vale excluído com sucesso.");
                    } else {
                        request.setAttribute("msg", "Erro ao excluir o vale.");
                    }
                } else {
                    request.setAttribute("msg", "ID do vale não encontrado.");
                }
            }

            // Busca os funcionários e os vales novamente após a exclusão
            DAOFuncionario relatorio = new DAOFuncionario();
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            // Busca os vales dos últimos 30 dias
            DAOVales daoVales = new DAOVales();
            List<ModelVales> valesList = daoVales.buscarValesUltimos30Dias();
            request.setAttribute("vales", valesList); // Nome do atributo ajustado

            // Encaminha para o JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/vales.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao processar a solicitação: " + e.getMessage());
            request.setAttribute("vales", new ArrayList<>()); // Garante que a lista será exibida, mesmo vazia
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/vales.jsp");
            dispatcher.forward(request, response);
        }
    }




    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String msg = "";

        try {
            if ("inserirVale".equals(acao)) {
                // Captura os parâmetros do formulário
                String idFuncionarioStr = request.getParameter("id_funcionario");
                String nomeFuncionario = request.getParameter("nome_funcionario");
                String data = request.getParameter("data");
                String observacao = request.getParameter("observacao");
                String valor = request.getParameter("valor");
                String formaPagamento = request.getParameter("forma_pagamento");

                // Cria um objeto ModelVales e configura os valores
                ModelVales vale = new ModelVales();

                // Verifica se o ID do funcionário foi enviado e atribui ao modelo
                if (idFuncionarioStr != null && !idFuncionarioStr.isEmpty()) {
                    vale.setId_funcionario(Long.parseLong(idFuncionarioStr));
                }

                vale.setNome_funcionario(nomeFuncionario);
                vale.setData(LocalDate.parse(data));
                vale.setObservacao(observacao);
                vale.setValor(new BigDecimal(valor));
                vale.setForma_pagamento(formaPagamento);

                // Chama o método para inserir o vale
                DAOVales daoVales = new DAOVales();
                boolean sucesso = daoVales.inserirVale(vale);

                // Atribui a mensagem de sucesso ou erro
                if (sucesso) {
                    msg = "Vale inserido com sucesso!";
                } else {
                    msg = "Erro ao inserir vale.";
                }
            }
        } catch (Exception e) {
            msg = "Erro ao processar o vale: " + e.getMessage();
        }

        // Configura a mensagem no request e redireciona de volta para a página de vales
        request.getSession().setAttribute("msg", msg);
        response.sendRedirect(request.getContextPath() + "/ServletVales");
    }


}
