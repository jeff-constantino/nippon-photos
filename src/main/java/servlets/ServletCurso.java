package servlets;

import com.google.gson.Gson;
import dao.CursoDAO;
import model.Curso;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/ServletCurso")
public class ServletCurso extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            CursoDAO dao = new CursoDAO();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            Gson gson = new Gson();
            
            if ("buscar".equals(acao)) {
                Long id = Long.parseLong(request.getParameter("id"));
                Curso curso = dao.buscarPorId(id);
                response.getWriter().write(gson.toJson(curso));
            } else {
                // Listar todos
                List<Curso> cursos = dao.listar();
                response.getWriter().write(gson.toJson(cursos));
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
            CursoDAO dao = new CursoDAO();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if ("inserir".equals(acao)) {
                Curso curso = new Curso();
                curso.setNomeCurso(request.getParameter("nomeCurso"));
                curso.setInstituicao(request.getParameter("instituicao"));
                curso.setAnoConclusao(Integer.parseInt(request.getParameter("anoConclusao")));
                
                String cargaHorariaStr = request.getParameter("cargaHoraria");
                if (cargaHorariaStr != null && !cargaHorariaStr.isEmpty()) {
                    curso.setCargaHoraria(Integer.parseInt(cargaHorariaStr));
                }
                
                curso.setDescricao(request.getParameter("descricao"));
                curso.setCertificadoUrl(request.getParameter("certificadoUrl"));
                
                String ordemStr = request.getParameter("ordem");
                curso.setOrdem(ordemStr != null ? Integer.parseInt(ordemStr) : 0);
                
                curso.setAtivo(true);
                
                dao.inserir(curso);
                response.getWriter().write("{\"success\": true, \"message\": \"Curso cadastrado com sucesso!\"}");
                
            } else if ("atualizar".equals(acao)) {
                Curso curso = new Curso();
                curso.setId(Long.parseLong(request.getParameter("id")));
                curso.setNomeCurso(request.getParameter("nomeCurso"));
                curso.setInstituicao(request.getParameter("instituicao"));
                curso.setAnoConclusao(Integer.parseInt(request.getParameter("anoConclusao")));
                
                String cargaHorariaStr = request.getParameter("cargaHoraria");
                if (cargaHorariaStr != null && !cargaHorariaStr.isEmpty()) {
                    curso.setCargaHoraria(Integer.parseInt(cargaHorariaStr));
                }
                
                curso.setDescricao(request.getParameter("descricao"));
                curso.setCertificadoUrl(request.getParameter("certificadoUrl"));
                
                String ordemStr = request.getParameter("ordem");
                curso.setOrdem(ordemStr != null ? Integer.parseInt(ordemStr) : 0);
                
                String ativoStr = request.getParameter("ativo");
                curso.setAtivo(ativoStr != null ? Boolean.parseBoolean(ativoStr) : true);
                
                dao.atualizar(curso);
                response.getWriter().write("{\"success\": true, \"message\": \"Curso atualizado com sucesso!\"}");
                
            } else if ("deletar".equals(acao)) {
                Long id = Long.parseLong(request.getParameter("id"));
                dao.deletar(id);
                response.getWriter().write("{\"success\": true, \"message\": \"Curso deletado com sucesso!\"}");
                
            } else if ("desativar".equals(acao)) {
                Long id = Long.parseLong(request.getParameter("id"));
                dao.desativar(id);
                response.getWriter().write("{\"success\": true, \"message\": \"Curso desativado com sucesso!\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
