package servlets;

import dao.DAOConfig;
import dao.DAOConfiguracao;
import jakarta.servlet.RequestDispatcher;
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

@WebServlet("/ServletConfiguracao")
public class ServletConfiguracao extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOConfiguracao daoConfiguracao;
    private DAOConfig daoConfig;


    @Override
    public void init() throws ServletException {
        daoConfig = new DAOConfig();
        daoConfiguracao = new DAOConfiguracao();
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao"); // Captura a ação enviada pelo formulário
            String msg = "Operação realizada com sucesso!";
            String idConfParam = request.getParameter("idConf");
            ModelConfiguracao modelConfiguracao = new ModelConfiguracao();

            // Verifica se já existe uma configuração no banco de dados
            List<ModelConfig> configsExistentes = daoConfig.consultarTodasConfigs();
            ModelConfig configExistente = null;

            if (configsExistentes != null && !configsExistentes.isEmpty()) {
                configExistente = configsExistentes.get(0); // Pega a primeira configuração existente
            }

            if ("salario".equals(acao)) {
                // Processamento da ação "salario"
                BigDecimal salario = parseBigDecimal(request.getParameter("salario"));
                BigDecimal comissao = parseBigDecimal(request.getParameter("comissao"));
                BigDecimal fgts = parseBigDecimal(request.getParameter("fgts"));
                BigDecimal inss = parseBigDecimal(request.getParameter("inss"));

                modelConfiguracao.setSalario(salario);
                modelConfiguracao.setComissao(comissao);
                modelConfiguracao.setFgts(fgts);
                modelConfiguracao.setInss(inss);

                // Se já existe uma configuração, define o ID para atualização
                if (configExistente != null) {
                    modelConfiguracao.setIdConf(configExistente.getIdConf());
                }

                // Grava ou atualiza as configurações de salário
                modelConfiguracao = daoConfiguracao.gravarConfig(modelConfiguracao);
            } else if ("cartao".equals(acao)) {
                // Processamento da ação "cartao"
                BigDecimal debVisaMaster = parseBigDecimal(request.getParameter("deb_visa_master"));
                BigDecimal credVisaMaster = parseBigDecimal(request.getParameter("cred_visa_master"));
                BigDecimal debOutros = parseBigDecimal(request.getParameter("deb_outros"));
                BigDecimal credOutros = parseBigDecimal(request.getParameter("cred_outros"));

                modelConfiguracao.setDeb_visa_master(debVisaMaster);
                modelConfiguracao.setCred_visa_master(credVisaMaster);
                modelConfiguracao.setDeb_outros(debOutros);
                modelConfiguracao.setCred_outros(credOutros);

                // Se já existe uma configuração, define o ID para atualização
                if (configExistente != null) {
                    modelConfiguracao.setIdConf(configExistente.getIdConf());
                }

                // Grava ou atualiza as configurações de cartão
                modelConfiguracao = daoConfiguracao.gravarConfigCartao(modelConfiguracao);
            } else {
                request.setAttribute("msg", "Ação inválida!");
                List<ModelConfig> configs = daoConfig.consultarTodasConfigs(); // Recupera todas as configurações
                request.setAttribute("configs", configs); // Adiciona a lista ao request
                request.getRequestDispatcher("/principal/config.jsp").forward(request, response); // Redireciona para a JSP
                return;
            }

            // Se idConfParam estiver presente, define o idConf no modelo
            if (idConfParam != null && !idConfParam.isEmpty()) {
                modelConfiguracao.setIdConf(Long.parseLong(idConfParam));
            }

            request.setAttribute("msg", msg); // Mensagem de sucesso
            List<ModelConfig> configs = daoConfig.consultarTodasConfigs(); // Recupera todas as configurações
            request.setAttribute("configs", configs); // Adiciona a lista ao request
            request.getRequestDispatcher("/principal/config.jsp").forward(request, response); // Redireciona para a JSP
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + e.getMessage()); // Mensagem de erro
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/config.jsp");
            dispatcher.forward(request, response);
        }
    }






    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if (acao == null || acao.isEmpty()) {
            List<ModelConfig> configs = new ArrayList<>();
            List<ModelConfiguracao> configsSalarios = new ArrayList<>();
            List<ModelConfiguracao> configsCartoes = new ArrayList<>();

            try {
                configs = daoConfig.consultarTodasConfigs();
                configsCartoes = daoConfiguracao.consultarJuros();
                configsSalarios = daoConfiguracao.consultarSalarios();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            request.setAttribute("configsCartoes", configsCartoes);
            request.setAttribute("configsSalarios", configsSalarios);
            request.setAttribute("configs", configs); // Adiciona a lista ao request

            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/config.jsp");
            dispatcher.forward(request, response);
        }
    }


    private BigDecimal parseBigDecimal(String value) {
        try {
            return (value != null && !value.isEmpty()) ? new BigDecimal(value) : BigDecimal.ZERO;
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }
}