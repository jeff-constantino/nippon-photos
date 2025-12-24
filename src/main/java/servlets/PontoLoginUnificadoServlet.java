package servlets;

import dao.PontoDAO;
import model.Ponto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ponto-login-unificado")
public class PontoLoginUnificadoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Servlet está ativa!");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String tipoLogin = req.getParameter("tipoLogin");
        String senha = req.getParameter("senha");

        try {
            PontoDAO dao = new PontoDAO();

            if ("funcionario".equals(tipoLogin)) {
                String cpf = req.getParameter("cpf");
                Ponto func = dao.autenticarFuncionario(cpf, senha);

                if (func != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("pontoFunc", func);
                    // REDIRECIONAMENTO SUCESSO: contextPath + caminho
                    resp.sendRedirect(req.getContextPath() + "/ponto/registroponto.jsp");
                } else {
                    req.setAttribute("erro", "CPF ou senha inválidos!");
                    // FORWARD ERRO: Caminho interno (sem o contextPath)
                    req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
                }

            } else if ("admin".equals(tipoLogin)) {
                String usuario = req.getParameter("usuario");

                if (dao.autenticarAdmin(usuario, senha)) {
                    HttpSession session = req.getSession();
                    session.setAttribute("pontoAdmin", usuario);
                    // REDIRECIONAMENTO SUCESSO
                    resp.sendRedirect(req.getContextPath() + "/ponto/adminponto.jsp");
                } else {
                    req.setAttribute("erro", "Usuário ou senha inválidos!");
                    req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro interno no servidor.");
            req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
        }
    }
}