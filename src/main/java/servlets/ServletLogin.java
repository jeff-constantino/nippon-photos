package servlets;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServletLogin", value = "/ServletLogin")
public class ServletLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ServletLogin() {

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        String url = request.getParameter("url");




        if (login != null && !login.trim().isEmpty() && senha != null && !senha.trim().isEmpty()) {

            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setLogin(login);
            modelLogin.setSenha(senha);

            if(modelLogin.getLogin().equalsIgnoreCase("admin") && modelLogin.getSenha().equalsIgnoreCase("admin")){

                request.getSession().setAttribute("usuario", modelLogin.getLogin()); /*adciona a sessão ao usuario*/


                if (url == null || url.equals("null")) {
                    url = "/principal/principal.jsp";
                }

                RequestDispatcher redirecionar = request.getRequestDispatcher("/principal/principal.jsp");/*redireciona*/
                redirecionar.forward(request, response);

            }else {
                RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");/*redireciona*/
                request.setAttribute("msg", "Informe o Login e Senha corretamente!");
                redirecionar.forward(request, response);
            }

        } else {

            RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");/*redireciona*/
            request.setAttribute("msg", "Informe o Login e Senha corretamente!");
            redirecionar.forward(request, response);
        }




    }
}
