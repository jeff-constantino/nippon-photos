package servlets;

import com.google.gson.Gson;
import dao.CursoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Curso;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletCurso")
public class ServletCurso extends HttpServlet {
    // ✅ REMOVIDO: private CursoDAO dao = new CursoDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        CursoDAO dao = new CursoDAO(conn);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");

        try {
            if ("buscar".equals(acao)) {
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty() || "undefined".equals(idParam)) {
                    enviarErro(response, "ID do curso não fornecido");
                    return;
                }

                try {
                    Long id = Long.parseLong(idParam);
                    Curso curso = dao.buscarPorId(id);
                    if (curso != null) {
                        String json = gson.toJson(curso);
                        response.getWriter().write(json);
                    } else {
                        enviarErro(response, "Curso não encontrado");
                    }
                } catch (NumberFormatException e) {
                    System.out.println("❌ Erro ao parsear ID: " + e.getMessage());
                    enviarErro(response, "ID inválido: " + idParam);
                }
            } else {
                List<Curso> cursos = dao.listar();
                String json = gson.toJson(cursos);
                response.getWriter().write(json);
            }
        } catch (Exception e) {
            System.err.println("❌ ERRO NO SERVLET:");
            e.printStackTrace();
            enviarErro(response, "Erro ao buscar cursos: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        CursoDAO dao = new CursoDAO(conn);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");

        try {
            if ("inserir".equals(acao)) {
                inserirCurso(request, response, dao);
            } else if ("atualizar".equals(acao)) {
                atualizarCurso(request, response, dao);
            } else if ("deletar".equals(acao)) {
                deletarCurso(request, response, dao);
            } else {
                enviarErro(response, "Ação inválida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            enviarErro(response, "Erro: " + e.getMessage());
        }
    }

    private void inserirCurso(HttpServletRequest request, HttpServletResponse response, CursoDAO dao) throws Exception {
        Curso curso = new Curso();
        curso.setNomeCurso(request.getParameter("nomeCurso"));
        curso.setInstituicao(request.getParameter("instituicao"));
        curso.setDescricao(request.getParameter("descricao"));
        curso.setCertificadoUrl(request.getParameter("certificadoUrl"));

        String anoParam = request.getParameter("anoConclusao");
        if (anoParam != null && !anoParam.isEmpty()) {
            try {
                curso.setAnoConclusao(Integer.parseInt(anoParam));
            } catch (NumberFormatException e) {
                curso.setAnoConclusao(0);
            }
        } else {
            curso.setAnoConclusao(0);
        }

        String cargaParam = request.getParameter("cargaHoraria");
        if (cargaParam != null && !cargaParam.isEmpty()) {
            try {
                curso.setCargaHoraria(Integer.parseInt(cargaParam));
            } catch (NumberFormatException e) {
                curso.setCargaHoraria(0);
            }
        } else {
            curso.setCargaHoraria(0);
        }

        String ordemParam = request.getParameter("ordem");
        if (ordemParam != null && !ordemParam.isEmpty()) {
            try {
                curso.setOrdem(Integer.parseInt(ordemParam));
            } catch (NumberFormatException e) {
                curso.setOrdem(0);
            }
        } else {
            curso.setOrdem(0);
        }

        curso.setAtivo(true);
        dao.inserir(curso);

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", "Curso criado com sucesso!");
        response.getWriter().write(gson.toJson(resultado));
    }

    private void atualizarCurso(HttpServletRequest request, HttpServletResponse response, CursoDAO dao) throws Exception {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            enviarErro(response, "ID não fornecido");
            return;
        }

        Long id = Long.parseLong(idParam);
        Curso curso = new Curso();
        curso.setId(id);
        curso.setNomeCurso(request.getParameter("nomeCurso"));
        curso.setInstituicao(request.getParameter("instituicao"));
        curso.setDescricao(request.getParameter("descricao"));
        curso.setCertificadoUrl(request.getParameter("certificadoUrl"));

        String anoParam = request.getParameter("anoConclusao");
        if (anoParam != null && !anoParam.isEmpty()) {
            try {
                curso.setAnoConclusao(Integer.parseInt(anoParam));
            } catch (NumberFormatException e) {
                curso.setAnoConclusao(0);
            }
        } else {
            curso.setAnoConclusao(0);
        }

        String cargaParam = request.getParameter("cargaHoraria");
        if (cargaParam != null && !cargaParam.isEmpty()) {
            try {
                curso.setCargaHoraria(Integer.parseInt(cargaParam));
            } catch (NumberFormatException e) {
                curso.setCargaHoraria(0);
            }
        } else {
            curso.setCargaHoraria(0);
        }

        String ordemParam = request.getParameter("ordem");
        if (ordemParam != null && !ordemParam.isEmpty()) {
            try {
                curso.setOrdem(Integer.parseInt(ordemParam));
            } catch (NumberFormatException e) {
                curso.setOrdem(0);
            }
        } else {
            curso.setOrdem(0);
        }

        curso.setAtivo(true);
        dao.atualizar(curso);

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", "Curso atualizado com sucesso!");
        response.getWriter().write(gson.toJson(resultado));
    }

    private void deletarCurso(HttpServletRequest request, HttpServletResponse response, CursoDAO dao) throws Exception {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            enviarErro(response, "ID não fornecido");
            return;
        }

        Long id = Long.parseLong(idParam);
        dao.deletar(id);

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", "Curso deletado com sucesso!");
        response.getWriter().write(gson.toJson(resultado));
    }

    private void enviarErro(HttpServletResponse response, String mensagem) throws IOException {
        Map<String, Object> erro = new HashMap<>();
        erro.put("success", false);
        erro.put("error", mensagem);
        response.getWriter().write(gson.toJson(erro));
    }
}