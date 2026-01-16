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
import java.sql.Connection;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/ServletVales")
public class ServletVales extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(ServletVales.class.getName());
    // ✅ Não tinha campos DAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");

        try {
            String acao = request.getParameter("acao");

            if ("excluirVale".equals(acao)) {
                String idValeStr = request.getParameter("idVale");
                if (idValeStr != null && !idValeStr.isEmpty()) {
                    long idVale = Long.parseLong(idValeStr);

                    DAOVales daoVales = new DAOVales(conn);
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

            if ("buscarValesPorData".equals(acao)) {
                String dataInicialStr = request.getParameter("dataInicial");
                String dataFinalStr = request.getParameter("dataFinal");
                String funcionarioIdStr = request.getParameter("funcionarioId");

                if (dataInicialStr != null && dataFinalStr != null && funcionarioIdStr != null
                        && !dataInicialStr.isEmpty() && !dataFinalStr.isEmpty() && !funcionarioIdStr.isEmpty()) {
                    try {
                        LocalDate dataInicial = LocalDate.parse(dataInicialStr);
                        LocalDate dataFinal = LocalDate.parse(dataFinalStr);
                        Long funcionarioId = Long.parseLong(funcionarioIdStr);

                        DAOVales daoVales = new DAOVales(conn);
                        List<ModelVales> valesFiltrados = daoVales.buscarValesPorDataEFuncionario(dataInicial, dataFinal, funcionarioId);
                        request.setAttribute("valesFiltrados", valesFiltrados);
                        request.setAttribute("modalDataAbrir", true);

                    } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("msg", "Erro ao buscar os vales filtrados: " + e.getMessage());
                    }
                }
            }

            DAOFuncionario relatorio = new DAOFuncionario(conn);
            List<ModelLogin> funcionarios = relatorio.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            DAOVales daoVales = new DAOVales(conn);
            List<ModelVales> valesList = daoVales.buscarValesUltimos30Dias();
            request.setAttribute("vales", valesList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/vales.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao processar a solicitação: " + e.getMessage());
            request.setAttribute("vales", new ArrayList<>());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/vales.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");

        String acao = request.getParameter("acao");
        String msg = "";

        try {
            if ("inserirVale".equals(acao)) {
                String idFuncionarioStr = request.getParameter("funcionarioId");
                String nomeFuncionario = request.getParameter("nome_funcionario");
                String data = request.getParameter("data");
                String observacao = request.getParameter("observacao");
                String valor = request.getParameter("valor");
                String formaPagamento = request.getParameter("forma_pagamento");

                ModelVales vale = new ModelVales();

                if (idFuncionarioStr != null && !idFuncionarioStr.isEmpty()) {
                    vale.setId_funcionario(Long.parseLong(idFuncionarioStr));
                }

                vale.setNome_funcionario(nomeFuncionario);
                vale.setData(LocalDate.parse(data));
                vale.setObservacao(observacao);
                vale.setValor(new BigDecimal(valor));
                vale.setForma_pagamento(formaPagamento);

                DAOVales daoVales = new DAOVales(conn);
                boolean sucesso = daoVales.inserirVale(vale);

                if (sucesso) {
                    msg = "Vale inserido com sucesso!";
                } else {
                    msg = "Erro ao inserir vale.";
                }
            }
        } catch (Exception e) {
            msg = "Erro ao processar o vale: " + e.getMessage();
        }

        request.getSession().setAttribute("msg", msg);
        response.sendRedirect(request.getContextPath() + "/ServletVales");
    }
}