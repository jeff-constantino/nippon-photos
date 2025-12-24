<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, connection.SingleConnectionBanco, java.security.MessageDigest" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Utilitário - Gerenciar Senhas</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f2a654;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            width: 100%;
            max-width: 600px;
        }
        .card {
            background: #1a1a1a;
            border-radius: 15px;
            padding: 30px;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            margin-bottom: 20px;
        }
        h1 {
            color: #f2a654;
            text-align: center;
            margin-bottom: 10px;
            font-size: 28px;
        }
        .aviso {
            background: #d32f2f;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
        h2 {
            color: #f2a654;
            margin: 20px 0 15px;
            font-size: 20px;
            border-bottom: 2px solid #f2a654;
            padding-bottom: 10px;
        }
        label {
            color: #f2a654;
            font-weight: 600;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #333;
            border-radius: 8px;
            background: #2a2a2a;
            color: white;
            font-size: 16px;
            margin-bottom: 5px;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #f2a654;
        }
        .btn {
            width: 100%;
            padding: 15px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #f2a654;
            color: #1a1a1a;
        }
        .btn-primary:hover {
            background: #e09543;
            transform: translateY(-2px);
        }
        .btn-danger {
            background: #d32f2f;
            color: white;
        }
        .btn-danger:hover {
            background: #b71c1c;
        }
        .msg {
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            text-align: center;
            font-weight: bold;
        }
        .msg-sucesso {
            background: #2e7d32;
        }
        .msg-erro {
            background: #d32f2f;
        }
        .msg-info {
            background: #1976d2;
        }
        .code {
            background: #2a2a2a;
            padding: 10px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            margin: 10px 0;
            word-break: break-all;
        }
        small {
            color: #ccc;
            display: block;
            margin-top: 5px;
        }
        hr {
            border: none;
            border-top: 1px solid #333;
            margin: 30px 0;
        }
    </style>
</head>
<body>
<%!
    // Método para gerar hash SHA-256
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
%>

<div class="container">
    <div class="card">
        <h1>🔧 Utilitário de Senhas</h1>

        <%
            String acao = request.getParameter("acao");
            String mensagem = null;
            String tipoMensagem = null;

            if (acao != null) {
                Connection conn = SingleConnectionBanco.getConnection();

                try {
                    if ("criar-admin".equals(acao)) {
                        String usuario = request.getParameter("usuario");
                        String senha = request.getParameter("senha");
                        String nome = request.getParameter("nome");
                        String senhaHash = hashSenha(senha);

                        String sql = "INSERT INTO ponto_admin (usuario, senha, nome) VALUES (?, ?, ?)";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, usuario);
                        ps.setString(2, senhaHash);
                        ps.setString(3, nome);
                        ps.executeUpdate();
                        conn.commit();

                        mensagem = "✅ Admin criado com sucesso!<br>Usuário: <strong>" + usuario + "</strong>";
                        tipoMensagem = "sucesso";

                    } else if ("alterar-senha-admin".equals(acao)) {
                        String usuario = request.getParameter("usuario-alt");
                        String novaSenha = request.getParameter("nova-senha");
                        String senhaHash = hashSenha(novaSenha);

                        String sql = "UPDATE ponto_admin SET senha = ? WHERE usuario = ?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, senhaHash);
                        ps.setString(2, usuario);
                        int rows = ps.executeUpdate();
                        conn.commit();

                        if (rows > 0) {
                            mensagem = "✅ Senha do admin <strong>" + usuario + "</strong> alterada!";
                            tipoMensagem = "sucesso";
                        } else {
                            mensagem = "❌ Usuário admin não encontrado!";
                            tipoMensagem = "erro";
                        }

                    } else if ("alterar-senha-func".equals(acao)) {
                        int funcId = Integer.parseInt(request.getParameter("func-id"));
                        String novaSenha = request.getParameter("senha-func");
                        String senhaHash = hashSenha(novaSenha);

                        String sql = "UPDATE ponto_funcionarios SET senha = ? WHERE id = ?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, senhaHash);
                        ps.setInt(2, funcId);
                        int rows = ps.executeUpdate();
                        conn.commit();

                        if (rows > 0) {
                            mensagem = "✅ Senha do funcionário alterada!";
                            tipoMensagem = "sucesso";
                        } else {
                            mensagem = "❌ Funcionário não encontrado!";
                            tipoMensagem = "erro";
                        }

                    } else if ("gerar-hash".equals(acao)) {
                        String senhaParaHash = request.getParameter("senha-hash");
                        String hash = hashSenha(senhaParaHash);

                        mensagem = "Hash SHA-256 gerado:<br><div class='code'>" + hash + "</div>";
                        tipoMensagem = "info";
                    }

                } catch (Exception e) {
                    mensagem = "❌ Erro: " + e.getMessage();
                    tipoMensagem = "erro";
                    e.printStackTrace();
                }
            }
        %>

        <% if (mensagem != null) { %>
        <div class="msg msg-<%= tipoMensagem %>"><%= mensagem %></div>
        <% } %>

        <!-- CRIAR NOVO ADMIN -->
        <h2>➕ Criar Novo Admin</h2>
        <form method="post">
            <input type="hidden" name="acao" value="criar-admin">

            <label>Usuário *</label>
            <input type="text" name="usuario" required placeholder="Ex: joao.silva">
            <small>Login que será usado para acessar o painel admin</small>

            <label>Nome Completo *</label>
            <input type="text" name="nome" required placeholder="Ex: João Silva">

            <label>Senha *</label>
            <input type="password" name="senha" required placeholder="Digite a senha">
            <small>Mínimo 6 caracteres (recomendado: use letras, números e símbolos)</small>

            <button type="submit" class="btn btn-primary">Criar Admin</button>
        </form>

        <hr>

        <!-- ALTERAR SENHA ADMIN -->
        <h2>🔑 Alterar Senha de Admin</h2>
        <form method="post">
            <input type="hidden" name="acao" value="alterar-senha-admin">

            <label>Usuário Admin *</label>
            <select name="usuario-alt" required>
                <option value="">Selecione...</option>
                <%
                    try {
                        Connection conn = SingleConnectionBanco.getConnection();
                        PreparedStatement ps = conn.prepareStatement("SELECT usuario, nome FROM ponto_admin ORDER BY usuario");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%= rs.getString("usuario") %>"><%= rs.getString("usuario") %> - <%= rs.getString("nome") %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select>

            <label>Nova Senha *</label>
            <input type="password" name="nova-senha" required placeholder="Digite a nova senha">

            <button type="submit" class="btn btn-primary">Alterar Senha Admin</button>
        </form>

        <hr>

        <!-- ALTERAR SENHA FUNCIONÁRIO -->
        <h2>👤 Alterar Senha de Funcionário</h2>
        <form method="post">
            <input type="hidden" name="acao" value="alterar-senha-func">

            <label>Funcionário *</label>
            <select name="func-id" required>
                <option value="">Selecione...</option>
                <%
                    try {
                        Connection conn = SingleConnectionBanco.getConnection();
                        PreparedStatement ps = conn.prepareStatement("SELECT id, nome, cpf FROM ponto_funcionarios ORDER BY nome");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%= rs.getInt("id") %>"><%= rs.getString("nome") %> (CPF: <%= rs.getString("cpf") %>)</option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select>

            <label>Nova Senha *</label>
            <input type="password" name="senha-func" required placeholder="Digite a nova senha">

            <button type="submit" class="btn btn-primary">Alterar Senha Funcionário</button>
        </form>

        <hr>

        <!-- GERAR HASH (PARA SQL MANUAL) -->
        <h2>🔐 Gerar Hash SHA-256</h2>
        <p style="color: #ccc; margin-bottom: 15px;">
            Use este hash se for inserir/atualizar senhas diretamente no banco via SQL.
        </p>
        <form method="post">
            <input type="hidden" name="acao" value="gerar-hash">

            <label>Senha *</label>
            <input type="text" name="senha-hash" required placeholder="Digite a senha">
            <small>O hash será exibido abaixo (copie e use no SQL)</small>

            <button type="submit" class="btn btn-primary">Gerar Hash</button>
        </form>

        <hr>


    </div>
</div>
</body>
</html>
