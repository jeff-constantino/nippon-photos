package servlets;

import com.google.gson.Gson;
import dao.PerfilDevDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PerfilDev;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/ServletPerfil")
public class ServletPerfil extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");

        try {
            PerfilDevDAO dao = new PerfilDevDAO(conn);
            PerfilDev perfil = dao.getPerfil();

            if (perfil != null) {
                System.out.println("Perfil encontrado:");
                System.out.println("ID: " + perfil.getId());
                System.out.println("Nome: " + perfil.getNome());
                System.out.println("Email: " + perfil.getEmail());
            } else {
                System.out.println("NENHUM PERFIL ENCONTRADO NO BANCO!");
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();
            response.getWriter().write(gson.toJson(perfil));

        } catch (Exception e) {
            System.out.println("ERRO NO GET: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");

        request.setCharacterEncoding("UTF-8");

        try {
            PerfilDevDAO dao = new PerfilDevDAO(conn);

            PerfilDev perfil = dao.getPerfil();

            if (perfil == null) {
                perfil = new PerfilDev();
                perfil.setId(1L);
                perfil.setNome("Nome Padrão");
                perfil.setTitulo("Título Padrão");
                perfil.setEmail("email@exemplo.com");
            } else {
                System.out.println("Perfil existente - ID: " + perfil.getId());
            }

            String nome = request.getParameter("nome");
            if (nome != null && !nome.trim().isEmpty()) {
                perfil.setNome(nome);
            }

            String titulo = request.getParameter("titulo");
            if (titulo != null && !titulo.trim().isEmpty()) {
                perfil.setTitulo(titulo);
            }

            String descricao = request.getParameter("descricao");
            if (descricao != null && !descricao.trim().isEmpty()) {
                perfil.setDescricao(descricao);
            }

            String fotoUrl = request.getParameter("fotoUrl");
            if (fotoUrl != null && !fotoUrl.trim().isEmpty()) {
                System.out.println("Atualizando fotoUrl: " + fotoUrl);
                perfil.setFotoUrl(fotoUrl);
            }

            String email = request.getParameter("email");
            if (email != null && !email.trim().isEmpty()) {
                System.out.println("Atualizando email: " + email);
                perfil.setEmail(email);
            }

            String telefone = request.getParameter("telefone");
            if (telefone != null && !telefone.trim().isEmpty()) {
                System.out.println("Atualizando telefone: " + telefone);
                perfil.setTelefone(telefone);
            }

            String linkedin = request.getParameter("linkedin");
            if (linkedin != null && !linkedin.trim().isEmpty()) {
                System.out.println("Atualizando linkedin: " + linkedin);
                perfil.setLinkedin(linkedin);
            }

            String github = request.getParameter("github");
            if (github != null && !github.trim().isEmpty()) {
                System.out.println("Atualizando github: " + github);
                perfil.setGithub(github);
            }

            String escolaridade = request.getParameter("escolaridade");
            if (escolaridade != null && !escolaridade.trim().isEmpty()) {
                System.out.println("Atualizando escolaridade");
                perfil.setEscolaridade(escolaridade);
            }

            System.out.println("Chamando dao.updatePerfil...");
            dao.updatePerfil(perfil);
            System.out.println("UpdatePerfil executado com sucesso!");

            PerfilDev perfilDepois = dao.getPerfil();
            System.out.println("Perfil após salvar:");
            System.out.println("Nome: " + perfilDepois.getNome());
            System.out.println("Email: " + perfilDepois.getEmail());
            System.out.println("FotoUrl: " + perfilDepois.getFotoUrl());

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Perfil atualizado com sucesso!\"}");

        } catch (Exception e) {
            System.out.println("ERRO NO POST: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}