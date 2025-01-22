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
import java.sql.Date;
import java.time.LocalDate;

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
            if ("buscaFechamentoDiario".equals(acao)) {
                buscarFechamentoPorData(request, response);
            } else if ("buscaConfDiario".equals(acao)) {
                buscarConferenciaPorData(request, response);
            } else {

                // Usa o forward ao invés de sendRedirect
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Caso ocorra um erro, a mensagem é configurada e passada para o JSP
            request.setAttribute("msg", "Erro: " + e.getMessage());
            // Usa o forward ao invés de sendRedirect
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        }
    }

    private void buscarFechamentoPorData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dataFechamento = request.getParameter("data_fechamento");
        Date dataFechamentoDate = Date.valueOf(dataFechamento);

        // DAO para buscar a conferência pela data
        DAOConfDiario dao = new DAOConfDiario();

        // Verifica se a conferência já foi realizada para a data informada
        if (dao.existeConferenciaParaData(dataFechamentoDate)) {
            request.setAttribute("msg", "Conferência já realizada para essa data");
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        } else {
            // Se não houver conferência para a data, busca a conferência
            ModelConfDiario conf = dao.buscarPorData(dataFechamentoDate);

            if (conf != null) {
                // Armazena o objeto conf no request para ser acessado no JSP
                request.setAttribute("conf_diario", conf);
                System.out.println(conf.toString());


                // Use forward em vez de sendRedirect
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            } else {
                // Caso não encontre a conferência, define uma mensagem de erro
                request.setAttribute("msg", "Nenhum fechamento encontrado para a data informada.");

                // Redireciona de volta para o JSP com a mensagem de erro
                request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
            }
        }
    }

    private void buscarConferenciaPorData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dataFechamento = request.getParameter("data_conferencia");

        // DAO para buscar a conferência pela data
        DAOConfDiario dao = new DAOConfDiario();
        ModelConfDiario conf = dao.buscarConferenciaPorData(Date.valueOf(dataFechamento));

        if (conf != null) {
            // Armazena o objeto conf no request para ser acessado no JSP
            request.setAttribute("conf_diario", conf);



            // Use forward em vez de sendRedirect
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
            // Chamando o método para atualizar a conferência
            atualizarConferencia(request, response);

            // Mensagem de sucesso enviada no redirecionamento
            request.setAttribute("msg", "Conferência do dia Confirmada com sucesso!");
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        } catch (Exception e) {
            // Em caso de erro, exibe a mensagem de erro
            e.printStackTrace();

            // Mensagem de erro enviada no redirecionamento
            request.setAttribute("msg", "Erro: " + URLEncoder.encode(e.getMessage(), "UTF-8"));
            request.getRequestDispatcher("/principal/confDiario.jsp").forward(request, response);
        }
    }


    private void atualizarConferencia(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ModelConfDiario confDiario = new ModelConfDiario();

            // Preenchendo os dados do ModelConfDiario
            confDiario.setId(Long.parseLong(request.getParameter("id"))); // Recuperando o ID para atualização

            // Atribuindo os valores aos campos
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


            // Converte a String para LocalDate para 'data_fechamento'
            String dataString = request.getParameter("data_fechamento");
            LocalDate localDate = LocalDate.parse(dataString);
            confDiario.setData_fechamento(localDate);

            // Atribui valores numéricos inteiros
            confDiario.setTotal_revelado(Integer.parseInt(request.getParameter("total_revelado")));
            confDiario.setTotal_informado(Integer.parseInt(request.getParameter("total_informado")));


            // Campos adicionais de ribbon e sobras
            confDiario.setRibbon_1_atual(Integer.parseInt(request.getParameter("ribbon_1_atual")));
            confDiario.setRibbon_2_atual(Integer.parseInt(request.getParameter("ribbon_2_atual")));
            confDiario.setRibbon_3_atual(Integer.parseInt(request.getParameter("ribbon_3_atual")));
            confDiario.setRibbon_4_atual(Integer.parseInt(request.getParameter("ribbon_4_atual")));
            confDiario.setRibbon_5_atual(Integer.parseInt(request.getParameter("ribbon_5_atual")));
            confDiario.setRibbon_6_atual(Integer.parseInt(request.getParameter("ribbon_6_atual")));
            confDiario.setSobras(Integer.parseInt(request.getParameter("sobras")));

            // Diferenças de ribbon
            confDiario.setDif_ribbon_1(Integer.parseInt(request.getParameter("dif_ribbon_1")));
            confDiario.setDif_ribbon_2(Integer.parseInt(request.getParameter("dif_ribbon_2")));
            confDiario.setDif_ribbon_3(Integer.parseInt(request.getParameter("dif_ribbon_3")));
            confDiario.setDif_ribbon_4(Integer.parseInt(request.getParameter("dif_ribbon_4")));
            confDiario.setDif_ribbon_5(Integer.parseInt(request.getParameter("dif_ribbon_5")));
            confDiario.setDif_ribbon_6(Integer.parseInt(request.getParameter("dif_ribbon_6")));

            //ribbon revelado
            confDiario.setRev_ribbon_1(Integer.parseInt(request.getParameter("rev_ribbon_1")));
            confDiario.setRev_ribbon_2(Integer.parseInt(request.getParameter("rev_ribbon_2")));
            confDiario.setRev_ribbon_3(Integer.parseInt(request.getParameter("rev_ribbon_3")));
            confDiario.setRev_ribbon_4(Integer.parseInt(request.getParameter("rev_ribbon_4")));
            confDiario.setRev_ribbon_5(Integer.parseInt(request.getParameter("rev_ribbon_5")));
            confDiario.setRev_ribbon_6(Integer.parseInt(request.getParameter("rev_ribbon_6")));

            // ribbon antigo
            confDiario.setOld_ribbon_1(Integer.parseInt(request.getParameter("old_ribbon_1")));
            confDiario.setOld_ribbon_2(Integer.parseInt(request.getParameter("old_ribbon_2")));
            confDiario.setOld_ribbon_3(Integer.parseInt(request.getParameter("old_ribbon_3")));
            confDiario.setOld_ribbon_4(Integer.parseInt(request.getParameter("old_ribbon_4")));
            confDiario.setOld_ribbon_5(Integer.parseInt(request.getParameter("old_ribbon_5")));
            confDiario.setOld_ribbon_6(Integer.parseInt(request.getParameter("old_ribbon_6")));
            confDiario.setObservacao_ribbon(request.getParameter("observacao_ribbon"));

            // Chama o método de atualização do DAO
            daoConfDiario.atualizarConfiguracao(confDiario);

            // Passando a mensagem de sucesso para ser exibida após o redirecionamento
            request.setAttribute("msg", "Conferência atualizada com sucesso!");

            // Não faça nada aqui, apenas retorne para o método doPost
        } catch (Exception e) {
            e.printStackTrace();
            // Se ocorrer um erro, define a mensagem de erro
            request.setAttribute("msg", "Erro inesperado: " + e.getMessage());
        }
    }


}
