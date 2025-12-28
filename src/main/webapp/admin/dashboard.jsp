<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0a0a0a;
            color: #fff;
        }
        
        /* Header */
        .admin-header {
            background: #000;
            padding: 20px 40px;
            border-bottom: 2px solid #daa520;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #daa520;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .logout-btn {
            background: #daa520;
            color: #000;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #c49520;
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 40px;
        }
        
        h1 {
            color: #daa520;
            margin-bottom: 30px;
        }
        
        /* Menu Cards */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .menu-card {
            background: #111;
            padding: 40px 30px;
            border-radius: 15px;
            border: 1px solid #222;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #fff;
            display: block;
        }
        
        .menu-card:hover {
            border-color: #daa520;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(218, 165, 32, 0.2);
        }
        
        .menu-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #daa520, #c49520);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 20px;
            color: #000;
        }
        
        .menu-card h3 {
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: #daa520;
        }
        
        .menu-card p {
            color: #888;
            font-size: 0.95rem;
        }
        
        /* Stats */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: #111;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #222;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #daa520;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #888;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="admin-header">
        <div class="logo">
            <i class="fas fa-shield-alt"></i> Admin Panel
        </div>
        <div class="user-info">
            <span>Olá, <strong>${sessionScope.usuario.nome}</strong></span>
            <a href="<%= request.getContextPath() %>/ServletLogin?acao=logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Sair
            </a>
        </div>
    </div>
    
    <!-- Container -->
    <div class="container">
        <h1>Dashboard</h1>
        
        <!-- Estatísticas -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number" id="stat-projetos">0</div>
                <div class="stat-label">Projetos Ativos</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="stat-cursos">0</div>
                <div class="stat-label">Cursos Cadastrados</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">100%</div>
                <div class="stat-label">Online</div>
            </div>
        </div>
        
        <!-- Menu Principal -->
        <h2 style="color: #fff; margin-bottom: 20px;">Gerenciar Conteúdo</h2>
        <div class="menu-grid">
            <a href="perfil.jsp" class="menu-card">
                <div class="menu-icon">
                    <i class="fas fa-user"></i>
                </div>
                <h3>Editar Perfil</h3>
                <p>Atualize suas informações pessoais, foto e contatos</p>
            </a>
            
            <a href="cursos.jsp" class="menu-card">
                <div class="menu-icon">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <h3>Gerenciar Cursos</h3>
                <p>Adicione, edite ou remova cursos e certificações</p>
            </a>
            
            <a href="projetos.jsp" class="menu-card">
                <div class="menu-icon">
                    <i class="fas fa-code"></i>
                </div>
                <h3>Gerenciar Projetos</h3>
                <p>Gerencie seus projetos e funcionalidades</p>
            </a>
        </div>
        
        <div style="margin-top: 40px; text-align: center;">
            <a href="<%= request.getContextPath() %>/index.jsp" 
               style="color: #daa520; text-decoration: none; font-size: 1rem;">
                <i class="fas fa-eye"></i> Visualizar Portfólio Público
            </a>
        </div>
    </div>
    
    <script>
        // Carregar estatísticas
        fetch('<%= request.getContextPath() %>/ServletProjeto')
            .then(res => res.json())
            .then(data => {
                document.getElementById('stat-projetos').textContent = data.length;
            });
            
        fetch('<%= request.getContextPath() %>/ServletCurso')
            .then(res => res.json())
            .then(data => {
                document.getElementById('stat-cursos').textContent = data.length;
            });
    </script>
</body>
</html>
