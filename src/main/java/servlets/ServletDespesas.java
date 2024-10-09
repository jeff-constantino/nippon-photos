package servlets;

import dao.DAODespesas;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelDespesas;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/ServletDespesas")
public class ServletDespesas extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;

    private DAODespesas daoDespesas;

    // Inicializa o DAODespesas no construtor
    public ServletDespesas() {
        daoDespesas = new DAODespesas();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Busca a lista de despesas dos últimos 60 dias
            List<ModelDespesas> despesasList = daoDespesas.listarDespesasUltimos60Dias();

            // Busca a lista de todas as despesas
            List<ModelDespesas> todasDespesasList = daoDespesas.listarTodasDespesas(); // Você deve implementar este método no DAO

            // Adiciona ambas as listas como atributos da requisição para a JSP
            request.setAttribute("despesasList", despesasList);
            request.setAttribute("todasDespesasList", todasDespesasList);

            // Encaminha para a página JSP que exibe a lista de despesas
            request.getRequestDispatcher("principal/despesas.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Erro ao listar despesas", e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String msg = "";

        try {
            if ("gravarDespesa".equals(acao)) {
                String nomeDespesa = request.getParameter("nome_despesa");
                String descricaoDespesa = request.getParameter("descricao_despesa");
                double valorDespesa = Double.parseDouble(request.getParameter("valor_despesa"));
                String dataString = request.getParameter("data_despesa");

                // Converter a string da data para java.util.Date
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date dataUtil = format.parse(dataString); // Converte para java.util.Date

                // Converte java.util.Date para java.sql.Date
                java.sql.Date dataDespesa = new java.sql.Date(dataUtil.getTime()); // Converte para java.sql.Date

                ModelDespesas novaDespesa = new ModelDespesas();
                novaDespesa.setNome_despesa(nomeDespesa);
                novaDespesa.setDescricao_despesa(descricaoDespesa);
                novaDespesa.setValor_despesa(valorDespesa);
                novaDespesa.setData_despesa(dataDespesa); // Defina a data aqui

                // Chame o método do DAO para gravar a despesa
                daoDespesas.gravarDespesa(novaDespesa);
                msg = "Despesa gravada com sucesso!";
            } else if ("editarDespesa".equals(acao)) {
                // Código para editar a despesa (já existente)

            } else if ("excluirDespesa".equals(acao)) {
                // Código para excluir a despesa
                Long idDespesa = Long.parseLong(request.getParameter("id_despesa"));

                daoDespesas.excluirDespesa(idDespesa);
                msg = "Despesa excluída com sucesso!";
            }
        } catch (Exception e) {
            msg = "Erro ao processar a despesa: " + e.getMessage();
        }

        // Configura a mensagem no request e redireciona de volta para a página de despesas
        request.setAttribute("msg", msg);
        request.getRequestDispatcher("principal/despesas.jsp").forward(request, response);
    }



}
