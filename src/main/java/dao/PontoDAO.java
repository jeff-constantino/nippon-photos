package dao;

import connection.SingleConnectionBanco;
import model.Ponto;
import java.security.MessageDigest;
import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.time.LocalDate;

/**
 * DAO completo para todas as operações do sistema de ponto
 * SIMPLIFICADO - Sem cálculo automático de atrasos baseado em horários
 */
public class PontoDAO {

    private Connection conn;

    public PontoDAO() {
        conn = SingleConnectionBanco.getConnection();
    }

    // =============================================
    // AUTENTICAÇÃO E SEGURANÇA
    // =============================================

    private String hashSenha(String senha) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(senha.getBytes());
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Ponto autenticarFuncionario(String cpf, String senha) throws Exception {
        String sql = "SELECT * FROM ponto_funcionarios WHERE cpf = ? AND ativo = true";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, cpf.replaceAll("[^0-9]", ""));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            if (hashSenha(senha).equals(rs.getString("senha"))) {
                Ponto p = new Ponto();
                p.setFuncId(rs.getInt("id"));
                p.setFuncNome(rs.getString("nome"));
                p.setFuncCpf(rs.getString("cpf"));
                p.setFuncTelefone(rs.getString("telefone"));
                p.setFuncAtivo(rs.getBoolean("ativo"));
                return p;
            }
        }
        return null;
    }

    public boolean autenticarAdmin(String usuario, String senha) throws Exception {
        String sql = "SELECT * FROM ponto_admin WHERE usuario = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, usuario);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return hashSenha(senha).equals(rs.getString("senha"));
        }
        return false;
    }

    // =============================================
    // REGISTRO DE PONTO
    // =============================================

    public void registrarPonto(int funcId, Date data) throws Exception {
        Timestamp agora = new Timestamp(System.currentTimeMillis());
        java.time.LocalDateTime agoraLDT = agora.toLocalDateTime();

        // CORREÇÃO: Se for antes das 6h da manhã, considerar como parte do dia anterior
        // Isso resolve o problema de jornadas noturnas (ex: entra 22h, sai 2h)
        Date dataRegistro = data;
        if (agoraLDT.getHour() < 6) {
            // Antes das 6h = pertence ao dia anterior
            dataRegistro = Date.valueOf(data.toLocalDate().minusDays(1));
        }

        Ponto registro = buscarRegistroDia(funcId, dataRegistro);

        if (registro == null) {
            // Primeiro registro - ENTRADA
            String sql = "INSERT INTO ponto_registros (funcionario_id, data, entrada) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, funcId);
            ps.setDate(2, dataRegistro);
            ps.setTimestamp(3, agora);
            ps.executeUpdate();
            conn.commit();
        } else {
            // Atualizar próximo campo
            String sql = null;
            if (registro.getRegEntrada() != null && registro.getRegSaidaIntervalo() == null) {
                sql = "UPDATE ponto_registros SET saida_intervalo = ? WHERE id = ?";
            } else if (registro.getRegSaidaIntervalo() != null && registro.getRegRetornoIntervalo() == null) {
                sql = "UPDATE ponto_registros SET retorno_intervalo = ? WHERE id = ?";
            } else if (registro.getRegRetornoIntervalo() != null && registro.getRegSaida() == null) {
                sql = "UPDATE ponto_registros SET saida = ? WHERE id = ?";
            }

            if (sql != null) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setTimestamp(1, agora);
                ps.setInt(2, registro.getRegId());
                ps.executeUpdate();
                conn.commit();

                // Calcular horas trabalhadas quando completar o dia (tem saída)
                if (registro.getRegRetornoIntervalo() != null && sql.contains("saida =")) {
                    calcularHorasTrabalhadasENoturnas(funcId, dataRegistro);
                }
            }
        }
    }

    /**
     * Calcula horas trabalhadas e noturnas (CORRIGIDO)
     * Considera corretamente o intervalo para almoço
     */
    private void calcularHorasTrabalhadasENoturnas(int funcId, java.sql.Date data) throws Exception {
        Ponto registro = buscarRegistroDia(funcId, data);
        if (registro == null || registro.getRegEntrada() == null || registro.getRegSaida() == null) {
            return;
        }

        long segundosTrabalhados = 0;

        // Período 1: Entrada até Saída Intervalo (ou Saída final se não tiver intervalo)
        Timestamp fimPeriodo1 = (registro.getRegSaidaIntervalo() != null) ?
                registro.getRegSaidaIntervalo() : registro.getRegSaida();

        segundosTrabalhados += java.time.Duration.between(
                registro.getRegEntrada().toInstant(),
                fimPeriodo1.toInstant()
        ).getSeconds();

        // Período 2: Retorno Intervalo até Saída (apenas se houver intervalo)
        if (registro.getRegRetornoIntervalo() != null && registro.getRegSaida() != null) {
            segundosTrabalhados += java.time.Duration.between(
                    registro.getRegRetornoIntervalo().toInstant(),
                    registro.getRegSaida().toInstant()
            ).getSeconds();
        }

        // Conversão: Arredonda para o minuto mais próximo
        int minutosTrabalhadosFinal = Math.round(segundosTrabalhados / 60.0f);

        // --- CÁLCULO NOTURNO (22h às 05h) ---
        java.time.LocalTime horaNoturnaInicio = java.time.LocalTime.of(22, 0);
        java.time.LocalTime horaNoturnaFim = java.time.LocalTime.of(5, 0);
        int minutosNoturno = 0;

        // Período 1 - horas noturnas
        minutosNoturno += calcularMinutosNoturnosPeriodo(
                registro.getRegEntrada(),
                fimPeriodo1,
                horaNoturnaInicio,
                horaNoturnaFim
        );

        // Período 2 - horas noturnas (se houver intervalo)
        if (registro.getRegRetornoIntervalo() != null && registro.getRegSaida() != null) {
            minutosNoturno += calcularMinutosNoturnosPeriodo(
                    registro.getRegRetornoIntervalo(),
                    registro.getRegSaida(),
                    horaNoturnaInicio,
                    horaNoturnaFim
            );
        }

        // --- ATUALIZAÇÃO NO BANCO ---
        String sql = "UPDATE ponto_registros SET minutos_trabalhados = ?, minutos_noturno = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, minutosTrabalhadosFinal);
            ps.setInt(2, minutosNoturno);
            ps.setInt(3, registro.getRegId());
            ps.executeUpdate();
        }
        conn.commit();
    }

    private int calcularMinutosNoturnosPeriodo(Timestamp inicio, Timestamp fim,
                                               java.time.LocalTime horaInicio,
                                               java.time.LocalTime horaFim) {
        if (inicio == null || fim == null) return 0;

        java.time.LocalDateTime dtInicio = inicio.toLocalDateTime();
        java.time.LocalDateTime dtFim = fim.toLocalDateTime();

        int minutosNoturno = 0;
        java.time.LocalDateTime atual = dtInicio;

        // Percorre minuto a minuto para verificar se está no período noturno
        while (atual.isBefore(dtFim)) {
            java.time.LocalTime hora = atual.toLocalTime();

            // Verifica se está entre 22:00 e 23:59 OU entre 00:00 e 04:59
            if ((hora.isAfter(horaInicio) || hora.equals(horaInicio)) ||
                    (hora.isBefore(horaFim))) {
                minutosNoturno++;
            }

            atual = atual.plusMinutes(1);
        }

        return minutosNoturno;
    }

    public Ponto buscarRegistroDia(int funcId, Date data) throws Exception {
        String sql = "SELECT * FROM ponto_registros WHERE funcionario_id = ? AND data = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, data);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return mapearRegistro(rs);
        }
        return null;
    }

    private Ponto mapearRegistro(ResultSet rs) throws SQLException {
        Ponto p = new Ponto();
        p.setRegId(rs.getInt("id"));
        p.setFuncId(rs.getInt("funcionario_id"));
        p.setRegData(rs.getDate("data"));
        p.setRegEntrada(rs.getTimestamp("entrada"));
        p.setRegSaidaIntervalo(rs.getTimestamp("saida_intervalo"));
        p.setRegRetornoIntervalo(rs.getTimestamp("retorno_intervalo"));
        p.setRegSaida(rs.getTimestamp("saida"));
        p.setRegObservacao(rs.getString("observacao"));
        p.setRegEditado(rs.getBoolean("editado"));
        p.setRegEditadoPor(rs.getString("editado_por"));
        p.setRegEditadoEm(rs.getTimestamp("editado_em"));

        Object minTrab = rs.getObject("minutos_trabalhados");
        p.setRegMinutosTrabalhados(minTrab != null ? (Integer)minTrab : 0);

        Object minAtraso = rs.getObject("minutos_atraso");
        p.setRegMinutosAtraso(minAtraso != null ? (Integer)minAtraso : 0);

        Object minNot = rs.getObject("minutos_noturno");
        p.setRegMinutosNoturno(minNot != null ? (Integer)minNot : 0);

        // Campo atraso autorizado
        p.setAtrasoAutorizado(rs.getBoolean("atraso_autorizado"));

        // Definir status
        if (p.getRegEntrada() != null && p.getRegSaida() != null) {
            p.setStatusDia("Completo");
        } else if (p.getRegEntrada() != null) {
            p.setStatusDia("Incompleto");
        }

        // Tem atraso apenas se houver atraso E não foi autorizado
        p.setTemAtraso(p.getRegMinutosAtraso() != null && p.getRegMinutosAtraso() > 0 && !p.getAtrasoAutorizado());

        return p;
    }

    // =============================================
    // AUTORIZAR ATRASO
    // =============================================

    public void autorizarAtraso(int regId, boolean autorizado) throws Exception {
        String sql = "UPDATE ponto_registros SET atraso_autorizado = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setBoolean(1, autorizado);
        ps.setInt(2, regId);
        ps.executeUpdate();
        conn.commit();
    }

    /**
     * Marca atraso manualmente com minutos específicos
     */
    public void marcarAtraso(int regId, int minutosAtraso, boolean autorizado) throws Exception {
        String sql = "UPDATE ponto_registros SET minutos_atraso = ?, atraso_autorizado = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, minutosAtraso);
        ps.setBoolean(2, autorizado);
        ps.setInt(3, regId);
        ps.executeUpdate();
        conn.commit();
    }

    // =============================================
    // HORÁRIOS
    // =============================================

    public void salvarHorario(int funcId, String diaSemana, Time horaEntrada, Time horaSaida,
                              int tolerancia, Integer cargaHoraria) throws Exception {
        String sql = "INSERT INTO ponto_horarios (funcionario_id, dia_semana, hora_entrada, hora_saida, " +
                "tolerancia_minutos, carga_horaria_minutos) VALUES (?, ?, ?, ?, ?, ?) " +
                "ON CONFLICT (funcionario_id, dia_semana) " +
                "DO UPDATE SET hora_entrada = ?, hora_saida = ?, tolerancia_minutos = ?, carga_horaria_minutos = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setString(2, diaSemana);
        ps.setTime(3, horaEntrada);
        ps.setTime(4, horaSaida);
        ps.setInt(5, tolerancia);
        ps.setObject(6, cargaHoraria);
        ps.setTime(7, horaEntrada);
        ps.setTime(8, horaSaida);
        ps.setInt(9, tolerancia);
        ps.setObject(10, cargaHoraria);
        ps.executeUpdate();
        conn.commit();
    }

    public List<Ponto> listarHorariosFuncionario(int funcId) throws Exception {
        List<Ponto> lista = new ArrayList<>();
        String sql = "SELECT * FROM ponto_horarios WHERE funcionario_id = ? ORDER BY " +
                "CASE dia_semana " +
                "WHEN 'segunda' THEN 1 WHEN 'terca' THEN 2 WHEN 'quarta' THEN 3 " +
                "WHEN 'quinta' THEN 4 WHEN 'sexta' THEN 5 WHEN 'sabado' THEN 6 " +
                "WHEN 'domingo' THEN 7 WHEN 'feriado' THEN 8 WHEN 'temporada' THEN 9 END";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Ponto p = new Ponto();
            p.setHorId(rs.getInt("id"));
            p.setHorDiaSemana(rs.getString("dia_semana"));
            p.setHorEntrada(rs.getTime("hora_entrada"));
            p.setHorSaida(rs.getTime("hora_saida"));
            p.setHorTolerancia(rs.getInt("tolerancia_minutos"));

            Object carga = rs.getObject("carga_horaria_minutos");
            p.setHorCargaHoraria(carga != null ? (Integer)carga : null);
            lista.add(p);
        }
        return lista;
    }

    // =============================================
    // FUNCIONÁRIOS
    // =============================================

    public List<Ponto> listarFuncionarios() throws Exception {
        List<Ponto> lista = new ArrayList<>();
        String sql = "SELECT * FROM ponto_funcionarios ORDER BY nome";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Ponto p = new Ponto();
            p.setFuncId(rs.getInt("id"));
            p.setFuncNome(rs.getString("nome"));
            p.setFuncCpf(rs.getString("cpf"));
            p.setFuncTelefone(rs.getString("telefone"));
            p.setFuncAtivo(rs.getBoolean("ativo"));
            p.setFuncCriadoEm(rs.getTimestamp("criado_em"));
            lista.add(p);
        }
        return lista;
    }

    public void salvarFuncionario(Ponto p) throws Exception {
        String sql = "INSERT INTO ponto_funcionarios (nome, cpf, telefone, senha, ativo) VALUES (?, ?, ?, ?, true)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, p.getFuncNome());
        ps.setString(2, p.getFuncCpf().replaceAll("[^0-9]", ""));
        ps.setString(3, p.getFuncTelefone());
        ps.setString(4, hashSenha(p.getFuncSenha()));
        ps.executeUpdate();
        conn.commit();
    }

    public void alternarStatus(int funcId) throws Exception {
        String sql = "UPDATE ponto_funcionarios SET ativo = NOT ativo WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.executeUpdate();
        conn.commit();
    }

    public void alterarSenhaFuncionario(int funcId, String novaSenha) throws Exception {
        String sql = "UPDATE ponto_funcionarios SET senha = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, hashSenha(novaSenha));
        ps.setInt(2, funcId);
        ps.executeUpdate();
        conn.commit();
    }

    // =============================================
    // RELATÓRIOS E CONSULTAS
    // =============================================

    public List<Ponto> buscarRegistrosPeriodo(int funcId, Date dataInicio, Date dataFim) throws Exception {
        List<Ponto> lista = new ArrayList<>();

        String sql = "SELECT r.*, f.nome, f.cpf, " +
                "j.tipo as just_tipo, j.descricao as just_desc " +
                "FROM ponto_registros r " +
                "JOIN ponto_funcionarios f ON r.funcionario_id = f.id " +
                "LEFT JOIN ponto_justificativas j ON j.funcionario_id = r.funcionario_id AND j.data = r.data AND j.aprovado = true " +
                "WHERE r.funcionario_id = ? AND r.data BETWEEN ? AND ? " +
                "ORDER BY r.data";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, dataInicio);
        ps.setDate(3, dataFim);
        ResultSet rs = ps.executeQuery();

        Map<Date, Ponto> registrosMap = new HashMap<>();
        while (rs.next()) {
            Ponto p = mapearRegistro(rs);
            p.setFuncNome(rs.getString("nome"));
            p.setFuncCpf(rs.getString("cpf"));

            // Capturar justificativa se existir
            String justTipo = rs.getString("just_tipo");
            String justDesc = rs.getString("just_desc");
            if (justTipo != null) {
                p.setJustTipo(justTipo);
                p.setJustDescricao(justDesc);
            }

            registrosMap.put(p.getRegData(), p);
        }

        LocalDate inicio = dataInicio.toLocalDate();
        LocalDate fim = dataFim.toLocalDate();

        String[] diasSemana = {"Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira",
                "Quinta-feira", "Sexta-feira", "Sábado"};

        // Preencher todos os dias do período
        for (LocalDate data = inicio; !data.isAfter(fim); data = data.plusDays(1)) {
            Date sqlDate = Date.valueOf(data);
            Ponto p = registrosMap.get(sqlDate);

            if (p == null) {
                // Dia sem registro = Falta
                p = new Ponto();
                p.setFuncId(funcId);
                p.setRegData(sqlDate);
                p.setStatusDia("Falta");
                p.setTemFalta(true);

                String sqlNome = "SELECT nome, cpf FROM ponto_funcionarios WHERE id = ?";
                PreparedStatement psNome = conn.prepareStatement(sqlNome);
                psNome.setInt(1, funcId);
                ResultSet rsNome = psNome.executeQuery();
                if (rsNome.next()) {
                    p.setFuncNome(rsNome.getString("nome"));
                    p.setFuncCpf(rsNome.getString("cpf"));
                }

                // Verificar se tem justificativa
                String sqlJust = "SELECT tipo, descricao FROM ponto_justificativas WHERE funcionario_id = ? AND data = ? AND aprovado = true";
                PreparedStatement psJust = conn.prepareStatement(sqlJust);
                psJust.setInt(1, funcId);
                psJust.setDate(2, sqlDate);
                ResultSet rsJust = psJust.executeQuery();
                if (rsJust.next()) {
                    p.setJustTipo(rsJust.getString("tipo"));
                    p.setJustDescricao(rsJust.getString("descricao"));
                }
            }

            Calendar cal = Calendar.getInstance();
            cal.setTime(sqlDate);
            p.setDiaSemanaTexto(diasSemana[cal.get(Calendar.DAY_OF_WEEK) - 1]);

            // Atualizar status se tiver justificativa
            if (p.getJustTipo() != null) {
                String tipoFormatado = formatarTipoJustificativa(p.getJustTipo());
                p.setStatusDia(tipoFormatado);
                p.setTemFalta(false);
            }

            lista.add(p);
        }

        return lista;
    }

    private String formatarTipoJustificativa(String tipo) {
        if (tipo == null) return "Justificado";

        switch (tipo.toLowerCase()) {
            case "feriado": return "Feriado";
            case "folga": return "Folga";
            case "atestado": return "Atestado";
            case "autorizado": return "Autorizado";
            default: return "Justificado";
        }
    }

    public Ponto calcularResumoMensal(int funcId, int mes, int ano) throws Exception {
        Ponto resumo = buscarResumoMensal(funcId, mes, ano);
        if (resumo == null) {
            resumo = new Ponto();
            resumo.setFuncId(funcId);
            resumo.setResumoMes(mes);
            resumo.setResumoAno(ano);
        }

        LocalDate dataInicio = LocalDate.of(ano, mes, 1);
        LocalDate dataFim = dataInicio.withDayOfMonth(dataInicio.lengthOfMonth());

        String sql = "SELECT " +
                "COUNT(*) as dias_trabalhados, " +
                "COALESCE(SUM(minutos_trabalhados), 0) as total_minutos, " +
                "COALESCE(SUM(CASE WHEN minutos_atraso > 0 AND atraso_autorizado = false THEN 1 ELSE 0 END), 0) as total_atrasos, " +
                "COALESCE(SUM(CASE WHEN atraso_autorizado = false THEN minutos_atraso ELSE 0 END), 0) as total_minutos_atraso, " +
                "COALESCE(SUM(minutos_noturno), 0) as total_minutos_noturno " +
                "FROM ponto_registros " +
                "WHERE funcionario_id = ? AND data BETWEEN ? AND ? AND entrada IS NOT NULL";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, Date.valueOf(dataInicio));
        ps.setDate(3, Date.valueOf(dataFim));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            resumo.setResumoTotalDiasTrabalhados(rs.getInt("dias_trabalhados"));
            resumo.setResumoTotalMinutosTrabalhados(rs.getInt("total_minutos"));
            resumo.setResumoTotalAtrasos(rs.getInt("total_atrasos"));
            resumo.setResumoTotalMinutosAtraso(rs.getInt("total_minutos_atraso"));
            resumo.setResumoTotalMinutosNoturno(rs.getInt("total_minutos_noturno"));
        }

        int totalDiasMes = dataInicio.lengthOfMonth();
        int diasTrabalhados = resumo.getResumoTotalDiasTrabalhados();
        int faltasNaoJustificadas = totalDiasMes - diasTrabalhados;

        sql = "SELECT COUNT(*) FROM ponto_justificativas WHERE funcionario_id = ? AND " +
                "EXTRACT(MONTH FROM data) = ? AND EXTRACT(YEAR FROM data) = ? AND aprovado = true";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setInt(2, mes);
        ps.setInt(3, ano);
        rs = ps.executeQuery();
        if (rs.next()) {
            faltasNaoJustificadas -= rs.getInt(1);
        }

        resumo.setResumoTotalFaltas(Math.max(0, faltasNaoJustificadas));

        int maxAtrasos = getConfigInt("max_atrasos_mes", 3);
        int maxFaltas = getConfigInt("max_faltas_mes", 1);

        boolean temDireito = resumo.getResumoTotalAtrasos() <= maxAtrasos &&
                resumo.getResumoTotalFaltas() <= maxFaltas;
        resumo.setResumoTemDireitoVale(temDireito);

        salvarResumoMensal(resumo);

        return resumo;
    }

    private Ponto buscarResumoMensal(int funcId, int mes, int ano) throws Exception {
        String sql = "SELECT * FROM ponto_resumo_mensal WHERE funcionario_id = ? AND mes = ? AND ano = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setInt(2, mes);
        ps.setInt(3, ano);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Ponto p = new Ponto();
            p.setResumoId(rs.getInt("id"));
            p.setFuncId(rs.getInt("funcionario_id"));
            p.setResumoMes(rs.getInt("mes"));
            p.setResumoAno(rs.getInt("ano"));
            p.setResumoTotalDiasTrabalhados(rs.getInt("total_dias_trabalhados"));
            p.setResumoTotalMinutosTrabalhados(rs.getInt("total_minutos_trabalhados"));
            p.setResumoTotalAtrasos(rs.getInt("total_atrasos"));
            p.setResumoTotalMinutosAtraso(rs.getInt("total_minutos_atraso"));
            p.setResumoTotalMinutosNoturno(rs.getInt("total_minutos_noturno"));
            p.setResumoTotalFaltas(rs.getInt("total_faltas"));
            p.setResumoTemDireitoVale(rs.getBoolean("tem_direito_vale"));
            p.setResumoObservacoes(rs.getString("observacoes"));
            return p;
        }
        return null;
    }

    private void salvarResumoMensal(Ponto resumo) throws Exception {
        String sql = "INSERT INTO ponto_resumo_mensal (funcionario_id, mes, ano, total_dias_trabalhados, " +
                "total_minutos_trabalhados, total_atrasos, total_minutos_atraso, total_minutos_noturno, " +
                "total_faltas, tem_direito_vale, atualizado_em) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now()) " +
                "ON CONFLICT (funcionario_id, mes, ano) " +
                "DO UPDATE SET total_dias_trabalhados = ?, total_minutos_trabalhados = ?, " +
                "total_atrasos = ?, total_minutos_atraso = ?, total_minutos_noturno = ?, " +
                "total_faltas = ?, tem_direito_vale = ?, atualizado_em = now()";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, resumo.getFuncId());
        ps.setInt(2, resumo.getResumoMes());
        ps.setInt(3, resumo.getResumoAno());
        ps.setInt(4, resumo.getResumoTotalDiasTrabalhados());
        ps.setInt(5, resumo.getResumoTotalMinutosTrabalhados());
        ps.setInt(6, resumo.getResumoTotalAtrasos());
        ps.setInt(7, resumo.getResumoTotalMinutosAtraso());
        ps.setInt(8, resumo.getResumoTotalMinutosNoturno());
        ps.setInt(9, resumo.getResumoTotalFaltas());
        ps.setBoolean(10, resumo.getResumoTemDireitoVale());
        ps.setInt(11, resumo.getResumoTotalDiasTrabalhados());
        ps.setInt(12, resumo.getResumoTotalMinutosTrabalhados());
        ps.setInt(13, resumo.getResumoTotalAtrasos());
        ps.setInt(14, resumo.getResumoTotalMinutosAtraso());
        ps.setInt(15, resumo.getResumoTotalMinutosNoturno());
        ps.setInt(16, resumo.getResumoTotalFaltas());
        ps.setBoolean(17, resumo.getResumoTemDireitoVale());

        ps.executeUpdate();
        conn.commit();
    }

    // =============================================
    // EDIÇÃO DE REGISTROS
    // =============================================

    public void editarRegistro(int regId, Timestamp entrada, Timestamp saidaInt, Timestamp retornoInt,
                               Timestamp saida, String obs, String editadoPor) throws Exception {
        String sql = "UPDATE ponto_registros SET entrada = ?, saida_intervalo = ?, retorno_intervalo = ?, " +
                "saida = ?, observacao = ?, editado = true, editado_por = ?, editado_em = now() WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setTimestamp(1, entrada);
        ps.setTimestamp(2, saidaInt);
        ps.setTimestamp(3, retornoInt);
        ps.setTimestamp(4, saida);
        ps.setString(5, obs);
        ps.setString(6, editadoPor);
        ps.setInt(7, regId);
        ps.executeUpdate();
        conn.commit();

        // Recalcular horas após edição
        sql = "SELECT funcionario_id, data FROM ponto_registros WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, regId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            calcularHorasTrabalhadasENoturnas(rs.getInt("funcionario_id"), rs.getDate("data"));
        }
    }

    // =============================================
    // JUSTIFICATIVAS
    // =============================================

    public void salvarJustificativa(int funcId, Date data, String tipo, String descricao) throws Exception {
        String sql = "INSERT INTO ponto_justificativas (funcionario_id, data, tipo, descricao, aprovado) " +
                "VALUES (?, ?, ?, ?, false)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, data);
        ps.setString(3, tipo);
        ps.setString(4, descricao);
        ps.executeUpdate();
        conn.commit();
    }

    public void aprovarJustificativa(int justId) throws Exception {
        String sql = "UPDATE ponto_justificativas SET aprovado = true WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, justId);
        ps.executeUpdate();
        conn.commit();
    }

    /**
     * Salvar justificativa para uma data específica (admin)
     */
    public void salvarJustificativaAdmin(int funcId, Date data, String tipo, String descricao, boolean aprovado) throws Exception {
        String sql = "INSERT INTO ponto_justificativas (funcionario_id, data, tipo, descricao, aprovado) " +
                "VALUES (?, ?, ?, ?, ?) " +
                "ON CONFLICT (funcionario_id, data) DO UPDATE " +
                "SET tipo = ?, descricao = ?, aprovado = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, data);
        ps.setString(3, tipo);
        ps.setString(4, descricao);
        ps.setBoolean(5, aprovado);
        ps.setString(6, tipo);
        ps.setString(7, descricao);
        ps.setBoolean(8, aprovado);
        ps.executeUpdate();
        conn.commit();
    }

    /**
     * Excluir justificativa
     */
    public void excluirJustificativa(int funcId, Date data) throws Exception {
        String sql = "DELETE FROM ponto_justificativas WHERE funcionario_id = ? AND data = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, data);
        ps.executeUpdate();
        conn.commit();
    }

    /**
     * Buscar justificativas de um funcionário
     */
    public List<Ponto> listarJustificativas(int funcId) throws Exception {
        List<Ponto> lista = new ArrayList<>();
        String sql = "SELECT j.*, f.nome FROM ponto_justificativas j " +
                "JOIN ponto_funcionarios f ON j.funcionario_id = f.id " +
                "WHERE j.funcionario_id = ? ORDER BY j.data DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Ponto p = new Ponto();
            p.setJustId(rs.getInt("id"));
            p.setFuncId(rs.getInt("funcionario_id"));
            p.setFuncNome(rs.getString("nome"));
            p.setRegData(rs.getDate("data"));
            p.setJustTipo(rs.getString("tipo"));
            p.setJustDescricao(rs.getString("descricao"));
            p.setJustAprovado(rs.getBoolean("aprovado"));
            lista.add(p);
        }
        return lista;
    }

    /**
     * Buscar registro específico por ID
     */
    public Ponto buscarRegistroPorId(int regId) throws Exception {
        String sql = "SELECT r.*, f.nome FROM ponto_registros r " +
                "JOIN ponto_funcionarios f ON r.funcionario_id = f.id " +
                "WHERE r.id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, regId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Ponto p = mapearRegistro(rs);
            p.setFuncNome(rs.getString("nome"));
            return p;
        }
        return null;
    }

    // =============================================
    // UTILITÁRIOS
    // =============================================

    private int getConfigInt(String chave, int valorPadrao) {
        try {
            String sql = "SELECT valor FROM ponto_config WHERE chave = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, chave);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return Integer.parseInt(rs.getString("valor"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return valorPadrao;
    }
}