package servlets;

import com.google.gson.Gson;
import dao.ProjetoDAO;
import model.Projeto;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/ServletProjeto")
public class ServletProjeto extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            ProjetoDAO dao = new ProjetoDAO();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            Gson gson = new Gson();
            
            if ("buscar".equals(acao)) {
                Long id = Long.parseLong(request.getParameter("id"));
                Projeto projeto = dao.buscarPorId(id);
                response.getWriter().write(gson.toJson(projeto));
            } else {
                // Listar todos
                List<Projeto> projetos = dao.listar();
                response.getWriter().write(gson.toJson(projetos));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        
        try {
            ProjetoDAO dao = new ProjetoDAO();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if ("inserir".equals(acao)) {
                Projeto projeto = new Projeto();
                projeto.setNome(request.getParameter("nome"));
                projeto.setDescricaoCurta(request.getParameter("descricaoCurta"));
                projeto.setDescricaoCompleta(request.getParameter("descricaoCompleta"));
                projeto.setIcone(request.getParameter("icone"));
                projeto.setTecnologias(request.getParameter("tecnologias"));
                projeto.setUrlAcesso(request.getParameter("urlAcesso"));
                projeto.setUrlGithub(request.getParameter("urlGithub"));
                projeto.setImagemUrl(request.getParameter("imagemUrl"));
                
                String ordemStr = request.getParameter("ordem");
                projeto.setOrdem(ordemStr != null ? Integer.parseInt(ordemStr) : 0);
                
                projeto.setAtivo(true);
                
                String destaqueStr = request.getParameter("destaque");
                projeto.setDestaque(destaqueStr != null ? Boolean.parseBoolean(destaqueStr) : false);
                
                // Funcionalidades (vem como string separada por linhas)
                String funcionalidadesStr = request.getParameter("funcionalidades");
                if (funcionalidadesStr != null && !funcionalidadesStr.trim().isEmpty()) {
                    List<String> funcionalidades = Arrays.asList(funcionalidadesStr.split("\n"));
                    projeto.setFuncionalidades(funcionalidades);
                }
                
                dao.inserir(projeto);
                response.getWriter().write("{\"success\": true, \"message\": \"Projeto cadastrado com sucesso!\"}");
                
            } else if ("atualizar".equals(acao)) {
                Projeto projeto = new Projeto();
                projeto.setId(Long.parseLong(request.getParameter("id")));
                projeto.setNome(request.getParameter("nome"));
                projeto.setDescricaoCurta(request.getParameter("descricaoCurta"));
                projeto.setDescricaoCompleta(request.getParameter("descricaoCompleta"));
                projeto.setIcone(request.getParameter("icone"));
                projeto.setTecnologias(request.getParameter("tecnologias"));
                projeto.setUrlAcesso(request.getParameter("urlAcesso"));
                projeto.setUrlGithub(request.getParameter("urlGithub"));
                projeto.setImagemUrl(request.getParameter("imagemUrl"));
                
                String ordemStr = request.getParameter("ordem");
                projeto.setOrdem(ordemStr != null ? Integer.parseInt(ordemStr) : 0);
                
                String ativoStr = request.getParameter("ativo");
                projeto.setAtivo(ativoStr != null ? Boolean.parseBoolean(ativoStr) : true);
                
                String destaqueStr = request.getParameter("destaque");
                projeto.setDestaque(destaqueStr != null ? Boolean.parseBoolean(destaqueStr) : false);
                
                // Funcionalidades
                String funcionalidadesStr = request.getParameter("funcionalidades");
                if (funcionalidadesStr != null && !funcionalidadesStr.trim().isEmpty()) {
                    List<String> funcionalidades = Arrays.asList(funcionalidadesStr.split("\n"));
                    projeto.setFuncionalidades(funcionalidades);
                }
                
                dao.atualizar(projeto);
                response.getWriter().write("{\"success\": true, \"message\": \"Projeto atualizado com sucesso!\"}");
                
            } else if ("deletar".equals(acao)) {
                Long id = Long.parseLong(request.getParameter("id"));
                dao.deletar(id);
                response.getWriter().write("{\"success\": true, \"message\": \"Projeto deletado com sucesso!\"}");
                
            } else if ("desativar".equals(acao)) {
                Long id = Long.parseLong(request.getParameter("id"));
                dao.desativar(id);
                response.getWriter().write("{\"success\": true, \"message\": \"Projeto desativado com sucesso!\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
