
package servlets;

import dao.DAOConfig;
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
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

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
            // Encaminha para a página principal sem mudar o endereço no navegador
            RequestDispatcher dispatcher = request.getRequestDispatcher("/principal/fechadia.jsp");
            dispatcher.forward(request, response);
            return; // Importante retornar para evitar que o código continue
        }

        // Inicializa o DAO
        DAOFechaDia daoFechaDia = new DAOFechaDia();



        // Lógica para "buscarfechamento"
        if ("buscarfechamento".equals(acao)) {
            try {
                // Obtém a data da requisição (formato a ser ajustado conforme necessário)
                String dataParam = request.getParameter("data_fechamento");
                Date dataFechamento = Date.valueOf(dataParam); // Certifique-se de que o formato está correto

                // Chama o DAO para buscar os dados de fechamento
                ModelFechaDia fechamento = daoFechaDia.buscarFechamento(dataFechamento); // Passando a data como argumento

                // Adiciona o fechamento na requisição
                request.setAttribute("fechamento", fechamento);


                // Agora, também executa a busca dos valores dos produtos
                try {
                    List<ModelConfig> configs = daoFechaDia.consultarValor();
                    ModelConfig config = configs.isEmpty() ? null : configs.get(0);  // Pega a primeira configuração

                    // Passa os valores de configuração para o JSP
                    if (config != null) {
                        request.setAttribute("conf1_valor", config.getConf1_valor());
                        request.setAttribute("conf2_valor", config.getConf2_valor());
                        request.setAttribute("conf3_valor", config.getConf3_valor());
                    } else {
                        request.setAttribute("produtosErro", "Nenhuma configuração encontrada.");
                    }

                } catch (Exception e) {
                    // Loga a exceção para análise posterior
                    e.printStackTrace();
                    // Envia uma resposta de erro ao cliente
                    request.setAttribute("produtosErro", "Erro ao buscar valores dos produtos.");
                }

            } catch (IllegalArgumentException e) {
                // Tratamento de erro de data inválida
                request.setAttribute("msgErro", "Data inválida: " + e.getMessage());
            } catch (SQLException e) {
                // Tratamento de erro SQL (exemplo: log e mensagem de erro)
                e.printStackTrace(); // Log do erro para análise
                request.setAttribute("msgErro", "Erro ao buscar fechamento: " + e.getMessage());
            } catch (Exception e) {
                // Tratamento de erro genérico (caso surja alguma outra exceção inesperada)
                e.printStackTrace(); // Log do erro para análise
                request.setAttribute("msgErro", "Erro inesperado: " + e.getMessage());
            }

            // Encaminha a requisição para a página JSP após tentar buscar o fechamento
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
            dispatcher.forward(request, response);
            return; // Interrompe a execução após o forward
        }


        // Se a ação for buscaData
        if ("buscaData".equals(acao)) {
            String dataFechamento = request.getParameter("data_fechamento");

            if (dataFechamento != null && !dataFechamento.isEmpty()) {
                try {
                    // Converte a string da data para o tipo Date
                    Date data = Date.valueOf(dataFechamento);

                    // Verifica se há vendas registradas para a data informada
                    if (!daoFechaDia.existeVendaParaData(data)) {
                        request.setAttribute("msg", "Nenhuma venda registrada para essa data");
                    } else {
                        // Verifica se já existe um fechamento para a data informada
                        if (daoFechaDia.verificarExistenciaFechamento(data.toLocalDate())) {
                            request.setAttribute("msg", "Já existe um fechamento para a data informada.");
                        } else {
                            // Chama o DAO para consultar o fechamento por data
                            ModelFechaDia fechamento = daoFechaDia.consultarFechamentoPorData(data);

                            // Verifica se o fechamento foi encontrado
                            if (fechamento != null) {
                                request.setAttribute("fechamento", fechamento);
                                System.out.println(fechamento);
                            } else {
                                request.setAttribute("msg", "Nenhum fechamento encontrado para a data informada."); // Mensagem caso não encontre
                            }

                            // Agora, também executa a busca dos valores dos produtos
                            try {

                                List<ModelConfig> configs = daoFechaDia.consultarValor();
                                ModelConfig config = configs.isEmpty() ? null : configs.get(0);  // Pega a primeira configuração

// Passa os valores de configuração para o JSP
                                request.setAttribute("conf1_valor", config.getConf1_valor());
                                request.setAttribute("conf2_valor", config.getConf2_valor());
                                request.setAttribute("conf3_valor", config.getConf3_valor());
                            } catch (Exception e) {
                                // Loga a exceção para análise posterior
                                e.printStackTrace();
                                // Envia uma resposta de erro ao cliente
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
                request.setAttribute("msg", "Data de fechamento não pode ser vazia."); // Mensagem de erro para o usuário
            }
        } else {
            request.setAttribute("msg", "Ação não reconhecida."); // Mensagem para ações não reconhecidas
        }

// Encaminha a requisição para a página JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
        dispatcher.forward(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModelFechaDia fechamento = new ModelFechaDia();

        try {
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
            fechamento.setSobras(Integer.parseInt(request.getParameter("sobras")));

            // Definindo os valores do ribbon
            fechamento.setRibbon_1_atual(parseOrDefault(request.getParameter("ribbon_1_atual"), 0));
            fechamento.setRibbon_2_atual(parseOrDefault(request.getParameter("ribbon_2_atual"), 0));
            fechamento.setRibbon_3_atual(parseOrDefault(request.getParameter("ribbon_3_atual"), 0));
            fechamento.setRibbon_4_atual(parseOrDefault(request.getParameter("ribbon_4_atual"), 0));
            fechamento.setRibbon_5_atual(parseOrDefault(request.getParameter("ribbon_5_atual"), 0));
            fechamento.setRibbon_6_atual(parseOrDefault(request.getParameter("ribbon_6_atual"), 0));

            // Definindo as diferenças do ribbon
            fechamento.setDif_ribbon_1(parseOrDefault(request.getParameter("dif_ribbon_1"), 0));
            fechamento.setDif_ribbon_2(parseOrDefault(request.getParameter("dif_ribbon_2"), 0));
            fechamento.setDif_ribbon_3(parseOrDefault(request.getParameter("dif_ribbon_3"), 0));
            fechamento.setDif_ribbon_4(parseOrDefault(request.getParameter("dif_ribbon_4"), 0));
            fechamento.setDif_ribbon_5(parseOrDefault(request.getParameter("dif_ribbon_5"), 0));
            fechamento.setDif_ribbon_6(parseOrDefault(request.getParameter("dif_ribbon_6"), 0));

            // Recuperar total_revelado e total_informado
            fechamento.setTotal_revelado(parseOrDefault(request.getParameter("total_rev"), 0));
            fechamento.setTotal_informado(parseOrDefault(request.getParameter("total_inf"), 0));

            // Adicionando os campos old_ribbon
            fechamento.setOld_ribbon_1(parseOrDefault(request.getParameter("old_ribbon_1"), 0));
            fechamento.setOld_ribbon_2(parseOrDefault(request.getParameter("old_ribbon_2"), 0));
            fechamento.setOld_ribbon_3(parseOrDefault(request.getParameter("old_ribbon_3"), 0));
            fechamento.setOld_ribbon_4(parseOrDefault(request.getParameter("old_ribbon_4"), 0));
            fechamento.setOld_ribbon_5(parseOrDefault(request.getParameter("old_ribbon_5"), 0));
            fechamento.setOld_ribbon_6(parseOrDefault(request.getParameter("old_ribbon_6"), 0));

            // Recuperar valores dos novos campos
            fechamento.setValor_din(parseOrDefault(request.getParameter("valor_din"), BigDecimal.ZERO));
            fechamento.setValor_deb(parseOrDefault(request.getParameter("valor_deb"), BigDecimal.ZERO));
            fechamento.setValor_cred(parseOrDefault(request.getParameter("valor_cred"), BigDecimal.ZERO));
            fechamento.setValor_pix(parseOrDefault(request.getParameter("valor_pix"), BigDecimal.ZERO));


            // Recuperando os campos rev_ribbon
            fechamento.setRev_ribbon_1(parseOrDefault(request.getParameter("rev_ribbon_1"), 0));
            fechamento.setRev_ribbon_2(parseOrDefault(request.getParameter("rev_ribbon_2"), 0));
            fechamento.setRev_ribbon_3(parseOrDefault(request.getParameter("rev_ribbon_3"), 0));
            fechamento.setRev_ribbon_4(parseOrDefault(request.getParameter("rev_ribbon_4"), 0));
            fechamento.setRev_ribbon_5(parseOrDefault(request.getParameter("rev_ribbon_5"), 0));
            fechamento.setRev_ribbon_6(parseOrDefault(request.getParameter("rev_ribbon_6"), 0));

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

            // Verifica a ação do botão
            String acao = request.getParameter("acao");

            if ("atualizarFechamento".equals(acao)) {
                // Chama o método para atualizar o fechamento
                try {
                    daoFechaDia.atualizarFechamento(fechamento);
                    request.setAttribute("msg", "Fechamento atualizado com sucesso!"); // Mensagem de sucesso
                } catch (Exception e) {
                    request.setAttribute("msg", "Erro ao atualizar o fechamento: " + e.getMessage()); // Mensagem de erro
                }
            } else {
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
            }

            // Encaminhar para a página apropriada
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            // Tratar exceção global
            request.setAttribute("msg", "Erro ao processar a requisição: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
            dispatcher.forward(request, response);
        }

    }
}