package servlets;

import com.google.gson.Gson;
import dao.DAOFechaDia;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelConfig;
import model.ModelFechaDia;
import model.ModelVendas;
import util.DateUtil;
import model.ModelConfig;
import dao.DAOConfig;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
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

@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("buscaData".equals(acao)) {
            String dataFechamento = request.getParameter("data_fechamento");

            if (dataFechamento != null && !dataFechamento.isEmpty()) {
                try {
                    // Converte a string da data para o formato adequado
                    Date data = Date.valueOf(dataFechamento);

                    // Chama o DAO para consultar o fechamento por data
                    ModelFechaDia fechamento = daoFechaDia.consultarFechamentoPorData(data);

                    // Adiciona o fechamento ao request para exibir no JSP
                    request.setAttribute("fechamento", fechamento);

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("msg", "Erro ao buscar fechamento: " + e.getMessage());
                }
            }
        }

        // Redireciona para a página JSP onde os resultados serão exibidos
        RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
        dispatcher.forward(request, response);
    }
@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Você pode deixar o método doPost vazio ou remover se não for necessário
    }
}
