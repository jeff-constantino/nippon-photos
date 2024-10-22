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
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ServletFechaDia")
public class ServletFechaDia extends ServletGenericUtil {
    private DAOFechaDia daoFechaDia;
    private DAOConfig daoConfig;
    private static final Logger LOGGER = Logger.getLogger(ServletFechaDia.class.getName()); // Logger para monitorar a execução


    @Override
    public void init() throws ServletException {
        // Inicializa a instância do DAO
        daoFechaDia = new DAOFechaDia();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        LOGGER.info("doGet chamado - Ação recebida: " + acao); // Log para monitorar qual ação está sendo recebida via GET

        // Verifica se a ação é vazia ou nula
        if (acao == null || acao.isEmpty()) {
            // Redireciona para a página principal se a ação não for fornecida
            LOGGER.info("Ação não fornecida, redirecionando para a página principal.");
            response.sendRedirect("principal/fechadia.jsp");
            return; // Importante retornar para evitar que o código continue
        }

        // Se a ação for buscaData
        if ("buscaData".equals(acao)) {
            String dataFechamento = request.getParameter("data_fechamento");
            LOGGER.info("Data recebida para busca: " + dataFechamento); // Log para verificar a data enviada pelo formulário

            if (dataFechamento != null && !dataFechamento.isEmpty()) {
                try {
                    Date data = Date.valueOf(dataFechamento);
                    LOGGER.info("Data convertida para SQL Date: " + data); // Log para verificar a conversão da data

                    // Chama o DAO para consultar o fechamento por data
                    ModelFechaDia fechamento = daoFechaDia.consultarFechamentoPorData(data);
                    LOGGER.info("Fechamento retornado: " + fechamento); // Log para verificar os dados retornados pelo DAO

                    request.setAttribute("fechamento", fechamento);
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Erro ao buscar fechamento", e); // Log detalhado em caso de erro na busca
                    request.setAttribute("msg", "Erro ao buscar fechamento: " + e.getMessage());
                    // Redirecionar para a página de erro ou retornar um erro específico
                    RequestDispatcher dispatcher = request.getRequestDispatcher("erro.jsp"); // Exemplo de página de erro
                    dispatcher.forward(request, response);
                    return; // Importante retornar para evitar que o código continue
                }
            } else {
                LOGGER.warning("Data de fechamento está vazia ou nula"); // Log de alerta se a data não foi preenchida
                request.setAttribute("msg", "Data de fechamento não pode ser vazia."); // Mensagem de erro para o usuário
            }
        } else {
            LOGGER.warning("Ação não reconhecida: " + acao); // Log de alerta se a ação não for reconhecida
            request.setAttribute("msg", "Ação não reconhecida.");
        }

        // Adicionando log antes de encaminhar para a JSP
        LOGGER.info("Encaminhando para a página JSP: principal/fechadia.jsp");

        // Encaminha a requisição para a página JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
        dispatcher.forward(request, response);
    }
}