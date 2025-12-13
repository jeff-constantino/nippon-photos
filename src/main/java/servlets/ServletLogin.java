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
    private final DAOLoginRepository daoLoginRepository = new DAOLoginRepository();
    private final DAOContas daoContas = new DAOContas(); // Instância do DAOContas

    public ServletLogin() {

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        // Se a ação for logout, invalida a sessão e redireciona para a página de login
        if (acao != null && acao.equals("logout")) {
            request.getSession().invalidate(); // Invalida a sessão
            response.sendRedirect(request.getContextPath() + "/crediario.jsp"); // Redireciona para a página de login
            return;
        }

        // Verifica se o usuário já está logado
        if (request.getSession().getAttribute("usuario") != null) {
            // Redireciona para a página principal se já estiver logado
            response.sendRedirect(request.getContextPath() + "/principal/principal.jsp");
            return;
        }

        // Se nenhuma ação foi especificada, chama doPost para processar o login
        doPost(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        String url = request.getParameter("url");

        try {
            if (login != null && !login.trim().isEmpty() && senha != null && !senha.trim().isEmpty()) {
                ModelLogin modelLogin = new ModelLogin();
                modelLogin.setLogin(login);
                modelLogin.setSenha(senha);

                if (daoLoginRepository.validarAutenticacao(modelLogin)) {
                    request.getSession().setAttribute("usuario", modelLogin.getLogin()); /* Adiciona a sessão ao usuário */

                    // Buscar contas vencendo em 7 dias
                    List<ModelContas> contasVencendo = daoContas.buscarContasVencendoEm7Dias();
                    request.setAttribute("contasVencendo", contasVencendo);

                    if (url == null || url.equals("null")) {
                        url = "/principal/principal.jsp";
                    }

                    RequestDispatcher redirecionar = request.getRequestDispatcher(url); /* Redireciona */
                    redirecionar.forward(request, response);
                } else {
                    RequestDispatcher redirecionar = request.getRequestDispatcher("/crediario.jsp"); /* Redireciona */
                    request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                    redirecionar.forward(request, response);
                }
            } else {
                RequestDispatcher redirecionar = request.getRequestDispatcher("crediario.jsp"); /* Redireciona */
                request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                redirecionar.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp"); /* Redireciona */
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }
}

