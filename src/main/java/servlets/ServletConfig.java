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
            String idConfParam = request.getParameter("idConf");
            ModelConfig modelConfig = new ModelConfig();

            // Verifica se o idConf foi passado e o configura
            if (idConfParam != null && !idConfParam.isEmpty()) {
                modelConfig.setIdConf(Long.parseLong(idConfParam)); // Converter para Long
            }

            modelConfig.setProd1_nome(request.getParameter("prod1_nome"));
            modelConfig.setProd2_nome(request.getParameter("prod2_nome"));
            modelConfig.setProd3_nome(request.getParameter("prod3_nome"));

            // Definindo valores de produtos e comissões
            modelConfig.setProd1_valor(parseBigDecimal(request.getParameter("prod1_valor")));
            modelConfig.setProd2_valor(parseBigDecimal(request.getParameter("prod2_valor")));
            modelConfig.setProd3_valor(parseBigDecimal(request.getParameter("prod3_valor")));
            modelConfig.setComissao(parseBigDecimal(request.getParameter("comissao")));

            // Grava ou atualiza a configuração no banco de dados
            modelConfig = daoConfig.gravarConfig(modelConfig); // Ajuste este método para que ele possa gravar ou atualizar

            // Obtendo valores de configuração para cada produto
            BigDecimal valorProd1 = modelConfig.getProd1_valor();
            BigDecimal valorProd2 = modelConfig.getProd2_valor();
            BigDecimal valorProd3 = modelConfig.getProd3_valor();

            // Adicionando os valores ao request
            request.setAttribute("valorProd1", valorProd1);
            request.setAttribute("valorProd2", valorProd2);
            request.setAttribute("valorProd3", valorProd3);

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
