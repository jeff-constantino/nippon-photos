package servlets;

import com.google.gson.Gson;
import dao.ProjetoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Projeto;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletProjeto")
public class ServletProjeto extends HttpServlet {
    // ✅ REMOVIDO: private ProjetoDAO dao = new ProjetoDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        ProjetoDAO dao = new ProjetoDAO(conn);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");

        try {
            if ("buscar".equals(acao)) {
                String idParam = request.getParameter("id");

                if (idParam == null || idParam.trim().isEmpty() || "undefined".equals(idParam)) {
                    enviarErro(response, "ID do projeto não fornecido");
                    return;
                }

                try {
                    Long id = Long.parseLong(idParam);
                    Projeto projeto = dao.buscarPorId(id);

                    if (projeto != null) {
                        String json = gson.toJson(projeto);
                        response.getWriter().write(json);
                    } else {
                        System.out.println("❌ Projeto não encontrado no banco");
                        enviarErro(response, "Projeto não encontrado");
                    }
                } catch (NumberFormatException e) {
                    System.out.println("❌ Erro ao parsear ID: " + e.getMessage());
                    enviarErro(response, "ID inválido: " + idParam);
                }

            } else {
                List<Projeto> projetos = dao.listar();
                String json = gson.toJson(projetos);
                response.getWriter().write(json);
            }

        } catch (Exception e) {
            System.err.println("❌ ERRO NO SERVLET:");
            e.printStackTrace();
            enviarErro(response, "Erro ao buscar projetos: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        ProjetoDAO dao = new ProjetoDAO(conn);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");

        try {
            if ("inserir".equals(acao)) {
                inserirProjeto(request, response, dao);
            } else if ("atualizar".equals(acao)) {
                atualizarProjeto(request, response, dao);
            } else if ("deletar".equals(acao)) {
                deletarProjeto(request, response, dao);
            } else {
                enviarErro(response, "Ação inválida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            enviarErro(response, "Erro: " + e.getMessage());
        }
    }

    private void inserirProjeto(HttpServletRequest request, HttpServletResponse response, ProjetoDAO dao) throws Exception {
        Projeto projeto = new Projeto();
        projeto.setNome(request.getParameter("nome"));
        projeto.setDescricao_curta(request.getParameter("descricao_curta"));
        projeto.setDescricao_completa(request.getParameter("descricao_completa"));
        projeto.setTecnologias(request.getParameter("tecnologias"));
        projeto.setIcone(request.getParameter("icone"));
        projeto.setUrl_acesso(request.getParameter("url_acesso"));
        projeto.setStatus(request.getParameter("status"));
        projeto.setFuncionalidades(request.getParameter("funcionalidades"));

        String ordemParam = request.getParameter("ordem");
        if (ordemParam != null && !ordemParam.isEmpty()) {
            projeto.setOrdem(Integer.parseInt(ordemParam));
        } else {
            projeto.setOrdem(0);
        }

        projeto.setAtivo(true);

        dao.inserir(projeto);

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", "Projeto criado com sucesso!");

        response.getWriter().write(gson.toJson(resultado));
    }

    private void atualizarProjeto(HttpServletRequest request, HttpServletResponse response, ProjetoDAO dao) throws Exception {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            enviarErro(response, "ID não fornecido");
            return;
        }

        Long id = Long.parseLong(idParam);

        Projeto projeto = new Projeto();
        projeto.setId(id);
        projeto.setNome(request.getParameter("nome"));
        projeto.setDescricao_curta(request.getParameter("descricao_curta"));
        projeto.setDescricao_completa(request.getParameter("descricao_completa"));
        projeto.setTecnologias(request.getParameter("tecnologias"));
        projeto.setIcone(request.getParameter("icone"));
        projeto.setUrl_acesso(request.getParameter("url_acesso"));
        projeto.setStatus(request.getParameter("status"));
        projeto.setFuncionalidades(request.getParameter("funcionalidades"));

        String ordemParam = request.getParameter("ordem");
        if (ordemParam != null && !ordemParam.isEmpty()) {
            projeto.setOrdem(Integer.parseInt(ordemParam));
        } else {
            projeto.setOrdem(0);
        }

        projeto.setAtivo(true);

        dao.atualizar(projeto);
        System.out.println("✅ Projeto atualizado com sucesso!");

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", "Projeto atualizado com sucesso!");

        response.getWriter().write(gson.toJson(resultado));
    }

    private void deletarProjeto(HttpServletRequest request, HttpServletResponse response, ProjetoDAO dao) throws Exception {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            enviarErro(response, "ID não fornecido");
            return;
        }

        Long id = Long.parseLong(idParam);
        System.out.println("Deletando projeto ID: " + id);

        dao.deletar(id);
        System.out.println("✅ Projeto deletado!");

        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", "Projeto deletado com sucesso!");

        response.getWriter().write(gson.toJson(resultado));
    }

    private void enviarErro(HttpServletResponse response, String mensagem) throws IOException {
        Map<String, Object> erro = new HashMap<>();
        erro.put("success", false);
        erro.put("error", mensagem);
        response.getWriter().write(gson.toJson(erro));
    }
}