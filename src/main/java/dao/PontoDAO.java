package dao;

import connection.SingleConnectionBanco;
import model.Ponto;
import java.security.MessageDigest;
import java.sql.*;
import java.sql.Date;
import java.util.*;

public class PontoDAO {

    private Connection conn;

    public PontoDAO() {
        conn = SingleConnectionBanco.getConnection();
    }

    // ===== HASH SENHA =====
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

    // ===== AUTENTICAÇÃO =====
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

    // ===== REGISTRAR PONTO =====
    public void registrarPonto(int funcId, Date data) throws Exception {
        // Buscar registro do dia
        String sql = "SELECT * FROM ponto_registros WHERE funcionario_id = ? AND data = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, data);
        ResultSet rs = ps.executeQuery();

        Timestamp agora = new Timestamp(System.currentTimeMillis());

        if (rs.next()) {
            // Já existe - atualizar próximo campo
            if (rs.getTimestamp("entrada") != null && rs.getTimestamp("saida_intervalo") == null) {
                sql = "UPDATE ponto_registros SET saida_intervalo = ? WHERE funcionario_id = ? AND data = ?";
            } else if (rs.getTimestamp("saida_intervalo") != null && rs.getTimestamp("retorno_intervalo") == null) {
                sql = "UPDATE ponto_registros SET retorno_intervalo = ? WHERE funcionario_id = ? AND data = ?";
            } else if (rs.getTimestamp("retorno_intervalo") != null && rs.getTimestamp("saida") == null) {
                sql = "UPDATE ponto_registros SET saida = ? WHERE funcionario_id = ? AND data = ?";
            } else {
                return; // Já completou o dia
            }
            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, agora);
            ps.setInt(2, funcId);
            ps.setDate(3, data);
        } else {
            // Primeiro registro - entrada
            sql = "INSERT INTO ponto_registros (funcionario_id, data, entrada) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, funcId);
            ps.setDate(2, data);
            ps.setTimestamp(3, agora);
        }

        ps.executeUpdate();
        conn.commit();
    }

    // ===== BUSCAR REGISTRO DO DIA =====
    public Ponto buscarRegistroDia(int funcId, Date data) throws Exception {
        String sql = "SELECT * FROM ponto_registros WHERE funcionario_id = ? AND data = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setDate(2, data);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Ponto p = new Ponto();
            p.setRegId(rs.getInt("id"));
            p.setRegData(rs.getDate("data"));
            p.setRegEntrada(rs.getTimestamp("entrada"));
            p.setRegSaidaIntervalo(rs.getTimestamp("saida_intervalo"));
            p.setRegRetornoIntervalo(rs.getTimestamp("retorno_intervalo"));
            p.setRegSaida(rs.getTimestamp("saida"));
            p.setRegEditado(rs.getBoolean("editado"));
            return p;
        }
        return null;
    }

    // ===== BUSCAR HORÁRIO DO DIA =====
    public Ponto buscarHorarioDia(int funcId, String diaSemana) throws Exception {
        String sql = "SELECT * FROM ponto_horarios WHERE funcionario_id = ? AND dia_semana = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setString(2, diaSemana);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Ponto p = new Ponto();
            p.setHorId(rs.getInt("id"));
            p.setHorDiaSemana(rs.getString("dia_semana"));
            p.setHorEntrada(rs.getTime("hora_entrada"));
            p.setHorTolerancia(rs.getInt("tolerancia_minutos"));
            return p;
        }
        return null;
    }

    // ===== ADMIN - LISTAR FUNCIONÁRIOS =====
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
            lista.add(p);
        }
        return lista;
    }

    // ===== ADMIN - SALVAR FUNCIONÁRIO =====
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

    // ===== ADMIN - ALTERNAR STATUS =====
    public void alternarStatus(int funcId) throws Exception {
        String sql = "UPDATE ponto_funcionarios SET ativo = NOT ativo WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.executeUpdate();
        conn.commit();
    }

    // ===== ADMIN - SALVAR HORÁRIO =====
    public void salvarHorario(int funcId, String diaSemana, Time horaEntrada, int tolerancia) throws Exception {
        String sql = "INSERT INTO ponto_horarios (funcionario_id, dia_semana, hora_entrada, tolerancia_minutos) " +
                "VALUES (?, ?, ?, ?) " +
                "ON CONFLICT (funcionario_id, dia_semana) " +
                "DO UPDATE SET hora_entrada = ?, tolerancia_minutos = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, funcId);
        ps.setString(2, diaSemana);
        ps.setTime(3, horaEntrada);
        ps.setInt(4, tolerancia);
        ps.setTime(5, horaEntrada);
        ps.setInt(6, tolerancia);
        ps.executeUpdate();
        conn.commit();
    }

    // ===== ADMIN - LISTAR REGISTROS =====
    public List<Ponto> listarRegistros(Integer funcId, Date dataInicio, Date dataFim) throws Exception {
        List<Ponto> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT r.*, f.nome, f.cpf FROM ponto_registros r " +
                        "JOIN ponto_funcionarios f ON r.funcionario_id = f.id WHERE 1=1"
        );

        if (funcId != null) sql.append(" AND r.funcionario_id = ?");
        if (dataInicio != null) sql.append(" AND r.data >= ?");
        if (dataFim != null) sql.append(" AND r.data <= ?");
        sql.append(" ORDER BY r.data DESC, f.nome");

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        int idx = 1;
        if (funcId != null) ps.setInt(idx++, funcId);
        if (dataInicio != null) ps.setDate(idx++, dataInicio);
        if (dataFim != null) ps.setDate(idx++, dataFim);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Ponto p = new Ponto();
            p.setRegId(rs.getInt("id"));
            p.setFuncId(rs.getInt("funcionario_id"));
            p.setFuncNome(rs.getString("nome"));
            p.setFuncCpf(rs.getString("cpf"));
            p.setRegData(rs.getDate("data"));
            p.setRegEntrada(rs.getTimestamp("entrada"));
            p.setRegSaidaIntervalo(rs.getTimestamp("saida_intervalo"));
            p.setRegRetornoIntervalo(rs.getTimestamp("retorno_intervalo"));
            p.setRegSaida(rs.getTimestamp("saida"));
            p.setRegEditado(rs.getBoolean("editado"));
            lista.add(p);
        }
        return lista;
    }

    // ===== ADMIN - EDITAR REGISTRO =====
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
    }

    // ===== ADMIN - LISTAR HORÁRIOS DE FUNCIONÁRIO =====
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
            p.setHorTolerancia(rs.getInt("tolerancia_minutos"));
            lista.add(p);
        }
        return lista;
    }
    public void notificarAtraso(int funcId) {
        // Implemente aqui usando API de sua preferência
        // Evolution API, Twilio, Baileys, etc
    }

}