<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Ponto" %>
<%@ page import="dao.PontoDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Controle de Ponto</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #daa520; padding: 20px; }
        .container { max-width: 1400px; margin: 0 auto; }
        .header {
            background: #1a1a1a;
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        h1 { color: #daa520; font-size: 28px; }
        .card { background: #1a1a1a; border-radius: 15px; padding: 25px; margin-bottom: 20px; color: white; }
        .card h2 { color: #daa520; margin-bottom: 20px; border-bottom: 2px solid #daa520; padding-bottom: 10px; }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            margin: 5px;
        }
        .btn-primary { background: #daa520; color: #1a1a1a; }
        .btn-primary:hover { background: #e09543; }
        .btn-secondary { background: #333; color: white; }
        .btn-secondary:hover { background: #444; }
        .btn-danger { background: #d32f2f; color: white; }
        .btn-success { background: #2e7d32; color: white; }
        .btn-sm { padding: 6px 12px; font-size: 14px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        table th { background: #2a2a2a; padding: 12px; text-align: left; color: #daa520; }
        table td { padding: 12px; border-bottom: 1px solid #333; }
        table tr:hover { background: #2a2a2a; }
        input, select, textarea {
            padding: 10px;
            border: 2px solid #333;
            border-radius: 8px;
            background: #2a2a2a;
            color: white;
            font-size: 14px;
            width: 100%;
            margin: 8px 0;
        }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #daa520; }
        label { color: #daa520; font-weight: 600; display: block; margin-top: 10px; }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.7);
        }
        .modal-content {
            background: #1a1a1a;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
            color: white;
            max-height: 90vh;
            overflow-y: auto;
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #daa520;
            padding-bottom: 10px;
        }
        .modal-header h3 { color: #daa520; }
        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover { color: white; }
        .msg {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }
        .msg-sucesso { background: #2e7d32; }
        .msg-erro { background: #d32f2f; }
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .badge-success { background: #2e7d32; }
        .badge-danger { background: #d32f2f; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<%
    String admin = (String) session.getAttribute("pontoAdmin");

    if (admin == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String erro = (String) request.getAttribute("erro");
    String sucesso = (String) request.getAttribute("sucesso");

    PontoDAO dao = new PontoDAO();
    List<Ponto> funcionarios = dao.listarFuncionarios();
%>

<!-- PAINEL ADMIN -->
<div class="container">
    <div class="header">
        <h1>⚙️ Painel Admin - Controle de Ponto</h1>
        <form action="<%= request.getContextPath() %>/ponto-logout" method="post" style="margin: 0;">
            <button type="submit" class="btn btn-secondary">Sair</button>
        </form>
    </div>

    <% if (erro != null) { %><div class="msg msg-erro"><%= erro %></div><% } %>
    <% if (sucesso != null) { %><div class="msg msg-sucesso"><%= sucesso %></div><% } %>

    <div class="card">
        <h2>🎯 Ações Rápidas</h2>
        <button onclick="abrirModal('modalFunc')" class="btn btn-primary">➕ Novo Funcionário</button>
        <button onclick="abrirModal('modalHorario')" class="btn btn-primary">⏰ Configurar Horário</button>
        <button onclick="abrirModal('modalRegistros')" class="btn btn-primary">📋 Ver Registros</button>
    </div>

    <!-- LISTA DE FUNCIONÁRIOS -->
    <div class="card">
        <h2>👥 Funcionários</h2>
        <table>
            <thead>
            <tr>
                <th>Nome</th>
                <th>CPF</th>
                <th>Telefone</th>
                <th>Status</th>
                <th>Ações</th>
            </tr>
            </thead>
            <tbody>
            <% for (Ponto f : funcionarios) { %>
            <tr>
                <td><%= f.getFuncNome() %></td>
                <td><%= f.getFuncCpf() %></td>
                <td><%= f.getFuncTelefone() != null ? f.getFuncTelefone() : "-" %></td>
                <td>
                    <% if (f.getFuncAtivo()) { %>
                    <span class="badge badge-success">Ativo</span>
                    <% } else { %>
                    <span class="badge badge-danger">Inativo</span>
                    <% } %>
                </td>
                <td>
                    <button onclick="verHorarios(<%= f.getFuncId() %>, '<%= f.getFuncNome() %>')" class="btn btn-secondary btn-sm">Horários</button>
                    <form action="<%= request.getContextPath() %>/ponto-admin" method="post" style="display: inline;">
                        <input type="hidden" name="acao" value="alternar-status">
                        <input type="hidden" name="funcId" value="<%= f.getFuncId() %>">
                        <button type="submit" class="btn <%= f.getFuncAtivo() ? "btn-danger" : "btn-success" %> btn-sm">
                            <%= f.getFuncAtivo() ? "Desativar" : "Ativar" %>
                        </button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- MODAL NOVO FUNCIONÁRIO -->
<div id="modalFunc" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>➕ Novo Funcionário</h3>
            <span class="close" onclick="fecharModal('modalFunc')">&times;</span>
        </div>
        <form action="<%= request.getContextPath() %>/ponto-admin" method="post">
            <input type="hidden" name="acao" value="salvar-funcionario">
            <label>Nome Completo *</label>
            <input type="text" name="nome" required>
            <label>CPF *</label>
            <input type="text" name="cpf" id="cpfModal" maxlength="14" required>
            <label>Telefone</label>
            <input type="text" name="telefone" id="telModal" maxlength="15">
            <label>Senha *</label>
            <input type="password" name="senha" required>
            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Salvar</button>
        </form>
    </div>
</div>

<!-- MODAL HORÁRIO -->
<div id="modalHorario" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>⏰ Configurar Horário</h3>
            <span class="close" onclick="fecharModal('modalHorario')">&times;</span>
        </div>
        <form action="<%= request.getContextPath() %>/ponto-admin" method="post">
            <input type="hidden" name="acao" value="salvar-horario">
            <label>Funcionário *</label>
            <select name="funcId" required>
                <option value="">Selecione...</option>
                <% for (Ponto f : funcionarios) { if (f.getFuncAtivo()) { %>
                <option value="<%= f.getFuncId() %>"><%= f.getFuncNome() %></option>
                <% }} %>
            </select>
            <label>Dia da Semana *</label>
            <select name="diaSemana" required>
                <option value="segunda">Segunda-feira</option>
                <option value="terca">Terça-feira</option>
                <option value="quarta">Quarta-feira</option>
                <option value="quinta">Quinta-feira</option>
                <option value="sexta">Sexta-feira</option>
                <option value="sabado">Sábado</option>
                <option value="domingo">Domingo</option>
                <option value="feriado">Feriado</option>
                <option value="temporada">Temporada</option>
            </select>
            <div class="form-row">
                <div>
                    <label>Horário Entrada *</label>
                    <input type="time" name="horaEntrada" required>
                </div>
                <div>
                    <label>Tolerância (min) *</label>
                    <input type="number" name="tolerancia" value="15" min="0" max="60" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Salvar</button>
        </form>
    </div>
</div>

<!-- MODAL REGISTROS -->
<div id="modalRegistros" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>📋 Consultar Registros</h3>
            <span class="close" onclick="fecharModal('modalRegistros')">&times;</span>
        </div>
        <form method="get" id="formFiltro">
            <label>Funcionário</label>
            <select name="filtroFunc" id="filtroFunc">
                <option value="">Todos</option>
                <% for (Ponto f : funcionarios) { %>
                <option value="<%= f.getFuncId() %>"><%= f.getFuncNome() %></option>
                <% } %>
            </select>
            <div class="form-row">
                <div>
                    <label>Data Início</label>
                    <input type="date" name="dataIni" id="dataIni">
                </div>
                <div>
                    <label>Data Fim</label>
                    <input type="date" name="dataFim" id="dataFim">
                </div>
            </div>
            <button type="button" onclick="carregarRegistros()" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Consultar</button>
        </form>
        <div id="resultadoRegistros" style="margin-top: 20px;"></div>
    </div>
</div>

<!-- MODAL VER HORÁRIOS -->
<div id="modalVerHorarios" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="tituloHorarios">⏰ Horários</h3>
            <span class="close" onclick="fecharModal('modalVerHorarios')">&times;</span>
        </div>
        <div id="listaHorarios"></div>
    </div>
</div>

<script>
    function abrirModal(id) {
        document.getElementById(id).style.display = 'block';
    }

    function fecharModal(id) {
        document.getElementById(id).style.display = 'none';
    }

    window.onclick = function(e) {
        if (e.target.classList.contains('modal')) {
            e.target.style.display = 'none';
        }
    }

    // Máscara CPF
    const cpfEl = document.getElementById('cpfModal');
    if (cpfEl) {
        cpfEl.addEventListener('input', function(e) {
            let v = e.target.value.replace(/\D/g, '');
            if (v.length > 11) v = v.substring(0, 11);
            if (v.length > 9) v = v.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
            else if (v.length > 6) v = v.replace(/(\d{3})(\d{3})(\d{1,3})/, '$1.$2.$3');
            else if (v.length > 3) v = v.replace(/(\d{3})(\d{1,3})/, '$1.$2');
            e.target.value = v;
        });
    }

    // Máscara Telefone
    const telEl = document.getElementById('telModal');
    if (telEl) {
        telEl.addEventListener('input', function(e) {
            let v = e.target.value.replace(/\D/g, '');
            if (v.length > 11) v = v.substring(0, 11);
            if (v.length > 10) v = v.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
            else if (v.length > 6) v = v.replace(/(\d{2})(\d{4})(\d{0,4})/, '($1) $2-$3');
            else if (v.length > 2) v = v.replace(/(\d{2})(\d{0,5})/, '($1) $2');
            e.target.value = v;
        });
    }

    // Carregar registros via AJAX simplificado (você pode melhorar)
    function carregarRegistros() {
        const funcId = document.getElementById('filtroFunc').value;
        const dataIni = document.getElementById('dataIni').value;
        const dataFim = document.getElementById('dataFim').value;

        // Por simplicidade, recarrega a página (você pode fazer AJAX)
        document.getElementById('resultadoRegistros').innerHTML = '<p style="color: #daa520;">Implemente AJAX ou recarregue a página com filtros...</p>';
    }

    // Ver horários de um funcionário
    function verHorarios(funcId, nome) {
        document.getElementById('tituloHorarios').textContent = '⏰ Horários de ' + nome;
        // Aqui você pode carregar via AJAX os horários
        document.getElementById('listaHorarios').innerHTML = '<p style="color: #daa520;">Carregando...</p>';
        abrirModal('modalVerHorarios');

        // Simulação - em produção, faça AJAX
        setTimeout(() => {
            document.getElementById('listaHorarios').innerHTML =
                '<p style="color: #ccc;">Configure os horários usando o botão "Configurar Horário"</p>';
        }, 500);
    }
</script>
</body>
</html>
