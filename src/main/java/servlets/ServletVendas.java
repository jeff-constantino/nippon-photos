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


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String venda_id = request.getParameter("venda_id");
            String nome = request.getParameter("nome");
            String vendedor_id_str = request.getParameter("vendedor_id"); // O id do vendedor pai (de model_login)

            // Criar um objeto ModelVendas
            ModelVendas modelVendas = new ModelVendas();
            modelVendas.setVenda_id(venda_id != null && !venda_id.isEmpty() ? Long.parseLong(venda_id) : null);

            // Verifica se o vendedor_id_str não é nulo ou vazio e converte para Long, se válido
            Long vendedor_id = vendedor_id_str != null && !vendedor_id_str.isEmpty() ? Long.parseLong(vendedor_id_str) : null;
            modelVendas.setVendedor_id(vendedor_id);  // Atribuindo o id correto (chave estrangeira vendedor_id)
            modelVendas.setNome(nome);

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
