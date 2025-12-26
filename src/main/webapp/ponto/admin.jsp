<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Ponto, dao.PontoDAO, java.sql.*, java.util.*, java.text.*, java.time.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Controle de Ponto</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #daa520;
            padding: 20px;
        }

        .container {
            max-width: 1600px;
            margin: 0 auto;
        }

        .header {
            background: #000000;
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        h1 {
            color: #daa520;
            font-size: 28px;
            font-weight: 700;
        }

        .card {
            background: #000000;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            color: white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        .card h2 {
            color: #daa520;
            margin-bottom: 20px;
            border-bottom: 2px solid #daa520;
            padding-bottom: 12px;
            font-size: 22px;
            font-weight: 600;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            margin: 5px;
            display: inline-block;
            text-decoration: none;
            text-align: center;
        }

        .btn-primary { background: #daa520; color: #000000; }
        .btn-primary:hover { background: #e09543; transform: translateY(-1px); }
        .btn-secondary { background: #333; color: white; }
        .btn-secondary:hover { background: #444; }
        .btn-danger { background: #d32f2f; color: white; }
        .btn-success { background: #2e7d32; color: white; }
        .btn-warning { background: #f57c00; color: white; }
        .btn-sm { padding: 7px 14px; font-size: 13px; }

        /* Tabela Responsiva */
        .table-wrapper {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            min-width: 600px;
        }

        table th {
            background: #2a2a2a;
            padding: 14px 12px;
            text-align: left;
            color: #daa520;
            font-weight: 600;
            font-size: 14px;
            white-space: nowrap;
        }

        table td {
            padding: 12px;
            border-bottom: 1px solid #333;
            font-size: 14px;
        }

        table tr:hover { background: #2a2a2a; }

        input, select, textarea {
            padding: 11px;
            border: 2px solid #333;
            border-radius: 8px;
            background: #2a2a2a;
            color: white;
            font-size: 14px;
            width: 100%;
            margin: 8px 0;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #daa520;
        }

        label {
            color: #daa520;
            font-weight: 600;
            display: block;
            margin-top: 12px;
            font-size: 14px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.75);
            overflow-y: auto;
            padding: 20px;
        }

        .modal-content {
            background: #000000;
            margin: 20px auto;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 700px;
            color: white;
            max-height: calc(100vh - 40px);
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 2px solid #daa520;
            padding-bottom: 12px;
        }

        .modal-header h3 {
            color: #daa520;
            font-size: 22px;
        }

        .close {
            color: #aaa;
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            line-height: 1;
        }

        .close:hover { color: white; }

        .msg {
            padding: 14px;
            border-radius: 10px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: 500;
        }

        .msg-sucesso { background: #2e7d32; }
        .msg-erro { background: #d32f2f; }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }

        .badge-success { background: #2e7d32; }
        .badge-danger { background: #d32f2f; }
        .badge-warning { background: #f57c00; }
        .badge-info { background: #0288d1; }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .relatorio-item {
            background: #2a2a2a;
            padding: 15px;
            border-radius: 10px;
            margin: 12px 0;
            border-left: 4px solid #daa520;
        }

        .relatorio-item.alerta {
            border-left-color: #d32f2f;
            background: rgba(211, 47, 47, 0.1);
        }

        .relatorio-item.falta {
            border-left-color: #f57c00;
            background: rgba(245, 124, 0, 0.1);
        }

        .relatorio-item.autorizado {
            border-left-color: #0288d1;
            background: rgba(2, 136, 209, 0.1);
        }

        .relatorio-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .relatorio-acoes {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .resumo-box {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .resumo-card {
            background: #2a2a2a;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .resumo-valor {
            font-size: 32px;
            font-weight: bold;
            color: #daa520;
            margin: 10px 0;
        }

        .resumo-label {
            color: #ccc;
            font-size: 14px;
        }

        .motivo-abono {
            background: #0288d1;
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 13px;
            margin-top: 8px;
            display: inline-block;
        }

        .horarios-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            font-size: 14px;
        }

        .gps-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            font-size: 13px;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #444;
        }

        /* RESPONSIVIDADE */
        @media (max-width: 1024px) {
            .container { max-width: 100%; }
            h1 { font-size: 24px; }
            .card h2 { font-size: 20px; }
            .resumo-box { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 768px) {
            body { padding: 10px; }
            .header { flex-direction: column; gap: 15px; padding: 15px 20px; }
            h1 { font-size: 22px; text-align: center; }
            .card { padding: 15px; }
            .card h2 { font-size: 18px; }
            .btn { width: 100%; margin: 5px 0; }
            .btn-sm { width: auto; padding: 6px 10px; font-size: 12px; }
            .form-row { grid-template-columns: 1fr; }
            table { font-size: 13px; }
            table th, table td { padding: 8px 6px; }
            .relatorio-header { flex-direction: column; align-items: flex-start; }
            .relatorio-acoes { width: 100%; justify-content: flex-start; }
            .horarios-grid, .gps-grid { grid-template-columns: 1fr; gap: 8px; }
            .resumo-box { grid-template-columns: 1fr; }
            .resumo-valor { font-size: 28px; }
            .modal { padding: 10px; }
            .modal-content { padding: 20px; margin: 10px auto; width: 95%; }
            .modal-header h3 { font-size: 18px; }
            .close { font-size: 28px; }
            .badge { font-size: 11px; padding: 4px 8px; }
            .motivo-abono { font-size: 12px; padding: 6px 10px; }
        }

        @media (max-width: 480px) {
            body { padding: 5px; }
            h1 { font-size: 20px; }
            .card { padding: 12px; margin-bottom: 15px; border-radius: 10px; }
            .card h2 { font-size: 16px; margin-bottom: 15px; }
            .btn { font-size: 14px; padding: 10px 20px; }
            .btn-sm { font-size: 11px; padding: 5px 8px; }
            table { font-size: 12px; }
            .relatorio-item { padding: 12px; font-size: 13px; }
            .resumo-valor { font-size: 24px; }
            .resumo-label { font-size: 12px; }
            input, select, textarea { font-size: 16px; padding: 10px; }
            .modal-content { padding: 15px; width: 98%; }
        }

        @media print {
            body { background: white; padding: 0; }
            .header form, .btn, .modal { display: none !important; }
            .card { box-shadow: none; page-break-inside: avoid; }
        }
    </style>
</head>
<body>
<%
    String admin = (String) session.getAttribute("pontoAdmin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/ponto/index.jsp");
        return;
    }

    String erro = (String) request.getAttribute("erro");
    String sucesso = (String) request.getAttribute("sucesso");

    PontoDAO dao = new PontoDAO();
    List<Ponto> funcionarios = dao.listarFuncionarios();
    List<Ponto> relatorioDetalhado = (List<Ponto>) request.getAttribute("relatorioDetalhado");
    Ponto resumoMensal = (Ponto) request.getAttribute("resumoMensal");
    Ponto funcSelecionado = (Ponto) request.getAttribute("funcSelecionado");
%>

<div class="container">
    <div class="header">
        <h1>⚙️ Painel Admin - SaaS</h1>
        <form action="<%= request.getContextPath() %>/ponto" method="post" style="margin: 0;">
            <input type="hidden" name="acao" value="logout">
            <button type="submit" class="btn btn-secondary">Sair</button>
        </form>
    </div>

    <% if (erro != null) { %><div class="msg msg-erro"><%= erro %></div><% } %>
    <% if (sucesso != null) { %><div class="msg msg-sucesso"><%= sucesso %></div><% } %>

    <div class="card">
        <h2>🎯 Ações Rápidas</h2>
        <button onclick="abrirModal('modalFunc')" class="btn btn-primary">➕ Novo Funcionário</button>
        <button onclick="abrirModal('modalRelatorio')" class="btn btn-primary">📊 Relatório Detalhado</button>
        <button onclick="window.location.href='<%= request.getContextPath() %>/ponto?acao=listar-zonas'" class="btn btn-primary">🗺️ Zonas Autorizadas</button>
    </div>

    <div class="card">
        <h2>👥 Funcionários</h2>
        <div class="table-wrapper">
            <table>
                <thead>
                <tr><th>Nome</th><th>CPF</th><th>Telefone</th><th>Status</th><th>Ações</th></tr>
                </thead>
                <tbody>
                <% for (Ponto f : funcionarios) { %>
                <tr>
                    <td><strong><%= f.getFuncNome() %></strong></td>
                    <td><%= f.getFuncCpf() %></td>
                    <td><%= f.getFuncTelefone() != null ? f.getFuncTelefone() : "-" %></td>
                    <td><span class="badge <%= f.getFuncAtivo() ? "badge-success" : "badge-danger" %>"><%= f.getFuncAtivo() ? "Ativo" : "Inativo" %></span></td>
                    <td>
                        <button onclick="editarFuncionario(<%= f.getFuncId() %>, '<%= f.getFuncNome().replace("'", "\\'") %>', '<%= f.getFuncCpf() %>', '<%= f.getFuncTelefone() != null ? f.getFuncTelefone() : "" %>')" class="btn btn-secondary btn-sm" title="Editar">✏️</button>
                        <button onclick="alternarStatusFunc(<%= f.getFuncId() %>)" class="btn <%= f.getFuncAtivo() ? "btn-warning" : "btn-success" %> btn-sm" title="<%= f.getFuncAtivo() ? "Inativar" : "Ativar" %>">
                            <%= f.getFuncAtivo() ? "🔒 Inativar" : "🔓 Ativar" %>
                        </button>
                        <button onclick="excluirFuncionario(<%= f.getFuncId() %>, '<%= f.getFuncNome().replace("'", "\\'") %>')" class="btn btn-danger btn-sm" title="Excluir">🗑️</button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <% if (relatorioDetalhado != null && !relatorioDetalhado.isEmpty()) { %>
    <div class="card">
        <div class="relatorio-header" style="margin-bottom: 20px;">
            <h2 style="margin: 0;">📊 Relatório Detalhado - <%= funcSelecionado.getFuncNome() %></h2>
            <form action="<%= request.getContextPath() %>/ponto-export" method="post" style="margin: 0;">
                <input type="hidden" name="funcId" value="<%= funcSelecionado.getFuncId() %>">
                <input type="hidden" name="dataInicio" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(request.getAttribute("periodoInicio")) %>">
                <input type="hidden" name="dataFim" value="<%= new SimpleDateFormat("yyyy-MM-dd").format(request.getAttribute("periodoFim")) %>">
                <button type="submit" class="btn btn-success">📥 Exportar Excel</button>
            </form>
        </div>
        <p style="color: #ccc; margin-bottom: 20px;">
            Período: <%= new SimpleDateFormat("dd/MM/yyyy").format(request.getAttribute("periodoInicio")) %> até <%= new SimpleDateFormat("dd/MM/yyyy").format(request.getAttribute("periodoFim")) %>
        </p>

        <%
            int totalDias = 0, totalAtrasos = 0, totalFaltas = 0, totalMinutos = 0, totalNoturno = 0;
            for (Ponto reg : relatorioDetalhado) {
                boolean isFalta = "Falta".equals(reg.getStatusDia());
                boolean isJustificado = reg.getJustTipo() != null;
                boolean temAtraso = reg.getTemAtraso() != null && reg.getTemAtraso();
                boolean atrasoAutorizado = reg.getAtrasoAutorizado() != null && reg.getAtrasoAutorizado();

                if (!isFalta && !isJustificado) totalDias++;
                if (temAtraso && !atrasoAutorizado) totalAtrasos++;
                if (isFalta && !isJustificado) totalFaltas++;
                if (reg.getRegMinutosTrabalhados() != null) totalMinutos += reg.getRegMinutosTrabalhados();
                if (reg.getRegMinutosNoturno() != null) totalNoturno += reg.getRegMinutosNoturno();

                String cssClass = "";
                if (temAtraso && !atrasoAutorizado) cssClass = "alerta";
                else if (isFalta) cssClass = "falta";
                else if (isJustificado) cssClass = "autorizado";
        %>
        <div class="relatorio-item <%= cssClass %>">
            <div class="relatorio-header">
                <strong style="font-size: 16px;"><%= new SimpleDateFormat("dd/MM/yyyy").format(reg.getRegData()) %> - <%= reg.getDiaSemanaTexto() %></strong>
                <div class="relatorio-acoes">
                    <span class="badge <%= isFalta ? "badge-warning" : (isJustificado ? "badge-info" : (temAtraso && !atrasoAutorizado ? "badge-danger" : "badge-success")) %>">
                        <%= reg.getStatusDia() %>
                    </span>

                    <% if (reg.getJustTipo() != null && reg.getJustDescricao() != null && !reg.getJustDescricao().trim().isEmpty()) { %>
                    <span class="motivo-abono" title="<%= reg.getJustDescricao() %>">
                        📝 <%= reg.getJustDescricao().length() > 20 ? reg.getJustDescricao().substring(0, 20) + "..." : reg.getJustDescricao() %>
                    </span>
                    <% } %>

                    <% if (!isFalta && !isJustificado) { %>
                    <button onclick="editarRegistro(<%= reg.getRegId() %>, '<%= new SimpleDateFormat("yyyy-MM-dd").format(reg.getRegData()) %>', '<%= reg.getRegEntrada() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegEntrada()) : "" %>', '<%= reg.getRegSaidaIntervalo() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegSaidaIntervalo()) : "" %>', '<%= reg.getRegRetornoIntervalo() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegRetornoIntervalo()) : "" %>', '<%= reg.getRegSaida() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegSaida()) : "" %>', '<%= reg.getRegObservacao() != null ? reg.getRegObservacao().replace("'", "\\'").replace("\n", " ") : "" %>')" class="btn btn-secondary btn-sm" title="Editar">✏️</button>

                    <% if (reg.getRegEntrada() != null) { %>
                    <% if (!atrasoAutorizado) { %>
                    <button onclick="marcarAtraso(<%= reg.getRegId() %>, <%= reg.getFuncId() %>, '<%= new SimpleDateFormat("yyyy-MM-dd").format(reg.getRegData()) %>')" class="btn btn-warning btn-sm" title="Marcar como Atraso">⏰ Atraso</button>
                    <% } else { %>
                    <button onclick="autorizarAtraso(<%= reg.getRegId() %>, false)" class="btn btn-success btn-sm" title="Remover Marcação de Atraso">✅ Sem Atraso</button>
                    <% } %>
                    <% } %>
                    <% } %>

                    <% if (isFalta && !isJustificado) { %>
                    <button onclick="abonarFalta(<%= reg.getFuncId() %>, '<%= new SimpleDateFormat("yyyy-MM-dd").format(reg.getRegData()) %>')" class="btn btn-success btn-sm">✅ Abonar</button>
                    <% } else if (isJustificado) { %>
                    <button onclick="removerJustificativa(<%= reg.getFuncId() %>, '<%= new SimpleDateFormat("yyyy-MM-dd").format(reg.getRegData()) %>')" class="btn btn-danger btn-sm">❌</button>
                    <% } %>
                </div>
            </div>

            <% if (!isFalta && !isJustificado) { %>
            <div class="horarios-grid">
                <div><span style="color: #999;">Entrada:</span> <strong><%= reg.getRegEntrada() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegEntrada()) : "-" %></strong></div>
                <div><span style="color: #999;">Saída Intervalo:</span> <strong><%= reg.getRegSaidaIntervalo() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegSaidaIntervalo()) : "-" %></strong></div>
                <div><span style="color: #999;">Retorno Intervalo:</span> <strong><%= reg.getRegRetornoIntervalo() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegRetornoIntervalo()) : "-" %></strong></div>
                <div><span style="color: #999;">Saída:</span> <strong><%= reg.getRegSaida() != null ? new SimpleDateFormat("HH:mm").format(reg.getRegSaida()) : "-" %></strong></div>
                <% if (reg.getRegMinutosTrabalhados() != null && reg.getRegMinutosTrabalhados() > 0) { %>
                <div><span style="color: #999;">Horas Trabalhadas:</span> <strong style="color: #4ade80;"><%= reg.getHorasTrabalhadasFormatado() %></strong></div>
                <% } %>
                <% if (temAtraso && reg.getRegMinutosAtraso() > 0) { %>
                <div><span style="color: #999;">Atraso:</span> <strong style="color: <%= atrasoAutorizado ? "#0288d1" : "#ff6b6b" %>;"><%= reg.getAtrasoFormatado() %> <%= atrasoAutorizado ? "(Autorizado)" : "" %></strong></div>
                <% } %>
            </div>
            <% } %>

            <% if (reg.getGpsLatitude() != null) { %>
            <div class="gps-grid">
                <div>
                    <span style="color: #999;">Localização:</span>
                    <strong>
                        <%= reg.getGpsIcone() %> <%= reg.getGpsTextoStatus() %>
                        <% if (reg.getGpsTipoLocalizacao() != null) { %>
                        (<%= "gps".equals(reg.getGpsTipoLocalizacao()) ? "GPS" : "IP" %>)
                        <% } %>
                    </strong>
                </div>
                <% if (reg.getGpsPrecisao() != null) { %>
                <div>
                    <span style="color: #999;">Precisão:</span>
                    <strong style="color: <%= reg.getGpsPrecisao() < 50 ? "#4ade80" : (reg.getGpsPrecisao() < 100 ? "#f59e0b" : "#ef4444") %>;">
                        <%= reg.getGpsPrecisao() %>m
                    </strong>
                </div>
                <% } %>
                <div style="grid-column: span 2;">
                    <a href="<%= reg.getGoogleMapsLink() %>" target="_blank" class="btn btn-secondary btn-sm" style="font-size: 12px; padding: 5px 10px;">
                        🗺️ Ver no Mapa
                    </a>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
    <% } %>

    <% if (resumoMensal != null) { %>
    <div class="card">
        <h2>📈 Resumo Mensal - <%= funcSelecionado.getFuncNome() %></h2>
        <div class="resumo-box">
            <div class="resumo-card"><div class="resumo-label">Dias Trabalhados</div><div class="resumo-valor"><%= resumoMensal.getResumoTotalDiasTrabalhados() %></div></div>
            <div class="resumo-card"><div class="resumo-label">Total Horas</div><div class="resumo-valor"><%= String.format("%02d:%02d", resumoMensal.getResumoTotalMinutosTrabalhados()/60, resumoMensal.getResumoTotalMinutosTrabalhados()%60) %></div></div>
            <div class="resumo-card"><div class="resumo-label">Atrasos</div><div class="resumo-valor" style="color: #ff6b6b;"><%= resumoMensal.getResumoTotalAtrasos() %></div></div>
            <div class="resumo-card"><div class="resumo-label">Direito ao Vale</div><div class="resumo-valor" style="color: <%= resumoMensal.getResumoTemDireitoVale() ? "#4ade80" : "#ff6b6b" %>;"><%= resumoMensal.getResumoTemDireitoVale() ? "SIM" : "NÃO" %></div></div>
        </div>
    </div>
    <% } %>
</div>

<div id="modalFunc" class="modal"><div class="modal-content">
    <div class="modal-header"><h3>➕ Novo Funcionário</h3><span class="close" onclick="fecharModal('modalFunc')">&times;</span></div>
    <form action="<%= request.getContextPath() %>/ponto" method="post"><input type="hidden" name="acao" value="salvar-funcionario">
        <label>Nome Completo *</label><input type="text" name="nome" required>
        <label>CPF *</label><input type="text" name="cpf" id="cpfModal" maxlength="14" required>
        <label>Telefone</label><input type="text" name="telefone" id="telefoneModal" maxlength="15">
        <label>Senha *</label><input type="password" name="senha" required minlength="4">
        <button type="submit" class="btn btn-primary" style="width: 100%;">Salvar</button>
    </form>
</div></div>

<div id="modalEditarFunc" class="modal"><div class="modal-content">
    <div class="modal-header"><h3>✏️ Editar Funcionário</h3><span class="close" onclick="fecharModal('modalEditarFunc')">&times;</span></div>
    <form action="<%= request.getContextPath() %>/ponto" method="post">
        <input type="hidden" name="acao" value="editar-funcionario">
        <input type="hidden" name="funcId" id="editFuncId">
        <label>Nome Completo *</label>
        <input type="text" name="nome" id="editFuncNome" required>
        <label>CPF *</label>
        <input type="text" name="cpf" id="editFuncCpf" maxlength="14" required readonly style="background: #3a3a3a;">
        <small style="color: #999;">CPF não pode ser alterado</small>
        <label>Telefone</label>
        <input type="text" name="telefone" id="editFuncTelefone" maxlength="15">
        <label>Nova Senha (deixe em branco para não alterar)</label>
        <input type="password" name="novaSenha" id="editFuncSenha" minlength="4">
        <small style="color: #999;">Preencha apenas se quiser alterar a senha</small>
        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Salvar Alterações</button>
    </form>
</div></div>

<div id="modalRelatorio" class="modal"><div class="modal-content">
    <div class="modal-header"><h3>📊 Gerar Relatório</h3><span class="close" onclick="fecharModal('modalRelatorio')">&times;</span></div>
    <form action="<%= request.getContextPath() %>/ponto" method="post"><input type="hidden" name="acao" value="relatorio-detalhado">
        <label>Funcionário *</label><select name="funcId" required><option value="">Selecione...</option><% for (Ponto f : funcionarios) { %><option value="<%= f.getFuncId() %>"><%= f.getFuncNome() %></option><% } %></select>
        <div class="form-row"><div><label>Início</label><input type="date" name="dataInicio" id="dataInicioRel" required></div><div><label>Fim</label><input type="date" name="dataFim" id="dataFimRel" required></div></div>
        <button type="submit" class="btn btn-primary" style="width: 100%;">Gerar</button>
    </form>
</div></div>

<div id="modalAbonar" class="modal"><div class="modal-content">
    <div class="modal-header"><h3>✅ Abonar Falta</h3><span class="close" onclick="fecharModal('modalAbonar')">&times;</span></div>
    <form action="<%= request.getContextPath() %>/ponto" method="post">
        <input type="hidden" name="acao" value="abonar-falta"><input type="hidden" name="funcId" id="abonarFuncId"><input type="hidden" name="data" id="abonarData">
        <input type="hidden" name="dataInicio" id="abonarDataInicio"><input type="hidden" name="dataFim" id="abonarDataFim">
        <label>Tipo de Justificativa *</label>
        <select name="tipo" required>
            <option value="feriado">Feriado</option>
            <option value="folga">Folga</option>
            <option value="atestado">Atestado Médico</option>
            <option value="autorizado">Autorizado</option>
        </select>
        <label>Observação</label><textarea name="descricao" rows="3" placeholder="Ex: Feriado municipal, Atestado apresentado, etc."></textarea>
        <button type="submit" class="btn btn-primary" style="width: 100%;">Confirmar Abono</button>
    </form>
</div></div>

<div id="modalEditarReg" class="modal"><div class="modal-content">
    <div class="modal-header"><h3>✏️ Editar Registro</h3><span class="close" onclick="fecharModal('modalEditarReg')">&times;</span></div>
    <form action="<%= request.getContextPath() %>/ponto" method="post">
        <input type="hidden" name="acao" value="editar-registro"><input type="hidden" name="regId" id="editRegId">
        <label>Data</label><input type="date" id="editData" readonly style="background: #3a3a3a;">
        <div class="form-row">
            <div><label>Entrada</label><input type="time" name="entrada" id="editEntrada"></div>
            <div><label>Saída Int.</label><input type="time" name="saidaInt" id="editSaidaInt"></div>
        </div>
        <div class="form-row">
            <div><label>Retorno Int.</label><input type="time" name="retornoInt" id="editRetornoInt"></div>
            <div><label>Saída</label><input type="time" name="saida" id="editSaida"></div>
        </div>
        <label>Observação</label><textarea name="obs" id="editObs" rows="2"></textarea>
        <button type="submit" class="btn btn-primary" style="width: 100%;">Salvar Alterações</button>
    </form>
</div></div>

<div id="modalMarcarAtraso" class="modal"><div class="modal-content">
    <div class="modal-header"><h3>⏰ Marcar Atraso</h3><span class="close" onclick="fecharModal('modalMarcarAtraso')">&times;</span></div>
    <form action="<%= request.getContextPath() %>/ponto" method="post">
        <input type="hidden" name="acao" value="marcar-atraso">
        <input type="hidden" name="regId" id="atrasoRegId">
        <input type="hidden" name="funcIdRet" id="atrasoFuncId">
        <input type="hidden" name="dataRet" id="atrasoData">
        <input type="hidden" name="dataInicioRet" id="atrasoDataInicio">
        <input type="hidden" name="dataFimRet" id="atrasoDataFim">
        <label>Minutos de Atraso *</label>
        <input type="number" name="minutosAtraso" id="minutosAtraso" min="0" max="480" placeholder="Ex: 15" required>
        <small style="color: #999;">Informe quantos minutos o funcionário se atrasou</small>
        <label style="margin-top: 20px;">Este atraso será:</label>
        <div style="display: flex; gap: 15px; margin: 10px 0;">
            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                <input type="radio" name="tipoAtraso" value="nao-autorizado" checked> Não Autorizado (conta no relatório)
            </label>
            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                <input type="radio" name="tipoAtraso" value="autorizado"> Autorizado (não conta)
            </label>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Confirmar Atraso</button>
    </form>
</div></div>

<script>
    function abrirModal(id) { document.getElementById(id).style.display = 'block'; }
    function fecharModal(id) {
        document.getElementById(id).style.display = 'none';
        if (id === 'modalEditarReg') {
            document.getElementById('editEntrada').value = '';
            document.getElementById('editSaidaInt').value = '';
            document.getElementById('editRetornoInt').value = '';
            document.getElementById('editSaida').value = '';
            document.getElementById('editObs').value = '';
        }
    }
    window.onclick = function(e) { if (e.target.classList.contains('modal')) e.target.style.display = 'none'; }

    function abonarFalta(funcId, data) {
        document.getElementById('abonarFuncId').value = funcId;
        document.getElementById('abonarData').value = data;
        document.getElementById('abonarDataInicio').value = document.getElementById('dataInicioRel').value;
        document.getElementById('abonarDataFim').value = document.getElementById('dataFimRel').value;
        abrirModal('modalAbonar');
    }

    function removerJustificativa(funcId, data) {
        if (confirm('Deseja realmente remover esta justificativa?')) {
            const form = document.createElement('form');
            form.method = 'POST'; form.action = '<%= request.getContextPath() %>/ponto';
            const campos = { 'acao': 'excluir-justificativa', 'funcId': funcId, 'data': data, 'dataInicio': document.getElementById('dataInicioRel').value, 'dataFim': document.getElementById('dataFimRel').value };
            for (let key in campos) {
                const input = document.createElement('input'); input.type = 'hidden'; input.name = key; input.value = campos[key];
                form.appendChild(input);
            }
            document.body.appendChild(form); form.submit();
        }
    }

    function editarRegistro(regId, data, entrada, saidaInt, retornoInt, saida, obs) {
        document.getElementById('editRegId').value = regId;
        document.getElementById('editData').value = data;
        document.getElementById('editEntrada').value = entrada || '';
        document.getElementById('editSaidaInt').value = saidaInt || '';
        document.getElementById('editRetornoInt').value = retornoInt || '';
        document.getElementById('editSaida').value = saida || '';
        document.getElementById('editObs').value = obs || '';
        abrirModal('modalEditarReg');
    }

    function marcarAtraso(regId, funcId, data) {
        document.getElementById('atrasoRegId').value = regId;
        document.getElementById('atrasoFuncId').value = funcId;
        document.getElementById('atrasoData').value = data;
        document.getElementById('atrasoDataInicio').value = document.getElementById('dataInicioRel') ? document.getElementById('dataInicioRel').value : '';
        document.getElementById('atrasoDataFim').value = document.getElementById('dataFimRel') ? document.getElementById('dataFimRel').value : '';
        document.getElementById('minutosAtraso').value = '';
        abrirModal('modalMarcarAtraso');
    }

    function editarFuncionario(funcId, nome, cpf, telefone) {
        document.getElementById('editFuncId').value = funcId;
        document.getElementById('editFuncNome').value = nome;
        document.getElementById('editFuncCpf').value = cpf;
        document.getElementById('editFuncTelefone').value = telefone;
        document.getElementById('editFuncSenha').value = '';
        abrirModal('modalEditarFunc');
    }

    function alternarStatusFunc(funcId) {
        if (confirm('Deseja realmente alterar o status deste funcionário?')) {
            const form = document.createElement('form');
            form.method = 'POST'; form.action = '<%= request.getContextPath() %>/ponto';
            const acaoInput = document.createElement('input'); acaoInput.type = 'hidden'; acaoInput.name = 'acao'; acaoInput.value = 'alternar-status';
            form.appendChild(acaoInput);
            const funcIdInput = document.createElement('input'); funcIdInput.type = 'hidden'; funcIdInput.name = 'funcId'; funcIdInput.value = funcId;
            form.appendChild(funcIdInput);
            document.body.appendChild(form); form.submit();
        }
    }

    function excluirFuncionario(funcId, nome) {
        if (confirm('⚠️ ATENÇÃO! Deseja realmente EXCLUIR o funcionário "' + nome + '"?\n\nTodos os registros de ponto deste funcionário também serão excluídos!\n\nEsta ação NÃO pode ser desfeita!')) {
            const form = document.createElement('form');
            form.method = 'POST'; form.action = '<%= request.getContextPath() %>/ponto';
            const acaoInput = document.createElement('input'); acaoInput.type = 'hidden'; acaoInput.name = 'acao'; acaoInput.value = 'excluir-funcionario';
            form.appendChild(acaoInput);
            const funcIdInput = document.createElement('input'); funcIdInput.type = 'hidden'; funcIdInput.name = 'funcId'; funcIdInput.value = funcId;
            form.appendChild(funcIdInput);
            document.body.appendChild(form); form.submit();
        }
    }

    function autorizarAtraso(regId, autorizar) {
        const form = document.createElement('form');
        form.method = 'POST'; form.action = '<%= request.getContextPath() %>/ponto';
        const acaoInput = document.createElement('input'); acaoInput.type = 'hidden'; acaoInput.name = 'acao'; acaoInput.value = 'autorizar-atraso';
        form.appendChild(acaoInput);
        const regIdInput = document.createElement('input'); regIdInput.type = 'hidden'; regIdInput.name = 'regId'; regIdInput.value = regId;
        form.appendChild(regIdInput);
        const autorizarInput = document.createElement('input'); autorizarInput.type = 'hidden'; autorizarInput.name = 'autorizar'; autorizarInput.value = autorizar;
        form.appendChild(autorizarInput);
        const funcIdInput = document.createElement('input'); funcIdInput.type = 'hidden'; funcIdInput.name = 'funcIdRet'; funcIdInput.value = '<%= funcSelecionado != null ? funcSelecionado.getFuncId() : "" %>';
        form.appendChild(funcIdInput);
        const dataInicioInput = document.createElement('input'); dataInicioInput.type = 'hidden'; dataInicioInput.name = 'dataInicioRet'; dataInicioInput.value = document.getElementById('dataInicioRel') ? document.getElementById('dataInicioRel').value : '';
        form.appendChild(dataInicioInput);
        const dataFimInput = document.createElement('input'); dataFimInput.type = 'hidden'; dataFimInput.name = 'dataFimRet'; dataFimInput.value = document.getElementById('dataFimRel') ? document.getElementById('dataFimRel').value : '';
        form.appendChild(dataFimInput);
        document.body.appendChild(form); form.submit();
    }

    document.addEventListener('DOMContentLoaded', function() {
        const hoje = new Date();
        const ano = hoje.getFullYear();
        const mes = String(hoje.getMonth() + 1).padStart(2, '0');
        const dia = String(hoje.getDate()).padStart(2, '0');
        if(document.getElementById('dataInicioRel')) document.getElementById('dataInicioRel').value = ano + '-' + mes + '-01';
        if(document.getElementById('dataFimRel')) document.getElementById('dataFimRel').value = ano + '-' + mes + '-' + dia;

        const cpfInputs = ['cpfModal', 'editFuncCpf'];
        cpfInputs.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.addEventListener('input', function(e) {
                    let v = e.target.value.replace(/\D/g, '');
                    if (v.length > 11) v = v.substring(0, 11);
                    if (v.length > 9) v = v.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
                    else if (v.length > 6) v = v.replace(/(\d{3})(\d{3})(\d{1,3})/, '$1.$2.$3');
                    else if (v.length > 3) v = v.replace(/(\d{3})(\d{1,3})/, '$1.$2');
                    e.target.value = v;
                });
            }
        });

        const telInputs = ['telefoneModal', 'editFuncTelefone'];
        telInputs.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.addEventListener('input', function(e) {
                    let v = e.target.value.replace(/\D/g, '');
                    if (v.length > 11) v = v.substring(0, 11);
                    if (v.length > 10) v = v.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
                    else if (v.length > 6) v = v.replace(/(\d{2})(\d{4})(\d{1,4})/, '($1) $2-$3');
                    else if (v.length > 2) v = v.replace(/(\d{2})(\d{1,5})/, '($1) $2');
                    e.target.value = v;
                });
            }
        });
    });
</script>
</body>
</html>
