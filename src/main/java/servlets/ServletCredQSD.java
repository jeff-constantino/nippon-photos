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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
                request.setAttribute("listaClientes", dao.getClientesUnicos());
                request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
            }
        } catch (Exception e) {
            try {
                request.setAttribute("listaClientes", dao.getClientesUnicos());
            } catch (Exception ex) {
                // Ignorar erro ao carregar lista de clientes em caso de falha
            }
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
            try {
                request.setAttribute("listaClientes", dao.getClientesUnicos());
            } catch (Exception ex) {
                // Ignorar erro ao carregar lista de clientes em caso de falha
            }
            request.setAttribute("msg", "Erro: " + e.getMessage());
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
        try {
            request.setAttribute("listaClientes", dao.getClientesUnicos());
        } catch (Exception ex) {
            // Ignorar erro ao carregar lista de clientes
        }
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

        try {
            request.setAttribute("listaClientes", dao.getClientesUnicos());
        } catch (Exception ex) {
            // Ignorar erro ao carregar lista de clientes
        }
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void buscar(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String clienteBusca = request.getParameter("clienteBusca");
        List<ModelCrediarioQSD> lista;
        String nomeBusca = null;
        String empresaBusca = null;

        if (clienteBusca != null && !clienteBusca.trim().isEmpty()) {
            String[] parts = clienteBusca.split("\\|");
            if (parts.length == 2) {
                nomeBusca = parts[0];
                empresaBusca = parts[1];
            }
            lista = dao.buscarPorCliente(nomeBusca, empresaBusca);
        } else {
            lista = dao.buscarTodos();
        }

        request.setAttribute("listaCreditos", lista);
        try {
            request.setAttribute("listaClientes", dao.getClientesUnicos());
        } catch (Exception ex) {
            // Ignorar erro ao carregar lista de clientes
        }
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void relatorio(HttpServletRequest request, HttpServletResponse response) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String clienteRelatorio = request.getParameter("clienteRelatorio");
        String nome = null;
        String empresa = null;
        if (clienteRelatorio != null && !clienteRelatorio.trim().isEmpty()) {
            String[] parts = clienteRelatorio.split("\\|");
            if (parts.length == 2) {
                nome = parts[0];
                empresa = parts[1];
            }
        }
        String dataInicioStr = request.getParameter("dataInicio");
        String dataFimStr = request.getParameter("dataFim");
        Date dataInicio = null;
        Date dataFim = null;
        if (dataInicioStr != null && !dataInicioStr.trim().isEmpty()) {
            dataInicio = sdf.parse(dataInicioStr);
        }
        if (dataFimStr != null && !dataFimStr.trim().isEmpty()) {
            dataFim = sdf.parse(dataFimStr);
        }

        List<ModelCrediarioQSD> lista;

        if (nome != null && dataInicio != null && dataFim != null) {
            lista = dao.buscarPorClienteEPeriodo(nome, empresa, dataInicio, dataFim);
        } else if (dataInicio != null && dataFim != null) {
            lista = dao.buscarPorPeriodo(dataInicio, dataFim);
        } else if (nome != null) {
            lista = dao.buscarPorCliente(nome, empresa);
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
        try {
            request.setAttribute("listaClientes", dao.getClientesUnicos());
        } catch (Exception ex) {
            // Ignorar erro ao carregar lista de clientes
        }
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }

    private void carregar(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Long id = Long.parseLong(request.getParameter("id"));
        ModelCrediarioQSD model = dao.buscarPorId(id);

        request.setAttribute("modelReceber", model);
        try {
            request.setAttribute("listaClientes", dao.getClientesUnicos());
        } catch (Exception ex) {
            // Ignorar erro ao carregar lista de clientes
        }
        request.getRequestDispatcher("/qsd/crediario.jsp").forward(request, response);
    }
}