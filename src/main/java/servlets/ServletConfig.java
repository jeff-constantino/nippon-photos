package servlets;

import dao.DAOConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfig;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/ServletConfig")
public class ServletConfig extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DAOConfig daoConfig;

    @Override
    public void init() {
        daoConfig = new DAOConfig();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<ModelConfig> configs = daoConfig.consultarTodasConfigs(); // Recupera todas as configurações
            System.out.println("Número de configurações encontradas: " + configs.size()); // Exibe a quantidade de configurações
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
            String idConf = request.getParameter("idConf");

            ModelConfig modelConfig = new ModelConfig();

            // Se idConf não for nulo, configure o idConf
            if (idConf != null && !idConf.isEmpty()) {
                modelConfig.setIdConf(Long.parseLong(idConf)); // Converter para Long
            } else {
                modelConfig.setIdConf(null); // ou modelConfig.setIdConf(0L); dependendo da lógica
            }

            modelConfig.setProd1_nome(request.getParameter("prod1_nome"));
            modelConfig.setProd2_nome(request.getParameter("prod2_nome"));
            modelConfig.setProd3_nome(request.getParameter("prod3_nome"));

            // Definindo valores de produtos e comissões, com tratamento de exceção
            modelConfig.setProd1_valor(parseBigDecimal(request.getParameter("prod1_valor")));
            modelConfig.setProd2_valor(parseBigDecimal(request.getParameter("prod2_valor")));
            modelConfig.setProd3_valor(parseBigDecimal(request.getParameter("prod3_valor")));
            modelConfig.setComissao(parseBigDecimal(request.getParameter("comissao")));

            // Grava a configuração no banco de dados
            modelConfig = daoConfig.gravarConfig(modelConfig);

            // Define a mensagem de sucesso e os dados do modelo para a requisição
            request.setAttribute("msg", msg);
            request.setAttribute("modelConfig", modelConfig);

            // Redireciona para o método doGet para carregar os dados atualizados
            doGet(request, response); // Chama o método doGet para recuperar os dados da configuração
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value != null && !value.isEmpty()) {
            try {
                return new BigDecimal(value);
            } catch (NumberFormatException e) {
                return BigDecimal.ZERO; // Retorna 0 em caso de erro de conversão
            }
        }
        return BigDecimal.ZERO;
    }
}
