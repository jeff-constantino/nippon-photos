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
                } else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscaruserajax")) {
                    String nomeBusca = request.getParameter("nomeBusca");
                    List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca, super.getUserLogado(request));

                    ObjectMapper mapper = new ObjectMapper();
                    String json = mapper.writeValueAsString(dadosJsonUser);
                    response.getWriter().write(json);


                }

                // Ação de deletar via Ajax
                else if (acao.equals("deletarajax")) {
                    String venda_id = request.getParameter("venda_id");
                    if (venda_id != null && !venda_id.isEmpty()) {
                        daoVendas.deleteVenda(Long.parseLong(venda_id));
                        response.getWriter().write("Venda Excluída!");
                    }
                }

                // Ação de buscar para editar
                else if (acao.equalsIgnoreCase("buscarEditar")) {
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
                        request.setAttribute("modelVendas", modelVendas); // Para manter os dados na tela
                        request.setAttribute("totalPagina", daoVendas.totalPagina(this.getUserLogado(request)));

                        request.getRequestDispatcher("/principal/vendas.jsp").forward(request, response);
                    } else {
                        // Caso o ID seja inválido ou nulo
                        request.setAttribute("msg", "ID de venda inválido.");
                        request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                    }
                }

            } else if (acao.equalsIgnoreCase("buscarFunc")) {
                String idFuncStr = request.getParameter("id");
                String nome = request.getParameter("nome");
                Long idFunc = null;

                // Verifica e tenta converter venda_id para Long
                if (idFuncStr != null && !idFuncStr.isEmpty()) {
                    try {
                        idFunc = Long.parseLong(idFuncStr);
                    } catch (NumberFormatException e) {
                        throw new ServletException("ID de venda inválido: " + idFuncStr);
                    }
                }

                // Se o idVenda não for nulo, prossegue com a busca para edição
                if (idFunc != null) {
                    ModelVendas modelVendas = daoVendas.consultaVenda(idFunc, super.getUserLogado(request));
                    List<ModelVendas> modelVendasList = daoVendas.listaVendas(super.getUserLogado(request));

                    // Define os atributos e redireciona para a página de edição
                    request.setAttribute("modelVendas", modelVendas);
                    request.setAttribute("msg", "Cadastrar Venda");
                    request.setAttribute("nome", nome);
                    request.setAttribute("modelVendas", modelVendas); // Para manter os dados na tela
                    request.setAttribute("totalPagina", daoVendas.totalPagina(this.getUserLogado(request)));

                    request.getRequestDispatcher("/principal/vendas.jsp").forward(request, response);
                } else {
                    // Caso o ID seja inválido ou nulo
                    request.setAttribute("msg", "ID de Funcionário inválido.");
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                }
            }
            {
                // Ação ou ID de venda não especificados
                request.setAttribute("msg", "Ação ou ID de venda não especificados.");
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
