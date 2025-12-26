<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Ponto, dao.PontoDAO, java.sql.*, java.util.*, java.text.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDateTime" %>
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
            background: linear-gradient(135deg, #daa520 0%, #e09543 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .card {
            background: #000000;
            border-radius: 20px;
            padding: 35px;
            width: 100%;
            max-width: 550px;
            color: white;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        h1 { color: #daa520; text-align: center; margin-bottom: 15px; font-size: 30px; font-weight: 700; }
        .nome { text-align: center; color: #daa520; font-size: 22px; margin-bottom: 25px; font-weight: 600; }
        .relogio {
            text-align: center;
            font-size: 56px;
            font-weight: bold;
            color: #daa520;
            font-family: 'Courier New', monospace;
            margin: 25px 0;
            text-shadow: 0 0 20px rgba(242, 166, 84, 0.3);
        }
        .data { text-align: center; color: #ccc; margin-bottom: 35px; font-size: 17px; }
        .btn {
            width: 100%;
            padding: 20px;
            font-size: 20px;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            margin: 12px 0;
            transition: all 0.3s;
        }
        .btn-primary { background: #daa520; color: #000000; }
        .btn-primary:hover { background: #e09543; transform: translateY(-2px); box-shadow: 0 5px 20px rgba(242, 166, 84, 0.4); }
        .btn-secondary { background: #333; color: white; }
        .btn-secondary:hover { background: #444; }
        .registro {
            display: flex;
            justify-content: space-between;
            padding: 14px 16px;
            background: #2a2a2a;
            border-radius: 10px;
            margin: 10px 0;
            transition: all 0.3s;
        }
        .registro:hover { background: #333; }
        .registro.alerta {
            background: #d32f2f !important;
            animation: pulse 2s infinite;
        }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.85; } }
        .msg {
            padding: 14px;
            border-radius: 10px;
            margin: 18px 0;
            text-align: center;
            font-weight: 500;
        }
        .msg-sucesso { background: #2e7d32; }
        .msg-erro { background: #d32f2f; }
        h3 { color: #daa520; margin: 25px 0 12px; font-size: 20px; }
        .registro-label { color: #ccc; font-size: 15px; }
        .registro-hora { font-weight: bold; color: white; font-size: 16px; }
        .aviso-noturno {
            background: #0288d1;
            padding: 12px;
            border-radius: 10px;
            margin: 15px 0;
            text-align: center;
            font-size: 14px;
        }
        @media (max-width: 600px) {
            .card { padding: 25px 20px; }
            .relogio { font-size: 44px; }
            h1 { font-size: 26px; }
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
            response.sendRedirect("../index.jsp");
            return;
        }

        // CORREÇÃO: Buscar registro do dia correto considerando jornadas noturnas
        PontoDAO dao = new PontoDAO();
        Date hoje = new Date(System.currentTimeMillis());

        // Se for antes das 6h da manhã, buscar registro do dia anterior
        LocalDateTime agora = LocalDateTime.now();
        Date dataRegistro = hoje;
        boolean isJornadaNoturna = false;

        if (agora.getHour() < 6) {
            dataRegistro = Date.valueOf(hoje.toLocalDate().minusDays(1));
            isJornadaNoturna = true;
        }

        Ponto reg = dao.buscarRegistroDia(func.getFuncId(), dataRegistro);

        // Verificar atraso
        boolean temAtraso = false;
        if (reg != null && reg.getTemAtraso() != null) {
            temAtraso = reg.getTemAtraso();
        }
    %>

    <h1>🕐 Controle de Ponto</h1>
    <div class="nome"><%= func.getFuncNome() %></div>

    <% if (sucesso != null) { %><div class="msg msg-sucesso"><%= sucesso %></div><% } %>
    <% if (erro != null) { %><div class="msg msg-erro"><%= erro %></div><% } %>

    <% if (isJornadaNoturna) { %>
    <div class="aviso-noturno">
        🌙 Jornada Noturna - Seus registros estão sendo salvos no dia <%= new SimpleDateFormat("dd/MM/yyyy").format(dataRegistro) %>
    </div>
    <% } %>

    <div class="relogio" id="relogio"></div>
    <div class="data" id="data"></div>

    <form action="<%= request.getContextPath() %>/ponto" method="post">
        <input type="hidden" name="acao" value="registrar-ponto">
        <style>
            .gps-indicador {
                padding: 10px;
                border-radius: 8px;
                text-align: center;
                margin: 15px 0;
                font-size: 14px;
                font-weight: 600;
                color: white;
                background: #666;
            }
        </style>
        <div id="gpsIndicador" class="gps-indicador">
            📍 Obtendo localização...
        </div>

        <button type="button" onclick="registrarPontoComGPS()" class="btn btn-primary">
            📍 Registrar Ponto
        </button>
    </form>

    <form action="<%= request.getContextPath() %>/ponto"method="post">
        <input type="hidden" name="acao" value="logout">
        <button type="submit" class="btn btn-secondary">Sair</button>
    </form>

    <% if (reg != null) { %>
    <h3>Registros de Hoje <% if (isJornadaNoturna) { %>(Dia <%= new SimpleDateFormat("dd/MM").format(dataRegistro) %>)<% } %></h3>

    <% if (temAtraso) { %>
    <div class="registro alerta">
        <div style="width: 100%; text-align: center; font-weight: bold;">
            ⚠️ ATRASO DETECTADO
        </div>
    </div>
    <% } %>

    <% if (reg.getRegEntrada() != null) { %>
    <div class="registro <%= temAtraso ? "alerta" : "" %>">
        <span class="registro-label">Entrada:</span>
        <strong class="registro-hora"><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegEntrada()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegSaidaIntervalo() != null) { %>
    <div class="registro">
        <span class="registro-label">Saída Intervalo:</span>
        <strong class="registro-hora"><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegSaidaIntervalo()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegRetornoIntervalo() != null) { %>
    <div class="registro">
        <span class="registro-label">Retorno Intervalo:</span>
        <strong class="registro-hora"><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegRetornoIntervalo()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegSaida() != null) { %>
    <div class="registro">
        <span class="registro-label">Saída:</span>
        <strong class="registro-hora"><%= new SimpleDateFormat("HH:mm:ss").format(reg.getRegSaida()) %></strong>
    </div>
    <% } %>

    <% if (reg.getRegMinutosTrabalhados() != null && reg.getRegMinutosTrabalhados() > 0) { %>
    <div class="registro" style="background: #1a4d2e; margin-top: 15px;">
        <span class="registro-label">Total Trabalhado:</span>
        <strong class="registro-hora" style="color: #4ade80;"><%= reg.getHorasTrabalhadasFormatado() %></strong>
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

    /**
     * Sistema de Geolocalização
     * Funciona em celular (GPS) e computador (IP geolocation)
     */

    let localizacaoAtual = null;
    let precisao = null;
    let tipoLocalizacao = null;

    // Tentar obter localização assim que a página carregar
    document.addEventListener('DOMContentLoaded', function() {
        tentarObterLocalizacao();
    });

    /**
     * Tenta obter localização (GPS primeiro, IP como fallback)
     */
    function tentarObterLocalizacao() {
        if (navigator.geolocation) {
            // Celular/navegador com GPS
            navigator.geolocation.getCurrentPosition(
                sucessoGPS,
                erroGPS,
                {
                    enableHighAccuracy: true,
                    timeout: 10000,
                    maximumAge: 0
                }
            );
        } else {
            // Fallback para IP geolocation
            obterLocalizacaoPorIP();
        }
    }

    /**
     * Sucesso ao obter GPS
     */
    function sucessoGPS(position) {
        localizacaoAtual = {
            latitude: position.coords.latitude,
            longitude: position.coords.longitude
        };
        precisao = Math.round(position.coords.accuracy);
        tipoLocalizacao = 'gps';

        console.log('📍 GPS obtido:', localizacaoAtual, 'Precisão:', precisao + 'm');
        atualizarIndicadorGPS(true, precisao);
    }

    /**
     * Erro ao obter GPS
     */
    function erroGPS(error) {
        console.warn('❌ Erro GPS:', error.message);

        // Tentar IP geolocation como fallback
        obterLocalizacaoPorIP();
    }

    /**
     * Fallback: Obter localização aproximada por IP
     */
    function obterLocalizacaoPorIP() {
        fetch('https://ipapi.co/json/')
            .then(response => response.json())
            .then(data => {
                localizacaoAtual = {
                    latitude: data.latitude,
                    longitude: data.longitude
                };
                precisao = 1000; // IP geolocation tem precisão de ~1km
                tipoLocalizacao = 'ip';

                console.log('📍 Localização por IP:', localizacaoAtual, 'Precisão: ~1km');
                atualizarIndicadorGPS(false, precisao);
            })
            .catch(error => {
                console.error('❌ Erro ao obter localização por IP:', error);
                alert('Não foi possível obter sua localização. Ative o GPS ou permita acesso à localização.');
            });
    }

    /**
     * Atualizar indicador visual de GPS
     */
    function atualizarIndicadorGPS(isGPS, precisao) {
        const indicador = document.getElementById('gpsIndicador');
        if (!indicador) return;

        if (isGPS) {
            if (precisao < 50) {
                indicador.innerHTML = '📍 GPS: Excelente (' + precisao + 'm)';
                indicador.style.background = '#2e7d32';
            } else if (precisao < 100) {
                indicador.innerHTML = '📍 GPS: Bom (' + precisao + 'm)';
                indicador.style.background = '#f57c00';
            } else {
                indicador.innerHTML = '📍 GPS: Fraco (' + precisao + 'm)';
                indicador.style.background = '#d32f2f';
            }
        } else {
            indicador.innerHTML = '📍 Localização aproximada (IP)';
            indicador.style.background = '#0288d1';
        }
    }

    /**
     * Registrar ponto com validação de localização
     */
    function registrarPontoComGPS() {
        if (!localizacaoAtual) {
            alert('⚠️ Aguarde... Obtendo sua localização.');
            tentarObterLocalizacao();

            // Tentar novamente em 2 segundos
            setTimeout(function() {
                if (localizacaoAtual) {
                    registrarPontoComGPS();
                } else {
                    alert('❌ Não foi possível obter sua localização. Ative o GPS e tente novamente.');
                }
            }, 2000);
            return;
        }

        // Criar form e enviar
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '<%= request.getContextPath() %>/ponto';

        // Ação
        const inputAcao = document.createElement('input');
        inputAcao.type = 'hidden';
        inputAcao.name = 'acao';
        inputAcao.value = 'registrar-ponto';
        form.appendChild(inputAcao);

        // Latitude
        const inputLat = document.createElement('input');
        inputLat.type = 'hidden';
        inputLat.name = 'latitude';
        inputLat.value = localizacaoAtual.latitude;
        form.appendChild(inputLat);

        // Longitude
        const inputLon = document.createElement('input');
        inputLon.type = 'hidden';
        inputLon.name = 'longitude';
        inputLon.value = localizacaoAtual.longitude;
        form.appendChild(inputLon);

        // Precisão
        const inputPrec = document.createElement('input');
        inputPrec.type = 'hidden';
        inputPrec.name = 'precisao';
        inputPrec.value = precisao;
        form.appendChild(inputPrec);

        // Tipo
        const inputTipo = document.createElement('input');
        inputTipo.type = 'hidden';
        inputTipo.name = 'tipoLocalizacao';
        inputTipo.value = tipoLocalizacao;
        form.appendChild(inputTipo);

        document.body.appendChild(form);
        form.submit();
    }
</script>

<!-- SUBSTITUA O BOTÃO DE REGISTRO POR ESTE: -->
<style>
    .gps-indicador {
        padding: 10px;
        border-radius: 8px;
        text-align: center;
        margin: 15px 0;
        font-size: 14px;
        font-weight: 600;
        color: white;
        background: #666;
    }
</script>
</body>
</html>
