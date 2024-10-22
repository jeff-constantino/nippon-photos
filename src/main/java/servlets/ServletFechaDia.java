package servlets;

import dao.DAOConfig;
import dao.DAOFechaDia;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelFechaDia;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;

@WebServlet("/ServletFechaDia")
public class ServletFechaDia extends ServletGenericUtil {
    private DAOFechaDia daoFechaDia;
    private DAOConfig daoConfig;


    @Override
    public void init() throws ServletException {
        // Inicializa a instância do DAO
        daoFechaDia = new DAOFechaDia();
    }
    // Método para converter String para int com valor padrão
    private int parseOrDefault(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue; // Retorna o valor padrão em caso de erro
        }
    }

    // Método para converter String para BigDecimal com valor padrão
    private BigDecimal parseOrDefault(String value, BigDecimal defaultValue) {
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException e) {
            return defaultValue; // Retorna o valor padrão em caso de erro
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Redireciona para a página principal se a ação não for fornecida
            response.sendRedirect("principal/fechadia.jsp");
            return; // Importante retornar para evitar que o código continue
        }

        // Se a ação for buscaData
        if ("buscaData".equals(acao)) {
            String dataFechamento = request.getParameter("data_fechamento");

            if (dataFechamento != null && !dataFechamento.isEmpty()) {
                try {
                    Date data = Date.valueOf(dataFechamento);

                    // Chama o DAO para consultar o fechamento por data
                    ModelFechaDia fechamento = daoFechaDia.consultarFechamentoPorData(data);

                    request.setAttribute("fechamento", fechamento);
                } catch (Exception e) {
                    request.setAttribute("msg", "Erro ao buscar fechamento: " + e.getMessage());
                    // Redirecionar para a página de erro ou retornar um erro específico
                    RequestDispatcher dispatcher = request.getRequestDispatcher("erro.jsp"); // Exemplo de página de erro
                    dispatcher.forward(request, response);
                    return; // Importante retornar para evitar que o código continue
                }
            } else {
                request.setAttribute("msg", "Data de fechamento não pode ser vazia."); // Mensagem de erro para o usuário
            }
        } else {
            request.setAttribute("msg", "Ação não reconhecida.");
        }

        // Adicionando log antes de encaminhar para a JSP

        // Encaminha a requisição para a página JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModelFechaDia fechamento = new ModelFechaDia();

        // Recuperar valores dos inputs com checagem
        fechamento.setData_fechamento(Date.valueOf(request.getParameter("data_fechamento")));
        fechamento.setTotal_ft_din(parseOrDefault(request.getParameter("total_ft_din"), 0));
        fechamento.setTotal_ft_deb(parseOrDefault(request.getParameter("total_ft_deb"), 0));
        fechamento.setTotal_ft_cred(parseOrDefault(request.getParameter("total_ft_cred"), 0));
        fechamento.setTotal_ft_pix(parseOrDefault(request.getParameter("total_ft_pix"), 0));
        fechamento.setTotal_enc_din(parseOrDefault(request.getParameter("total_enc_din"), 0));
        fechamento.setTotal_enc_deb(parseOrDefault(request.getParameter("total_enc_deb"), 0));
        fechamento.setTotal_enc_cred(parseOrDefault(request.getParameter("total_enc_cred"), 0));
        fechamento.setTotal_enc_pix(parseOrDefault(request.getParameter("total_enc_pix"), 0));
        fechamento.setTotal_dig_din(parseOrDefault(request.getParameter("total_dig_din"), 0));
        fechamento.setTotal_dig_deb(parseOrDefault(request.getParameter("total_dig_deb"), 0));
        fechamento.setTotal_dig_cred(parseOrDefault(request.getParameter("total_dig_cred"), 0));
        fechamento.setTotal_dig_pix(parseOrDefault(request.getParameter("total_dig_pix"), 0));

        // Definindo os valores do ribbon
        fechamento.setTotal_ribbon_1(parseOrDefault(request.getParameter("ribbon_1_atual"), 0));
        fechamento.setTotal_ribbon_2(parseOrDefault(request.getParameter("ribbon_2_atual"), 0));
        fechamento.setTotal_ribbon_3(parseOrDefault(request.getParameter("ribbon_3_atual"), 0));
        fechamento.setTotal_ribbon_4(parseOrDefault(request.getParameter("ribbon_4_atual"), 0));
        fechamento.setTotal_ribbon_5(parseOrDefault(request.getParameter("ribbon_5_atual"), 0));
        fechamento.setTotal_ribbon_6(parseOrDefault(request.getParameter("ribbon_6_atual"), 0));

        // Definindo as diferenças do ribbon
        fechamento.setDifRibbon1(parseOrDefault(request.getParameter("dif_ribbon_1"), 0));
        fechamento.setDifRibbon2(parseOrDefault(request.getParameter("dif_ribbon_2"), 0));
        fechamento.setDifRibbon3(parseOrDefault(request.getParameter("dif_ribbon_3"), 0));
        fechamento.setDifRibbon4(parseOrDefault(request.getParameter("dif_ribbon_4"), 0));
        fechamento.setDifRibbon5(parseOrDefault(request.getParameter("dif_ribbon_5"), 0));
        fechamento.setDifRibbon6(parseOrDefault(request.getParameter("dif_ribbon_6"), 0));

        // Recuperar total_revelado e total_informado
        fechamento.setTotal_revelado(parseOrDefault(request.getParameter("total_rev"), 0));
        fechamento.setTotal_informado(parseOrDefault(request.getParameter("total_inf"), 0));

        // Outros campos
        String descontoString = request.getParameter("desconto");
        BigDecimal desconto = BigDecimal.ZERO; // Valor padrão

        if (descontoString != null && !descontoString.isEmpty()) {
            try {
                desconto = new BigDecimal(descontoString);
            } catch (NumberFormatException e) {
                // Log ou trate a exceção, se necessário
            }
        }

        fechamento.setDesconto(desconto);
        fechamento.setObservacao(request.getParameter("observacao"));

        // Verifica se já existe um fechamento com a mesma data
        if (daoFechaDia.verificarExistenciaFechamento(fechamento.getData_fechamento().toLocalDate())) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); // Formato desejado
            String dataFormatada = sdf.format(fechamento.getData_fechamento());
            request.setAttribute("msg", "Já existe um fechamento com a data " + dataFormatada);
            request.setAttribute("atualizacaoNecessaria", true); // Indica que uma atualização é necessária
        } else {
            // Gravar no banco de dados
            try {
                daoFechaDia.gravarFechamento(fechamento);
                request.setAttribute("msg", "Fechamento gravado com sucesso!"); // Mensagem de sucesso
            } catch (Exception e) {
                request.setAttribute("msg", "Erro ao gravar o fechamento: " + e.getMessage()); // Mensagem de erro
            }
        }

        // Encaminhar para a página apropriada
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
        dispatcher.forward(request, response);
    }


}