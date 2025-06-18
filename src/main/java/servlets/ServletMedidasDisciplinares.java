package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.DAOFuncionario;
import dao.DAOVendasRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelVales;
import model.ModelVendas;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/ServletMedidasDisciplinares")
public class ServletMedidasDisciplinares extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Logger logger = Logger.getLogger(ServletMedidasDisciplinares.class.getName());
    private final DAOVendasRepository daoVendasFunc = new DAOVendasRepository();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Verifica se a ação é para excluir um vale
            String acao = request.getParameter("acao");
            String funcionarioId = request.getParameter("funcionarioId");


            // Instancia o DAO para buscar os funcionários
            DAOFuncionario relatorio = new DAOFuncionario();
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            // Adiciona lista de funcionários ao request para que esteja sempre disponível no JSP
            request.setAttribute("funcionarios", funcionarios);

            List<ModelVendas> vendasFuncionarioList = new ArrayList<>();


//            RequestDispatcher dispatcher;


            // Encaminha para o JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/medidasDisciplinares.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao processar a solicitação: " + e.getMessage());
            request.setAttribute("vales", new ArrayList<>()); // Garante que a lista será exibida, mesmo vazia
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/medidasDisciplinares.jsp");
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



            }
        } catch (Exception e) {
            msg = "Erro ao processar o vale: " + e.getMessage();
        }

        // Configura a mensagem no request e redireciona de volta para a página de vales
        request.getSession().setAttribute("msg", msg);
        response.sendRedirect(request.getContextPath() + "/ServletMedidasDisciplinares");
    }


}
