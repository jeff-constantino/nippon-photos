<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jeff Constantino - Portfólio</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: #daa520;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Padrão decorativo no fundo */
        body::before {
            content: '';
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: 
                repeating-linear-gradient(
                    45deg,
                    transparent,
                    transparent 100px,
                    rgba(0,0,0,0.02) 100px,
                    rgba(0,0,0,0.02) 200px
                );
            animation: bgMove 20s linear infinite;
            pointer-events: none;
        }
        
        @keyframes bgMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }
        
        /* Card Principal */
        .main-card {
            background: #000;
            border-radius: 30px;
            width: 100%;
            max-width: 1200px;
            min-height: 650px;
            box-shadow: 
                0 50px 100px rgba(0, 0, 0, 0.3),
                0 0 0 1px rgba(218, 165, 32, 0.1);
            position: relative;
            overflow: hidden;
            animation: cardEntry 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        @keyframes cardEntry {
            from {
                opacity: 0;
                transform: scale(0.9) translateY(50px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }
        
        /* Brilho decorativo no card */
        .main-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(218, 165, 32, 0.1), transparent);
            animation: shine 3s infinite;
        }
        
        @keyframes shine {
            0% { left: -100%; }
            100% { left: 100%; }
        }
        
        /* Header do Card */
        .card-header {
            background: linear-gradient(135deg, #1a1a1a 0%, #000 100%);
            padding: 30px 40px;
            border-bottom: 2px solid #daa520;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 2rem;
            font-weight: 700;
            color: #daa520;
            text-shadow: 0 0 20px rgba(218, 165, 32, 0.5);
        }
        
        .admin-link {
            background: #daa520;
            color: #000;
            padding: 10px 25px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .admin-link:hover {
            background: #c49520;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 165, 32, 0.4);
        }
        
        /* Menu Lateral */
        .card-body {
            display: flex;
            min-height: 550px;
        }
        
        .sidebar {
            width: 250px;
            background: #0a0a0a;
            padding: 30px 0;
            border-right: 1px solid #222;
        }
        
        .menu-item {
            padding: 18px 30px;
            color: #888;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 15px;
            font-weight: 500;
            border-left: 3px solid transparent;
        }
        
        .menu-item:hover {
            background: #111;
            color: #daa520;
            border-left-color: #daa520;
        }
        
        .menu-item.active {
            background: #111;
            color: #daa520;
            border-left-color: #daa520;
        }
        
        .menu-item i {
            font-size: 1.2rem;
            width: 25px;
        }
        
        /* Conteúdo Principal */
        .content {
            flex: 1;
            padding: 40px;
            color: #fff;
            overflow-y: auto;
            max-height: 550px;
        }
        
        .content::-webkit-scrollbar {
            width: 8px;
        }
        
        .content::-webkit-scrollbar-track {
            background: #0a0a0a;
        }
        
        .content::-webkit-scrollbar-thumb {
            background: #daa520;
            border-radius: 10px;
        }
        
        .content-section {
            display: none;
            animation: fadeIn 0.5s ease;
        }
        
        .content-section.active {
            display: block;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #daa520;
        }
        
        h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: #daa520;
        }
        
        h3 {
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: #fff;
        }
        
        p {
            color: #aaa;
            line-height: 1.8;
            margin-bottom: 15px;
        }
        
        /* Perfil */
        .profile-header {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
            align-items: center;
        }
        
        .profile-photo {
            width: 150px;
            height: 150px;
            border-radius: 20px;
            background: #222;
            border: 3px solid #daa520;
            object-fit: cover;
        }
        
        .profile-info {
            flex: 1;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            color: #ccc;
        }
        
        .info-item i {
            color: #daa520;
            width: 20px;
        }
        
        /* Cursos */
        .curso-item {
            background: #111;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 15px;
            border-left: 4px solid #daa520;
        }
        
        .curso-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 10px;
        }
        
        .curso-nome {
            font-size: 1.1rem;
            font-weight: 600;
            color: #fff;
        }
        
        .curso-ano {
            color: #daa520;
            font-weight: 600;
        }
        
        .curso-instituicao {
            color: #888;
            font-size: 0.9rem;
        }
        
        /* Projetos Grid */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .project-card {
            background: #111;
            padding: 25px;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .project-card:hover {
            border-color: #daa520;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(218, 165, 32, 0.2);
        }
        
        .project-icon {
            width: 60px;
            height: 60px;
            background: #daa520;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: #000;
        }
        
        .project-name {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #fff;
        }
        
        .project-desc {
            font-size: 0.9rem;
            color: #888;
            margin-bottom: 15px;
        }
        
        .project-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }
        
        .tag {
            background: rgba(218, 165, 32, 0.1);
            color: #daa520;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            border: 1px solid rgba(218, 165, 32, 0.3);
        }
        
        /* Detalhes do Projeto */
        .project-detail {
            display: none;
        }
        
        .project-detail.active {
            display: block;
        }
        
        .back-btn {
            background: #222;
            color: #daa520;
            border: 1px solid #daa520;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            margin-bottom: 20px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            background: #daa520;
            color: #000;
        }
        
        .feature-list {
            list-style: none;
            margin-top: 20px;
        }
        
        .feature-list li {
            padding: 12px 0;
            border-bottom: 1px solid #222;
            color: #ccc;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .feature-list li i {
            color: #daa520;
        }
        
        .access-btn {
            display: inline-block;
            background: #daa520;
            color: #000;
            padding: 15px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            margin-top: 20px;
            transition: all 0.3s ease;
        }
        
        .access-btn:hover {
            background: #c49520;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 165, 32, 0.4);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .main-card {
                border-radius: 20px;
                min-height: auto;
            }
            
            .card-header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }
            
            .card-body {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
                border-right: none;
                border-bottom: 1px solid #222;
                padding: 15px 0;
            }
            
            .content {
                padding: 20px;
                max-height: none;
            }
            
            .profile-header {
                flex-direction: column;
                text-align: center;
            }
            
            .projects-grid {
                grid-template-columns: 1fr;
            }
            
            h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="main-card">
        <!-- Header -->
        <div class="card-header">
            <div class="logo">JC Portfolio</div>
            <a href="<%= request.getContextPath() %>/admin/login.jsp" class="admin-link">
                <i class="fas fa-lock"></i>
                Área Admin
            </a>
        </div>
        
        <!-- Body -->
        <div class="card-body">
            <!-- Sidebar Menu -->
            <div class="sidebar">
                <div class="menu-item active" data-section="perfil">
                    <i class="fas fa-user"></i>
                    <span>Perfil</span>
                </div>
                <div class="menu-item" data-section="cursos">
                    <i class="fas fa-graduation-cap"></i>
                    <span>Cursos</span>
                </div>
                <div class="menu-item" data-section="projetos">
                    <i class="fas fa-code"></i>
                    <span>Projetos</span>
                </div>
            </div>
            
            <!-- Content Area -->
            <div class="content">
                <!-- Seção Perfil -->
                <div class="content-section active" id="perfil">
                    <h1>Sobre Mim</h1>
                    
                    <div class="profile-header">
                        <img src="<%= request.getContextPath() %>/images/profile.jpg" 
                             alt="Jeff Constantino" 
                             class="profile-photo"
                             onerror="this.src='https://via.placeholder.com/150/daa520/000?text=JC'">
                        <div class="profile-info">
                            <h2 id="dev-nome">Jeff Constantino</h2>
                            <p id="dev-titulo">Desenvolvedor Full Stack</p>
                            
                            <div class="info-item">
                                <i class="fas fa-envelope"></i>
                                <span id="dev-email">jeff@exemplo.com</span>
                            </div>
                            <div class="info-item">
                                <i class="fab fa-linkedin"></i>
                                <span id="dev-linkedin">linkedin.com/in/jeffconstantino</span>
                            </div>
                            <div class="info-item">
                                <i class="fab fa-github"></i>
                                <span id="dev-github">github.com/jeffconstantino</span>
                            </div>
                        </div>
                    </div>
                    
                    <h3>Sobre</h3>
                    <p id="dev-descricao">
                        Desenvolvedor Full Stack especializado em criar soluções empresariais completas. 
                        Com forte experiência em Java, JSP e PostgreSQL, desenvolvo sistemas robustos 
                        que otimizam processos e aumentam a produtividade das empresas.
                    </p>
                    
                    <h3>Escolaridade</h3>
                    <p id="dev-escolaridade">Análise e Desenvolvimento de Sistemas</p>
                </div>
                
                <!-- Seção Cursos -->
                <div class="content-section" id="cursos">
                    <h1>Formação e Cursos</h1>
                    <div id="cursos-list">
                        <div class="curso-item">
                            <div class="curso-header">
                                <div>
                                    <div class="curso-nome">Análise e Desenvolvimento de Sistemas</div>
                                    <div class="curso-instituicao">Faculdade Exemplo</div>
                                </div>
                                <div class="curso-ano">2022</div>
                            </div>
                            <p>Formação completa em desenvolvimento de sistemas, banco de dados e engenharia de software.</p>
                        </div>
                        
                        <div class="curso-item">
                            <div class="curso-header">
                                <div>
                                    <div class="curso-nome">Java Web Development</div>
                                    <div class="curso-instituicao">Udemy</div>
                                </div>
                                <div class="curso-ano">2021</div>
                            </div>
                            <p>Desenvolvimento de aplicações web com Java, Servlets, JSP e JDBC.</p>
                        </div>
                    </div>
                </div>
                
                <!-- Seção Projetos - Lista -->
                <div class="content-section" id="projetos">
                    <h1>Meus Projetos</h1>
                    <p>Clique em um projeto para ver mais detalhes</p>
                    
                    <div class="projects-grid" id="projects-grid">
                        <!-- Projetos serão carregados aqui -->
                    </div>
                </div>
                
                <!-- Seção Projetos - Detalhe (inicialmente oculta) -->
                <div class="project-detail" id="project-detail">
                    <button class="back-btn" onclick="voltarProjetos()">
                        <i class="fas fa-arrow-left"></i>
                        Voltar
                    </button>
                    
                    <h1 id="detail-nome">Nome do Projeto</h1>
                    <p id="detail-descricao">Descrição completa do projeto...</p>
                    
                    <h3>Tecnologias Utilizadas</h3>
                    <div id="detail-tags" class="project-tags"></div>
                    
                    <h3>Funcionalidades</h3>
                    <ul class="feature-list" id="detail-funcionalidades">
                        <!-- Funcionalidades serão carregadas aqui -->
                    </ul>
                    
                    <a href="#" id="detail-link" class="access-btn" target="_blank">
                        <i class="fas fa-external-link-alt"></i>
                        Acessar Sistema
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Menu Navigation
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                // Remove active de todos
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                document.querySelectorAll('.content-section').forEach(s => s.classList.remove('active'));
                
                // Adiciona active no clicado
                this.classList.add('active');
                const section = this.getAttribute('data-section');
                document.getElementById(section).classList.add('active');
                
                // Volta para lista de projetos se estava vendo detalhe
                if(section === 'projetos') {
                    document.getElementById('projetos').style.display = 'block';
                    document.getElementById('project-detail').classList.remove('active');
                }
            });
        });
        
        // Carregar Projetos (simulado - depois virá do banco)
        const projetos = [
            {
                id: 1,
                nome: 'Nippon Photos - Sistema de Gestão',
                descricao_curta: 'Sistema completo de vendas e gerenciamento financeiro',
                descricao_completa: 'Sistema completo de vendas e gerenciamento financeiro desenvolvido para a empresa Nippon Photos, incluindo controle de estoque, PDV, relatórios e dashboards analíticos.',
                icone: 'fa-camera',
                tecnologias: ['Java', 'JSP', 'PostgreSQL', 'MVC'],
                url_acesso: '<%= request.getContextPath() %>/principal/principal.jsp',
                funcionalidades: [
                    'Controle completo de estoque com movimentações',
                    'PDV (Ponto de Venda) integrado',
                    'Gestão financeira e fluxo de caixa',
                    'Relatórios gerenciais e dashboards',
                    'Controle de clientes e fornecedores',
                    'Sistema de permissões por usuário'
                ]
            },
            {
                id: 2,
                nome: 'Sistema de Registro de Ponto',
                descricao_curta: 'Gestão de ponto eletrônico com controle de jornada',
                descricao_completa: 'Aplicação web para gestão de ponto eletrônico com controle de jornada, relatórios de horas trabalhadas e exportação de dados para folha de pagamento.',
                icone: 'fa-clock',
                tecnologias: ['Java', 'JSP', 'PostgreSQL'],
                url_acesso: '<%= request.getContextPath() %>/ponto/index.jsp',
                funcionalidades: [
                    'Registro de entrada e saída de funcionários',
                    'Cálculo automático de horas trabalhadas',
                    'Relatórios para folha de pagamento',
                    'Controle de horas extras e faltas',
                    'Exportação de dados em diversos formatos'
                ]
            },
            {
                id: 3,
                nome: 'Sistema de Gestão de Crediário',
                descricao_curta: 'Controle de vendas a prazo e inadimplência',
                descricao_completa: 'Sistema para controle de vendas a prazo, gerenciamento de parcelas, controle de inadimplência e geração de carnês personalizados.',
                icone: 'fa-credit-card',
                tecnologias: ['Java', 'JSP', 'PostgreSQL'],
                url_acesso: '<%= request.getContextPath() %>/qsd/crediario.jsp',
                funcionalidades: [
                    'Cadastro de vendas a prazo',
                    'Controle de parcelas e vencimentos',
                    'Gestão de inadimplência',
                    'Geração de carnês personalizados',
                    'Relatórios de contas a receber'
                ]
            },
            {
                id: 4,
                nome: 'Calculadora de Conferência',
                descricao_curta: 'Ferramenta para conferência de relatórios',
                descricao_completa: 'Ferramenta para conferência rápida e precisa de relatórios de vendas em máquinas de cartão, com cálculo automático de taxas e diferenças.',
                icone: 'fa-calculator',
                tecnologias: ['JavaScript', 'JSP'],
                url_acesso: '<%= request.getContextPath() %>/calc/index.jsp',
                funcionalidades: [
                    'Conferência rápida de relatórios',
                    'Cálculo automático de taxas',
                    'Identificação de diferenças',
                    'Interface intuitiva e responsiva'
                ]
            }
        ];
        
        // Renderizar projetos
        function renderizarProjetos() {
            const grid = document.getElementById('projects-grid');
            grid.innerHTML = '';
            
            projetos.forEach(projeto => {
                const card = document.createElement('div');
                card.className = 'project-card';
                card.onclick = () => mostrarDetalheProjeto(projeto);
                
                const tags = projeto.tecnologias.map(tec => 
                    `<span class="tag">${tec}</span>`
                ).join('');
                
                card.innerHTML = `
                    <div class="project-icon">
                        <i class="fas ${projeto.icone}"></i>
                    </div>
                    <div class="project-name">${projeto.nome}</div>
                    <div class="project-desc">${projeto.descricao_curta}</div>
                    <div class="project-tags">${tags}</div>
                `;
                
                grid.appendChild(card);
            });
        }
        
        // Mostrar detalhe do projeto
        function mostrarDetalheProjeto(projeto) {
            document.getElementById('projetos').style.display = 'none';
            document.getElementById('project-detail').classList.add('active');
            
            document.getElementById('detail-nome').textContent = projeto.nome;
            document.getElementById('detail-descricao').textContent = projeto.descricao_completa;
            document.getElementById('detail-link').href = projeto.url_acesso;
            
            // Tags
            const tagsHtml = projeto.tecnologias.map(tec => 
                `<span class="tag">${tec}</span>`
            ).join('');
            document.getElementById('detail-tags').innerHTML = tagsHtml;
            
            // Funcionalidades
            const funcHtml = projeto.funcionalidades.map(func => 
                `<li><i class="fas fa-check-circle"></i> ${func}</li>`
            ).join('');
            document.getElementById('detail-funcionalidades').innerHTML = funcHtml;
        }
        
        // Voltar para lista de projetos
        function voltarProjetos() {
            document.getElementById('projetos').style.display = 'block';
            document.getElementById('project-detail').classList.remove('active');
        }
        
        // Inicializar
        renderizarProjetos();
    </script>
</body>
</html>
