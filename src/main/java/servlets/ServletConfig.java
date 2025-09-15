package servlets;

import dao.DAOConfig;
import dao.DAOConfiguracao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfig;
import model.ModelConfiguracao;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ServletConfig")
public class ServletConfig extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOConfig daoConfig;
    private DAOConfiguracao daoConfiguracao;

    @Override
    public void init() throws ServletException {
        daoConfig = new DAOConfig();
        daoConfiguracao = new DAOConfiguracao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<ModelConfig> configs = daoConfig.consultarTodasConfigs();
            List<ModelConfiguracao> configsSalarios = daoConfiguracao.consultarSalarios();
            List<ModelConfiguracao> configsJuros = daoConfiguracao.consultarJuros();
            ModelConfiguracao configInss = daoConfiguracao.buscarFaixasInss();

            // --- BUSCA OS DADOS DE IRRF CORRETAMENTE ---
            ModelConfiguracao configIrrf = daoConfiguracao.buscarFaixasIrrf();

            // Carrega os 3 materiais fixos para preencher o formulário
            List<ModelConfig> materiaisFixos = daoConfig.carregarMateriaisFixos();

            // Cria arrays para facilitar o acesso na JSP
            ModelConfig[] materiais = new ModelConfig[3];

            // Inicializa com objetos vazios
            for (int i = 0; i < 3; i++) {
                materiais[i] = new ModelConfig();
            }

            // Preenche com os dados existentes do banco
            for (ModelConfig material : materiaisFixos) {
                int index = (int) (material.getIdConf() - 1); // ID 1 = index 0, ID 2 = index 1, etc.
                if (index >= 0 && index < 3) {
                    materiais[index] = material;
                }
            }

            // Disponibiliza todos os atributos para a JSP
            request.setAttribute("configsJuros", configsJuros);
            request.setAttribute("configsSalarios", configsSalarios);
            request.setAttribute("configs", configs);
            request.setAttribute("configInss", configInss);

            // --- ATRIBUTO DO IRRF CORRIGIDO ---
            request.setAttribute("configIrrf", configIrrf);

            request.setAttribute("material1", materiais[0]);
            request.setAttribute("material2", materiais[1]);
            request.setAttribute("material3", materiais[2]);

            request.getRequestDispatcher("/principal/config.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }


    @Override
      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String tipoConfig = request.getParameter("tipo_config");
            String acao = request.getParameter("acao");
            if ("limparMsg".equals(acao)) {
                // limpe sua mensagem da sessão, se for o caso
                request.getSession().removeAttribute("msg");
                response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
                return; // NÃO segue para gravação
            }



            // --- NOVO FLUXO: MATERIAIS (tabela conf_materiais) ---
            if ("materiais".equals(tipoConfig)) {
                processarMateriais(request);
                request.setAttribute("msg", "Materiais gravados com sucesso!");
                doGet(request, response);
                return; // encerra aqui para não seguir para o fluxo de 'configuracao'
            }

            // --- FLUXO EXISTENTE: CONFIGURAÇÕES GERAIS (tabela configuracao) ---
            String idConfParam = request.getParameter("idConf");
            ModelConfig modelConfig = new ModelConfig();

            if (idConfParam != null && !idConfParam.isEmpty()) {
                long id = Long.parseLong(idConfParam);
                if (id > 0) {
                    modelConfig.setIdConf(id);
                }
            }


            // Configura os nomes
            modelConfig.setConf1_nome(request.getParameter("conf1_nome"));
            modelConfig.setConf2_nome(request.getParameter("conf2_nome"));
            modelConfig.setConf3_nome(request.getParameter("conf3_nome"));
            modelConfig.setConf4_nome(request.getParameter("conf4_nome")); // Novo campo
            modelConfig.setConf_name(request.getParameter("conf_name"));

            // Definindo valores de configurações
            modelConfig.setConf1_valor(parseBigDecimal(request.getParameter("conf1_valor")));
            modelConfig.setConf1_valor2(parseBigDecimal(request.getParameter("conf1_valor2")));
            modelConfig.setConf2_valor(parseBigDecimal(request.getParameter("conf2_valor")));
            modelConfig.setConf3_valor(parseBigDecimal(request.getParameter("conf3_valor")));
            modelConfig.setConf4_valor(parseBigDecimal(request.getParameter("conf4_valor"))); // Novo campo

            // Definindo custos
            modelConfig.setConf1_custo(parseBigDecimal(request.getParameter("conf1_custo")));
            modelConfig.setConf2_custo(parseBigDecimal(request.getParameter("conf2_custo")));
            modelConfig.setConf3_custo(parseBigDecimal(request.getParameter("conf3_custo")));
            modelConfig.setConf4_custo(parseBigDecimal(request.getParameter("conf4_custo"))); // Novo campo

            // Definindo quantidades
            modelConfig.setConf1_qtd(parseIntOrDefault(request.getParameter("conf1_qtd")));
            modelConfig.setConf2_qtd(parseIntOrDefault(request.getParameter("conf2_qtd")));
            modelConfig.setConf3_qtd(parseIntOrDefault(request.getParameter("conf3_qtd")));
            modelConfig.setConf4_qtd(parseIntOrDefault(request.getParameter("conf4_qtd"))); // Novo campo

            // Grava ou atualiza a configuração no banco de dados
            modelConfig = daoConfig.gravarConfig(modelConfig);

            // (Opcional) Anexa valores no request para reuso na JSP
            request.setAttribute("valorConf1", modelConfig.getConf1_valor());
            request.setAttribute("valorConf1_2", modelConfig.getConf1_valor2());
            request.setAttribute("valorConf2", modelConfig.getConf2_valor());
            request.setAttribute("valorConf3", modelConfig.getConf3_valor());
            request.setAttribute("valorConf4", modelConfig.getConf4_valor());
            request.setAttribute("valorConf1_custo", modelConfig.getConf1_custo());
            request.setAttribute("valorConf2_custo", modelConfig.getConf2_custo());
            request.setAttribute("valorConf3_custo", modelConfig.getConf3_custo());
            request.setAttribute("valorConf4_custo", modelConfig.getConf4_custo());

            request.setAttribute("msg", "Configuração gravada com sucesso!");
            // Redireciona para o método doGet para carregar os dados atualizados
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }


    // Método auxiliar para tratar os valores nulos ou inválidos
    private int parseIntOrDefault(String value) {
        if (value != null && !value.isEmpty()) {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // log para depuração
                return 0; // Retorna 0 em caso de erro
            }
        }
        return 0; // Retorna 0 se o valor for nulo ou vazio
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value != null && !value.isEmpty()) {
            try {
                // Trocar vírgula por ponto se necessário
                value = value.replace(",", ".");
                return new BigDecimal(value);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // log para depuração
                return BigDecimal.ZERO; // Retorna 0 em caso de erro de conversão
            }
        }
        return BigDecimal.ZERO; // Retorna 0 se o valor estiver vazio
    }


    /**
     * Processa o formulário de materiais
     * Cada produto será gravado separadamente
     */
    /**
     * Processa os 3 materiais do formulário
     */
    private void processarMateriais(HttpServletRequest request) throws Exception {
        // Material 1
        String nome1 = request.getParameter("conf1_nome");
        String valor1 = request.getParameter("conf1_valor");
        String qtd1 = request.getParameter("conf1_qtd");
        String custo1 = request.getParameter("conf1_custo");

        // Material 2
        String nome2 = request.getParameter("conf2_nome");
        String valor2 = request.getParameter("conf2_valor");
        String qtd2 = request.getParameter("conf2_qtd");
        String custo2 = request.getParameter("conf2_custo");

        // Material 3
        String nome3 = request.getParameter("conf3_nome");
        String valor3 = request.getParameter("conf3_valor");
        String qtd3 = request.getParameter("conf3_qtd");
        String custo3 = request.getParameter("conf3_custo");

        // Chama o DAO para salvar/atualizar os 3 materiais fixos
        daoConfig.salvarMateriaisFixos(
                nome1, valor1, qtd1, custo1,
                nome2, valor2, qtd2, custo2,
                nome3, valor3, qtd3, custo3
        );
    }

    /**
     * Carrega materiais para exibição (opcional - para usar no doGet se necessário)
     */
    private void carregarMateriais(HttpServletRequest request) {
        try {
            // Se você quiser carregar materiais específicos por conf_name:
            String confName = request.getParameter("conf_name_materiais");
            if (confName != null && !confName.trim().isEmpty()) {
                List<ModelConfig> materiais = daoConfig.buscarMateriaisPorConfName(confName);
                request.setAttribute("materiaisCarregados", materiais);
            }

            // Ou carregar todos os materiais:
            List<ModelConfig> todosMateriais = daoConfig.listarTodosMateriais();
            request.setAttribute("todosMateriais", todosMateriais);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erroMateriais", "Erro ao carregar materiais: " + e.getMessage());
        }
    }


}
