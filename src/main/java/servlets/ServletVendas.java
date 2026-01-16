package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import dao.DAOConfig;
import dao.DAOControleRibbon;
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
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletVendas")
public class ServletVendas extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ NOVO: Pega a conexão do request
        Connection connection = (Connection) request.getAttribute("connection");

        // ✅ NOVO: Cria DAOs localmente com a conexão
        DAOVendasRepository daoVendas = new DAOVendasRepository(connection);
        DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository(connection);
        DAOConfig daoConfig = new DAOConfig(connection);
        DAOControleRibbon daoControleRibbon = new DAOControleRibbon(connection);

        try {
            String acao = request.getParameter("acao");
            String idVenda = request.getParameter("venda_id");

            // Se a ação não for especificada, chama a ação vendaDoDia automaticamente
            if (acao == null || acao.isEmpty()) {
                acao = "vendaDoDia";
            }

            if ("buscarValoresProdutos".equals(acao)) {
                List<ModelConfig> configs = daoConfig.consultarTodasConfigs();
                List<BigDecimal> controles = daoControleRibbon.buscarRibbonAtual();

                Map<String, Object> responseData = new HashMap<>();
                responseData.put("configs", configs);
                responseData.put("controles", controles);

                String jsonResponse = new Gson().toJson(responseData);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
                return;
            }

            if ("gerenciarVenda".equals(acao) && idVenda != null && !idVenda.isEmpty()) {
                try {
                    Long id = Long.parseLong(idVenda);
                    ModelVendas modelVendasConsulta = daoVendas.buscarVendaPorId(id);

                    if (modelVendasConsulta != null) {
                        if (modelVendasConsulta.getData_venda() != null) {
                            String formattedDataVenda = DateUtil.formatDate(modelVendasConsulta.getData_venda());
                            request.setAttribute("formattedDataVenda", formattedDataVenda);
                        }

                        request.setAttribute("modelVendasConsulta", modelVendasConsulta);
                        request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                        return;
                    } else {
                        request.setAttribute("msg", "Venda não encontrada.");
                        request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("msg", "ID de venda inválido.");
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                    return;
                }
            }

            if (acao != null && !acao.isEmpty()) {
                if (acao.equals("vendaDoDia")) {
                    List<ModelVendas> listaVendasDoDia = daoVendas.vendaDia();
                    request.setAttribute("listaVendasDoDia", listaVendasDoDia);
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                }
                else if (acao.equalsIgnoreCase("buscaruserajax")) {
                    String nome = request.getParameter("nome");

                    List<ModelLogin> dadosJsonUser = new ArrayList<>();
                    try {
                        dadosJsonUser = daoVendas.consultaFuncionarioList(nome);
                    } catch (Exception e) {
                        System.err.println("Erro na busca: " + e.getMessage());
                        response.setContentType("application/json");
                        response.getWriter().write("{\"error\":\"Erro ao buscar funcionários: " + e.getMessage() + "\"}");
                        return;
                    }

                    ObjectMapper mapper = new ObjectMapper();
                    String json = mapper.writeValueAsString(dadosJsonUser);
                    response.setContentType("application/json");
                    response.getWriter().write(json);
                }
                else if (acao.equalsIgnoreCase("buscarEditar")) {
                    String id = request.getParameter("id");
                    ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(id, super.getUserLogado(request));

                    List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
                    request.setAttribute("modelLogins", modelLogins);

                    request.setAttribute("msg", "EDITAR O FUNCIONÁRIO");
                    request.setAttribute("modelLogin", modelLogin);
                    request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
                    request.getRequestDispatcher("/principal/vendas.jsp").forward(request, response);
                }
                else if (acao.equalsIgnoreCase("CadVenda")) {
                    String vendaIdStr = request.getParameter("venda_id");
                    idVenda = null;

                    if (vendaIdStr != null && !vendaIdStr.isEmpty()) {
                        try {
                            idVenda = (vendaIdStr);
                        } catch (NumberFormatException e) {
                            throw new ServletException("ID de venda inválido: " + vendaIdStr);
                        }
                    }

                    if (idVenda != null) {
                        ModelVendas modelVendas = daoVendas.consultaVenda(Long.valueOf(idVenda), super.getUserLogado(request));
                        List<ModelVendas> modelVendasList = daoVendas.listaVendas(super.getUserLogado(request));

                        request.setAttribute("modelVendas", modelVendas);
                        request.setAttribute("msg", "EDITAR A VENDA");
                        request.setAttribute("totalPagina", daoVendas.totalPagina(this.getUserLogado(request)));
                        request.getRequestDispatcher("/principal/vendas.jsp").forward(request, response);
                    } else {
                        request.setAttribute("msg", "ID de venda inválido.");
                        request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                    }
                }
                else {
                    request.setAttribute("msg", "Ação não reconhecida.");
                    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "Ação não especificada.");
                request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
        // ✅ NÃO precisa fechar conexão - Filter faz automaticamente
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ NOVO: Pega a conexão do request
        Connection connection = (Connection) request.getAttribute("connection");

        // ✅ NOVO: Cria DAOs localmente com a conexão
        DAOVendasRepository daoVendas = new DAOVendasRepository(connection);
        DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository(connection);

        try {
            String acao = request.getParameter("acao");
            String msg = "Venda Gravada com Sucesso!";

            if (acao != null && acao.equals("deletar")) {
                String venda_id = request.getParameter("venda_id");

                if (venda_id != null && !venda_id.isEmpty()) {
                    daoVendas.deleteVenda(Long.parseLong(venda_id));
                    request.getSession().setAttribute("msg", "Venda Excluída!");
                    response.sendRedirect(request.getContextPath() + "/ServletVendas");
                } else {
                    System.out.println("ID da venda não foi recebido ou está vazio.");
                }
            } else if (acao != null && acao.equals("limparMsg")) {
                request.getSession().removeAttribute("msg");
            } else {
                String venda_id = request.getParameter("venda_id");
                String nome = request.getParameter("nome");

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

                String dataVenda = request.getParameter("dataVenda");
                String sobras_str = request.getParameter("sobras");
                String ribbon = request.getParameter("ribbon");
                String ribbon_dif_str = request.getParameter("ribbon_dif");

                ModelVendas modelVendas = new ModelVendas();
                if (venda_id != null && !venda_id.isEmpty()) {
                    modelVendas.setVenda_id(Long.parseLong(venda_id));
                }

                String vendedor_id_str = request.getParameter("vendedor_id");
                modelVendas.setVendedor_id(vendedor_id_str);
                modelVendas.setNome(nome);

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

                modelVendas.setRibbon_dif(ribbon_dif_str != null && !ribbon_dif_str.isEmpty() ? Integer.parseInt(ribbon_dif_str) : 0);

                if (dataVenda != null && !dataVenda.isEmpty()) {
                    Date sqlDate = Date.valueOf(dataVenda);
                    modelVendas.setData_venda(sqlDate);
                } else {
                    throw new Exception("O parâmetro 'dataVenda' não pode ser nulo ou vazio.");
                }

                if (modelVendas.getData_venda() != null) {
                    String formattedDataVenda = DateUtil.formatDate(modelVendas.getData_venda());
                    request.setAttribute("formattedDataVenda", formattedDataVenda);
                }

                modelVendas.setSobras(sobras_str != null && !sobras_str.isEmpty() ? Integer.parseInt(sobras_str) : 0);

                if (ribbon != null && !ribbon.isEmpty()) {
                    modelVendas.setRibbon(ribbon);
                }

                if (modelVendas.getVenda_id() != null) {
                    modelVendas = daoVendas.atualizarVenda(modelVendas.getVenda_id(), modelVendas, super.getUserLogado(request));
                } else {
                    modelVendas = daoVendas.gravarVenda(modelVendas, super.getUserLogado(request));
                }

                ModelVendas modelVendasConsulta = daoVendas.consultaVenda(modelVendas.getVenda_id(), super.getUserLogado(request));
                request.setAttribute("modelVendasConsulta", modelVendasConsulta);

                request.setAttribute("msg", msg);
                request.setAttribute("modelVenda", modelVendas);
                request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

                ModelVendas modelVendasConsulta1 = daoVendas.consultaVenda(modelVendas.getVenda_id(), super.getUserLogado(request));

                if (modelVendasConsulta1.getData_venda() != null) {
                    String formattedDataVenda = DateUtil.formatDate(modelVendasConsulta1.getData_venda());
                    request.setAttribute("formattedDataVenda", formattedDataVenda);
                } else {
                    request.setAttribute("msg", "Selecione a Data da venda.");
                }

                request.setAttribute("msg", msg);
                request.setAttribute("modelVenda", modelVendas);
                request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));

                request.setAttribute("acao", "vendaDoDia");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
        // ✅ NÃO precisa fazer commit/rollback - Filter gerencia automaticamente
        // ✅ NÃO precisa fechar conexão - Filter faz automaticamente
    }
}