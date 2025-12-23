package servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import dao.DAOAssociado;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelAssociado;
import model.ModelLogin;
import util.DateUtil;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ServletAssociado")
public class ServletAssociado extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOAssociado daoAssociado;

    @Override
    public void init() throws ServletException {
        super.init();
        daoAssociado = new DAOAssociado();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");
            String idVenda = request.getParameter("venda_id");

            // Se a ação não for especificada, chama a ação vendaDoDia automaticamente
            if (acao == null || acao.isEmpty()) {
                acao = "vendaDoDia";
            }
            // ========== AÇÃO: BUSCAR RELATÓRIO ==========
            if ("buscarRelatorio".equals(acao)) {
                String dataInicial = request.getParameter("data_inicial");
                String dataFinal = request.getParameter("data_final");

                try {
                    List<ModelAssociado> dadosRelatorio = daoAssociado.buscarDadosRelatorio(dataInicial, dataFinal);

                    String jsonResponse = new Gson().toJson(dadosRelatorio);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jsonResponse);
                } catch (Exception e) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }

            // ========== CARREGAR CONFIGURAÇÕES (SEMPRE) ==========
            try {
                ModelAssociado config = daoAssociado.buscarConfiguracaoPorId(1L);
                if (config != null) {
                    request.setAttribute("modelConfig", config);

                    // Também envia os materiais separados para facilitar no JSP
                    request.setAttribute("material1", config);
                    request.setAttribute("material2", config);
                    request.setAttribute("material3", config);
                }
            } catch (Exception e) {
                // Se não conseguir carregar, continua sem erro
                e.printStackTrace();
            }

            // ========== CARREGAR RIBBONS (SEMPRE) ==========
            try {
                List<java.math.BigDecimal> ribbonAtual = daoAssociado.buscarRibbonAtual();
                request.setAttribute("ribbonAtual", ribbonAtual);
            } catch (Exception e) {
                // Se não conseguir carregar, continua sem erro
                e.printStackTrace();
            }

            // ========== AÇÃO: BUSCAR VALORES PRODUTOS (AJAX) ==========
            if ("buscarValoresProdutos".equals(acao)) {
                List<ModelAssociado> configs = daoAssociado.listarConfiguracoes();
                List<java.math.BigDecimal> controles = daoAssociado.buscarRibbonAtual();

                Map<String, Object> responseData = new HashMap<>();
                responseData.put("configs", configs);
                responseData.put("controles", controles);  // Adiciona os ribbons na resposta

                String jsonResponse = new Gson().toJson(responseData);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
                return;
            }

            // ========== AÇÃO: CONSULTAR FINANCEIRO ==========
            if ("consultarFinanceiro".equals(acao)) {
                String dataInicial = request.getParameter("data_inicial");
                String dataFinal = request.getParameter("data_final");

                try {
                    Map<String, Object> dadosFinanceiros = daoAssociado.consultarDadosFinanceiros(dataInicial, dataFinal);

                    String jsonResponse = new Gson().toJson(dadosFinanceiros);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jsonResponse);
                } catch (Exception e) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }

            // ========== AÇÃO: BUSCAR TOTAL VENDIDO NO MÊS ==========
            if ("buscarTotalVendidoMes".equals(acao)) {
                String vendedorId = request.getParameter("vendedor_id");
                String mes = request.getParameter("mes");
                String ano = request.getParameter("ano");

                try {
                    int totalFotos = daoAssociado.buscarTotalFotosVendidasMes(Long.parseLong(vendedorId), Integer.parseInt(mes), Integer.parseInt(ano));

                    Map<String, Object> resultado = new HashMap<>();
                    resultado.put("total_fotos", totalFotos);

                    String jsonResponse = new Gson().toJson(resultado);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jsonResponse);
                } catch (Exception e) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
                }
                return;
            }

            // ========== AÇÃO: GERENCIAR VENDA ==========
            if ("gerenciarVenda".equals(acao) && idVenda != null && !idVenda.isEmpty()) {
                try {
                    Long id = Long.parseLong(idVenda);
                    ModelAssociado modelAssociado = daoAssociado.consultaVenda(id, super.getUserLogado(request));

                    if (modelAssociado != null) {
                        if (modelAssociado.getData_venda() != null) {
                            String formattedDataVenda = DateUtil.formatDate(modelAssociado.getData_venda());
                            request.setAttribute("formattedDataVenda", formattedDataVenda);
                        }

                        request.setAttribute("modelAssociadoConsulta", modelAssociado);

                        // Carrega lista de vendas do dia
                        List<ModelAssociado> listaVendasDoDia = daoAssociado.vendaDia();
                        request.setAttribute("listaVendasDoDia", listaVendasDoDia);

                        request.getRequestDispatcher("principal/associado.jsp").forward(request, response);
                        return;
                    } else {
                        request.setAttribute("msg", "Venda não encontrada.");
                        request.getRequestDispatcher("principal/associado.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("msg", "ID de venda inválido.");
                    request.getRequestDispatcher("principal/associado.jsp").forward(request, response);
                    return;
                }
            }

            // ========== AÇÃO: VENDAS DO DIA ==========
            if (acao.equals("vendaDoDia")) {
                List<ModelAssociado> listaVendasDoDia = daoAssociado.vendaDia();
                request.setAttribute("listaVendasDoDia", listaVendasDoDia);
                request.getRequestDispatcher("principal/associado.jsp").forward(request, response);
                return;
            }

            // ========== AÇÃO: BUSCAR USUÁRIO AJAX ==========
            if (acao.equalsIgnoreCase("buscaruserajax")) {
                String nome = request.getParameter("nome");

                List<ModelLogin> dadosJsonUser = new ArrayList<>();
                try {
                    dadosJsonUser = daoAssociado.consultaFuncionarioList(nome);
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
                return;
            }

            // ========== AÇÃO: CARREGAR CONFIGURAÇÕES ==========
            if (acao.equalsIgnoreCase("carregarConfig")) {
                String idconf = request.getParameter("idconf");

                if (idconf != null && !idconf.isEmpty()) {
                    ModelAssociado config = daoAssociado.buscarConfiguracao(Long.parseLong(idconf));
                    request.setAttribute("modelConfig", config);
                } else {
                    // Busca a primeira configuração disponível
                    List<ModelAssociado> configs = daoAssociado.listarConfiguracoes();
                    if (!configs.isEmpty()) {
                        request.setAttribute("modelConfig", configs.get(0));
                    }
                }

                List<ModelAssociado> listaVendasDoDia = daoAssociado.vendaDia();
                request.setAttribute("listaVendasDoDia", listaVendasDoDia);
                request.getRequestDispatcher("principal/associado.jsp").forward(request, response);
                return;
            }

            // ========== AÇÃO: CARREGAR FINANCEIRO ==========
            if (acao.equalsIgnoreCase("carregarFinanceiro")) {
                String mes = request.getParameter("mes");
                String ano = request.getParameter("ano");

                if (mes != null && ano != null && !mes.isEmpty() && !ano.isEmpty()) {
                    ModelAssociado financeiro = daoAssociado.buscarFinanceiroPorPeriodo(
                            Integer.parseInt(mes),
                            Integer.parseInt(ano)
                    );
                    request.setAttribute("modelFinanceiro", financeiro);
                }

                List<ModelAssociado> listaVendasDoDia = daoAssociado.vendaDia();
                request.setAttribute("listaVendasDoDia", listaVendasDoDia);
                request.getRequestDispatcher("principal/associado.jsp").forward(request, response);
                return;
            }

            // Caso a ação não seja reconhecida
            request.setAttribute("msg", "Ação não reconhecida.");
            request.getRequestDispatcher("principal/associado.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");
            String tipoConfig = request.getParameter("tipo_config");
            String financeiro = request.getParameter("financeiro");

            // ========== AÇÃO: DELETAR VENDA ==========
            if (acao != null && acao.equals("deletar")) {
                String venda_id = request.getParameter("venda_id");

                if (venda_id != null && !venda_id.isEmpty()) {
                    daoAssociado.deleteVenda(Long.parseLong(venda_id));
                    request.getSession().setAttribute("msg", "Venda Excluída!");
                    response.sendRedirect(request.getContextPath() + "/ServletAssociado");
                } else {
                    System.out.println("ID da venda não foi recebido ou está vazio.");
                }
                return;
            }

            // ========== AÇÃO: LIMPAR MENSAGEM ==========
            if (acao != null && acao.equals("limparMsg")) {
                request.getSession().removeAttribute("msg");
                return;
            }

            // ========== AÇÃO: SALVAR CONFIGURAÇÃO DE MATERIAIS ==========
            if ("materiais".equals(tipoConfig)) {
                // Busca configuração existente (ID 1) para mesclar dados
                ModelAssociado config = daoAssociado.buscarConfiguracaoPorId(1L);
                if (config == null) {
                    config = new ModelAssociado();
                    config.setIdconf(1L);
                }

                // Configurações Financeiras
                String limite = request.getParameter("limite");
                if (limite != null && !limite.isEmpty()) {
                    config.setLimite(Integer.parseInt(limite));
                }
                config.setPercentual_extras(request.getParameter("percentual_extras"));

                // Atualiza apenas os campos de materiais (mantém produtos)
                config.setMat1_nome(request.getParameter("conf1_nome"));
                config.setMat1_valor(request.getParameter("conf1_valor"));
                String mat1Qtd = request.getParameter("conf1_qtd");
                if (mat1Qtd != null && !mat1Qtd.isEmpty()) {
                    config.setMat1_qtd(Integer.parseInt(mat1Qtd));
                }
                config.setMat1_custo(request.getParameter("conf1_custo"));

                // Material 2
                config.setMat2_nome(request.getParameter("conf2_nome"));
                config.setMat2_valor(request.getParameter("conf2_valor"));
                String mat2Qtd = request.getParameter("conf2_qtd");
                if (mat2Qtd != null && !mat2Qtd.isEmpty()) {
                    config.setMat2_qtd(Integer.parseInt(mat2Qtd));
                }
                config.setMat2_custo(request.getParameter("conf2_custo"));

                // Material 3
                config.setMat3_nome(request.getParameter("conf3_nome"));
                config.setMat3_valor(request.getParameter("conf3_valor"));
                String mat3Qtd = request.getParameter("conf3_qtd");
                if (mat3Qtd != null && !mat3Qtd.isEmpty()) {
                    config.setMat3_qtd(Integer.parseInt(mat3Qtd));
                }
                config.setMat3_custo(request.getParameter("conf3_custo"));

                daoAssociado.salvarConfiguracao(config);

                request.setAttribute("msg", "Configuração de materiais salva com sucesso!");
                request.setAttribute("acao", "vendaDoDia");
                doGet(request, response);
                return;
            }

            // ========== AÇÃO: SALVAR CONFIGURAÇÃO DE PRODUTOS ==========
            if (tipoConfig == null && request.getParameter("conf1_nome") != null) {
                // Busca configuração existente (ID 1) para mesclar dados
                ModelAssociado config = daoAssociado.buscarConfiguracaoPorId(1L);
                if (config == null) {
                    config = new ModelAssociado();
                    config.setIdconf(1L);
                }

                // Atualiza apenas os campos de produtos (mantém materiais)
                config.setConf1_nome(request.getParameter("conf1_nome"));
                config.setConf1_valor(request.getParameter("conf1_valor"));

                // Produto 2
                config.setConf2_nome(request.getParameter("conf2_nome"));
                config.setConf2_valor(request.getParameter("conf2_valor"));

                // Produto 3
                config.setConf3_nome(request.getParameter("conf3_nome"));
                config.setConf3_valor(request.getParameter("conf3_valor"));

                daoAssociado.salvarConfiguracao(config);

                request.setAttribute("msg", "Configuração de produtos salva com sucesso!");
                request.setAttribute("modelConfig", config);
                request.setAttribute("acao", "vendaDoDia");
                doGet(request, response);
                return;
            }

            // ========== AÇÃO: SALVAR FINANCEIRO ==========
            if ("financeiro".equals(financeiro)) {
                ModelAssociado fin = new ModelAssociado();

                // Extrair mês e ano das datas
                String dataInicial = request.getParameter("data_inicial");
                String dataFinal = request.getParameter("data_final");

                if (dataFinal != null && !dataFinal.isEmpty()) {
                    String[] partesData = dataFinal.split("-");
                    fin.setAno_referencia(Integer.parseInt(partesData[0]));
                    fin.setMes_referencia(Integer.parseInt(partesData[1]));
                }

                // Quantidades
                String totalFotos = request.getParameter("total_fotos");
                if (totalFotos != null && !totalFotos.isEmpty()) {
                    fin.setTotal_fotos(Integer.parseInt(totalFotos));
                }

                String totalSobras = request.getParameter("total_sobras");
                if (totalSobras != null && !totalSobras.isEmpty()) {
                    fin.setTotal_sobras(Integer.parseInt(totalSobras));
                }

                String totalEncartes = request.getParameter("total_encartes");
                if (totalEncartes != null && !totalEncartes.isEmpty()) {
                    fin.setTotal_encartes(Integer.parseInt(totalEncartes));
                }

                String digTotal = request.getParameter("dig_total");
                if (digTotal != null && !digTotal.isEmpty()) {
                    fin.setDig_total(Integer.parseInt(digTotal));
                }

                String totalExtras = request.getParameter("total_extras");
                if (totalExtras != null && !totalExtras.isEmpty()) {
                    fin.setFotos_extras(Integer.parseInt(totalExtras));
                }

                String totalEncExtras = request.getParameter("total_enc_extras");
                if (totalEncExtras != null && !totalEncExtras.isEmpty()) {
                    fin.setEncartes_extras(Integer.parseInt(totalEncExtras));
                }

                // ========== FUNÇÃO AUXILIAR PARA REMOVER FORMATAÇÃO ==========
                // Remove "R$ ", pontos e vírgulas, converte para BigDecimal
                java.util.function.Function<String, java.math.BigDecimal> limparValor = (valor) -> {
                    if (valor == null || valor.isEmpty()) return java.math.BigDecimal.ZERO;
                    try {
                        // Remove "R$ ", espaços, pontos (separador de milhar)
                        // Substitui vírgula por ponto (separador decimal)
                        String limpo = valor.replace("R$", "")
                                .replace(" ", "")
                                .replace(".", "")
                                .replace(",", ".");
                        return new java.math.BigDecimal(limpo);
                    } catch (NumberFormatException e) {
                        return java.math.BigDecimal.ZERO;
                    }
                };

                // Custos (com formatação monetária)
                fin.setCusto_fotos_sobras(limparValor.apply(request.getParameter("custo_fotos_sobras")));
                fin.setCusto_encartes(limparValor.apply(request.getParameter("custo_encartes")));
                fin.setFgts(limparValor.apply(request.getParameter("fgts_valor")));
                fin.setInss(limparValor.apply(request.getParameter("inss_valor")));
                fin.setParcela_inss(limparValor.apply(request.getParameter("parcela_inss")));

                // Financeiro (com formatação monetária)
                fin.setTotal_bruto(limparValor.apply(request.getParameter("total_bruto")));
                fin.setTotal_vendas(limparValor.apply(request.getParameter("total_vendas")));
                fin.setValor_extras(limparValor.apply(request.getParameter("valor_extras")));
                fin.setCustos_fotos(limparValor.apply(request.getParameter("custos_totais")));
                fin.setRestituir(limparValor.apply(request.getParameter("restituir")));
                fin.setSaldo_liquido(limparValor.apply(request.getParameter("saldo_liquido")));

                daoAssociado.salvarFinanceiro(fin, super.getUserLogado(request));

                request.setAttribute("msg", "Dados financeiros salvos com sucesso!");
                request.setAttribute("acao", "vendaDoDia");
                doGet(request, response);
                return;
            }

            // ========== AÇÃO: GRAVAR/ATUALIZAR VENDA ==========
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
            String sobras_extras_str = request.getParameter("sobras_extras");
            String ribbon = request.getParameter("ribbon");
            String ribbon_dif_str = request.getParameter("ribbon_dif");

            ModelAssociado modelAssociado = new ModelAssociado();

            if (venda_id != null && !venda_id.isEmpty()) {
                modelAssociado.setVenda_id(Long.parseLong(venda_id));
            }

            String vendedor_id_str = request.getParameter("vendedor_id");
            if (vendedor_id_str != null && !vendedor_id_str.isEmpty()) {
                modelAssociado.setVendedor_id(Long.parseLong(vendedor_id_str));
            }
            modelAssociado.setNome(nome);

            modelAssociado.setProd1_din(prod1_din_str != null && !prod1_din_str.isEmpty() ? Integer.parseInt(prod1_din_str) : 0);
            modelAssociado.setProd1_deb(prod1_deb_str != null && !prod1_deb_str.isEmpty() ? Integer.parseInt(prod1_deb_str) : 0);
            modelAssociado.setProd1_cred(prod1_cred_str != null && !prod1_cred_str.isEmpty() ? Integer.parseInt(prod1_cred_str) : 0);
            modelAssociado.setProd1_pix(prod1_pix_str != null && !prod1_pix_str.isEmpty() ? Integer.parseInt(prod1_pix_str) : 0);

            modelAssociado.setProd2_din(prod2_din_str != null && !prod2_din_str.isEmpty() ? Integer.parseInt(prod2_din_str) : 0);
            modelAssociado.setProd2_deb(prod2_deb_str != null && !prod2_deb_str.isEmpty() ? Integer.parseInt(prod2_deb_str) : 0);
            modelAssociado.setProd2_cred(prod2_cred_str != null && !prod2_cred_str.isEmpty() ? Integer.parseInt(prod2_cred_str) : 0);
            modelAssociado.setProd2_pix(prod2_pix_str != null && !prod2_pix_str.isEmpty() ? Integer.parseInt(prod2_pix_str) : 0);

            modelAssociado.setProd3_din(prod3_din_str != null && !prod3_din_str.isEmpty() ? Integer.parseInt(prod3_din_str) : 0);
            modelAssociado.setProd3_deb(prod3_deb_str != null && !prod3_deb_str.isEmpty() ? Integer.parseInt(prod3_deb_str) : 0);
            modelAssociado.setProd3_cred(prod3_cred_str != null && !prod3_cred_str.isEmpty() ? Integer.parseInt(prod3_cred_str) : 0);
            modelAssociado.setProd3_pix(prod3_pix_str != null && !prod3_pix_str.isEmpty() ? Integer.parseInt(prod3_pix_str) : 0);

            modelAssociado.setRibbon_dif(ribbon_dif_str != null && !ribbon_dif_str.isEmpty() ? Integer.parseInt(ribbon_dif_str) : 0);

            if (dataVenda != null && !dataVenda.isEmpty()) {
                Date sqlDate = Date.valueOf(dataVenda);
                modelAssociado.setData_venda(sqlDate);
            } else {
                throw new Exception("O parâmetro 'dataVenda' não pode ser nulo ou vazio.");
            }

            modelAssociado.setSobras(sobras_str != null && !sobras_str.isEmpty() ? Integer.parseInt(sobras_str) : 0);
            modelAssociado.setSobras_extras(sobras_extras_str != null && !sobras_extras_str.isEmpty() ? Integer.parseInt(sobras_extras_str) : 0);

            if (ribbon != null && !ribbon.isEmpty()) {
                modelAssociado.setRibbon(ribbon);
            }

            // Grava ou atualiza a venda
            if (modelAssociado.getVenda_id() != null && modelAssociado.getVenda_id() > 0) {
                modelAssociado = daoAssociado.atualizarVenda(
                        modelAssociado.getVenda_id(),
                        modelAssociado,
                        super.getUserLogado(request)
                );
                request.setAttribute("msg", "Venda Atualizada com Sucesso!");
            } else {
                modelAssociado = daoAssociado.gravarVenda(modelAssociado, super.getUserLogado(request));
                request.setAttribute("msg", "Venda Gravada com Sucesso!");
            }

            // Busca a venda atualizada
            ModelAssociado modelAssociadoConsulta = daoAssociado.consultaVenda(
                    modelAssociado.getVenda_id(),
                    super.getUserLogado(request)
            );

            request.setAttribute("modelAssociadoConsulta", modelAssociadoConsulta);

            if (modelAssociadoConsulta.getData_venda() != null) {
                String formattedDataVenda = DateUtil.formatDate(modelAssociadoConsulta.getData_venda());
                request.setAttribute("formattedDataVenda", formattedDataVenda);
            }

            request.setAttribute("acao", "vendaDoDia");
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }
}