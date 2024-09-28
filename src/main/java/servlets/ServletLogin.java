package servlets;


import dao.DAOLoginRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

import java.io.IOException;

@WebServlet(name = "ServletLogin", value = "/ServletLogin")
public class ServletLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DAOLoginRepository daoLoginRepository = new DAOLoginRepository();
    public ServletLogin() {

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        if ( acao != null && !acao.isEmpty() && acao.equals("logout") ) {
            request.getSession().invalidate();
            RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
            redirecionar.forward(request, response);
        }else {

            doPost(request, response);
        }
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

                    request.getSession().setAttribute("usuario", modelLogin.getLogin()); /*adciona a sessão ao usuario*/


                    if (url == null || url.equals("null")) {
                        url = "/principal/principal.jsp";
                    }

                    RequestDispatcher redirecionar = request.getRequestDispatcher("/principal/principal.jsp");/*redireciona*/
                    redirecionar.forward(request, response);

                } else {
                    RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");/*redireciona*/
                    request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                    redirecionar.forward(request, response);
                }

            } else {

                RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");/*redireciona*/
                request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                redirecionar.forward(request, response);

            }

        }catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");/*redireciona*/
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }

    }
}