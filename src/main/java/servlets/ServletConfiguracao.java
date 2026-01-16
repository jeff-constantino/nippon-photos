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
import java.sql.Connection;
import java.util.List;

@WebServlet("/ServletConfiguracao")
public class ServletConfiguracao extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: private DAOConfiguracao daoConfiguracao;
    // ✅ REMOVIDO: private DAOConfig daoConfig;
    // ✅ REMOVIDO: init()

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOConfiguracao daoConfiguracao = new DAOConfiguracao(conn);
        DAOConfig daoConfig = new DAOConfig(conn);

        String acao = request.getParameter("acao");
        String msg = "Operação realizada com sucesso!";

        ModelConfiguracao modelConfiguracao = new ModelConfiguracao();
        List<ModelConfig> configsExistentes = null;
        try {
            configsExistentes = daoConfig.consultarTodasConfigs();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ModelConfig configExistente = (configsExistentes != null && !configsExistentes.isEmpty()) ? configsExistentes.get(0) : null;

        try {
            if ("salario".equals(acao)) {
                BigDecimal salario = parseToBigDecimal(request.getParameter("salario"));
                BigDecimal comissao = parseToBigDecimal(request.getParameter("comissao"));
                BigDecimal fgts = parseToBigDecimal(request.getParameter("fgts"));
                BigDecimal comissao2 = parseToBigDecimal(request.getParameter("comissao2"));

                modelConfiguracao.setSalario(salario);
                modelConfiguracao.setComissao(comissao);
                modelConfiguracao.setFgts(fgts);
                modelConfiguracao.setComissao2(comissao2);

                if (configExistente != null) {
                    modelConfiguracao.setIdconf(configExistente.getIdconf());
                }

                modelConfiguracao.setId_irrf_1(parseToLong(request.getParameter("id_irrf_1")));
                modelConfiguracao.setIrrf_1(parseToBigDecimal(request.getParameter("irrf_1")));
                modelConfiguracao.setParcela_irrf_1(parseToBigDecimal(request.getParameter("parcela_irrf_1")));
                modelConfiguracao.setMin_irrf_1(parseToBigDecimal(request.getParameter("min_irrf_1")));
                modelConfiguracao.setMax_irrf_1(parseToBigDecimal(request.getParameter("max_irrf_1")));
                modelConfiguracao.setId_irrf_2(parseToLong(request.getParameter("id_irrf_2")));
                modelConfiguracao.setIrrf_2(parseToBigDecimal(request.getParameter("irrf_2")));
                modelConfiguracao.setParcela_irrf_2(parseToBigDecimal(request.getParameter("parcela_irrf_2")));
                modelConfiguracao.setMin_irrf_2(parseToBigDecimal(request.getParameter("min_irrf_2")));
                modelConfiguracao.setMax_irrf_2(parseToBigDecimal(request.getParameter("max_irrf_2")));
                modelConfiguracao.setId_irrf_3(parseToLong(request.getParameter("id_irrf_3")));
                modelConfiguracao.setIrrf_3(parseToBigDecimal(request.getParameter("irrf_3")));
                modelConfiguracao.setParcela_irrf_3(parseToBigDecimal(request.getParameter("parcela_irrf_3")));
                modelConfiguracao.setMin_irrf_3(parseToBigDecimal(request.getParameter("min_irrf_3")));
                modelConfiguracao.setMax_irrf_3(parseToBigDecimal(request.getParameter("max_irrf_3")));
                modelConfiguracao.setId_irrf_4(parseToLong(request.getParameter("id_irrf_4")));
                modelConfiguracao.setIrrf_4(parseToBigDecimal(request.getParameter("irrf_4")));
                modelConfiguracao.setParcela_irrf_4(parseToBigDecimal(request.getParameter("parcela_irrf_4")));
                modelConfiguracao.setMin_irrf_4(parseToBigDecimal(request.getParameter("min_irrf_4")));
                modelConfiguracao.setMax_irrf_4(parseToBigDecimal(request.getParameter("max_irrf_4")));

                daoConfiguracao.gravarConfig(modelConfiguracao);
                daoConfiguracao.gravarIrrf(modelConfiguracao);
                msg = "Configurações de Salários e IRRF salvas com sucesso!";

            } else if ("cartao".equals(acao)) {
                BigDecimal debVisaMaster = parseToBigDecimal(request.getParameter("deb_visa_master"));
                BigDecimal credVisaMaster = parseToBigDecimal(request.getParameter("cred_visa_master"));
                BigDecimal debOutros = parseToBigDecimal(request.getParameter("deb_outros"));
                BigDecimal credOutros = parseToBigDecimal(request.getParameter("cred_outros"));

                modelConfiguracao.setDeb_visa_master(debVisaMaster);
                modelConfiguracao.setCred_visa_master(credVisaMaster);
                modelConfiguracao.setDeb_outros(debOutros);
                modelConfiguracao.setCred_outros(credOutros);

                if (configExistente != null) {
                    modelConfiguracao.setIdconf(configExistente.getIdconf());
                }
                daoConfiguracao.gravarConfigCartao(modelConfiguracao);
                msg = "Configurações de Cartão salvas com sucesso!";

            } else if ("inss".equals(acao)) {
                for (int i = 1; i <= 4; i++) {
                    String idStr = request.getParameter("id_inss_" + i);
                    Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);
                    BigDecimal inss = new BigDecimal(request.getParameter("inss_" + i));
                    BigDecimal min = new BigDecimal(request.getParameter("min_inss_" + i));
                    BigDecimal max = new BigDecimal(request.getParameter("max_inss_" + i));
                    BigDecimal parcela = new BigDecimal(request.getParameter("parcela_" + i));
                    daoConfiguracao.salvarOuAtualizarFaixaInss(id, inss, min, max, parcela);
                }
                msg = "Faixas INSS atualizadas com sucesso!";

            } else {
                msg = "Ação inválida!";
            }

        } catch (Exception e) {
            e.printStackTrace();
            msg = "Erro: " + e.getMessage();
        }

        request.setAttribute("msg", msg);
        request.getRequestDispatcher("/ServletConfig").forward(request, response);
    }

    private Long parseToLong(String s) {
        try {
            if (s != null && !s.isEmpty()) {
                return Long.parseLong(s);
            }
            return null;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private BigDecimal parseToBigDecimal(String s) {
        try {
            if (s != null && !s.isEmpty()) {
                return new BigDecimal(s.replace(",", "."));
            }
            return BigDecimal.ZERO;
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
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