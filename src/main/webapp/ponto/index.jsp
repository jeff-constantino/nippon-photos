<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- PWA Meta Tags -->
    <meta name="theme-color" content="#daa520">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <meta name="apple-mobile-web-app-title" content="SaaS Ponto">
    <link rel="manifest" href="<%= request.getContextPath() %>/ponto/manifest.json">
    <link rel="apple-touch-icon" href="<%= request.getContextPath() %>/ponto/icon-192.png">

    <title>Controle de Ponto - Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #daa520 0%, #e09543 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            padding-bottom: 80px; /* Espaço para o rodapé */
        }
        .card {
            background: #000000;
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            color: white;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 {
            color: #daa520;
            text-align: center;
            margin-bottom: 10px;
            font-size: 32px;
            font-weight: 700;
        }
        .subtitle {
            text-align: center;
            color: #ccc;
            margin-bottom: 35px;
            font-size: 15px;
        }
        .tipo-login {
            display: flex;
            gap: 12px;
            margin-bottom: 30px;
        }
        .tipo-btn {
            flex: 1;
            padding: 14px;
            border: 2px solid #333;
            border-radius: 10px;
            background: #2a2a2a;
            color: #ccc;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            font-weight: 600;
            font-size: 15px;
        }
        .tipo-btn:hover {
            border-color: #daa520;
            transform: translateY(-2px);
        }
        .tipo-btn.active {
            background: #daa520;
            color: #000000;
            border-color: #daa520;
        }
        label {
            color: #daa520;
            font-weight: 600;
            display: block;
            margin-top: 20px;
            margin-bottom: 8px;
            font-size: 14px;
        }
        input {
            width: 100%;
            padding: 14px;
            border: 2px solid #333;
            border-radius: 10px;
            background: #2a2a2a;
            color: white;
            font-size: 16px;
            transition: border-color 0.3s;
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
            color: #000000;
        }
        .btn:hover {
            background: #e09543;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(242, 166, 84, 0.4);
        }
        .msg {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 500;
        }
        .msg-erro {
            background: #d32f2f;
            color: white;
        }
        #adminFields { display: none; }
        small {
            color: #999;
            font-size: 13px;
            display: block;
            margin-top: 5px;
        }

        /* Banner de instalação do PWA */
        .install-banner {
            display: none;
            background: #0288d1;
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .install-banner button {
            background: white;
            color: #0288d1;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }

        /* Rodapé - VERSÃO MAIS VISÍVEL */
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            text-align: center;
            padding: 15px;
            background: rgba(0, 0, 0, 0.85);      /* Preto 85% - MUITO MAIS VISÍVEL */
            backdrop-filter: blur(10px);
            border-top: 1px solid #daa520;        /* Borda dourada sutil */
            color: #fff;                          /* Texto branco */
            font-size: 13px;
        }
        .footer a {
            color: #ffd700;                       /* Dourado vibrante */
            text-decoration: none;
            font-weight: 700;                     /* Negrito */
            transition: all 0.3s;
        }
        .footer a:hover {
            color: #fff;                          /* Branco ao passar mouse */
            text-shadow: 0 0 10px #daa520;        /* Brilho dourado */
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .card { padding: 30px 25px; }
            h1 { font-size: 28px; }
            body { padding-bottom: 70px; }
            .footer { font-size: 12px; padding: 12px; }
        }
    </style>
</head>
<body>
<div class="card">
    <!-- Banner de instalação -->
    <div id="installBanner" class="install-banner">
        <strong>📱 Instalar App</strong>
        <p style="margin: 8px 0; font-size: 14px;">Adicione à tela inicial para acesso rápido!</p>
        <button onclick="instalarApp()">Instalar Agora</button>
        <button onclick="document.getElementById('installBanner').style.display='none'" style="background: transparent; color: white; text-decoration: underline;">Agora não</button>
    </div>

    <h1>🕐 Controle de Ponto</h1>
    <p class="subtitle">#SaaS</p>

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

    <form action="<%= request.getContextPath() %>/ponto" method="post" id="formLogin">
        <input type="hidden" name="acao" value="login">
        <input type="hidden" name="tipoLogin" id="tipoLogin" value="funcionario">

        <!-- CAMPOS FUNCIONÁRIO -->
        <div id="funcFields">
            <label>CPF</label>
            <input type="text" name="cpf" id="cpf" placeholder="000.000.000-00" maxlength="14">
            <small>Digite seu CPF</small>
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

<!-- Rodapé -->
<div class="footer">
    Desenvolvido por <a href="https://jeffconstantino.dev" target="_blank" rel="noopener">Jeff Constantino</a>
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

    // ===== PWA - INSTALAÇÃO =====
    let deferredPrompt;

    window.addEventListener('beforeinstallprompt', (e) => {
        // Previne o prompt automático
        e.preventDefault();
        deferredPrompt = e;

        // Mostra o banner de instalação
        document.getElementById('installBanner').style.display = 'block';
    });

    function instalarApp() {
        if (!deferredPrompt) {
            alert('App já está instalado ou navegador não suporta instalação');
            return;
        }

        // Mostra o prompt de instalação
        deferredPrompt.prompt();

        deferredPrompt.userChoice.then((choiceResult) => {
            if (choiceResult.outcome === 'accepted') {
                console.log('✅ App instalado!');
                document.getElementById('installBanner').style.display = 'none';
            }
            deferredPrompt = null;
        });
    }

    // Detecta quando app é instalado
    window.addEventListener('appinstalled', () => {
        console.log('✅ PWA instalado com sucesso!');
        document.getElementById('installBanner').style.display = 'none';
    });

    // ===== REGISTRAR SERVICE WORKER =====
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
            navigator.serviceWorker.register('<%= request.getContextPath() %>/ponto/service-worker.js')
                .then(registration => {
                    console.log('✅ Service Worker registrado:', registration.scope);
                })
                .catch(error => {
                    console.log('❌ Erro ao registrar Service Worker:', error);
                });
        });
    }
</script>
</body>
</html>
