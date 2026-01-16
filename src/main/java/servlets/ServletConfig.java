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
import java.math.RoundingMode;
import java.sql.Connection;
import java.util.List;

@WebServlet("/ServletConfig")
public class ServletConfig extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: private DAOConfig daoConfig;
    // ✅ REMOVIDO: private DAOConfiguracao daoConfiguracao;
    // ✅ REMOVIDO: init()

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOConfig daoConfig = new DAOConfig(conn);
        DAOConfiguracao daoConfiguracao = new DAOConfiguracao(conn);

        try {
            List<ModelConfig> configs = daoConfig.consultarTodasConfigs();
            List<ModelConfiguracao> configsSalarios = daoConfiguracao.consultarSalarios();
            List<ModelConfiguracao> configsJuros = daoConfiguracao.consultarJuros();
            ModelConfiguracao configInss = daoConfiguracao.buscarFaixasInss();
            ModelConfiguracao configIrrf = daoConfiguracao.buscarFaixasIrrf();
            List<ModelConfig> materiaisFixos = daoConfig.carregarMateriaisFixos();

            ModelConfig[] materiais = new ModelConfig[3];
            for (int i = 0; i < 3; i++) {
                materiais[i] = new ModelConfig();
            }
            for (ModelConfig material : materiaisFixos) {
                int index = (int) (material.getIdconf() - 1);
                if (index >= 0 && index < 3) {
                    materiais[index] = material;
                }
            }

            request.setAttribute("configsJuros", configsJuros);
            request.setAttribute("configsSalarios", configsSalarios);
            request.setAttribute("configs", configs);
            request.setAttribute("configInss", configInss);
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
        Connection conn = (Connection) request.getAttribute("connection");
        DAOConfig daoConfig = new DAOConfig(conn);
        DAOConfiguracao daoConfiguracao = new DAOConfiguracao(conn);

        try {
            String tipoConfig = request.getParameter("tipo_config");
            String acao = request.getParameter("acao");

            if ("limparMsg".equals(acao)) {
                request.getSession().removeAttribute("msg");
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                return;
            }

            if ("materiais".equals(tipoConfig)) {
                processarMateriais(request, daoConfig);
                request.setAttribute("msg", "Materiais gravados com sucesso!");
                doGet(request, response);
                return;
            }

            if ("cartao".equals(acao)) {
                processarJurosCartao(request, daoConfiguracao);
                request.setAttribute("msg", "Juros de cartão atualizados com sucesso!");
                doGet(request, response);
                return;
            }

            String idconfParam = request.getParameter("idconf");
            ModelConfig modelConfig = new ModelConfig();

            if (idconfParam != null && !idconfParam.isEmpty()) {
                long id = Long.parseLong(idconfParam);
                if (id > 0) {
                    modelConfig.setIdconf(id);
                }
            }

            modelConfig.setConf1_nome(request.getParameter("conf1_nome"));
            modelConfig.setConf2_nome(request.getParameter("conf2_nome"));
            modelConfig.setConf3_nome(request.getParameter("conf3_nome"));
            modelConfig.setConf4_nome(request.getParameter("conf4_nome"));
            modelConfig.setConf_name(request.getParameter("conf_name"));
            modelConfig.setConf1_valor(parseBigDecimal(request.getParameter("conf1_valor")));
            modelConfig.setConf1_valor2(parseBigDecimal(request.getParameter("conf1_valor2")));
            modelConfig.setConf2_valor(parseBigDecimal(request.getParameter("conf2_valor")));
            modelConfig.setConf3_valor(parseBigDecimal(request.getParameter("conf3_valor")));
            modelConfig.setConf4_valor(parseBigDecimal(request.getParameter("conf4_valor")));
            modelConfig.setConf1_custo(parseBigDecimal(request.getParameter("conf1_custo")));
            modelConfig.setConf2_custo(parseBigDecimal(request.getParameter("conf2_custo")));
            modelConfig.setConf3_custo(parseBigDecimal(request.getParameter("conf3_custo")));
            modelConfig.setConf4_custo(parseBigDecimal(request.getParameter("conf4_custo")));
            modelConfig.setConf1_qtd(parseIntOrDefault(request.getParameter("conf1_qtd")));
            modelConfig.setConf2_qtd(parseIntOrDefault(request.getParameter("conf2_qtd")));
            modelConfig.setConf3_qtd(parseIntOrDefault(request.getParameter("conf3_qtd")));
            modelConfig.setConf4_qtd(parseIntOrDefault(request.getParameter("conf4_qtd")));

            modelConfig = daoConfig.gravarConfig(modelConfig);

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
            doGet(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    private int parseIntOrDefault(String value) {
        if (value != null && !value.isEmpty()) {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                return 0;
            }
        }
        return 0;
    }

    private BigDecimal parseBigDecimal(String value) {
        if (value != null && !value.isEmpty()) {
            try {
                value = value.replace(",", ".");
                return new BigDecimal(value);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                return BigDecimal.ZERO;
            }
        }
        return BigDecimal.ZERO;
    }

    private void processarMateriais(HttpServletRequest request, DAOConfig daoConfig) throws Exception {
        String nome1 = request.getParameter("conf1_nome");
        String valor1 = request.getParameter("conf1_valor");
        String qtd1 = request.getParameter("conf1_qtd");
        String custo1 = request.getParameter("conf1_custo");
        String nome2 = request.getParameter("conf2_nome");
        String valor2 = request.getParameter("conf2_valor");
        String qtd2 = request.getParameter("conf2_qtd");
        String custo2 = request.getParameter("conf2_custo");
        String nome3 = request.getParameter("conf3_nome");
        String valor3 = request.getParameter("conf3_valor");
        String qtd3 = request.getParameter("conf3_qtd");
        String custo3 = request.getParameter("conf3_custo");

        daoConfig.salvarMateriaisFixos(nome1, valor1, qtd1, custo1, nome2, valor2, qtd2, custo2, nome3, valor3, qtd3, custo3);
    }

    private void processarJurosCartao(HttpServletRequest request, DAOConfiguracao daoConfiguracao) throws Exception {
        String idconf = request.getParameter("idconf");
        String debVisaMaster = request.getParameter("deb_visa_master");
        String credVisaMaster = request.getParameter("cred_visa_master");
        String debOutros = request.getParameter("deb_outros");
        String credOutros = request.getParameter("cred_outros");

        ModelConfiguracao modelConfig = new ModelConfiguracao();
        if (idconf != null && !idconf.isEmpty()) {
            modelConfig.setIdconf(Long.parseLong(idconf));
        }

        modelConfig.setDeb_visa_master(dividirPor100(debVisaMaster));
        modelConfig.setCred_visa_master(dividirPor100(credVisaMaster));
        modelConfig.setDeb_outros(dividirPor100(debOutros));
        modelConfig.setCred_outros(dividirPor100(credOutros));

        daoConfiguracao.atualizarJurosCartao(modelConfig);
    }

    private BigDecimal dividirPor100(String valor) {
        if (valor != null && !valor.isEmpty()) {
            try {
                valor = valor.replace(",", ".");
                BigDecimal valorDecimal = new BigDecimal(valor);
                return valorDecimal.divide(new BigDecimal("100"), 4, RoundingMode.HALF_UP);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                return BigDecimal.ZERO;
            }
        }
        return BigDecimal.ZERO;
    }
}