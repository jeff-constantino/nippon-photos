package servlets;

import com.google.gson.Gson;
import dao.PerfilDevDAO;
import model.PerfilDev;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/ServletPerfil")
public class ServletPerfil extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            PerfilDevDAO dao = new PerfilDevDAO();
            PerfilDev perfil = dao.getPerfil();
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(perfil));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            PerfilDev perfil = new PerfilDev();
            perfil.setId(1L); // ID fixo pois só há um perfil
            perfil.setNome(request.getParameter("nome"));
            perfil.setTitulo(request.getParameter("titulo"));
            perfil.setDescricao(request.getParameter("descricao"));
            perfil.setFotoUrl(request.getParameter("fotoUrl"));
            perfil.setEmail(request.getParameter("email"));
            perfil.setTelefone(request.getParameter("telefone"));
            perfil.setLinkedin(request.getParameter("linkedin"));
            perfil.setGithub(request.getParameter("github"));
            perfil.setEscolaridade(request.getParameter("escolaridade"));
            
            PerfilDevDAO dao = new PerfilDevDAO();
            dao.updatePerfil(perfil);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Perfil atualizado com sucesso!\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
