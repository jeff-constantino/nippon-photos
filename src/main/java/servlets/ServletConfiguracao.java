package servlets;

import dao.DAOConfig;
import dao.DAOConfiguracao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfiguracao;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/ServletConfiguracao")
public class ServletConfiguracao extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOConfiguracao daoConfiguracao = new DAOConfiguracao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao"); // Captura a ação enviada pelo formulário
            String msg = "Operação realizada com sucesso!";
            String idConfParam = request.getParameter("idConf");
            ModelConfiguracao modelConfiguracao = new ModelConfiguracao();

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


                if (idConfParam != null && !idConfParam.isEmpty()) {
                    modelConfiguracao.setIdConf(Long.parseLong(idConfParam));
                }

                modelConfiguracao = daoConfiguracao.gravarConfig(modelConfiguracao);
                request.setAttribute("msg", msg);
            } else {
                request.setAttribute("msg", "Ação inválida!");
            }

            doGet(request, response); // Redireciona para carregar os dados
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("principal/configuracao.jsp").forward(request, response);
    }

    private BigDecimal parseBigDecimal(String value) {
        try {
            return (value != null && !value.isEmpty()) ? new BigDecimal(value) : BigDecimal.ZERO;
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }
}