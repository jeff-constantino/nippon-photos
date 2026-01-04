package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ModelLogin;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;


import java.io.IOException;
import java.util.List;

@MultipartConfig
@WebServlet(urlPatterns = {"/ServletUsuarioController"})
public class ServletUsuarioController extends ServletGenericUtil{

    private static final long serialVersionUID = 1L;
    private final DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

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
                request.setAttribute("totalPagina",daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

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
                request.setAttribute("totalPagina",daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
                request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);


            } else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) {
                List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));

                request.setAttribute("modelLogins", modelLogins);//para manter os dados na tela
                request.setAttribute("totalPagina",daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
                request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);




            }else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) {
                Integer offset = Integer.parseInt(request.getParameter("pagina"));
                List <ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioListPaginada(this.getUserLogado(request),offset);
                request.setAttribute("modelLogins", modelLogins);
                request.setAttribute("totalPagina",daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
                request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);


            }

            else {
                List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
                request.setAttribute("modelLogins", modelLogins);
                request.setAttribute("totalPagina",daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
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
            String comissao = request.getParameter("comissao");
            String rg = request.getParameter("rg");
            String cpf = request.getParameter("cpf");
            String pis = request.getParameter("pis");
            String telefone = request.getParameter("telefone");
            String endereco = request.getParameter("endereco");
            String apelido = request.getParameter("apelido");


            ModelLogin modelLogin = new ModelLogin();
            modelLogin.setComissao(comissao);

            // Condição ternária para ID
            modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
            modelLogin.setNome(nome);
            modelLogin.setStatus(status);
            modelLogin.setComissao(comissao);
            modelLogin.setRg(rg);
            modelLogin.setCpf(cpf);
            modelLogin.setPis(pis);
            modelLogin.setTelefone(telefone);
            modelLogin.setEndereco(endereco);
            modelLogin.setApelido(apelido);


            // 1. Verifique se o conteúdo é multipart (opcional, mas seguro)
            String contentType = request.getContentType();


            if (contentType != null && contentType.startsWith("multipart/form-data")) {

                // 2. Pegue a parte do arquivo diretamente do request (Nativo do Jakarta)
                Part part = request.getPart("filefoto");


                if (part != null && part.getSize() > 0) {
                    // 3. Converta para byte array (usando IOUtils que você já tem)
                    byte[] foto = IOUtils.toByteArray(part.getInputStream());

                    // 4. Use o Base64 do Tomcat que você configurou
                    String imagemBase64 = "data:image/"+part.getContentType().split("\\/")[1]+";base64," + org.apache.tomcat.util.codec.binary.Base64.encodeBase64String(foto);
                    modelLogin.setFotouser(imagemBase64);
                    modelLogin.setExtensaofotouser(part.getContentType().split("\\/")[1]);



                } else {
                    System.out.println("DEBUG SERVLET - Entrou no ELSE (sem foto nova)");
                    // Preserva a foto antiga se não houver upload novo (caso de edição)
                    if (modelLogin.getId() != null) {
                        ModelLogin usuarioAtual = daoUsuarioRepository.consultarUsuarioID(String.valueOf(modelLogin.getId()), super.getUserLogado(request));
                        modelLogin.setFotouser(usuarioAtual.getFotouser());
                        modelLogin.setExtensaofotouser(usuarioAtual.getExtensaofotouser());
                    }
                }
            } else {
                System.out.println("DEBUG SERVLET - NÃO é multipart!");
            }



            if (daoUsuarioRepository.validarLogin(modelLogin.getNome()) && modelLogin.getId() == null)
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
            request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
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
                String rg = request.getParameter("rg");
                String cpf = request.getParameter("cpf");
                String pis = request.getParameter("pis");
                String telefone = request.getParameter("telefone");
                String endereco = request.getParameter("endereco");
                String apelido = request.getParameter("apelido");

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
                request.setAttribute("totalPagina",daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
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