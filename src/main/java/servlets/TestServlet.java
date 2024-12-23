package servlets;

import jakarta.servlet.annotation.WebServlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Definir o tipo de conteúdo como HTML
        response.setContentType("text/html");

        // Obter o escritor para enviar a resposta
        PrintWriter out = response.getWriter();

        // Enviar uma resposta simples
        out.println("<html>");
        out.println("<head><title>Teste Servlet</title></head>");
        out.println("<body>");
        out.println("<h2>Servlet de Teste funcionando!</h2>");
        out.println("</body>");
        out.println("</html>");
    }
}
