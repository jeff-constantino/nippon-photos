<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"="width=device-width, initial-scale=1.0">
    <title>Admin - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #daa520;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .login-container {
            background: #000;
            padding: 50px 40px;
            border-radius: 20px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }
        
        h2 {
            color: #daa520;
            text-align: center;
            margin-bottom: 10px;
            font-size: 2rem;
        }
        
        p {
            color: #888;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            color: #daa520;
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 1px solid #333;
            background: #111;
            color: #fff;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        input:focus {
            outline: none;
            border-color: #daa520;
            background: #1a1a1a;
        }
        
        button {
            width: 100%;
            padding: 15px;
            background: #daa520;
            border: none;
            color: #000;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 10px;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        
        button:hover {
            background: #c49520;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 165, 32, 0.3);
        }
        
        .error-message {
            background: rgba(255, 77, 77, 0.1);
            border: 1px solid rgba(255, 77, 77, 0.3);
            color: #ff4d4d;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .back-link a {
            color: #daa520;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Área Administrativa</h2>
        <p>Gerenciamento do Portfólio</p>
        
        <% if (request.getAttribute("msg") != null) { %>
            <div class="error-message">
                ${msg}
            </div>
        <% } %>
        
        <form action="<%= request.getContextPath() %>/ServletLogin" method="post">
            <div class="form-group">
                <label>Usuário</label>
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="login" placeholder="Digite seu usuário" required autofocus>
                </div>
            </div>
            
            <div class="form-group">
                <label>Senha</label>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="senha" placeholder="Digite sua senha" required>
                </div>
            </div>
            
            <button type="submit">
                <i class="fas fa-sign-in-alt"></i> Acessar Painel
            </button>
        </form>
        
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/index.jsp">
                <i class="fas fa-arrow-left"></i> Voltar para o Portfólio
            </a>
        </div>
    </div>
</body>
</html>
