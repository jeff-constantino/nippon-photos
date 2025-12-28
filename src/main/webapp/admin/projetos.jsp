<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Projetos - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #0a0a0a; color: #fff; }
        
        /* Header */
        .admin-header { background: #000; padding: 20px 40px; border-bottom: 2px solid #daa520; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 1.5rem; font-weight: 700; color: #daa520; }
        .back-btn { background: #222; color: #daa520; padding: 10px 20px; border-radius: 8px; text-decoration: none; }
        
        /* Container */
        .container { max-width: 1400px; margin: 40px auto; padding: 0 40px; }
        h1 { color: #daa520; margin-bottom: 30px; }
        
        /* Botão Adicionar */
        .btn-add { background: #daa520; color: #000; padding: 12px 25px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; margin-bottom: 30px; }
        .btn-add:hover { background: #c49520; }
        
        /* Grid de Cards */
        .projects-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 25px; }
        
        .project-card { background: #111; border-radius: 15px; padding: 25px; border: 1px solid #222; transition: all 0.3s ease; position: relative; }
        .project-card:hover { border-color: #daa520; transform: translateY(-5px); }
        
        .project-header { display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px; }
        
        .project-icon { width: 60px; height: 60px; background: linear-gradient(135deg, #daa520, #c49520); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; color: #000; margin-bottom: 15px; }
        
        .project-card h3 { color: #daa520; margin-bottom: 10px; font-size: 1.2rem; }
        .project-card p { color: #888; font-size: 0.9rem; margin-bottom: 15px; line-height: 1.6; }
        
        .project-tags { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 15px; }
        .tag { background: rgba(218, 165, 32, 0.1); color: #daa520; padding: 5px 12px; border-radius: 15px; font-size: 0.75rem; border: 1px solid rgba(218, 165, 32, 0.3); }
        
        /* Badges */
        .badge { padding: 5px 12px; border-radius: 20px; font-size: 0.75rem; margin-right: 8px; }
        .badge-ativo { background: rgba(76, 175, 80, 0.2); color: #4caf50; border: 1px solid #4caf50; }
        .badge-inativo { background: rgba(255, 77, 77, 0.2); color: #ff4d4d; border: 1px solid #ff4d4d; }
        .badge-destaque { background: rgba(255, 193, 7, 0.2); color: #ffc107; border: 1px solid #ffc107; }
        
        /* Botões Card */
        .card-actions { display: flex; gap: 10px; margin-top: 15px; }
        .btn-edit { background: #2196F3; color: #fff; padding: 10px 15px; border: none; border-radius: 8px; cursor: pointer; flex: 1; }
        .btn-delete { background: #f44336; color: #fff; padding: 10px 15px; border: none; border-radius: 8px; cursor: pointer; flex: 1; }
        .btn-edit:hover { background: #1976D2; }
        .btn-delete:hover { background: #d32f2f; }
        
        /* Modal */
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); overflow-y: auto; padding: 20px; }
        .modal-content { background: #111; margin: 0 auto; padding: 40px; border-radius: 15px; max-width: 700px; border: 1px solid #daa520; }
        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .modal-header h2 { color: #daa520; }
        .close { color: #888; font-size: 2rem; cursor: pointer; }
        .close:hover { color: #daa520; }
        
        /* Form */
        .form-group { margin-bottom: 20px; }
        label { display: block; color: #daa520; margin-bottom: 8px; font-weight: 500; }
        input, textarea, select { width: 100%; padding: 12px 15px; background: #1a1a1a; border: 1px solid #333; color: #fff; border-radius: 8px; font-size: 1rem; }
        input:focus, textarea:focus, select:focus { outline: none; border-color: #daa520; }
        textarea { min-height: 100px; resize: vertical; font-family: inherit; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        
        /* Checkbox */
        .checkbox-group { display: flex; align-items: center; gap: 10px; }
        input[type="checkbox"] { width: auto; }
        
        /* Mensagens */
        .message { padding: 15px; border-radius: 8px; margin-bottom: 20px; display: none; }
        .success { background: rgba(76, 175, 80, 0.1); border: 1px solid #4caf50; color: #4caf50; }
        .error { background: rgba(255, 77, 77, 0.1); border: 1px solid #ff4d4d; color: #ff4d4d; }
        
        /* Loading */
        .loading { text-align: center; padding: 40px; color: #daa520; }
        .empty-state { text-align: center; padding: 60px; color: #666; }
        
        /* Lista de Ícones */
        .icon-selector { display: grid; grid-template-columns: repeat(6, 1fr); gap: 10px; max-height: 200px; overflow-y: auto; padding: 10px; background: #1a1a1a; border-radius: 8px; }
        .icon-option { padding: 15px; text-align: center; border: 1px solid #333; border-radius: 8px; cursor: pointer; transition: all 0.3s; font-size: 1.5rem; }
        .icon-option:hover { background: #222; border-color: #daa520; }
        .icon-option.selected { background: #daa520; color: #000; border-color: #daa520; }
        
        /* Responsivo */
        @media (max-width: 768px) {
            .projects-grid { grid-template-columns: 1fr; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="admin-header">
        <div class="logo"><i class="fas fa-code"></i> Gerenciar Projetos</div>
        <a href="dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Voltar</a>
    </div>
    
    <!-- Container -->
    <div class="container">
        <h1>Projetos do Portfólio</h1>
        
        <button class="btn-add" onclick="abrirModalNovo()">
            <i class="fas fa-plus"></i> Adicionar Projeto
        </button>
        
        <div id="message" class="message"></div>
        
        <div id="loading" class="loading">
            <i class="fas fa-spinner fa-spin"></i> Carregando...
        </div>
        
        <div id="empty-state" class="empty-state" style="display: none;">
            <i class="fas fa-code" style="font-size: 3rem; margin-bottom: 15px; color: #333;"></i>
            <p>Nenhum projeto cadastrado ainda</p>
        </div>
        
        <div id="projects-grid" class="projects-grid" style="display: none;"></div>
    </div>
    
    <!-- Modal -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modal-title">Adicionar Projeto</h2>
                <span class="close" onclick="fecharModal()">&times;</span>
            </div>
            
            <form id="formProjeto">
                <input type="hidden" id="projetoId" name="id">
                
                <div class="form-group">
                    <label>Nome do Projeto *</label>
                    <input type="text" id="nome" name="nome" required>
                </div>
                
                <div class="form-group">
                    <label>Descrição Curta * (para card)</label>
                    <textarea id="descricaoCurta" name="descricaoCurta" placeholder="Descrição breve para o card do projeto" style="min-height: 60px;" required></textarea>
                </div>
                
                <div class="form-group">
                    <label>Descrição Completa *</label>
                    <textarea id="descricaoCompleta" name="descricaoCompleta" placeholder="Descrição detalhada do projeto" required></textarea>
                </div>
                
                <div class="form-group">
                    <label>Ícone do Projeto</label>
                    <input type="text" id="icone" name="icone" value="fa-code" readonly>
                    <div class="icon-selector" style="margin-top: 10px;">
                        <div class="icon-option selected" onclick="selecionarIcone('fa-code')"><i class="fas fa-code"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-camera')"><i class="fas fa-camera"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-clock')"><i class="fas fa-clock"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-credit-card')"><i class="fas fa-credit-card"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-calculator')"><i class="fas fa-calculator"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-shopping-cart')"><i class="fas fa-shopping-cart"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-chart-line')"><i class="fas fa-chart-line"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-database')"><i class="fas fa-database"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-mobile-alt')"><i class="fas fa-mobile-alt"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-laptop-code')"><i class="fas fa-laptop-code"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-server')"><i class="fas fa-server"></i></div>
                        <div class="icon-option" onclick="selecionarIcone('fa-shield-alt')"><i class="fas fa-shield-alt"></i></div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Tecnologias * (separadas por vírgula)</label>
                    <input type="text" id="tecnologias" name="tecnologias" placeholder="Java,JSP,PostgreSQL,Bootstrap" required>
                </div>
                
                <div class="form-group">
                    <label>URL de Acesso *</label>
                    <input type="text" id="urlAcesso" name="urlAcesso" placeholder="/portifolio/meu-projeto" required>
                </div>
                
                <div class="form-group">
                    <label>URL do GitHub</label>
                    <input type="url" id="urlGithub" name="urlGithub" placeholder="https://github.com/usuario/repositorio">
                </div>
                
                <div class="form-group">
                    <label>URL da Imagem</label>
                    <input type="url" id="imagemUrl" name="imagemUrl" placeholder="https://...">
                </div>
                
                <div class="form-group">
                    <label>Funcionalidades (uma por linha)</label>
                    <textarea id="funcionalidades" name="funcionalidades" placeholder="Funcionalidade 1&#10;Funcionalidade 2&#10;Funcionalidade 3" style="min-height: 120px;"></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Ordem de Exibição</label>
                        <input type="number" id="ordem" name="ordem" value="0" min="0">
                    </div>
                    
                    <div class="form-group">
                        <label>Opções</label>
                        <div style="display: flex; gap: 20px; padding-top: 8px;">
                            <div class="checkbox-group">
                                <input type="checkbox" id="ativo" name="ativo" checked>
                                <label for="ativo" style="margin: 0;">Ativo</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="destaque" name="destaque">
                                <label for="destaque" style="margin: 0;">Destaque</label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn-add" style="width: 100%; margin: 20px 0 0 0;">
                    <i class="fas fa-save"></i> Salvar Projeto
                </button>
            </form>
        </div>
    </div>
    
    <script>
        let projetos = [];
        let editandoId = null;
        
        // Carregar projetos
        function carregarProjetos() {
            document.getElementById('loading').style.display = 'block';
            document.getElementById('projects-grid').style.display = 'none';
            document.getElementById('empty-state').style.display = 'none';
            
            fetch('<%= request.getContextPath() %>/ServletProjeto')
                .then(res => res.json())
                .then(data => {
                    projetos = data;
                    renderizarProjetos();
                })
                .catch(err => {
                    console.error(err);
                    mostrarMensagem('Erro ao carregar projetos', 'error');
                });
        }
        
        // Renderizar projetos
        function renderizarProjetos() {
            document.getElementById('loading').style.display = 'none';
            const grid = document.getElementById('projects-grid');
            grid.innerHTML = '';
            
            if (projetos.length === 0) {
                document.getElementById('empty-state').style.display = 'block';
                return;
            }
            
            document.getElementById('projects-grid').style.display = 'grid';
            
            projetos.forEach(projeto => {
                const tecnologias = projeto.tecnologias ? projeto.tecnologias.split(',') : [];
                const tagsHtml = tecnologias.map(tec => `<span class="tag">${tec.trim()}</span>`).join('');
                
                const card = document.createElement('div');
                card.className = 'project-card';
                card.innerHTML = `
                    <div class="project-icon">
                        <i class="fas ${projeto.icone}"></i>
                    </div>
                    <h3>${projeto.nome}</h3>
                    <p>${projeto.descricaoCurta}</p>
                    <div class="project-tags">${tagsHtml}</div>
                    <div>
                        <span class="badge ${projeto.ativo ? 'badge-ativo' : 'badge-inativo'}">
                            ${projeto.ativo ? 'Ativo' : 'Inativo'}
                        </span>
                        ${projeto.destaque ? '<span class="badge badge-destaque">Destaque</span>' : ''}
                    </div>
                    <div class="card-actions">
                        <button class="btn-edit" onclick="editarProjeto(${projeto.id})">
                            <i class="fas fa-edit"></i> Editar
                        </button>
                        <button class="btn-delete" onclick="deletarProjeto(${projeto.id}, '${projeto.nome}')">
                            <i class="fas fa-trash"></i> Deletar
                        </button>
                    </div>
                `;
                grid.appendChild(card);
            });
        }
        
        // Selecionar ícone
        function selecionarIcone(iconClass) {
            document.querySelectorAll('.icon-option').forEach(opt => opt.classList.remove('selected'));
            event.target.closest('.icon-option').classList.add('selected');
            document.getElementById('icone').value = iconClass;
        }
        
        // Abrir modal novo
        function abrirModalNovo() {
            editandoId = null;
            document.getElementById('modal-title').textContent = 'Adicionar Projeto';
            document.getElementById('formProjeto').reset();
            document.getElementById('projetoId').value = '';
            document.getElementById('icone').value = 'fa-code';
            document.getElementById('ativo').checked = true;
            document.getElementById('destaque').checked = false;
            document.querySelectorAll('.icon-option').forEach((opt, idx) => {
                opt.classList.toggle('selected', idx === 0);
            });
            document.getElementById('modal').style.display = 'block';
        }
        
        // Editar projeto
        function editarProjeto(id) {
            editandoId = id;
            const projeto = projetos.find(p => p.id === id);
            
            document.getElementById('modal-title').textContent = 'Editar Projeto';
            document.getElementById('projetoId').value = projeto.id;
            document.getElementById('nome').value = projeto.nome;
            document.getElementById('descricaoCurta').value = projeto.descricaoCurta;
            document.getElementById('descricaoCompleta').value = projeto.descricaoCompleta;
            document.getElementById('icone').value = projeto.icone;
            document.getElementById('tecnologias').value = projeto.tecnologias || '';
            document.getElementById('urlAcesso').value = projeto.urlAcesso;
            document.getElementById('urlGithub').value = projeto.urlGithub || '';
            document.getElementById('imagemUrl').value = projeto.imagemUrl || '';
            document.getElementById('ordem').value = projeto.ordem || 0;
            document.getElementById('ativo').checked = projeto.ativo;
            document.getElementById('destaque').checked = projeto.destaque;
            
            // Funcionalidades
            if (projeto.funcionalidades && projeto.funcionalidades.length > 0) {
                document.getElementById('funcionalidades').value = projeto.funcionalidades.join('\n');
            }
            
            // Selecionar ícone
            document.querySelectorAll('.icon-option').forEach(opt => {
                const icon = opt.querySelector('i').className.split(' ')[1];
                opt.classList.toggle('selected', icon === projeto.icone);
            });
            
            document.getElementById('modal').style.display = 'block';
        }
        
        // Deletar projeto
        function deletarProjeto(id, nome) {
            if (!confirm(`Tem certeza que deseja deletar o projeto "${nome}"?`)) {
                return;
            }
            
            const formData = new FormData();
            formData.append('acao', 'deletar');
            formData.append('id', id);
            
            fetch('<%= request.getContextPath() %>/ServletProjeto', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    mostrarMensagem(data.message, 'success');
                    carregarProjetos();
                } else {
                    mostrarMensagem('Erro: ' + data.error, 'error');
                }
            })
            .catch(err => mostrarMensagem('Erro ao deletar projeto', 'error'));
        }
        
        // Fechar modal
        function fecharModal() {
            document.getElementById('modal').style.display = 'none';
        }
        
        // Salvar projeto
        document.getElementById('formProjeto').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            formData.append('acao', editandoId ? 'atualizar' : 'inserir');
            formData.append('ativo', document.getElementById('ativo').checked);
            formData.append('destaque', document.getElementById('destaque').checked);
            
            fetch('<%= request.getContextPath() %>/ServletProjeto', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    mostrarMensagem(data.message, 'success');
                    fecharModal();
                    carregarProjetos();
                } else {
                    mostrarMensagem('Erro: ' + data.error, 'error');
                }
            })
            .catch(err => mostrarMensagem('Erro ao salvar projeto', 'error'));
        });
        
        // Mostrar mensagem
        function mostrarMensagem(texto, tipo) {
            const msg = document.getElementById('message');
            msg.className = 'message ' + tipo;
            msg.innerHTML = '<i class="fas fa-' + (tipo === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + texto;
            msg.style.display = 'block';
            
            setTimeout(() => {
                msg.style.display = 'none';
            }, 5000);
        }
        
        // Fechar modal ao clicar fora
        window.onclick = function(event) {
            const modal = document.getElementById('modal');
            if (event.target === modal) {
                fecharModal();
            }
        }
        
        // Inicializar
        carregarProjetos();
    </script>
</body>
</html>
