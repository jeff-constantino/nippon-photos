package servlets;

import com.google.gson.Gson;
import dao.DAOConfDiario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfDiario;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/ServletConfDiario")
public class ServletConfDiario extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DAOConfDiario daoConfDiario;

    public ServletConfDiario() {
        super();
        daoConfDiario = new DAOConfDiario();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        try {
            if ("buscaConfDiario".equals(acao)) {
                buscarConferenciaPorData(request, response);
            } else {
//                request.setAttribute("msg", "Ação inválida!");
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);


            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + e.getMessage());
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            

        }
    }

    private void buscarConferenciaPorData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dataFechamento = request.getParameter("data_fechamento");

        // DAO para buscar a conferência pela data
        DAOConfDiario dao = new DAOConfDiario();
        ModelConfDiario conf = dao.buscarPorData(Date.valueOf(dataFechamento));

        if (conf != null) {
            // Armazena o objeto conf no request para ser acessado no JSP
            request.setAttribute("conf_diario", conf);


            // Redireciona para a página de configuração (configuracao.jsp)
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        } else {
            // Caso não encontre a conferência, define uma mensagem de erro
            request.setAttribute("msg", "Nenhuma conferência encontrada para a data informada.");

            // Redireciona de volta para o JSP com a mensagem de erro
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        }
    }




    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            atualizarConferencia(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + e.getMessage());
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);

        }
    }



    private void atualizarConferencia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ModelConfDiario confDiario = new ModelConfDiario();

            // Preenchendo os dados do ModelConfDiario
            confDiario.setId(Long.parseLong(request.getParameter("id"))); // Recuperando o ID para atualização
            confDiario.setValor_din(new BigDecimal(request.getParameter("valor_din")));
            confDiario.setValor_din_real(new BigDecimal(request.getParameter("valor_din_real")));
            confDiario.setValor_din_dif(new BigDecimal(request.getParameter("valor_din_dif")));
            confDiario.setValor_deb(new BigDecimal(request.getParameter("valor_deb")));
            confDiario.setValor_deb_real(new BigDecimal(request.getParameter("valor_deb_real")));
            confDiario.setValor_deb_dif(new BigDecimal(request.getParameter("valor_deb_dif")));
            confDiario.setValor_cred(new BigDecimal(request.getParameter("valor_cred")));
            confDiario.setValor_cred_real(new BigDecimal(request.getParameter("valor_cred_real")));
            confDiario.setValor_cred_dif(new BigDecimal(request.getParameter("valor_cred_dif")));
            confDiario.setValor_pix(new BigDecimal(request.getParameter("valor_pix")));
            confDiario.setValor_pix_real(new BigDecimal(request.getParameter("valor_pix_real")));
            confDiario.setValor_pix_dif(new BigDecimal(request.getParameter("valor_pix_dif")));
            confDiario.setValor_despesa_total(new BigDecimal(request.getParameter("valor_despesa_total")));
            confDiario.setValor_vale_total(new BigDecimal(request.getParameter("valor_vale_total")));
            confDiario.setValor_descontos(new BigDecimal(request.getParameter("valor_descontos")));
            confDiario.setValor_total_dia(new BigDecimal(request.getParameter("valor_total_dia")));
            confDiario.setObservacao(request.getParameter("observacao"));
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            confDiario.setData_fechamento(Date.valueOf(LocalDate.parse(request.getParameter("data_fechamento"), formatter)));
            confDiario.setTotal_revelado(Integer.parseInt(request.getParameter("total_revelado")));
            confDiario.setTotal_informado(Integer.parseInt(request.getParameter("total_informado")));
            confDiario.setValor_deb_24h(new BigDecimal(request.getParameter("valor_deb_24h")));
            confDiario.setValor_cred_24h(new BigDecimal(request.getParameter("valor_cred_24h")));

            // Chama o método atualizar do DAO
            daoConfDiario.atualizarConfiguracao(confDiario);
            request.setAttribute("msg", "Configuração do dia atualizada com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro inesperado: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/ServletConfDiario");
    }
}
