package servlets;

import dao.DAOFuncionario;
import dao.DAOMedidasDisciplinares;
import dao.DAOVendasRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelAdvertencia;
import model.ModelFaltas;
import model.ModelLogin;
import model.ModelSuspensao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@SuppressWarnings("ALL")
@WebServlet("/ServletMedidasDisciplinares")
public class ServletMedidasDisciplinares extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Logger logger = Logger.getLogger(ServletMedidasDisciplinares.class.getName());
    private final DAOVendasRepository daoVendasFunc = new DAOVendasRepository();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DAOFuncionario daoFuncionario = new DAOFuncionario();
            List<ModelLogin> funcionarios = daoFuncionario.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            System.out.println("doGet: Mensagem na sessão: " + request.getSession().getAttribute("msg"));

            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/medidasDisciplinares.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro ao processar a solicitação: " + e.getMessage());
            request.setAttribute("funcionarios", new ArrayList<>());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/medidasDisciplinares.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String msg = null;
        try {
            String acao = request.getParameter("acao");
            if ("limparMsg".equals(acao)) {
                request.getSession().removeAttribute("msg");
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            }

            DAOFuncionario daoFuncionario = new DAOFuncionario();
            List<ModelLogin> funcionarios = daoFuncionario.buscaFuncionarios();
            request.setAttribute("funcionarios", funcionarios);

            if ("gravarAdvertencia".equals(acao)) {
                String funcionarioId = request.getParameter("funcionarioId");
                String dataAdvertencia = request.getParameter("data_advertencia");
                String motivo = request.getParameter("adv_motivo");
                String nomeFuncionario = request.getParameter("nomeFuncionario");



                if (funcionarioId == null || funcionarioId.isEmpty()) {
                    msg = "Funcionário não selecionado.";
                } else if (dataAdvertencia == null || dataAdvertencia.isEmpty()) {
                    msg = "Data da advertência é obrigatória.";
                } else if (motivo == null || motivo.trim().isEmpty()) {
                    msg = "Motivo da advertência é obrigatório.";
                } else {
                    DAOMedidasDisciplinares dao = new DAOMedidasDisciplinares();
                    ModelAdvertencia advertencia = new ModelAdvertencia();
                    advertencia.setFuncionarioId(Long.parseLong(funcionarioId));
                    advertencia.setDataAdvertencia(java.sql.Date.valueOf(dataAdvertencia));
                    advertencia.setMotivo(motivo);
                    advertencia.setNomeFuncionario(nomeFuncionario);


                    dao.gravarAdvertencia(advertencia);
                    msg = "Advertência registrada com sucesso!";
                    request.getSession().setAttribute("funcionarioIdADV", funcionarioId);
                }
            } else if ("gravarFaltas".equals(acao)) {
                String funcionarioId = request.getParameter("funcionarioId");
                String dataFalta = request.getParameter("data_falta");
                String observacoes = request.getParameter("falta_obs");
                String nomeFuncionario = request.getParameter("nomeFuncionario");

                if (funcionarioId == null || funcionarioId.isEmpty()) {
                    msg = "Funcionário não selecionado.";
                } else if (dataFalta == null || dataFalta.isEmpty()) {
                    msg = "Data da falta é obrigatória.";
                } else if (observacoes == null || observacoes.trim().isEmpty()) {
                    msg = "Observações da falta são obrigatórias.";
                } else {
                    DAOMedidasDisciplinares dao = new DAOMedidasDisciplinares();
                    ModelFaltas falta = new ModelFaltas();
                    falta.setFuncionarioId(Long.parseLong(funcionarioId));
                    falta.setDataFalta(java.sql.Date.valueOf(dataFalta));
                    falta.setObservacoes(observacoes);
                    falta.setNomeFuncionario(nomeFuncionario);

                    dao.gravarFalta(falta);
                    msg = "Falta registrada com sucesso!";
                }
            } else if ("gravarSuspensao".equals(acao)) {
                String funcionarioId = request.getParameter("funcionarioId");
                String dataSuspensao = request.getParameter("data_suspensao");
                String motivo = request.getParameter("motivo");
                String nomeFuncionario = request.getParameter("nomeFuncionario");
                String dias  = request.getParameter("dias");

                if (funcionarioId == null || funcionarioId.isEmpty()) {
                    msg = "Funcionário não selecionado.";
                } else if (dataSuspensao == null || dataSuspensao.isEmpty()) {
                    msg = "Data da Suspensão é obrigatória.";
                } else if (motivo == null || motivo.trim().isEmpty()) {
                    msg = "O motivo da Suspenão é obrigatório.";
                } else {
                    DAOMedidasDisciplinares dao = new DAOMedidasDisciplinares();
                    ModelSuspensao suspensao = new ModelSuspensao();
                    suspensao.setFuncionarioId(Long.parseLong(funcionarioId));
                    suspensao.setDataSuspensao(java.sql.Date.valueOf(dataSuspensao));
                    suspensao.setMotivo(motivo);
                    suspensao.setNomeFuncionario(nomeFuncionario);
                    suspensao.setDias(Integer.parseInt(dias));

                    dao.gravarSuspensao(suspensao);
                    msg = "Suspensão registrada com sucesso!";
                }
            }
            else {
                msg = "Ação inválida.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "Erro ao gravar os dados: " + e.getMessage();
        }

        System.out.println("doPost: Mensagem armazenada na sessão: " + msg);
        request.getSession().setAttribute("msg", msg);
        response.sendRedirect(request.getContextPath() + "/ServletMedidasDisciplinares");
    }


}
