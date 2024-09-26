package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.DAOUsuarioRepository;
import dao.DAOVendasRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelVendas;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ServletVendas")
public class ServletVendas extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOVendasRepository daoVendas = new DAOVendasRepository();
    private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");

            if (acao != null && !acao.isEmpty()) {

                // Ação de deletar
                if (acao.equals("deletar")) {
                    String venda_id = request.getParameter("venda_id");
                    if (venda_id != null && !venda_id.isEmpty()) {
                        daoVendas.deleteVenda(Long.parseLong(venda_id));
                        request.setAttribute("msg", "Venda Excluída!");
                        request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                    }
                }
                // Ação de buscar usuários via AJAX
                else if (acao.equalsIgnoreCase("buscaruserajax")) {
                    String nome = request.getParameter("nome");
                    System.out.println("Buscando funcionários com o nome: " + nome);

                    List<ModelLogin> dadosJsonUser = new ArrayList<>();
                    try {
                        dadosJsonUser = daoVendas.consultaFuncionarioList(nome);
                        System.out.println("Número de resultados encontrados: " + dadosJsonUser.size());
                    } catch (Exception e) {
                        System.err.println("Erro na busca: " + e.getMessage());
                        // Responde com erro em formato JSON
                        response.setContentType("application/json");
                        response.getWriter().write("{\"error\":\"Erro ao buscar funcionários: " + e.getMessage() + "\"}");
                        return;
                    }

                    // Convertendo a lista para JSON
                    ObjectMapper mapper = new ObjectMapper();
                    String json = mapper.writeValueAsString(dadosJsonUser);

                    // Enviando a resposta JSON
                    response.setContentType("application/json"); // Define o tipo de conteúdo
                    response.getWriter().write(json);
                }

                // Ação de buscar para editar
                else if (acao.equalsIgnoreCase("buscarEditar")) {
                    String id = request.getParameter("id");
                    ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(id, super.getUserLogado(request));

                    List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
                    request.setAttribute("modelLogins", modelLogins);

                    request.setAttribute("msg", "EDITAR O FUNCIONÁRIO");
                    request.setAttribute("modelLogin", modelLogin); // para manter os dados na tela
                    request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
                    request.getRequestDispatcher("/principal/vendas.jsp").forward(request, response);
                }
                // Ação de deletar via Ajax
                else if (acao.equals("deletarajax")) {
                    String venda_id = request.getParameter("venda_id");
                    if (venda_id != null && !venda_id.isEmpty()) {
                        daoVendas.deleteVenda(Long.parseLong(venda_id));
                        response.getWriter().write("Venda Excluída!");
                    }
                }
                // Ação de buscar para editar venda
                else if (acao.equalsIgnoreCase("CadVenda")) {
                    String vendaIdStr = request.getParameter("venda_id");
                    Long idVenda = null;

                    // Verifica e tenta converter venda_id para Long
                    if (vendaIdStr != null && !vendaIdStr.isEmpty()) {
                        try {
                            idVenda = Long.parseLong(vendaIdStr);
                        } catch (NumberFormatException e) {
                            throw new ServletException("ID de venda inválido: " + vendaIdStr);
                        }
                    }

                    // Se o idVenda não for nulo, prossegue com a busca para edição
                    if (idVenda != null) {
                        ModelVendas modelVendas = daoVendas.consultaVenda(idVenda, super.getUserLogado(request));
                        List<ModelVendas> modelVendasList = daoVendas.listaVendas(super.getUserLogado(request));

                        // Define os atributos e redireciona para a página de edição
                        request.setAttribute("modelVendas", modelVendas);
                        request.setAttribute("msg", "EDITAR A VENDA");
                        request.setAttribute("totalPagina", daoVendas.totalPagina(this.getUserLogado(request)));

                        request.getRequestDispatcher("/principal/vendas.jsp").forward(request, response);
                    } else {
                        // Caso o ID seja inválido ou nulo
                        request.setAttribute("msg", "ID de venda inválido.");
                        request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                    }
                }
                // Caso a ação não seja reconhecida
                else {
                    request.setAttribute("msg", "Ação não reconhecida.");
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                }

            } else {
                // Ação ou ID de venda não especificados
                request.setAttribute("msg", "Ação não especificada.");
                request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp"); // redireciona
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String msg = "Operação realizada com sucesso!";
            // Obtém os parâmetros do request
            String venda_id = request.getParameter("venda_id");
            String nome = request.getParameter("nome");
            String vendedor_id_str = request.getParameter("vendedor_id");

            String prod1_din_str = request.getParameter("prod1_din");
            String prod1_deb_str = request.getParameter("prod1_deb");
            String prod1_cred_str = request.getParameter("prod1_cred");
            String prod1_pix_str = request.getParameter("prod1_pix");

            String prod2_din_str = request.getParameter("prod2_din");
            String prod2_deb_str = request.getParameter("prod2_deb");
            String prod2_cred_str = request.getParameter("prod2_cred");
            String prod2_pix_str = request.getParameter("prod2_pix");

            String prod3_din_str = request.getParameter("prod3_din");
            String prod3_deb_str = request.getParameter("prod3_deb");
            String prod3_cred_str = request.getParameter("prod3_cred");
            String prod3_pix_str = request.getParameter("prod3_pix");

            String sobras_str = request.getParameter("sobras");

            ModelVendas modelVendas = new ModelVendas();

            modelVendas.setVenda_id(venda_id != null && !venda_id.isEmpty() ? Long.parseLong(venda_id) : null);

            Long vendedor_id = vendedor_id_str != null && !vendedor_id_str.isEmpty() ? Long.parseLong(vendedor_id_str) : null;
            modelVendas.setVendedor_id(vendedor_id);
            modelVendas.setNome(nome);

            // Settar os campos novos de produtos
            modelVendas.setProd1_din(prod1_din_str != null && !prod1_din_str.isEmpty() ? Integer.parseInt(prod1_din_str) : 0);
            modelVendas.setProd1_deb(prod1_deb_str != null && !prod1_deb_str.isEmpty() ? Integer.parseInt(prod1_deb_str) : 0);
            modelVendas.setProd1_cred(prod1_cred_str != null && !prod1_cred_str.isEmpty() ? Integer.parseInt(prod1_cred_str) : 0);
            modelVendas.setProd1_pix(prod1_pix_str != null && !prod1_pix_str.isEmpty() ? Integer.parseInt(prod1_pix_str) : 0);

            modelVendas.setProd2_din(prod2_din_str != null && !prod2_din_str.isEmpty() ? Integer.parseInt(prod2_din_str) : 0);
            modelVendas.setProd2_deb(prod2_deb_str != null && !prod2_deb_str.isEmpty() ? Integer.parseInt(prod2_deb_str) : 0);
            modelVendas.setProd2_cred(prod2_cred_str != null && !prod2_cred_str.isEmpty() ? Integer.parseInt(prod2_cred_str) : 0);
            modelVendas.setProd2_pix(prod2_pix_str != null && !prod2_pix_str.isEmpty() ? Integer.parseInt(prod2_pix_str) : 0);

            modelVendas.setProd3_din(prod3_din_str != null && !prod3_din_str.isEmpty() ? Integer.parseInt(prod3_din_str) : 0);
            modelVendas.setProd3_deb(prod3_deb_str != null && !prod3_deb_str.isEmpty() ? Integer.parseInt(prod3_deb_str) : 0);
            modelVendas.setProd3_cred(prod3_cred_str != null && !prod3_cred_str.isEmpty() ? Integer.parseInt(prod3_cred_str) : 0);
            modelVendas.setProd3_pix(prod3_pix_str != null && !prod3_pix_str.isEmpty() ? Integer.parseInt(prod3_pix_str) : 0);

            modelVendas.setSobras(sobras_str != null && !sobras_str.isEmpty() ? Integer.parseInt(sobras_str) : 0);

            // Obtém o usuário logado
            Long userLogado = super.getUserLogado(request);

            // Chama o método para gravar ou atualizar a venda, passando o ModelVendas e o userLogado
            ModelVendas resultadoVenda = daoVendas.gravarVenda(modelVendas, userLogado);

            String mensagem;
            // Diferencia as mensagens de sucesso entre criar e atualizar
            if (resultadoVenda.getVenda_id() != null) {
                if (venda_id == null || venda_id.isEmpty()) {
                    mensagem = "Venda cadastrada com sucesso. ID: " + resultadoVenda.getVenda_id();
                } else {
                    mensagem = "Venda atualizada com sucesso. ID: " + resultadoVenda.getVenda_id();
                }
            } else {
                mensagem = "Erro ao gravar a venda.";
            }

            // Define a mensagem e o objeto para redirecionar com os dados na tela
            request.setAttribute("msg", mensagem);
            request.setAttribute("modelVendas", resultadoVenda);
            request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp"); // redireciona
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }

    }
}
