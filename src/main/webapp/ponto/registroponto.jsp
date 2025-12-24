<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Ponto, dao.PontoDAO, java.sql.*, java.util.*, java.text.*" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Ponto</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #daa520;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .card {
            background: #1a1a1a;
            border-radius: 15px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        h1 { color: #daa520; text-align: center; margin-bottom: 20px; font-size: 28px; }
        .nome { text-align: center; color: #daa520; font-size: 20px; margin-bottom: 20px; }
        .relogio {
            text-align: center;
            font-size: 48px;
            font-weight: bold;
            color: #daa520;
            font-family: 'Courier New', monospace;
            margin: 20px 0;
        }
        .data { text-align: center; color: #ccc; margin-bottom: 30px; font-size: 16px; }
        .btn {
            width: 100%;
            padding: 18px;
            font-size: 20px;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin: 10px 0;
            transition: all 0.3s;
        }
        .btn-primary { background: #daa520; color: #1a1a1a; }
        .btn-primary:hover { background: #e09543; transform: translateY(-2px); }
        .btn-secondary { background: #333; color: white; }
        .btn-secondary:hover { background: #444; }
        .registro {
            display: flex;
            justify-content: space-between;
            padding: 12px;
            background: #2a2a2a;
            border-radius: 8px;
            margin: 8px 0;
        }
        .registro.alerta {
            background: #d32f2f !important;
            animation: pulse 2s infinite;
        }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.8; } }
        .msg {
            padding: 12px;
            border-radius: 8px;
            margin: 15px 0;
            text-align: center;
        }
        .msg-sucesso { background: #2e7d32; }
        .msg-erro { background: #d32f2f; }
        h3 { color: #daa520; margin: 20px 0 10px; }
        @media (max-width: 600px) {
            .card { padding: 20px; }
            .relogio { font-size: 36px; }
        }
    </style>
</head>
<body>
<div class="card">
    <%
        Ponto func = (Ponto) session.getAttribute("pontoFunc");
        String erro = (String) request.getAttribute("erro");
        String sucesso = (String) request.getAttribute("sucesso");

        if (func == null) {
            // Redireciona para index se não estiver logado
            response.sendRedirect("../index.jsp");
            return;
        }

        // Buscar registro de hoje
        PontoDAO dao = new PontoDAO();
        Date hoje = new Date(System.currentTimeMillis());
        Ponto reg = dao.buscarRegistroDia(func.getFuncId(), hoje);

        // Verificar atraso
        Calendar cal = Calendar.getInstance();
        String[] dias = {"domingo", "segunda", "terca", "quarta", "quinta", "sexta", "sabado"};
        String diaHoje = dias[cal.get(Calendar.DAY_OF_WEEK) - 1];

        Ponto horario = dao.buscarHorarioDia(func.getFuncId(), diaHoje);
        boolean temAtraso = false;

        if (reg != null && reg.getRegEntrada() != null && horario != null) {
            Calendar calHor = Calendar.getInstance();
            calHor.setTime(horario.getHorEntrada());
            calHor.add(Calendar.MINUTE, horario.getHorTolerancia());

            Calendar calEnt = Calendar.getInstance();
            calEnt.setTime(reg.getRegEntrada());

            if (calEnt.after(calHor)) temAtraso = true;
        }
    %>

    <h1>🕐 Controle de Ponto #SaaS</h1>
    <div class="nome"><%= func.getFuncNome() %></div>

    <% if (sucesso != null) { %><div class="msg msg-sucesso"><%= sucesso %></div><% } %>
    <% if (erro != null) { %><div class="msg msg-erro"><%= erro %></div><% } %>

    <div class="relogio" id="relogio"></div>
    <div class="data" id="data"></div>

    <form action="<%= request.getContextPath() %>/ponto-registrar" method="post">
        <button type="submit" class="btn btn-primary">📍 Registrar Ponto</button>
    </form>

    <form action="<%= request.getContextPath() %>/ponto-logout" method="post">
        <button type="submit" class="btn btn-secondary">Sair</button>
    </form>

    <% if (reg != null) { %>
    <h3>Registros de Hoje</h3>

    <% if (temAtraso) { %>
    <div class="registro alerta">
        <div style="width: 100%; text-align: center; font-weight: bold;">
            ⚠️ ATRASO DETECTADO - Entrada fora do horário!
        </div>
    </div>
    <% } %>

    <% if (reg.getRegEntrada() != null) { %>
    <div class="registro <%= temAtraso ? "alerta" : "" %>">
        <span>Entrada:</span>
        <strong><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegEntrada()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegSaidaIntervalo() != null) { %>
    <div class="registro">
        <span>Saída Intervalo:</span>
        <strong><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegSaidaIntervalo()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegRetornoIntervalo() != null) { %>
    <div class="registro">
        <span>Retorno Intervalo:</span>
        <strong><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegRetornoIntervalo()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegSaida() != null) { %>
    <div class="registro">
        <span>Saída:</span>
        <strong><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegSaida()) %></strong>
    </div>
    <% } %>
    <% } %>
</div>

<script>
    function atualizarRelogio() {
        const agora = new Date();
        const h = String(agora.getHours()).padStart(2, '0');
        const m = String(agora.getMinutes()).padStart(2, '0');
        const s = String(agora.getSeconds()).padStart(2, '0');

        document.getElementById('relogio').textContent = h + ':' + m + ':' + s;

        const dias = ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
        const meses = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];

        document.getElementById('data').textContent = dias[agora.getDay()] + ', ' + agora.getDate() + ' de ' + meses[agora.getMonth()] + ' de ' + agora.getFullYear();
    }

    atualizarRelogio();
    setInterval(atualizarRelogio, 1000);
</script>
</body>
</html>
