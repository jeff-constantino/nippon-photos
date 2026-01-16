package servlets;

import dao.DAOConfDiario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfDiario;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/ServletConfDiario")
public class ServletConfDiario extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ REMOVIDO: private final DAOConfDiario daoConfDiario;
    // ✅ REMOVIDO: constructor

    private void carregarConfNaoFechadas(HttpServletRequest request, Connection conn) {
        try {
            DAOConfDiario dao = new DAOConfDiario(conn);
            List<Date> confNaoFechadas = dao.buscarConfNaoFechadas();
            request.setAttribute("confNaoFechadas", confNaoFechadas);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msgErro", "Erro ao buscar datas pendentes: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOConfDiario dao = new DAOConfDiario(conn);
        String acao = request.getParameter("acao");
        carregarConfNaoFechadas(request, conn);

        try {
            if ("buscaFechamentoDiario".equals(acao)) {
                buscarFechamentoPorData(request, response, dao);
            } else if ("buscaConfDiario".equals(acao)) {
                buscarConferenciaPorData(request, response, dao);
            } else {
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + e.getMessage());
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        }
    }

    private void buscarFechamentoPorData(HttpServletRequest request, HttpServletResponse response, DAOConfDiario dao) throws Exception {
        String dataFechamento = request.getParameter("data_fechamento");
        Date dataFechamentoDate = Date.valueOf(dataFechamento);

        if (dao.existeConferenciaParaData(dataFechamentoDate)) {
            request.setAttribute("msg", "Conferência já realizada para essa data");
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        } else {
            ModelConfDiario conf = dao.buscarPorData(dataFechamentoDate);
            if (conf != null) {
                request.setAttribute("conf_diario", conf);
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "Nenhum fechamento encontrado para a data informada.");
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            }
        }
    }

    private void buscarConferenciaPorData(HttpServletRequest request, HttpServletResponse response, DAOConfDiario dao) throws Exception {
        String dataFechamento = request.getParameter("data_conferencia");
        ModelConfDiario conf = dao.buscarConferenciaPorData(Date.valueOf(dataFechamento));

        if (conf != null) {
            request.setAttribute("conf_diario", conf);
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Nenhuma conferência encontrada para a data informada.");
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOConfDiario dao = new DAOConfDiario(conn);
        carregarConfNaoFechadas(request, conn);

        try {
            atualizarConferencia(request, response, dao);
            request.setAttribute("msg", "Conferência do dia Confirmada com sucesso!");
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro: " + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        }
    }

    private void atualizarConferencia(HttpServletRequest request, HttpServletResponse response, DAOConfDiario dao) throws ServletException, IOException {
        try {
            ModelConfDiario confDiario = new ModelConfDiario();
            confDiario.setId(Long.parseLong(request.getParameter("id")));
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
            confDiario.setDesconto(new BigDecimal(request.getParameter("desconto")));
            confDiario.setVenda_total_dia(new BigDecimal(request.getParameter("venda_total_dia")));
            confDiario.setObservacao(request.getParameter("observacao"));

            String dataString = request.getParameter("data_fechamento");
            LocalDate localDate = LocalDate.parse(dataString);
            confDiario.setData_fechamento(localDate);

            confDiario.setTotal_revelado(Integer.parseInt(request.getParameter("total_revelado")));
            confDiario.setTotal_informado(Integer.parseInt(request.getParameter("total_informado")));
            confDiario.setRibbon_1_atual(Integer.parseInt(request.getParameter("ribbon_1_atual")));
            confDiario.setRibbon_2_atual(Integer.parseInt(request.getParameter("ribbon_2_atual")));
            confDiario.setRibbon_3_atual(Integer.parseInt(request.getParameter("ribbon_3_atual")));
            confDiario.setRibbon_4_atual(Integer.parseInt(request.getParameter("ribbon_4_atual")));
            confDiario.setRibbon_5_atual(Integer.parseInt(request.getParameter("ribbon_5_atual")));
            confDiario.setRibbon_6_atual(Integer.parseInt(request.getParameter("ribbon_6_atual")));
            confDiario.setSobras(Integer.parseInt(request.getParameter("sobras")));
            confDiario.setDif_ribbon_1(Integer.parseInt(request.getParameter("dif_ribbon_1")));
            confDiario.setDif_ribbon_2(Integer.parseInt(request.getParameter("dif_ribbon_2")));
            confDiario.setDif_ribbon_3(Integer.parseInt(request.getParameter("dif_ribbon_3")));
            confDiario.setDif_ribbon_4(Integer.parseInt(request.getParameter("dif_ribbon_4")));
            confDiario.setDif_ribbon_5(Integer.parseInt(request.getParameter("dif_ribbon_5")));
            confDiario.setDif_ribbon_6(Integer.parseInt(request.getParameter("dif_ribbon_6")));
            confDiario.setRev_ribbon_1(Integer.parseInt(request.getParameter("rev_ribbon_1")));
            confDiario.setRev_ribbon_2(Integer.parseInt(request.getParameter("rev_ribbon_2")));
            confDiario.setRev_ribbon_3(Integer.parseInt(request.getParameter("rev_ribbon_3")));
            confDiario.setRev_ribbon_4(Integer.parseInt(request.getParameter("rev_ribbon_4")));
            confDiario.setRev_ribbon_5(Integer.parseInt(request.getParameter("rev_ribbon_5")));
            confDiario.setRev_ribbon_6(Integer.parseInt(request.getParameter("rev_ribbon_6")));
            confDiario.setOld_ribbon_1(Integer.parseInt(request.getParameter("old_ribbon_1")));
            confDiario.setOld_ribbon_2(Integer.parseInt(request.getParameter("old_ribbon_2")));
            confDiario.setOld_ribbon_3(Integer.parseInt(request.getParameter("old_ribbon_3")));
            confDiario.setOld_ribbon_4(Integer.parseInt(request.getParameter("old_ribbon_4")));
            confDiario.setOld_ribbon_5(Integer.parseInt(request.getParameter("old_ribbon_5")));
            confDiario.setOld_ribbon_6(Integer.parseInt(request.getParameter("old_ribbon_6")));
            confDiario.setObservacao_ribbon(request.getParameter("observacao_ribbon"));

            dao.atualizarConfiguracao(confDiario);
            request.setAttribute("msg", "Conferência atualizada com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Erro inesperado: " + e.getMessage());
        }
    }
}