package servlets;

import dao.PontoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Ponto;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/ponto")
public class PontoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("connection");
        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");
        if (acao == null) acao = "";

        try {
            switch (acao) {
                case "login": login(req, resp, conn); break;
                case "logout": logout(req, resp); break;
                case "registrar-ponto": registrarPonto(req, resp, conn); break;
                case "salvar-funcionario": salvarFuncionario(req, resp, conn); break;
                case "editar-funcionario": editarFuncionario(req, resp, conn); break;
                case "alternar-status": alternarStatus(req, resp, conn); break;
                case "excluir-funcionario": excluirFuncionario(req, resp, conn); break;
                case "alterar-senha": alterarSenha(req, resp, conn); break;
                case "salvar-horario": salvarHorario(req, resp, conn); break;
                case "listar-horarios": listarHorarios(req, resp, conn); break;
                case "relatorio-detalhado": relatorioDetalhado(req, resp, conn); break;
                case "resumo-mensal": resumoMensal(req, resp, conn); break;
                case "editar-registro": editarRegistro(req, resp, conn); break;
                case "abonar-falta": abonarFalta(req, resp, conn); break;
                case "excluir-justificativa": excluirJustificativa(req, resp, conn); break;
                case "carregar-registro": carregarRegistro(req, resp, conn); break;
                case "autorizar-atraso": autorizarAtraso(req, resp, conn); break;
                case "marcar-atraso": marcarAtraso(req, resp, conn); break;
                case "listar-zonas": listarZonas(req, resp); break;
                case "editar-zona": editarZona(req, resp, conn); break;
                case "alternar-status-zona": alternarStatusZona(req, resp, conn); break;
                default: resp.sendRedirect(req.getContextPath() + "/ponto/index.jsp"); break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Erro: " + e.getMessage());
            req.getRequestDispatcher("/ponto/index.jsp").forward(req, resp);
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        String tipoLogin = req.getParameter("tipoLogin");
        String senha = req.getParameter("senha");
        PontoDAO dao = new PontoDAO(conn);

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

    private void registrarPonto(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        HttpSession session = req.getSession();
        Ponto func = (Ponto) session.getAttribute("pontoFunc");
        if (func == null) {
            resp.sendRedirect(req.getContextPath() + "/ponto/index.jsp");
            return;
        }

        String latitudeStr = req.getParameter("latitude");
        String longitudeStr = req.getParameter("longitude");
        String precisaoStr = req.getParameter("precisao");
        String tipoLocalizacao = req.getParameter("tipoLocalizacao");

        PontoDAO dao = new PontoDAO(conn);
        Date hoje = Date.valueOf(LocalDate.now());

        try {
            if (latitudeStr != null && longitudeStr != null) {
                BigDecimal latitude = new BigDecimal(latitudeStr);
                BigDecimal longitude = new BigDecimal(longitudeStr);
                Integer precisao = precisaoStr != null ? Integer.parseInt(precisaoStr) : null;
                dao.registrarPontoComGPS(func.getFuncId(), hoje, latitude, longitude, precisao, tipoLocalizacao);
                session.setAttribute("msgSucesso", "✅ Ponto registrado com sucesso!");
            } else {
                dao.registrarPonto(func.getFuncId(), hoje);
                session.setAttribute("msgSucesso", "⚠️ Ponto registrado sem localização. Ative o GPS.");
            }
        } catch (Exception e) {
            session.setAttribute("msgErro", e.getMessage());
        }

        // ✅ CORREÇÃO: Usar redirect em vez de forward para forçar novo GET e buscar dados atualizados
        resp.sendRedirect(req.getContextPath() + "/ponto/registroponto.jsp");
    }

    private void salvarFuncionario(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        Ponto p = new Ponto();
        p.setFuncNome(req.getParameter("nome"));
        p.setFuncCpf(req.getParameter("cpf"));
        p.setFuncTelefone(req.getParameter("telefone"));
        p.setFuncSenha(req.getParameter("senha"));
        PontoDAO dao = new PontoDAO(conn);
        dao.salvarFuncionario(p);
        req.setAttribute("sucesso", "Funcionário cadastrado com sucesso!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void editarFuncionario(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        String nome = req.getParameter("nome");
        String telefone = req.getParameter("telefone");
        String novaSenha = req.getParameter("novaSenha");
        PontoDAO dao = new PontoDAO(conn);
        dao.editarFuncionario(funcId, nome, telefone, novaSenha);
        req.setAttribute("sucesso", "Funcionário atualizado com sucesso!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void alternarStatus(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        PontoDAO dao = new PontoDAO(conn);
        dao.alternarStatus(funcId);
        req.setAttribute("sucesso", "Status alterado!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void excluirFuncionario(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        PontoDAO dao = new PontoDAO(conn);
        dao.excluirFuncionario(funcId);
        req.setAttribute("sucesso", "Funcionário excluído com sucesso!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void alterarSenha(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        String novaSenha = req.getParameter("novaSenha");
        PontoDAO dao = new PontoDAO(conn);
        dao.alterarSenhaFuncionario(funcId, novaSenha);
        req.setAttribute("sucesso", "Senha alterada!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void salvarHorario(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        String diaSemana = req.getParameter("diaSemana");
        Time horaEntrada = Time.valueOf(req.getParameter("horaEntrada") + ":00");
        Time horaSaida = null;
        String horaSaidaParam = req.getParameter("horaSaida");
        if (horaSaidaParam != null && !horaSaidaParam.isEmpty()) horaSaida = Time.valueOf(horaSaidaParam + ":00");
        int tolerancia = Integer.parseInt(req.getParameter("tolerancia"));
        Integer cargaHoraria = null;
        String cargaParam = req.getParameter("cargaHoraria");
        if (cargaParam != null && !cargaParam.isEmpty()) cargaHoraria = Integer.parseInt(cargaParam);
        PontoDAO dao = new PontoDAO(conn);
        dao.salvarHorario(funcId, diaSemana, horaEntrada, horaSaida, tolerancia, cargaHoraria);
        req.setAttribute("sucesso", "Horário salvo!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void listarHorarios(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        PontoDAO dao = new PontoDAO(conn);
        List<Ponto> horarios = dao.listarHorariosFuncionario(funcId);
        req.setAttribute("horarios", horarios);
        req.setAttribute("funcIdSelecionado", funcId);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void relatorioDetalhado(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        Date dataInicio = Date.valueOf(req.getParameter("dataInicio"));
        Date dataFim = Date.valueOf(req.getParameter("dataFim"));
        PontoDAO dao = new PontoDAO(conn);
        List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
        List<Ponto> funcs = dao.listarFuncionarios();
        Ponto funcSelecionado = funcs.stream().filter(f -> f.getFuncId().equals(funcId)).findFirst().orElse(null);
        req.setAttribute("relatorioDetalhado", registros);
        req.setAttribute("funcSelecionado", funcSelecionado);
        req.setAttribute("periodoInicio", dataInicio);
        req.setAttribute("periodoFim", dataFim);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void resumoMensal(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        int mes = Integer.parseInt(req.getParameter("mes"));
        int ano = Integer.parseInt(req.getParameter("ano"));
        PontoDAO dao = new PontoDAO(conn);
        Ponto resumo = dao.calcularResumoMensal(funcId, mes, ano);
        List<Ponto> funcs = dao.listarFuncionarios();
        Ponto funcSelecionado = funcs.stream().filter(f -> f.getFuncId().equals(funcId)).findFirst().orElse(null);
        req.setAttribute("resumoMensal", resumo);
        req.setAttribute("funcSelecionado", funcSelecionado);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void editarRegistro(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));
        PontoDAO dao = new PontoDAO(conn);
        Ponto registroAtual = dao.buscarRegistroPorId(regId);
        String dataRegistro = new java.text.SimpleDateFormat("yyyy-MM-dd").format(registroAtual.getRegData());

        String entradaParam = req.getParameter("entrada");
        String saidaIntParam = req.getParameter("saidaInt");
        String retornoIntParam = req.getParameter("retornoInt");
        String saidaParam = req.getParameter("saida");

        // ✅ CORREÇÃO: Usar novo método que ajusta a data para horários após meia-noite
        Timestamp entrada = (entradaParam != null && !entradaParam.trim().isEmpty())
                ? parseTimestampComData(entradaParam, dataRegistro, registroAtual.getRegEntrada())
                : registroAtual.getRegEntrada();

        Timestamp saidaInt = (saidaIntParam != null && !saidaIntParam.trim().isEmpty())
                ? parseTimestampComDataInteligente(saidaIntParam, dataRegistro, entrada)
                : registroAtual.getRegSaidaIntervalo();

        Timestamp retornoInt = (retornoIntParam != null && !retornoIntParam.trim().isEmpty())
                ? parseTimestampComDataInteligente(retornoIntParam, dataRegistro, saidaInt != null ? saidaInt : entrada)
                : registroAtual.getRegRetornoIntervalo();

        Timestamp saida = (saidaParam != null && !saidaParam.trim().isEmpty())
                ? parseTimestampComDataInteligente(saidaParam, dataRegistro, retornoInt != null ? retornoInt : entrada)
                : registroAtual.getRegSaida();

        String obs = req.getParameter("obs");
        HttpSession session = req.getSession();
        String editadoPor = (String) session.getAttribute("pontoAdmin");
        dao.editarRegistro(regId, entrada, saidaInt, retornoInt, saida, obs, editadoPor);
        req.setAttribute("sucesso", "Registro editado com sucesso!");
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    /**
     * ✅ NOVO MÉTODO: Converte hora para Timestamp ajustando a data quando necessário
     * Se a hora for entre 00:00 e 05:59 E menor que a hora de referência, assume que é do dia seguinte
     */
    private Timestamp parseTimestampComDataInteligente(String hora, String data, Timestamp referencia) {
        if (hora == null || hora.trim().isEmpty()) return null;
        try {
            LocalDate dataBase = LocalDate.parse(data);
            LocalTime horaTime = LocalTime.parse(hora);

            // Se a hora está na madrugada (00:00 - 05:59)
            if (horaTime.getHour() >= 0 && horaTime.getHour() < 6) {
                // Se temos uma referência (entrada ou saída intervalo)
                if (referencia != null) {
                    LocalDateTime referenciaLDT = referencia.toLocalDateTime();
                    LocalTime horaReferencia = referenciaLDT.toLocalTime();

                    // Se a hora de madrugada é MENOR que a hora de referência,
                    // assume que é do dia seguinte
                    if (horaTime.isBefore(horaReferencia)) {
                        dataBase = dataBase.plusDays(1);
                    }
                }
            }

            LocalDateTime dateTime = LocalDateTime.of(dataBase, horaTime);
            return Timestamp.valueOf(dateTime);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Método original para entrada (não precisa de ajuste)
     */
    private Timestamp parseTimestampComData(String hora, String data, Timestamp original) {
        if (hora == null || hora.trim().isEmpty()) return original;
        try {
            return Timestamp.valueOf(data + " " + hora + ":00");
        } catch (Exception e) {
            return null;
        }
    }

    private void abonarFalta(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        Date data = Date.valueOf(req.getParameter("data"));
        String tipo = req.getParameter("tipo");
        String descricao = req.getParameter("descricao");
        PontoDAO dao = new PontoDAO(conn);
        dao.salvarJustificativaAdmin(funcId, data, tipo, descricao, true);
        req.setAttribute("sucesso", "Falta abonada com sucesso!");
        String dataInicioStr = req.getParameter("dataInicio");
        String dataFimStr = req.getParameter("dataFim");
        if (dataInicioStr != null && dataFimStr != null) {
            Date dataInicio = Date.valueOf(dataInicioStr);
            Date dataFim = Date.valueOf(dataFimStr);
            List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            List<Ponto> funcs = dao.listarFuncionarios();
            Ponto funcSelecionado = funcs.stream().filter(f -> f.getFuncId().equals(funcId)).findFirst().orElse(null);
            req.setAttribute("relatorioDetalhado", registros);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void excluirJustificativa(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int funcId = Integer.parseInt(req.getParameter("funcId"));
        Date data = Date.valueOf(req.getParameter("data"));
        PontoDAO dao = new PontoDAO(conn);
        dao.excluirJustificativa(funcId, data);
        req.setAttribute("sucesso", "Justificativa removida!");
        String dataInicioStr = req.getParameter("dataInicio");
        String dataFimStr = req.getParameter("dataFim");
        if (dataInicioStr != null && dataFimStr != null) {
            Date dataInicio = Date.valueOf(dataInicioStr);
            Date dataFim = Date.valueOf(dataFimStr);
            List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            List<Ponto> funcs = dao.listarFuncionarios();
            Ponto funcSelecionado = funcs.stream().filter(f -> f.getFuncId().equals(funcId)).findFirst().orElse(null);
            req.setAttribute("relatorioDetalhado", registros);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void carregarRegistro(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));
        PontoDAO dao = new PontoDAO(conn);
        Ponto registro = dao.buscarRegistroPorId(regId);
        req.setAttribute("registroEditar", registro);
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void autorizarAtraso(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));
        boolean autorizar = Boolean.parseBoolean(req.getParameter("autorizar"));
        PontoDAO dao = new PontoDAO(conn);
        dao.autorizarAtraso(regId, autorizar);
        req.setAttribute("sucesso", autorizar ? "Atraso autorizado com sucesso!" : "Autorização de atraso cancelada!");
        String funcIdRet = req.getParameter("funcIdRet");
        String dataInicioRet = req.getParameter("dataInicioRet");
        String dataFimRet = req.getParameter("dataFimRet");
        if (funcIdRet != null && !funcIdRet.isEmpty() && dataInicioRet != null && !dataInicioRet.isEmpty() && dataFimRet != null && !dataFimRet.isEmpty()) {
            int funcId = Integer.parseInt(funcIdRet);
            Date dataInicio = Date.valueOf(dataInicioRet);
            Date dataFim = Date.valueOf(dataFimRet);
            List<Ponto> relatorio = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            Ponto funcSelecionado = dao.listarFuncionarios().stream().filter(f -> f.getFuncId().equals(funcId)).findFirst().orElse(null);
            req.setAttribute("relatorioDetalhado", relatorio);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void marcarAtraso(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int regId = Integer.parseInt(req.getParameter("regId"));
        int minutosAtraso = Integer.parseInt(req.getParameter("minutosAtraso"));
        String tipoAtraso = req.getParameter("tipoAtraso");
        boolean autorizado = "autorizado".equals(tipoAtraso);
        PontoDAO dao = new PontoDAO(conn);
        dao.marcarAtraso(regId, minutosAtraso, autorizado);
        req.setAttribute("sucesso", "Atraso de " + minutosAtraso + " minutos registrado!");
        String funcIdRet = req.getParameter("funcIdRet");
        String dataInicioRet = req.getParameter("dataInicioRet");
        String dataFimRet = req.getParameter("dataFimRet");
        if (funcIdRet != null && !funcIdRet.isEmpty() && dataInicioRet != null && !dataInicioRet.isEmpty() && dataFimRet != null && !dataFimRet.isEmpty()) {
            int funcId = Integer.parseInt(funcIdRet);
            Date dataInicio = Date.valueOf(dataInicioRet);
            Date dataFim = Date.valueOf(dataFimRet);
            List<Ponto> relatorio = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);
            Ponto funcSelecionado = dao.listarFuncionarios().stream().filter(f -> f.getFuncId().equals(funcId)).findFirst().orElse(null);
            req.setAttribute("relatorioDetalhado", relatorio);
            req.setAttribute("funcSelecionado", funcSelecionado);
            req.setAttribute("periodoInicio", dataInicio);
            req.setAttribute("periodoFim", dataFim);
        }
        req.getRequestDispatcher("/ponto/admin.jsp").forward(req, resp);
    }

    private void listarZonas(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("/ponto/admin_zonas.jsp").forward(req, resp);
    }

    private void editarZona(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int zonaId = Integer.parseInt(req.getParameter("zonaId"));
        String nome = req.getParameter("nome");
        String descricao = req.getParameter("descricao");
        BigDecimal latitude = new BigDecimal(req.getParameter("latitude"));
        BigDecimal longitude = new BigDecimal(req.getParameter("longitude"));
        int raioMetros = Integer.parseInt(req.getParameter("raioMetros"));
        Ponto zona = new Ponto();
        zona.setZonaId(zonaId);
        zona.setZonaNome(nome);
        zona.setZonaDescricao(descricao);
        zona.setZonaLatitude(latitude);
        zona.setZonaLongitude(longitude);
        zona.setZonaRaioMetros(raioMetros);
        zona.setZonaAtivo(true);
        PontoDAO dao = new PontoDAO(conn);
        dao.salvarZona(zona);
        req.setAttribute("sucesso", "Zona atualizada com sucesso!");
        req.getRequestDispatcher("/ponto/admin_zonas.jsp").forward(req, resp);
    }

    private void alternarStatusZona(HttpServletRequest req, HttpServletResponse resp, Connection conn) throws Exception {
        int zonaId = Integer.parseInt(req.getParameter("zonaId"));
        PontoDAO dao = new PontoDAO(conn);
        dao.alternarStatusZona(zonaId);
        req.setAttribute("sucesso", "Status alterado!");
        req.getRequestDispatcher("/ponto/admin_zonas.jsp").forward(req, resp);
    }
}