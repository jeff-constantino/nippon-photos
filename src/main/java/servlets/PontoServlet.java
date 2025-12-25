package servlets;

import dao.PontoDAO;
import model.Ponto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.List;

/**
 * Servlet único que gerencia todas as ações do sistema de ponto
 */
@WebServlet("/ponto")
public class PontoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");

        if (acao == null) acao = "";

        try {
            switch (acao) {
                // ===== AUTENTICAÇÃO =====
                case "login":
                    login(req, resp);
                    break;
                case "logout":
                    logout(req, resp);
                    break;

                // ===== FUNCIONÁRIO =====
                case "registrar-ponto":
                    registrarPonto(req, resp);
                    break;

                // ===== ADMIN - FUNCIONÁRIOS =====
                case "salvar-funcionario":
                    salvarFuncionario(req, resp);
                    break;
                case "alternar-status":
                    alternarStatus(req, resp);
                    break;
                case "alterar-senha":
                    alterarSenha(req, resp);
                    break;

                // ===== ADMIN - HORÁRIOS =====
                case "salvar-horario":
                    salvarHorario(req, resp);
                    break;
                case "listar-horarios":
                    listarHorarios(req, resp);
                    break;

                // ===== ADMIN - RELATÓRIOS =====
                case "relatorio-detalhado":
                    relatorioDetalhado(req, resp);
                    break;
                case "resumo-mensal":
                    resumoMensal(req, resp);
                    break;

                // ===== ADMIN - EDIÇÃO =====
                case "editar-registro":
                    editarRegistro(req, resp);
                    break;

                case "abonar-falta":
                    abonarFalta(req, resp);
                    break;

                case "excluir-justificativa":
                    excluirJustificativa(req, resp);
                    break;

                case "carregar-registro":
                    carregarRegistro(req, resp);
                    break;

                // ===== NOVO: AUTORIZAR ATRASO =====
                case "autorizar-atraso":
                    autorizarAtraso(req, resp);
                    break;

                // ===== NOVO: MARCAR ATRASO =====
                case "marcar-atraso":
                    marcarAtraso(req, resp);
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/ponto/index.jsp");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro: " + e.getMessage());
            req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
        }
    }

    // =============================================
    // AUTENTICAÇÃO
    // =============================================

    private void login(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String tipoLogin = req.getParameter("tipoLogin");
        String senha = req.getParameter("senha");
        PontoDAO dao = new PontoDAO();

        if ("funcionario".equals(tipoLogin)) {
            String cpf = req.getParameter("cpf");
            Ponto func = dao.autenticarFuncionario(cpf, senha);

            if (func != null) {
                HttpSession session = req.getSession();
                session.setAttribute("pontoFunc", func);
                resp.sendRedirect(req.getContextPath() + "/ponto/registroponto.jsp");
            } else {
                req.setAttribute("erro", "CPF ou senha inválidos!");
                req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
            }

        } else if ("admin".equals(tipoLogin)) {
            String usuario = req.getParameter("usuario");

            if (dao.autenticarAdmin(usuario, senha)) {
                HttpSession session = req.getSession();
                session.setAttribute("pontoAdmin", usuario);
                resp.sendRedirect(req.getContextPath() + "/ponto/admin.jsp");
            } else {
                req.setAttribute("erro", "Usuário ou senha inválidos!");
                req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
            }
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute("pontoFunc");
            session.removeAttribute("pontoAdmin");
        }
        resp.sendRedirect(req.getContextPath() + "/ponto/index.jsp");
    }

    // =============================================
    // FUNCIONÁRIO - REGISTRO DE PONTO
    // =============================================

    private void registrarPonto(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        Ponto func = (Ponto) session.getAttribute("pontoFunc");

        if (func == null) {
            resp.sendRedirect(req.getContextPath() + "/ponto/index.jsp");
            return;
        }

        PontoDAO dao = new PontoDAO();
        Date hoje = Date.valueOf(LocalDate.now());
        dao.registrarPonto(func.getFuncId(), hoje);

        req.setAttribute("sucesso", "Ponto registrado com sucesso!");
        req.getRequestDispatcher("/ponto/registroponto.jsp").forward(req, resp);
    }

    // =============================================
    // ADMIN - FUNCIONÁRIOS
    // =============================================

    private void salvarFuncionario(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Ponto p = new Ponto();
        p.setFuncNome(req.getParameter("nome"));
        p.setFuncCpf(req.getParameter("cpf"));
        p.setFuncTelefone(req.getParameter("telefone"));
        p.setFuncSenha(req.getParameter("senha"));

        PontoDAO dao = new PontoDAO();
        dao.salvarFuncionario(p);

        req.setAttribute("sucesso", "Funcionário cadastrado com sucesso!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void alternarStatus(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));

        PontoDAO dao = new PontoDAO();
        dao.alternarStatus(funcId);

        req.setAttribute("sucesso", "Status alterado!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void alterarSenha(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        String novaSenha = req.getParameter("novaSenha");

        PontoDAO dao = new PontoDAO();
        dao.alterarSenhaFuncionario(funcId, novaSenha);

        req.setAttribute("sucesso", "Senha alterada!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    // =============================================
    // ADMIN - HORÁRIOS
    // =============================================

    private void salvarHorario(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        String diaSemana = req.getParameter("diaSemana");
        Time horaEntrada = Time.valueOf(req.getParameter("horaEntrada") + ":00");
        Time horaSaida = null;

        String horaSaidaParam = req.getParameter("horaSaida");
        if (horaSaidaParam != null && !horaSaidaParam.isEmpty()) {
            horaSaida = Time.valueOf(horaSaidaParam + ":00");
        }

        int tolerancia = Integer.parseInt(req.getParameter("tolerancia"));
        Integer cargaHoraria = null;

        String cargaParam = req.getParameter("cargaHoraria");
        if (cargaParam != null && !cargaParam.isEmpty()) {
            cargaHoraria = Integer.parseInt(cargaParam);
        }

        PontoDAO dao = new PontoDAO();
        dao.salvarHorario(funcId, diaSemana, horaEntrada, horaSaida, tolerancia, cargaHoraria);

        req.setAttribute("sucesso", "Horário salvo!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void listarHorarios(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));

        PontoDAO dao = new PontoDAO();
        List<Ponto> horarios = dao.listarHorariosFuncionario(funcId);

        req.setAttribute("horarios", horarios);
        req.setAttribute("funcIdSelecionado", funcId);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    // =============================================
    // ADMIN - RELATÓRIOS
    // =============================================

    private void relatorioDetalhado(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        Date dataInicio = Date.valueOf(req.getParameter("dataInicio"));
        Date dataFim = Date.valueOf(req.getParameter("dataFim"));

        PontoDAO dao = new PontoDAO();
        List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);

        // Buscar info do funcionário
        List<Ponto> funcs = dao.listarFuncionarios();
        Ponto funcSelecionado = funcs.stream()
                .filter(f -> f.getFuncId().equals(funcId))
                .findFirst()
                .orElse(null);

        req.setAttribute("relatorioDetalhado", registros);
        req.setAttribute("funcSelecionado", funcSelecionado);
        req.setAttribute("periodoInicio", dataInicio);
        req.setAttribute("periodoFim", dataFim);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void resumoMensal(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        int mes = Integer.parseInt(req.getParameter("mes"));
        int ano = Integer.parseInt(req.getParameter("ano"));

        PontoDAO dao = new PontoDAO();
        Ponto resumo = dao.calcularResumoMensal(funcId, mes, ano);

        // Buscar info do funcionário
        List<Ponto> funcs = dao.listarFuncionarios();
        Ponto funcSelecionado = funcs.stream()
                .filter(f -> f.getFuncId().equals(funcId))
                .findFirst()
                .orElse(null);

        req.setAttribute("resumoMensal", resumo);
        req.setAttribute("funcSelecionado", funcSelecionado);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    // =============================================
    // ADMIN - EDIÇÃO
    // =============================================

    private void editarRegistro(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));

        // Buscar o registro atual primeiro
        PontoDAO dao = new PontoDAO();
        Ponto registroAtual = dao.buscarRegistroPorId(regId);
        String dataRegistro = new java.text.SimpleDateFormat("yyyy-MM-dd").format(registroAtual.getRegData());

        // Parse dos horários - se vier vazio, mantém o valor atual
        String entradaParam = req.getParameter("entrada");
        String saidaIntParam = req.getParameter("saidaInt");
        String retornoIntParam = req.getParameter("retornoInt");
        String saidaParam = req.getParameter("saida");

        Timestamp entrada = (entradaParam != null && !entradaParam.trim().isEmpty())
                ? parseTimestampComData(entradaParam, dataRegistro)
                : registroAtual.getRegEntrada();

        Timestamp saidaInt = (saidaIntParam != null && !saidaIntParam.trim().isEmpty())
                ? parseTimestampComData(saidaIntParam, dataRegistro)
                : registroAtual.getRegSaidaIntervalo();

        Timestamp retornoInt = (retornoIntParam != null && !retornoIntParam.trim().isEmpty())
                ? parseTimestampComData(retornoIntParam, dataRegistro)
                : registroAtual.getRegRetornoIntervalo();

        Timestamp saida = (saidaParam != null && !saidaParam.trim().isEmpty())
                ? parseTimestampComData(saidaParam, dataRegistro)
                : registroAtual.getRegSaida();

        String obs = req.getParameter("obs");

        HttpSession session = req.getSession();
        String editadoPor = (String) session.getAttribute("pontoAdmin");

        dao.editarRegistro(regId, entrada, saidaInt, retornoInt, saida, obs, editadoPor);

        req.setAttribute("sucesso", "Registro editado com sucesso!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private Timestamp parseTimestampComData(String hora, String data) {
        if (hora == null || hora.trim().isEmpty()) return null;
        try {
            // Formato esperado da hora: "08:30"
            // Formato esperado da data: "2025-01-15"
            return Timestamp.valueOf(data + " " + hora + ":00");
        } catch (Exception e) {
            return null;
        }
    }

    private Timestamp parseTimestamp(String str) {
        if (str == null || str.trim().isEmpty()) return null;
        try {
            // Formato esperado: "2025-01-15 08:30"
            if (!str.contains(":")) return null;
            return Timestamp.valueOf(str + ":00");
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Abonar falta (criar justificativa)
     */
    private void abonarFalta(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        Date data = Date.valueOf(req.getParameter("data"));
        String tipo = req.getParameter("tipo");
        String descricao = req.getParameter("descricao");

        PontoDAO dao = new PontoDAO();
        dao.salvarJustificativaAdmin(funcId, data, tipo, descricao, true);

        req.setAttribute("sucesso", "Falta abonada com sucesso!");

        // Recarregar relatório
        String dataInicioStr = req.getParameter("dataInicio");
        String dataFimStr = req.getParameter("dataFim");

        if (dataInicioStr != null && dataFimStr != null) {
            Date dataInicio = Date.valueOf(dataInicioStr);
            Date dataFim = Date.valueOf(dataFimStr);

            List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            List<Ponto> funcs = dao.listarFuncionarios();
            Ponto funcSelecionado = funcs.stream()
                    .filter(f -> f.getFuncId().equals(funcId))
                    .findFirst()
                    .orElse(null);

            req.setAttribute("relatorioDetalhado", registros);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }

        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    /**
     * Excluir justificativa
     */
    private void excluirJustificativa(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        Date data = Date.valueOf(req.getParameter("data"));

        PontoDAO dao = new PontoDAO();
        dao.excluirJustificativa(funcId, data);

        req.setAttribute("sucesso", "Justificativa removida!");

        // Recarregar relatório
        String dataInicioStr = req.getParameter("dataInicio");
        String dataFimStr = req.getParameter("dataFim");

        if (dataInicioStr != null && dataFimStr != null) {
            Date dataInicio = Date.valueOf(dataInicioStr);
            Date dataFim = Date.valueOf(dataFimStr);

            List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            List<Ponto> funcs = dao.listarFuncionarios();
            Ponto funcSelecionado = funcs.stream()
                    .filter(f -> f.getFuncId().equals(funcId))
                    .findFirst()
                    .orElse(null);

            req.setAttribute("relatorioDetalhado", registros);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }

        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    /**
     * Carregar registro para edição
     */
    private void carregarRegistro(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));

        PontoDAO dao = new PontoDAO();
        Ponto registro = dao.buscarRegistroPorId(regId);

        req.setAttribute("registroEditar", registro);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    // =============================================
    // NOVO: AUTORIZAR ATRASO
    // =============================================

    /**
     * Autoriza ou cancela autorização de atraso
     */
    private void autorizarAtraso(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));
        boolean autorizar = Boolean.parseBoolean(req.getParameter("autorizar"));

        PontoDAO dao = new PontoDAO();
        dao.autorizarAtraso(regId, autorizar);

        req.setAttribute("sucesso", autorizar ? "Atraso autorizado com sucesso!" : "Autorização de atraso cancelada!");

        // Redirecionar de volta ao relatório se tiver os parâmetros
        String funcIdRet = req.getParameter("funcIdRet");
        String dataInicioRet = req.getParameter("dataInicioRet");
        String dataFimRet = req.getParameter("dataFimRet");

        if (funcIdRet != null && !funcIdRet.isEmpty() &&
                dataInicioRet != null && !dataInicioRet.isEmpty() &&
                dataFimRet != null && !dataFimRet.isEmpty()) {

            // Reprocessar relatório para exibir as alterações
            int funcId = Integer.parseInt(funcIdRet);
            Date dataInicio = Date.valueOf(dataInicioRet);
            Date dataFim = Date.valueOf(dataFimRet);

            List<Ponto> relatorio = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            Ponto funcSelecionado = dao.listarFuncionarios().stream()
                    .filter(f -> f.getFuncId().equals(funcId))
                    .findFirst()
                    .orElse(null);

            req.setAttribute("relatorioDetalhado", relatorio);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }

        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    /**
     * Marca atraso manualmente em um registro
     */
    private void marcarAtraso(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));
        int minutosAtraso = Integer.parseInt(req.getParameter("minutosAtraso"));
        String tipoAtraso = req.getParameter("tipoAtraso");
        boolean autorizado = "autorizado".equals(tipoAtraso);

        PontoDAO dao = new PontoDAO();
        dao.marcarAtraso(regId, minutosAtraso, autorizado);

        req.setAttribute("sucesso", "Atraso de " + minutosAtraso + " minutos registrado!");

        // Redirecionar de volta ao relatório
        String funcIdRet = req.getParameter("funcIdRet");
        String dataInicioRet = req.getParameter("dataInicioRet");
        String dataFimRet = req.getParameter("dataFimRet");

        if (funcIdRet != null && !funcIdRet.isEmpty() &&
                dataInicioRet != null && !dataInicioRet.isEmpty() &&
                dataFimRet != null && !dataFimRet.isEmpty()) {

            int funcId = Integer.parseInt(funcIdRet);
            Date dataInicio = Date.valueOf(dataInicioRet);
            Date dataFim = Date.valueOf(dataFimRet);

            List<Ponto> relatorio = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            Ponto funcSelecionado = dao.listarFuncionarios().stream()
                    .filter(f -> f.getFuncId().equals(funcId))
                    .findFirst()
                    .orElse(null);

            req.setAttribute("relatorioDetalhado", relatorio);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }

        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }
}