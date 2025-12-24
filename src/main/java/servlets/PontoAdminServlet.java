package servlets;

import dao.PontoDAO;
import model.Ponto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ponto-admin")
public class PontoAdminServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");
        HttpSession session = req.getSession();
        PontoDAO dao = new PontoDAO();

        try {
            switch (acao) {
                case "login":
                    String user = req.getParameter("usuario");
                    String senha = req.getParameter("senha");
                    if (dao.autenticarAdmin(user, senha)) {
                        session.setAttribute("pontoAdmin", user);
                        resp.sendRedirect("ponto/adminponto.jsp");
                    } else {
                        req.setAttribute("erro", "Usuário ou senha inválidos!");
                        req.getRequestDispatcher("ponto/adminponto.jsp").forward(req, resp);
                    }
                    break;

                case "logout":
                    session.removeAttribute("pontoAdmin");
                    resp.sendRedirect("ponto/adminponto.jsp");
                    break;

                case "salvar-funcionario":
                    Ponto p = new Ponto();
                    p.setFuncNome(req.getParameter("nome"));
                    p.setFuncCpf(req.getParameter("cpf"));
                    p.setFuncTelefone(req.getParameter("telefone"));
                    p.setFuncSenha(req.getParameter("senha"));
                    dao.salvarFuncionario(p);
                    req.setAttribute("sucesso", "Funcionário cadastrado!");
                    req.getRequestDispatcher("ponto/adminponto.jsp").forward(req, resp);
                    break;

                case "alternar-status":
                    int funcId = Integer.parseInt(req.getParameter("funcId"));
                    dao.alternarStatus(funcId);
                    req.setAttribute("sucesso", "Status alterado!");
                    req.getRequestDispatcher("ponto/adminponto.jsp").forward(req, resp);
                    break;

                case "salvar-horario":
                    int fId = Integer.parseInt(req.getParameter("funcId"));
                    String dia = req.getParameter("diaSemana");
                    Time hora = Time.valueOf(req.getParameter("horaEntrada") + ":00");
                    int tol = Integer.parseInt(req.getParameter("tolerancia"));
                    dao.salvarHorario(fId, dia, hora, tol);
                    req.setAttribute("sucesso", "Horário salvo!");
                    req.getRequestDispatcher("ponto/adminponto.jsp").forward(req, resp);
                    break;

                case "editar-registro":
                    int regId = Integer.parseInt(req.getParameter("regId"));
                    Timestamp ent = req.getParameter("entrada").isEmpty() ? null : Timestamp.valueOf(req.getParameter("entrada"));
                    Timestamp sInt = req.getParameter("saidaInt").isEmpty() ? null : Timestamp.valueOf(req.getParameter("saidaInt"));
                    Timestamp rInt = req.getParameter("retornoInt").isEmpty() ? null : Timestamp.valueOf(req.getParameter("retornoInt"));
                    Timestamp sai = req.getParameter("saida").isEmpty() ? null : Timestamp.valueOf(req.getParameter("saida"));
                    String obs = req.getParameter("obs");
                    dao.editarRegistro(regId, ent, sInt, rInt, sai, obs, (String) session.getAttribute("pontoAdmin"));
                    req.setAttribute("sucesso", "Registro editado!");
                    req.getRequestDispatcher("ponto/adminponto.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro: " + e.getMessage());
            req.getRequestDispatcher("ponto/adminponto.jsp").forward(req, resp);
        }
    }
}