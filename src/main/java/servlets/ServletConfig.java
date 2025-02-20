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

            request.setAttribute("configsJuros", configsJuros);
            request.setAttribute("configsSalarios", configsSalarios);
            request.setAttribute("configs", configs); // Adiciona a lista ao request
            request.getRequestDispatcher("/principal/config.jsp").forward(request, response); // Redireciona para a JSP
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String msg = "Operação realizada com sucesso!";
            String idConfParam = request.getParameter("idConf");
            ModelConfig modelConfig = new ModelConfig();

            // Verifica se o idConf foi passado e o configura
            if (idConfParam != null && !idConfParam.isEmpty()) {
                modelConfig.setIdConf(Long.parseLong(idConfParam)); // Converter para Long
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
            modelConfig = daoConfig.gravarConfig(modelConfig); // Ajuste este método para que ele possa gravar ou atualizar

            // Obtendo valores de configuração para cada item
            BigDecimal valorConf1 = modelConfig.getConf1_valor();
            BigDecimal valorConf1_2 = modelConfig.getConf1_valor2();
            BigDecimal valorConf2 = modelConfig.getConf2_valor();
            BigDecimal valorConf3 = modelConfig.getConf3_valor();
            BigDecimal valorConf4 = modelConfig.getConf4_valor(); // Novo campo
            BigDecimal valorConf1_custo = modelConfig.getConf1_custo();
            BigDecimal valorConf2_custo = modelConfig.getConf2_custo();
            BigDecimal valorConf3_custo = modelConfig.getConf3_custo();
            BigDecimal valorConf4_custo = modelConfig.getConf4_custo(); // Novo campo

            // Adicionando os valores ao request
            request.setAttribute("valorConf1", valorConf1);
            request.setAttribute("valorConf1_2", valorConf1_2);
            request.setAttribute("valorConf2", valorConf2);
            request.setAttribute("valorConf3", valorConf3);
            request.setAttribute("valorConf4", valorConf4); // Novo campo
            request.setAttribute("valorConf1_custo", valorConf1_custo);
            request.setAttribute("valorConf2_custo", valorConf2_custo);
            request.setAttribute("valorConf3_custo", valorConf3_custo);
            request.setAttribute("valorConf4_custo", valorConf4_custo); // Novo campo

            // Redireciona para o método doGet para carregar os dados atualizados
            doGet(request, response); // Chama o método doGet para recuperar os dados da configuração
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
                e.printStackTrace(); // Adicione log para depuração
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
                e.printStackTrace(); // Adicione log para depuração
                return BigDecimal.ZERO; // Retorna 0 em caso de erro de conversão
            }
        }
        return BigDecimal.ZERO; // Retorna 0 se o valor estiver vazio
    }
}
