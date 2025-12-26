<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Ponto, dao.PontoDAO, java.util.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Zonas Autorizadas</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #daa520; padding: 20px; }
        .container { max-width: 1400px; margin: 0 auto; }
        .header {
            background: #000000; color: white; padding: 20px 30px; border-radius: 15px;
            margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;
        }
        h1 { color: #daa520; font-size: 28px; }
        .card { background: #000000; border-radius: 15px; padding: 25px; margin-bottom: 20px; color: white; }
        .card h2 { color: #daa520; margin-bottom: 20px; border-bottom: 2px solid #daa520; padding-bottom: 12px; }
        .btn { padding: 12px 24px; border: none; border-radius: 10px; font-size: 15px; font-weight: bold; cursor: pointer; margin: 5px; }
        .btn-primary { background: #daa520; color: #000000; }
        .btn-secondary { background: #333; color: white; }
        .btn-danger { background: #d32f2f; color: white; }
        .btn-success { background: #2e7d32; color: white; }
        .btn-sm { padding: 7px 14px; font-size: 13px; }

        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        table th { background: #2a2a2a; padding: 14px 12px; text-align: left; color: #daa520; font-weight: 600; }
        table td { padding: 12px; border-bottom: 1px solid #333; }
        table tr:hover { background: #2a2a2a; }

        input, select, textarea { padding: 11px; border: 2px solid #333; border-radius: 8px; background: #2a2a2a; color: white; font-size: 14px; width: 100%; margin: 8px 0; }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #daa520; }
        label { color: #daa520; font-weight: 600; display: block; margin-top: 12px; }

        .badge { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .badge-success { background: #2e7d32; }
        .badge-danger { background: #d32f2f; }

        .zona-info { background: #2a2a2a; padding: 15px; border-radius: 10px; margin: 10px 0; }
        .zona-mapa { width: 100%; height: 300px; border-radius: 10px; margin-top: 10px; }

        .instrucoes { background: #0288d1; padding: 15px; border-radius: 10px; margin: 15px 0; }
        .instrucoes h3 { color: white; margin-bottom: 10px; }
        .instrucoes ol { margin-left: 20px; color: white; }
        .instrucoes ol li { margin: 5px 0; }
    </style>
</head>
<body>
<%
    String admin = (String) session.getAttribute("pontoAdmin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/ponto/index.jsp");
        return;
    }

    PontoDAO dao = new PontoDAO();
    List<Ponto> zonas = dao.listarTodasZonas();
    String erro = (String) request.getAttribute("erro");
    String sucesso = (String) request.getAttribute("sucesso");
%>

<div class="container">
    <div class="header">
        <h1>🗺️ Zonas Autorizadas</h1>
        <a href="<%= request.getContextPath() %>/ponto/admin.jsp" class="btn btn-secondary">← Voltar</a>
    </div>

    <% if (erro != null) { %><div style="padding: 14px; border-radius: 10px; background: #d32f2f; margin-bottom: 20px; text-align: center; font-weight: 500;"><%= erro %></div><% } %>
    <% if (sucesso != null) { %><div style="padding: 14px; border-radius: 10px; background: #2e7d32; margin-bottom: 20px; text-align: center; font-weight: 500;"><%= sucesso %></div><% } %>

    <!-- Instruções -->
    <div class="instrucoes">
        <h3>📍 Como Configurar as Zonas</h3>
        <ol>
            <li>Abra o <strong>Google Maps</strong></li>
            <li>Clique direito no local exato onde seus funcionários devem bater o ponto</li>
            <li>Clique na primeira opção (as coordenadas)</li>
            <li>Copie os números (ex: -23.550520, -46.633308)</li>
            <li>Cole nos campos abaixo</li>
            <li>Ajuste o <strong>raio em metros</strong> (ex: 100m = permite bater ponto até 100m do ponto central)</li>
        </ol>
    </div>

    <!-- Lista de Zonas -->
    <div class="card">
        <h2>🗺️ Zonas Cadastradas</h2>
        <table>
            <thead>
            <tr>
                <th>Nome</th>
                <th>Endereço</th>
                <th>Raio (metros)</th>
                <th>Status</th>
                <th>Ações</th>
            </tr>
            </thead>
            <tbody>
            <% for (Ponto zona : zonas) { %>
            <tr>
                <td><strong><%= zona.getZonaNome() %></strong></td>
                <td><%= zona.getZonaDescricao() != null ? zona.getZonaDescricao() : "-" %></td>
                <td><%= zona.getZonaRaioMetros() %>m</td>
                <td><span class="badge <%= zona.getZonaAtivo() ? "badge-success" : "badge-danger" %>"><%= zona.getZonaAtivo() ? "Ativa" : "Inativa" %></span></td>
                <td>
                    <a href="https://www.google.com/maps?q=<%= zona.getZonaLatitude() %>,<%= zona.getZonaLongitude() %>" target="_blank" class="btn btn-secondary btn-sm">🗺️ Ver Mapa</a>
                    <button onclick="editarZona(<%= zona.getZonaId() %>, '<%= zona.getZonaNome().replace("'", "\\'") %>', '<%= zona.getZonaDescricao() != null ? zona.getZonaDescricao().replace("'", "\\'") : "" %>', <%= zona.getZonaLatitude() %>, <%= zona.getZonaLongitude() %>, <%= zona.getZonaRaioMetros() %>)" class="btn btn-primary btn-sm">✏️ Editar</button>
                    <button onclick="alternarStatusZona(<%= zona.getZonaId() %>)" class="btn <%= zona.getZonaAtivo() ? "btn-danger" : "btn-success" %> btn-sm"><%= zona.getZonaAtivo() ? "🔒 Desativar" : "🔓 Ativar" %></button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Editar Zona -->
<div id="modalEditarZona" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.75); overflow-y: auto;">
    <div style="background: #000000; margin: 50px auto; padding: 30px; border-radius: 15px; width: 90%; max-width: 700px; color: white;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #daa520; padding-bottom: 12px;">
            <h3 style="color: #daa520;">✏️ Editar Zona</h3>
            <span onclick="fecharModal()" style="color: #aaa; font-size: 32px; cursor: pointer;">&times;</span>
        </div>

        <form action="<%= request.getContextPath() %>/ponto" method="post">
            <input type="hidden" name="acao" value="editar-zona">
            <input type="hidden" name="zonaId" id="editZonaId">

            <label>Nome da Zona *</label>
            <input type="text" name="nome" id="editNome" required>

            <label>Endereço Completo</label>
            <textarea name="descricao" id="editDescricao" rows="2"></textarea>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                <div>
                    <label>Latitude *</label>
                    <input type="text" name="latitude" id="editLatitude" required step="any">
                </div>
                <div>
                    <label>Longitude *</label>
                    <input type="text" name="longitude" id="editLongitude" required step="any">
                </div>
            </div>

            <label>Raio de Tolerância (metros) *</label>
            <input type="number" name="raioMetros" id="editRaio" required min="10" max="1000" value="100">
            <small style="color: #999;">Quanto maior o raio, maior a área permitida para bater ponto</small>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Salvar Alterações</button>
        </form>
    </div>
</div>

<script>
    function editarZona(id, nome, descricao, latitude, longitude, raio) {
        document.getElementById('editZonaId').value = id;
        document.getElementById('editNome').value = nome;
        document.getElementById('editDescricao').value = descricao;
        document.getElementById('editLatitude').value = latitude;
        document.getElementById('editLongitude').value = longitude;
        document.getElementById('editRaio').value = raio;
        document.getElementById('modalEditarZona').style.display = 'block';
    }

    function fecharModal() {
        document.getElementById('modalEditarZona').style.display = 'none';
    }

    function alternarStatusZona(zonaId) {
        if (confirm('Deseja realmente alterar o status desta zona?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%= request.getContextPath() %>/ponto';

            const acaoInput = document.createElement('input');
            acaoInput.type = 'hidden';
            acaoInput.name = 'acao';
            acaoInput.value = 'alternar-status-zona';
            form.appendChild(acaoInput);

            const zonaIdInput = document.createElement('input');
            zonaIdInput.type = 'hidden';
            zonaIdInput.name = 'zonaId';
            zonaIdInput.value = zonaId;
            form.appendChild(zonaIdInput);

            document.body.appendChild(form);
            form.submit();
        }
    }

    window.onclick = function(e) {
        if (e.target.id === 'modalEditarZona') {
            fecharModal();
        }
    }
</script>
</body>
</html>
