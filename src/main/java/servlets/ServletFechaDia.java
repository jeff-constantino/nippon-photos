package servlets;

import dao.DAOFechaDia;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfig;
import model.ModelFechaDia;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/ServletFechaDia")
public class ServletFechaDia extends ServletGenericUtil {
    // ✅ REMOVIDO: private DAOFechaDia daoFechaDia;
    // ✅ REMOVIDO: private DAOConfig daoConfig;
    // ✅ REMOVIDO: init()

    private int parseOrDefault(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private BigDecimal parseOrDefault(String value, BigDecimal defaultValue) {
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private void carregarDatasNaoFechadas(HttpServletRequest request, Connection conn) {
        try {
            DAOFechaDia dao = new DAOFechaDia(conn);
            List<Date> datasNaoFechadas = dao.buscarDatasNaoFechadas();
            request.setAttribute("datasNaoFechadas", datasNaoFechadas);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("msgErro", "Erro ao buscar datas pendentes: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOFechaDia daoFechaDia = new DAOFechaDia(conn);

        String acao = request.getParameter("acao");
        carregarDatasNaoFechadas(request, conn);

        if (acao == null || acao.isEmpty()) {
            carregarDatasNaoFechadas(request, conn);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/fechadia.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if ("resetfechamento".equals(acao)) {
            try {
                daoFechaDia.resetFechamento();
                request.setAttribute("msg", "Último fechamento apagado com sucesso!");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "Erro ao apagar fechamento: " + e.getMessage());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/fechadia.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if ("buscarfechamento".equals(acao)) {
            try {
                String dataParam = request.getParameter("data_fechamento");
                Date dataFechamento = Date.valueOf(dataParam);
                ModelFechaDia fechamento = daoFechaDia.buscarFechamento(dataFechamento);
                request.setAttribute("fechamento", fechamento);

                try {
                    List<ModelConfig> configs = daoFechaDia.consultarValor();
                    ModelConfig config = configs.isEmpty() ? null : configs.get(0);
                    if (config != null) {
                        request.setAttribute("conf1_valor", config.getConf1_valor());
                        request.setAttribute("conf2_valor", config.getConf2_valor());
                        request.setAttribute("conf3_valor", config.getConf3_valor());
                    } else {
                        request.setAttribute("produtosErro", "Nenhuma configuração encontrada.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("produtosErro", "Erro ao buscar valores dos produtos.");
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgErro", "Data inválida: " + e.getMessage());
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("msgErro", "Erro ao buscar fechamento: " + e.getMessage());
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msgErro", "Erro inesperado: " + e.getMessage());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if ("buscaData".equals(acao)) {
            String dataFechamento = request.getParameter("data_fechamento");
            if (dataFechamento != null && !dataFechamento.isEmpty()) {
                try {
                    Date data = Date.valueOf(dataFechamento);
                    if (!daoFechaDia.existeVendaParaData(data)) {
                        request.setAttribute("msg", "Nenhuma venda registrada para essa data");
                    } else {
                        if (daoFechaDia.verificarExistenciaFechamento(data.toLocalDate())) {
                            request.setAttribute("msg", "Já existe um fechamento para a data informada.");
                        } else {
                            ModelFechaDia fechamento = daoFechaDia.consultarFechamentoPorData(data);
                            if (fechamento != null) {
                                request.setAttribute("fechamento", fechamento);
                            } else {
                                request.setAttribute("msg", "Nenhum fechamento encontrado para a data informada.");
                            }
                            try {
                                List<ModelConfig> configs = daoFechaDia.consultarValor();
                                ModelConfig config = configs.isEmpty() ? null : configs.get(0);
                                if (config != null) {
                                    request.setAttribute("conf1_valor", config.getConf1_valor());
                                    request.setAttribute("conf2_valor", config.getConf2_valor());
                                    request.setAttribute("conf3_valor", config.getConf3_valor());
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                request.setAttribute("produtosErro", "Erro ao buscar valores dos produtos.");
                            }
                        }
                    }
                } catch (IllegalArgumentException e) {
                    request.setAttribute("msg", "Data inválida: " + e.getMessage());
                } catch (Exception e) {
                    request.setAttribute("msg", "Erro ao buscar fechamento: " + e.getMessage());
                }
            } else {
                request.setAttribute("msg", "Data de fechamento não pode ser vazia.");
            }
        } else {
            request.setAttribute("msg", "Ação não reconhecida.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOFechaDia daoFechaDia = new DAOFechaDia(conn);

        ModelFechaDia fechamento = new ModelFechaDia();
        carregarDatasNaoFechadas(request, conn);

        try {
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
            fechamento.setSobras(Integer.parseInt(request.getParameter("sobras")));
            fechamento.setRibbon_1_atual(parseOrDefault(request.getParameter("ribbon_1_atual"), 0));
            fechamento.setRibbon_2_atual(parseOrDefault(request.getParameter("ribbon_2_atual"), 0));
            fechamento.setRibbon_3_atual(parseOrDefault(request.getParameter("ribbon_3_atual"), 0));
            fechamento.setRibbon_4_atual(parseOrDefault(request.getParameter("ribbon_4_atual"), 0));
            fechamento.setRibbon_5_atual(parseOrDefault(request.getParameter("ribbon_5_atual"), 0));
            fechamento.setRibbon_6_atual(parseOrDefault(request.getParameter("ribbon_6_atual"), 0));
            fechamento.setDif_ribbon_1(parseOrDefault(request.getParameter("dif_ribbon_1"), 0));
            fechamento.setDif_ribbon_2(parseOrDefault(request.getParameter("dif_ribbon_2"), 0));
            fechamento.setDif_ribbon_3(parseOrDefault(request.getParameter("dif_ribbon_3"), 0));
            fechamento.setDif_ribbon_4(parseOrDefault(request.getParameter("dif_ribbon_4"), 0));
            fechamento.setDif_ribbon_5(parseOrDefault(request.getParameter("dif_ribbon_5"), 0));
            fechamento.setDif_ribbon_6(parseOrDefault(request.getParameter("dif_ribbon_6"), 0));
            fechamento.setTotal_revelado(parseOrDefault(request.getParameter("total_rev"), 0));
            fechamento.setTotal_informado(parseOrDefault(request.getParameter("total_inf"), 0));
            fechamento.setOld_ribbon_1(parseOrDefault(request.getParameter("old_ribbon_1"), 0));
            fechamento.setOld_ribbon_2(parseOrDefault(request.getParameter("old_ribbon_2"), 0));
            fechamento.setOld_ribbon_3(parseOrDefault(request.getParameter("old_ribbon_3"), 0));
            fechamento.setOld_ribbon_4(parseOrDefault(request.getParameter("old_ribbon_4"), 0));
            fechamento.setOld_ribbon_5(parseOrDefault(request.getParameter("old_ribbon_5"), 0));
            fechamento.setOld_ribbon_6(parseOrDefault(request.getParameter("old_ribbon_6"), 0));
            fechamento.setValor_din(parseOrDefault(request.getParameter("valor_din"), BigDecimal.ZERO));
            fechamento.setValor_deb(parseOrDefault(request.getParameter("valor_deb"), BigDecimal.ZERO));
            fechamento.setValor_cred(parseOrDefault(request.getParameter("valor_cred"), BigDecimal.ZERO));
            fechamento.setValor_pix(parseOrDefault(request.getParameter("valor_pix"), BigDecimal.ZERO));
            fechamento.setRev_ribbon_1(parseOrDefault(request.getParameter("rev_ribbon_1"), 0));
            fechamento.setRev_ribbon_2(parseOrDefault(request.getParameter("rev_ribbon_2"), 0));
            fechamento.setRev_ribbon_3(parseOrDefault(request.getParameter("rev_ribbon_3"), 0));
            fechamento.setRev_ribbon_4(parseOrDefault(request.getParameter("rev_ribbon_4"), 0));
            fechamento.setRev_ribbon_5(parseOrDefault(request.getParameter("rev_ribbon_5"), 0));
            fechamento.setRev_ribbon_6(parseOrDefault(request.getParameter("rev_ribbon_6"), 0));

            String descontoString = request.getParameter("desconto");
            BigDecimal desconto = BigDecimal.ZERO;
            if (descontoString != null && !descontoString.isEmpty()) {
                try {
                    desconto = new BigDecimal(descontoString);
                } catch (NumberFormatException e) {
                }
            }
            fechamento.setDesconto(desconto);
            fechamento.setObservacao(request.getParameter("observacao"));

            String acao = request.getParameter("acao");

            if ("atualizarFechamento".equals(acao)) {
                try {
                    daoFechaDia.atualizarFechamento(fechamento);
                    request.setAttribute("msg", "Fechamento atualizado com sucesso!");
                } catch (Exception e) {
                    request.setAttribute("msg", "Erro ao atualizar o fechamento: " + e.getMessage());
                }
            } else {
                if (daoFechaDia.verificarExistenciaFechamento(fechamento.getData_fechamento().toLocalDate())) {
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                    String dataFormatada = sdf.format(fechamento.getData_fechamento());
                    request.setAttribute("msg", "Já existe um fechamento com a data " + dataFormatada);
                    request.setAttribute("atualizacaoNecessaria", true);
                } else {
                    try {
                        daoFechaDia.gravarFechamento(fechamento);
                        request.setAttribute("msg", "Fechamento gravado com sucesso!");
                    } catch (Exception e) {
                        request.setAttribute("msg", "Erro ao gravar o fechamento: " + e.getMessage());
                    }
                }
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            request.setAttribute("msg", "Erro ao processar a requisição: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
            dispatcher.forward(request, response);
        }
    }
}