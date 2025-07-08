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


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");
            String msg = "Operação realizada com sucesso!";
            String idConfParam = request.getParameter("idConf");
            ModelConfiguracao modelConfiguracao = new ModelConfiguracao();

            // Verifica se já existe uma configuração
            List<ModelConfig> configsExistentes = daoConfig.consultarTodasConfigs();
            ModelConfig configExistente = (configsExistentes != null && !configsExistentes.isEmpty())
                    ? configsExistentes.get(0) : null;

            if ("salario".equals(acao)) {
                BigDecimal salario = parseBigDecimal(request.getParameter("salario"));
                BigDecimal comissao = parseBigDecimal(request.getParameter("comissao"));
                BigDecimal fgts = parseBigDecimal(request.getParameter("fgts"));
                BigDecimal inss = parseBigDecimal(request.getParameter("inss"));

                modelConfiguracao.setSalario(salario);
                modelConfiguracao.setComissao(comissao);
                modelConfiguracao.setFgts(fgts);
                modelConfiguracao.setInss(inss);

                if (configExistente != null) {
                    modelConfiguracao.setIdConf(configExistente.getIdConf());
                }

                daoConfiguracao.gravarConfig(modelConfiguracao);

            } else if ("cartao".equals(acao)) {
                BigDecimal debVisaMaster = parseBigDecimal(request.getParameter("deb_visa_master"));
                BigDecimal credVisaMaster = parseBigDecimal(request.getParameter("cred_visa_master"));
                BigDecimal debOutros = parseBigDecimal(request.getParameter("deb_outros"));
                BigDecimal credOutros = parseBigDecimal(request.getParameter("cred_outros"));

                modelConfiguracao.setDeb_visa_master(debVisaMaster);
                modelConfiguracao.setCred_visa_master(credVisaMaster);
                modelConfiguracao.setDeb_outros(debOutros);
                modelConfiguracao.setCred_outros(credOutros);

                if (configExistente != null) {
                    modelConfiguracao.setIdConf(configExistente.getIdConf());
                }

                daoConfiguracao.gravarConfigCartao(modelConfiguracao);

            } else if ("inss".equals(acao)) {
                for (int i = 1; i <= 4; i++) {
                    String idStr = request.getParameter("id_inss_" + i);
                    Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);
                    BigDecimal inss = new BigDecimal(request.getParameter("inss_" + i));
                    BigDecimal min = new BigDecimal(request.getParameter("min_inss_" + i));
                    BigDecimal max = new BigDecimal(request.getParameter("max_inss_" + i));

                    daoConfiguracao.salvarOuAtualizarFaixaInss(id, inss, min, max);
                }

                msg = "Faixas INSS atualizadas com sucesso!";

            } else {
                request.setAttribute("msg", "Ação inválida!");
                request.getRequestDispatcher("/ServletConfig").forward(request, response);
                return;
            }

            if (idConfParam != null && !idConfParam.isEmpty()) {
                modelConfiguracao.setIdConf(Long.parseLong(idConfParam));
            }

            // Redireciona para a ServletConfig para recarregar os dados
            request.setAttribute("msg", msg);
            request.getRequestDispatcher("/ServletConfig").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + e.getMessage());
            request.getRequestDispatcher("/ServletConfig").forward(request, response);
        }
    }







    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/ServletConfig");
    }




    private BigDecimal parseBigDecimal(String value) {
        try {
            return (value != null && !value.isEmpty()) ? new BigDecimal(value) : BigDecimal.ZERO;
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }
}