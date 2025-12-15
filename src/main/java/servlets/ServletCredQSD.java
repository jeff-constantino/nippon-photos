package servlets;

import dao.DAOQSD;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelCrediarioQSD;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet ("/ServletCredQSD")
public class ServletCredQSD extends HttpServlet {
    private final DAOQSD dao = new DAOQSD();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        try {
            if ("buscar".equals(acao)) {
                buscar(request, response);
            } else if ("relatorio".equals(acao)) {
                relatorio(request, response);
            } else if ("carregar".equals(acao)) {
                carregar(request, response);
            } else {
                carregarListaClientes(request);
                request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("msg", "Erro: " + e.getMessage());
            request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        try {
            if ("salvar".equals(acao)) {
                salvar(request, response);
            } else if ("receber".equals(acao)) {
                receber(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("msg", "Erro: " + e.getMessage());
            try {
                carregarListaClientes(request);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
        }
    }

    private void salvar(HttpServletRequest request, HttpServletResponse response) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        ModelCrediarioQSD model = new ModelCrediarioQSD();

        model.setCliente(request.getParameter("cliente"));
        model.setEmpresa(request.getParameter("empresa"));
        model.setProdutos(request.getParameter("produtos"));
        model.setValor(new BigDecimal(request.getParameter("valor").replace(",", ".")));
        model.setDatavenda(sdf.parse(request.getParameter("datavenda")));
        model.setDesconto(BigDecimal.ZERO);
        model.setStatus("A Receber");

        dao.gravarQSD(model);

        request.setAttribute("msg", "Crediário lançado com sucesso!");
        carregarListaClientes(request);
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void receber(HttpServletRequest request, HttpServletResponse response) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Long id = Long.parseLong(request.getParameter("id"));
        ModelCrediarioQSD model = dao.buscarPorId(id);

        if (model != null) {
            model.setDatapagamento(sdf.parse(request.getParameter("datapagamento")));
            model.setForma(request.getParameter("forma"));

            String descontoStr = request.getParameter("desconto");
            if (descontoStr != null && !descontoStr.trim().isEmpty()) {
                model.setDesconto(new BigDecimal(descontoStr.replace(",", ".")));
            } else {
                model.setDesconto(BigDecimal.ZERO);
            }

            model.setValorpago(new BigDecimal(request.getParameter("valorpago").replace(",", ".")));
            model.setStatus("Pago");

            dao.gravarQSD(model);

            request.setAttribute("msg", "Pagamento registrado com sucesso!");
        }

        carregarListaClientes(request);
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void buscar(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String nomeBusca = request.getParameter("nomeBusca");
        List<ModelCrediarioQSD> lista;

        if (nomeBusca != null && !nomeBusca.trim().isEmpty()) {
            lista = dao.buscarPorNome(nomeBusca);
        } else {
            lista = dao.buscarTodos();
        }

        request.setAttribute("listaCreditos", lista);
        carregarListaClientes(request);
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void relatorio(HttpServletRequest request, HttpServletResponse response) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String nomeRelatorio = request.getParameter("nomeRelatorio");
        String dataInicioStr = request.getParameter("dataInicio");
        String dataFimStr = request.getParameter("dataFim");

        List<ModelCrediarioQSD> lista;

        if ((nomeRelatorio != null && !nomeRelatorio.trim().isEmpty()) &&
                (dataInicioStr != null && !dataInicioStr.trim().isEmpty()) &&
                (dataFimStr != null && !dataFimStr.trim().isEmpty())) {

            lista = dao.buscarPorNomeEPeriodo(nomeRelatorio,
                    sdf.parse(dataInicioStr), sdf.parse(dataFimStr));

        } else if (dataInicioStr != null && !dataInicioStr.trim().isEmpty() &&
                dataFimStr != null && !dataFimStr.trim().isEmpty()) {

            lista = dao.buscarPorPeriodo(sdf.parse(dataInicioStr), sdf.parse(dataFimStr));

        } else if (nomeRelatorio != null && !nomeRelatorio.trim().isEmpty()) {

            lista = dao.buscarPorNome(nomeRelatorio);

        } else {
            lista = dao.buscarTodos();
        }

        BigDecimal totalRecebido = BigDecimal.ZERO;
        BigDecimal totalAReceber = BigDecimal.ZERO;

        for (ModelCrediarioQSD item : lista) {
            if ("Pago".equals(item.getStatus())) {
                totalRecebido = totalRecebido.add(item.getValorpago() != null ?
                        item.getValorpago() : BigDecimal.ZERO);
            } else {
                totalAReceber = totalAReceber.add(item.getValor());
            }
        }

        request.setAttribute("listaRelatorio", lista);
        request.setAttribute("totalRecebido", totalRecebido);
        request.setAttribute("totalAReceber", totalAReceber);
        carregarListaClientes(request);
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void carregar(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Long id = Long.parseLong(request.getParameter("id"));
        ModelCrediarioQSD model = dao.buscarPorId(id);

        request.setAttribute("modelReceber", model);
        carregarListaClientes(request);
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void carregarListaClientes(HttpServletRequest request) throws Exception {
        List<ModelCrediarioQSD> lista = dao.listarClientesUnicos();
        request.setAttribute("listaClientes", lista);
    }
}