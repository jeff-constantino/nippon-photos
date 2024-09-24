package servlets;

import dao.DAOVendasRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelVendas;

import java.io.IOException;

@WebServlet ("/ServletVendas")
public class ServletVendas extends ServletGenericUtil {
    private static final long serialVersionUID = 1L;
    private DAOVendasRepository daoVendas = new DAOVendasRepository();


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String acao = request.getParameter("acao");
if (acao != null && !acao.isEmpty() && acao.equals("deletar")) {
    String venda_id = request.getParameter("venda_id");


}


    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
try {
    String venda_id = request.getParameter("venda_id");
    String nome = request.getParameter("nome");
    String vendedor_id_str = request.getParameter("vendedor_id"); // O id do vendedor pai (de model_login)

// Colocar todos os dados do banco de dados

    ModelVendas modelVendas = new ModelVendas();
    modelVendas.setVenda_id(venda_id != null && !venda_id.isEmpty() ? Long.parseLong(venda_id) : null);

// Verifica se o vendedor_id_str não é nulo ou vazio e converte para Long, se válido
    Long vendedor_id = vendedor_id_str != null && !vendedor_id_str.isEmpty() ? Long.parseLong(vendedor_id_str) : null;
    modelVendas.setVendedor_id(vendedor_id);  // Atribuindo o id correto (chave estrangeira vendedor_id)

    modelVendas.setNome(nome);


//colocar todos do BD
   modelVendas = daoVendas.gravarVenda(modelVendas);
//   se não funcionar retira o modelVendas


    request.setAttribute("msg", "Venda gravada com sucesso!");
    request.setAttribute("modelVendas", modelVendas); // para redirecionar com os dados na tela
    request.getRequestDispatcher("principal/vendas.jsp").forward(request, response);
}catch (Exception e) {
    e.printStackTrace();
    RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");/*redireciona*/
    request.setAttribute("msg", e.getMessage());
    redirecionar.forward(request, response);
}
}
}


