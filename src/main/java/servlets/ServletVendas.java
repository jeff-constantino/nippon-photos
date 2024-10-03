package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import dao.DAOConfig;
import dao.DAOUsuarioRepository;
import dao.DAOVendasRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfig;
import model.ModelLogin;
import model.ModelVendas;
import util.DateUtil;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ServletVendas")
public class ServletVendas extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOVendasRepository daoVendas = new DAOVendasRepository();
    private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

    private DAOConfig daoConfig;

    @Override
    public void init() throws ServletException {
        super.init();
        daoConfig = new DAOConfig(); // Instanciar o DAOConfig aqui
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        try {
            String acao = request.getParameter("acao");
            String idVenda = request.getParameter("venda_id"); // Pega o ID da venda para gerenciar

            // Se a ação não for especificada, chama a ação vendaDoDia automaticamente
            if (acao == null || acao.isEmpty()) {
                acao = "vendaDoDia";
            }
            if ("buscarValoresProdutos".equals(acao)) {
                // Supondo que você tenha uma instância do DAOConfig
                List<ModelConfig> configs = daoConfig.consultarTodasConfigs();

                // Converte a lista de configurações em JSON
                String jsonResponse = new Gson().toJson(configs); // Usando a biblioteca Gson
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
                return;
            }

            if (acao.equals("vendaDoDia")) {
                // Lógica para buscar as vendas do dia
                List<ModelVendas> listaVendasDoDia = daoVendas.vendaDia();
                request.setAttribute("listaVendasDoDia", listaVendasDoDia);
                request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                return;
            }

            // Nova ação: Gerenciar Venda
            if (acao.equals("gerenciarVenda") && idVenda != null && !idVenda.isEmpty()) {
                // Busca a venda específica pelo ID
                ModelVendas modelVendasConsulta = daoVendas.buscarVendaPorId(Long.parseLong(idVenda));

                if (modelVendasConsulta != null) {
                    // Envia os dados da venda para o JSP
                    request.setAttribute("modelVendasConsulta", modelVendasConsulta);
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                    return;
                }
            }

            if (acao != null && !acao.isEmpty()) {
                // Ação para listar vendas do dia
                if (acao.equals("vendaDoDia")) {

                    List<ModelVendas> listaVendasDoDia = daoVendas.vendaDia(); // Chama o método que busca vendas do dia

                    request.setAttribute("listaVendasDoDia", listaVendasDoDia); // Define a lista como atributo
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response); // Redireciona para o JSP
                    return; // Sai do método
                }

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

                    List<ModelLogin> dadosJsonUser = new ArrayList<>();
                    try {
                        dadosJsonUser = daoVendas.consultaFuncionarioList(nome);

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
                    // AÇÃO PARA RELATORIO DE VENDAS
                } else if (acao.equals("imprimirRelatorioVendas")) {
                    String dataInicial = request.getParameter("dataInicial");
                    String dataFinal = request.getParameter("dataFinal");

                    if (dataFinal == null || dataFinal.isEmpty() && dataFinal == null || dataFinal.isEmpty()) {
                        request.setAttribute("listaVendas", daoVendas.consultaVendasRel());
                    } else {
                        request.setAttribute("listaVendas", daoVendas.consultaVendasRel(dataInicial, dataFinal));
                    }

                    request.setAttribute("dataInicial", dataInicial);
                    request.setAttribute("dataFinal", dataFinal);
                    request.getRequestDispatcher("/principal/relvendas.jsp").forward(request, response);
                }
                // Ação de buscar para editar venda
                else if (acao.equalsIgnoreCase("CadVenda")) {
                    String vendaIdStr = request.getParameter("venda_id");
                    idVenda = null;

                    // Verifica e tenta converter venda_id para Long
                    if (vendaIdStr != null && !vendaIdStr.isEmpty()) {
                        try {
                            idVenda = (vendaIdStr);
                        } catch (NumberFormatException e) {
                            throw new ServletException("ID de venda inválido: " + vendaIdStr);
                        }
                    }

                    // Se o idVenda não for nulo, prossegue com a busca para edição
                    if (idVenda != null) {
                        ModelVendas modelVendas = daoVendas.consultaVenda(Long.valueOf(idVenda), super.getUserLogado(request));
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

            // Produtos
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

            // Data da Venda
            String dataVenda = request.getParameter("dataVenda"); // Certifique-se que o nome do parâmetro é correto

            // Sobras
            String sobras_str = request.getParameter("sobras");

            // Ribbon
            String ribbon = request.getParameter("ribbon"); // Obtém o parâmetro 'ribbon'

            // Criação do objeto ModelVendas
            ModelVendas modelVendas = new ModelVendas();

            // Settar os dados da venda
            if (venda_id != null && !venda_id.isEmpty()) {
                modelVendas.setVenda_id(Long.parseLong(venda_id)); // Atualiza se existe
            }

            // Usando o novo método para setar vendedor_id
            String vendedor_id_str = request.getParameter("vendedor_id");
            modelVendas.setVendedor_id(vendedor_id_str); // Define o ID do vendedor no modelo
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

            // Definindo a data da venda
            if (dataVenda != null && !dataVenda.isEmpty()) {
                Date sqlDate = Date.valueOf(dataVenda); // Converte diretamente para java.sql.Date
                modelVendas.setData_venda(sqlDate);
            } else {
                throw new Exception("O parâmetro 'dataVenda' não pode ser nulo ou vazio."); // A mensagem de erro
            }

            // Após recuperar a data da venda
            if (modelVendas.getData_venda() != null) {
                String formattedDataVenda = DateUtil.formatDate(modelVendas.getData_venda());
                request.setAttribute("formattedDataVenda", formattedDataVenda);
            }

            modelVendas.setSobras(sobras_str != null && !sobras_str.isEmpty() ? Integer.parseInt(sobras_str) : 0);

            // Definindo o ribbon
            if (ribbon != null && !ribbon.isEmpty()) {
                modelVendas.setRibbon(ribbon); // Supondo que você tenha um método setRibbon no seu ModelVendas
            }

            // Grava ou atualiza a venda
            if (modelVendas.getVenda_id() != null) {
                modelVendas = daoVendas.atualizarVenda(modelVendas.getVenda_id(), modelVendas, super.getUserLogado(request)); // Atualiza
            } else {
                modelVendas = daoVendas.gravarVenda(modelVendas, super.getUserLogado(request)); // Grava nova venda
            }

            // Consulta a venda
            ModelVendas modelVendasConsulta = daoVendas.consultaVenda(modelVendas.getVenda_id(), super.getUserLogado(request));
            request.setAttribute("modelVendasConsulta", modelVendasConsulta);

            // Mantém os dados na tela e envia a mensagem de sucesso
            request.setAttribute("msg", msg);
            request.setAttribute("modelVenda", modelVendas);
            request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

            // Após recuperar a venda
            ModelVendas modelVendasConsulta1 = daoVendas.consultaVenda(modelVendas.getVenda_id(), super.getUserLogado(request));

            // Formata a data para o formato necessário
            if (modelVendasConsulta1.getData_venda() != null) {
                String formattedDataVenda = DateUtil.formatDate(modelVendasConsulta1.getData_venda());

                request.setAttribute("formattedDataVenda", formattedDataVenda);
            } else {
                System.out.println("Data da venda está nula."); // Mensagem caso a data esteja nula
            }

            // Mantém os dados na tela e envia a mensagem de sucesso
            request.setAttribute("msg", msg);
            request.setAttribute("modelVenda", modelVendas);
            request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

//            // Redireciona para vendas.jsp
//            RequestDispatcher redireciona = request.getRequestDispatcher("/principal/vendas.jsp");
//            redireciona.forward(request, response);

            // Chama o doGet para buscar vendas do dia após a gravação
            request.setAttribute("acao", "vendaDoDia"); // Define a ação para o doGet
            doGet(request, response); // Chama o doGet

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }





}