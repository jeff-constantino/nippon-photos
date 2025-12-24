<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Controle de Ponto - Login</title>
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
            padding: 40px;
            width: 100%;
            max-width: 450px;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        h1 {
            color: #daa520;
            text-align: center;
            margin-bottom: 10px;
            font-size: 32px;
        }
        .subtitle {
            text-align: center;
            color: #ccc;
            margin-bottom: 30px;
            font-size: 14px;
        }
        label {
            color: #daa520;
            font-weight: 600;
            display: block;
            margin-top: 20px;
            margin-bottom: 8px;
        }
        input {
            width: 100%;
            padding: 14px;
            border: 2px solid #333;
            border-radius: 8px;
            background: #2a2a2a;
            color: white;
            font-size: 16px;
        }
        input:focus {
            outline: none;
            border-color: #daa520;
        }
        .btn {
            width: 100%;
            padding: 16px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 25px;
            transition: all 0.3s;
            background: #daa520;
            color: #1a1a1a;
        }
        .btn:hover {
            background: #e09543;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(242, 166, 84, 0.4);
        }
        .msg {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        .msg-erro {
            background: #d32f2f;
        }
        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 25px 0;
            color: #666;
        }
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #333;
        }
        .divider span {
            padding: 0 15px;
            font-size: 13px;
        }
        .tipo-login {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .tipo-btn {
            flex: 1;
            padding: 12px;
            border: 2px solid #333;
            border-radius: 8px;
            background: #2a2a2a;
            color: #ccc;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            font-weight: 600;
        }
        .tipo-btn:hover {
            border-color: #daa520;
        }
        .tipo-btn.active {
            background: #daa520;
            color: #1a1a1a;
            border-color: #daa520;
        }
        #adminFields {
            display: none;
        }
        small {
            color: #999;
            font-size: 13px;
            display: block;
            margin-top: 5px;
        }
        @media (max-width: 600px) {
            .card { padding: 30px 25px; }
            h1 { font-size: 28px; }
        }
    </style>
</head>
<body>
<div class="card">
    <h1>🕐 Controle de Ponto</h1>
    <p class="subtitle">Sistema de Registro e Gestão</p>

    <%
        String erro = (String) request.getAttribute("erro");
        if (erro != null) {
    %>
    <div class="msg msg-erro"><%= erro %></div>
    <% } %>

    <div class="tipo-login">
        <div class="tipo-btn active" id="btnFunc" onclick="mostrarFunc()">
            👤 Funcionário
        </div>
        <div class="tipo-btn" id="btnAdmin" onclick="mostrarAdmin()">
            ⚙️ Admin
        </div>
    </div>

    <form action="<%= request.getContextPath() %>/ponto-login-unificado" method="post" id="formLogin">
        <input type="hidden" name="tipoLogin" id="tipoLogin" value="funcionario">

        <!-- CAMPOS FUNCIONÁRIO -->
        <div id="funcFields">
            <label>CPF</label>
            <input type="text" name="cpf" id="cpf" placeholder="000.000.000-00" maxlength="14">
            <small>Digite seu CPF (apenas números ou com pontuação)</small>
        </div>

        <!-- CAMPOS ADMIN -->
        <div id="adminFields">
            <label>Usuário</label>
            <input type="text" name="usuario" id="usuario" placeholder="Digite seu usuário">
        </div>

        <label>Senha</label>
        <input type="password" name="senha" placeholder="Digite sua senha" required>

        <button type="submit" class="btn">Entrar</button>
    </form>
</div>

<script>
    function mostrarFunc() {
        document.getElementById('btnFunc').classList.add('active');
        document.getElementById('btnAdmin').classList.remove('active');
        document.getElementById('funcFields').style.display = 'block';
        document.getElementById('adminFields').style.display = 'none';
        document.getElementById('tipoLogin').value = 'funcionario';
        document.getElementById('cpf').required = true;
        document.getElementById('usuario').required = false;
    }

    function mostrarAdmin() {
        document.getElementById('btnAdmin').classList.add('active');
        document.getElementById('btnFunc').classList.remove('active');
        document.getElementById('adminFields').style.display = 'block';
        document.getElementById('funcFields').style.display = 'none';
        document.getElementById('tipoLogin').value = 'admin';
        document.getElementById('usuario').required = true;
        document.getElementById('cpf').required = false;
    }

    // Máscara CPF
    const cpfEl = document.getElementById('cpf');
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
</script>
</body>
</html>
