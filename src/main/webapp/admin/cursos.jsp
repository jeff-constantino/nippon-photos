<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Cursos - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #0a0a0a; color: #fff; }
        
        /* Header */
        .admin-header { background: #000; padding: 20px 40px; border-bottom: 2px solid #daa520; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 1.5rem; font-weight: 700; color: #daa520; }
        .back-btn { background: #222; color: #daa520; padding: 10px 20px; border-radius: 8px; text-decoration: none; }
        
        /* Container */
        .container { max-width: 1200px; margin: 40px auto; padding: 0 40px; }
        h1 { color: #daa520; margin-bottom: 30px; }
        
        /* Botão Adicionar */
        .btn-add { background: #daa520; color: #000; padding: 12px 25px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; margin-bottom: 30px; }
        .btn-add:hover { background: #c49520; }
        
        /* Tabela */
        .table-container { background: #111; border-radius: 12px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #1a1a1a; }
        th { padding: 15px; text-align: left; color: #daa520; font-weight: 600; }
        td { padding: 15px; border-top: 1px solid #222; }
        tbody tr:hover { background: #1a1a1a; }
        
        /* Badges */
        .badge { padding: 5px 12px; border-radius: 20px; font-size: 0.75rem; }
        .badge-ativo { background: rgba(76, 175, 80, 0.2); color: #4caf50; border: 1px solid #4caf50; }
        .badge-inativo { background: rgba(255, 77, 77, 0.2); color: #ff4d4d; border: 1px solid #ff4d4d; }
        
        /* Botões Ação */
        .btn-edit { background: #2196F3; color: #fff; padding: 8px 15px; border: none; border-radius: 6px; cursor: pointer; margin-right: 8px; }
        .btn-delete { background: #f44336; color: #fff; padding: 8px 15px; border: none; border-radius: 6px; cursor: pointer; }
        .btn-edit:hover { background: #1976D2; }
        .btn-delete:hover { background: #d32f2f; }
        
        /* Modal */
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); overflow-y: auto; }
        .modal-content { background: #111; margin: 50px auto; padding: 40px; border-radius: 15px; max-width: 600px; border: 1px solid #daa520; }
        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .modal-header h2 { color: #daa520; }
        .close { color: #888; font-size: 2rem; cursor: pointer; }
        .close:hover { color: #daa520; }
        
        /* Form */
        .form-group { margin-bottom: 20px; }
        label { display: block; color: #daa520; margin-bottom: 8px; font-weight: 500; }
        input, textarea { width: 100%; padding: 12px 15px; background: #1a1a1a; border: 1px solid #333; color: #fff; border-radius: 8px; font-size: 1rem; }
        input:focus, textarea:focus { outline: none; border-color: #daa520; }
        textarea { min-height: 100px; resize: vertical; font-family: inherit; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        
        /* Mensagens */
        .message { padding: 15px; border-radius: 8px; margin-bottom: 20px; display: none; }
        .success { background: rgba(76, 175, 80, 0.1); border: 1px solid #4caf50; color: #4caf50; }
        .error { background: rgba(255, 77, 77, 0.1); border: 1px solid #ff4d4d; color: #ff4d4d; }
        
        /* Checkbox */
        .checkbox-group { display: flex; align-items: center; gap: 10px; }
        input[type="checkbox"] { width: auto; }
        
        /* Loading */
        .loading { text-align: center; padding: 40px; color: #daa520; }
        .empty-state { text-align: center; padding: 60px; color: #666; }
        
        /* Responsivo */
        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
            table { font-size: 0.9rem; }
            th, td { padding: 10px; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="admin-header">
        <div class="logo"><i class="fas fa-graduation-cap"></i> Gerenciar Cursos</div>
        <a href="dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Voltar</a>
    </div>
    
    <!-- Container -->
    <div class="container">
        <h1>Cursos e Certificações</h1>
        
        <button class="btn-add" onclick="abrirModalNovo()">
            <i class="fas fa-plus"></i> Adicionar Curso
        </button>
        
        <div id="message" class="message"></div>
        
        <div class="table-container">
            <div id="loading" class="loading">
                <i class="fas fa-spinner fa-spin"></i> Carregando...
            </div>
            
            <div id="empty-state" class="empty-state" style="display: none;">
                <i class="fas fa-graduation-cap" style="font-size: 3rem; margin-bottom: 15px; color: #333;"></i>
                <p>Nenhum curso cadastrado ainda</p>
            </div>
            
            <table id="table-cursos" style="display: none;">
                <thead>
                    <tr>
                        <th>Curso</th>
                        <th>Instituição</th>
                        <th>Ano</th>
                        <th>Carga Horária</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody id="tbody-cursos"></tbody>
            </table>
        </div>
    </div>
    
    <!-- Modal -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modal-title">Adicionar Curso</h2>
                <span class="close" onclick="fecharModal()">&times;</span>
            </div>
            
            <form id="formCurso">
                <input type="hidden" id="cursoId" name="id">
                
                <div class="form-group">
                    <label>Nome do Curso *</label>
                    <input type="text" id="nomeCurso" name="nomeCurso" required>
                </div>
                
                <div class="form-group">
                    <label>Instituição *</label>
                    <input type="text" id="instituicao" name="instituicao" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Ano de Conclusão *</label>
                        <input type="number" id="anoConclusao" name="anoConclusao" min="1900" max="2100" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Carga Horária (horas)</label>
                        <input type="number" id="cargaHoraria" name="cargaHoraria" min="0">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Descrição</label>
                    <textarea id="descricao" name="descricao" placeholder="Descreva o conteúdo do curso..."></textarea>
                </div>
                
                <div class="form-group">
                    <label>URL do Certificado</label>
                    <input type="url" id="certificadoUrl" name="certificadoUrl" placeholder="https://...">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Ordem de Exibição</label>
                        <input type="number" id="ordem" name="ordem" value="0" min="0">
                    </div>
                    
                    <div class="form-group">
                        <label>Status</label>
                        <div class="checkbox-group">
                            <input type="checkbox" id="ativo" name="ativo" checked>
                            <label for="ativo" style="margin: 0;">Ativo</label>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn-add" style="width: 100%; margin: 0;">
                    <i class="fas fa-save"></i> Salvar
                </button>
            </form>
        </div>
    </div>
    
    <script>
        let cursos = [];
        let editandoId = null;
        
        // Carregar cursos
        function carregarCursos() {
            document.getElementById('loading').style.display = 'block';
            document.getElementById('table-cursos').style.display = 'none';
            document.getElementById('empty-state').style.display = 'none';
            
            fetch('<%= request.getContextPath() %>/ServletCurso')
                .then(res => res.json())
                .then(data => {
                    cursos = data;
                    renderizarTabela();
                })
                .catch(err => {
                    console.error(err);
                    mostrarMensagem('Erro ao carregar cursos', 'error');
                });
        }
        
        // Renderizar tabela
        function renderizarTabela() {
            document.getElementById('loading').style.display = 'none';
            const tbody = document.getElementById('tbody-cursos');
            tbody.innerHTML = '';
            
            if (cursos.length === 0) {
                document.getElementById('empty-state').style.display = 'block';
                return;
            }
            
            document.getElementById('table-cursos').style.display = 'table';
            
            cursos.forEach(curso => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td><strong>${curso.nomeCurso}</strong></td>
                    <td>${curso.instituicao}</td>
                    <td>${curso.anoConclusao}</td>
                    <td>${curso.cargaHoraria ? curso.cargaHoraria + 'h' : '-'}</td>
                    <td>
                        <span class="badge ${curso.ativo ? 'badge-ativo' : 'badge-inativo'}">
                            ${curso.ativo ? 'Ativo' : 'Inativo'}
                        </span>
                    </td>
                    <td>
                        <button class="btn-edit" onclick="editarCurso(${curso.id})">
                            <i class="fas fa-edit"></i> Editar
                        </button>
                        <button class="btn-delete" onclick="deletarCurso(${curso.id}, '${curso.nomeCurso}')">
                            <i class="fas fa-trash"></i> Deletar
                        </button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        // Abrir modal novo
        function abrirModalNovo() {
            editandoId = null;
            document.getElementById('modal-title').textContent = 'Adicionar Curso';
            document.getElementById('formCurso').reset();
            document.getElementById('cursoId').value = '';
            document.getElementById('ativo').checked = true;
            document.getElementById('modal').style.display = 'block';
        }
        
        // Editar curso
        function editarCurso(id) {
            editandoId = id;
            const curso = cursos.find(c => c.id === id);
            
            document.getElementById('modal-title').textContent = 'Editar Curso';
            document.getElementById('cursoId').value = curso.id;
            document.getElementById('nomeCurso').value = curso.nomeCurso;
            document.getElementById('instituicao').value = curso.instituicao;
            document.getElementById('anoConclusao').value = curso.anoConclusao;
            document.getElementById('cargaHoraria').value = curso.cargaHoraria || '';
            document.getElementById('descricao').value = curso.descricao || '';
            document.getElementById('certificadoUrl').value = curso.certificadoUrl || '';
            document.getElementById('ordem').value = curso.ordem || 0;
            document.getElementById('ativo').checked = curso.ativo;
            
            document.getElementById('modal').style.display = 'block';
        }
        
        // Deletar curso
        function deletarCurso(id, nome) {
            if (!confirm(`Tem certeza que deseja deletar o curso "${nome}"?`)) {
                return;
            }
            
            const formData = new FormData();
            formData.append('acao', 'deletar');
            formData.append('id', id);
            
            fetch('<%= request.getContextPath() %>/ServletCurso', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    mostrarMensagem(data.message, 'success');
                    carregarCursos();
                } else {
                    mostrarMensagem('Erro: ' + data.error, 'error');
                }
            })
            .catch(err => mostrarMensagem('Erro ao deletar curso', 'error'));
        }
        
        // Fechar modal
        function fecharModal() {
            document.getElementById('modal').style.display = 'none';
        }
        
        // Salvar curso
        document.getElementById('formCurso').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            formData.append('acao', editandoId ? 'atualizar' : 'inserir');
            formData.append('ativo', document.getElementById('ativo').checked);
            
            fetch('<%= request.getContextPath() %>/ServletCurso', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    mostrarMensagem(data.message, 'success');
                    fecharModal();
                    carregarCursos();
                } else {
                    mostrarMensagem('Erro: ' + data.error, 'error');
                }
            })
            .catch(err => mostrarMensagem('Erro ao salvar curso', 'error'));
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
        carregarCursos();
    </script>
</body>
</html>
