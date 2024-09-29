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
import util.DateUtil;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLOutput;
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

// Debugging para verificar os dados da venda
            System.out.println("Dados da Venda Consultada:");
            System.out.println("Venda ID: " + modelVendasConsulta1.getVenda_id());
            System.out.println("Nome: " + modelVendasConsulta.getNome());
            System.out.println("Data da Venda: " + modelVendasConsulta.getData_venda()); // Verifique se está retornando a data

// Formata a data para o formato necessário
            if (modelVendasConsulta1.getData_venda() != null) {
                String formattedDataVenda = DateUtil.formatDate(modelVendasConsulta1.getData_venda());
                System.out.println("Data formatada: " + formattedDataVenda); // Debugging da data formatada
                request.setAttribute("formattedDataVenda", formattedDataVenda);
            } else {
                System.out.println("Data da venda está nula."); // Mensagem caso a data esteja nula
            }

// Mantém os dados na tela e envia a mensagem de sucesso
            request.setAttribute("msg", msg);
            request.setAttribute("modelVenda", modelVendas);
            request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

// Redireciona para vendas.jsp
            RequestDispatcher redireciona = request.getRequestDispatcher("/principal/vendas.jsp");
            redireciona.forward(request, response);



           

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }






}