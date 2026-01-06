package servlets;

import dao.DAOLoginRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelContas;
import model.ModelLogin;
import dao.DAOContas;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletLogin", value = "/ServletLogin")
public class ServletLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ❌ REMOVIDO - Não instanciar no campo da classe
    // private final DAOLoginRepository daoLoginRepository = new DAOLoginRepository();
    // private final DAOContas daoContas = new DAOContas();

    public ServletLogin() {
        // Construtor vazio
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        if (acao != null && acao.equals("logout")) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        if (request.getSession().getAttribute("usuario") != null) {
            response.sendRedirect(request.getContextPath() + "/principal/principal.jsp");
            return;
        }

        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        String url = request.getParameter("url");

        try {
            if (login != null && !login.trim().isEmpty() &&
                    senha != null && !senha.trim().isEmpty()) {

                // ✅ Cria os DAOs aqui, quando necessário
                DAOLoginRepository daoLoginRepository = new DAOLoginRepository();

                ModelLogin modelLogin = new ModelLogin();
                modelLogin.setLogin(login);
                modelLogin.setSenha(senha);

                if (daoLoginRepository.validarAutenticacao(modelLogin)) {
                    request.getSession().setAttribute("usuario", modelLogin.getLogin());

                    // ✅ Cria o DAOContas aqui
                    DAOContas daoContas = new DAOContas();
                    List<ModelContas> contasVencendo = daoContas.buscarContasVencendoEm7Dias();
                    request.setAttribute("contasVencendo", contasVencendo);

                    if (url == null || url.equals("null")) {
                        url = "/principal/principal.jsp";
                    }

                    RequestDispatcher redirecionar = request.getRequestDispatcher(url);
                    redirecionar.forward(request, response);
                } else {
                    RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
                    request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                    redirecionar.forward(request, response);
                }
            } else {
                RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
                request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                redirecionar.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }
}