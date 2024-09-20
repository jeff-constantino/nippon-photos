package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.DAOLoginRepository;
import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

import java.io.IOException;
import java.util.List;


@WebServlet(urlPatterns = {"/ServletUsuarioController"})
public class ServletUsuarioController extends ServletGenericUtil{

    private static final long serialVersionUID = 1L;
    private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

    public ServletUsuarioController() {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

      try {
          String acao = request.getParameter("acao");

          if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
              String idUser = request.getParameter("id");
              daoUsuarioRepository.deletarUser(idUser);

              List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
              request.setAttribute("modelLogins", modelLogins);

              request.setAttribute("msg", "Funcionário Apagado com sucesso");

              request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);

          }
 /*AJAX DELETAR*/
          else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarajax")) {
                  String idUser = request.getParameter("id");
                  daoUsuarioRepository.deletarUser(idUser);

                  response.getWriter().write("Funcionário Excluído!!!");


          }else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscaruserajax")) {
              String nomeBusca = request.getParameter("nomeBusca");
              List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca, super.getUserLogado(request));

              ObjectMapper mapper = new ObjectMapper();
              String json = mapper.writeValueAsString(dadosJsonUser);

             response.getWriter().write(json);


          }else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) {
           String id = request.getParameter("id");
           ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(id, super.getUserLogado(request));

              List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
              request.setAttribute("modelLogins", modelLogins);

              request.setAttribute("msg", "EDITAR O FUNCIONÁRIO");
              request.setAttribute("modelLogin", modelLogin);//para manter os dados na tela

              request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);


          } else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) {
                List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));

              request.setAttribute("modelLogins", modelLogins);//para manter os dados na tela

              request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);




          }

          else {
              List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
              request.setAttribute("modelLogins", modelLogins);

              request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);
          }

      }catch (Exception e) {
          e.printStackTrace();
          RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");/*redireciona*/
          request.setAttribute("msg", e.getMessage());
          redirecionar.forward(request, response);
      }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String msg = "Operação realizada com sucesso!";
            String id = request.getParameter("id");
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String status = request.getParameter("status");

            ModelLogin modelLogin = new ModelLogin();

 //condição ternaria.. valida..? se sim : se não
            modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
            modelLogin.setNome(nome);
            modelLogin.setStatus(status);

            if (daoUsuarioRepository.validarLogin(modelLogin.getNome())&& modelLogin.getId() == null) //"Para criar um novo usuario com o mesmo nome"
            {
                msg = "Funcionário com o mesmo nome já Cadastrado";

            } else {
                if (modelLogin.isNovo()) {
                    msg = "Funcionário Cadastrado com sucesso!";

                } else {
                    msg = "Funcionário Atualizado com sucesso!";
                }

                modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin, super.getUserLogado(request));

            }

            List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
            request.setAttribute("modelLogins", modelLogins);

            request.setAttribute("msg", msg);
            request.setAttribute("modelLogin", modelLogin);//para manter os dados na tela

            RequestDispatcher redireciona = request.getRequestDispatcher("/principal/usuario.jsp");
            redireciona.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");/*redireciona*/
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }


/*AJAX CADASTRAR*/
        String acao = request.getParameter("acao");
        if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("cadastrar")) {

            try {
                String msg = "Operação realizada com sucesso!";
                String id = request.getParameter("id");
                String nome = request.getParameter("nome");
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String status = request.getParameter("status");

                ModelLogin modelLogin = new ModelLogin();

                //condição ternaria.. valida..? se sim : se não
                modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
                modelLogin.setNome(nome);

                if (daoUsuarioRepository.validarLogin(modelLogin.getNome())) //&& modelLogin.getId() == null) "Para criar um novo usuario com o mesmo nome"
                {
                    msg = "Funcionário com o mesmo nome já Cadastrado";

                } else {
                    if (modelLogin.isNovo()) {
                        msg = "Funcionário Cadastrado com sucesso!";

                    } else {
                        msg = "Funcionário Atualizado com sucesso!";
                    }

                    modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin, super.getUserLogado(request));

                }

                List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
                request.setAttribute("modelLogins", modelLogins);


                request.setAttribute("msg", msg);
                request.setAttribute("modelLogin", modelLogin);//para manter os dados na tela

                RequestDispatcher redireciona = request.getRequestDispatcher("/principal/usuario.jsp");
                redireciona.forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");/*redireciona*/
                request.setAttribute("msg", e.getMessage());
                redirecionar.forward(request, response);
            }


        }
    }

}
