<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #0a0a0a; color: #fff; }
        .admin-header { background: #000; padding: 20px 40px; border-bottom: 2px solid #daa520; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 1.5rem; font-weight: 700; color: #daa520; }
        .back-btn { background: #222; color: #daa520; padding: 10px 20px; border-radius: 8px; text-decoration: none; }
        .container { max-width: 800px; margin: 40px auto; padding: 0 40px; }
        h1 { color: #daa520; margin-bottom: 30px; }
        .form-group { margin-bottom: 25px; }
        label { display: block; color: #daa520; margin-bottom: 8px; font-weight: 500; }
        input, textarea { width: 100%; padding: 12px 15px; background: #111; border: 1px solid #333; color: #fff; border-radius: 8px; font-size: 1rem; }
        input:focus, textarea:focus { outline: none; border-color: #daa520; background: #1a1a1a; }
        textarea { min-height: 150px; resize: vertical; font-family: inherit; }
        .btn-primary { background: #daa520; color: #000; padding: 15px 30px; border: none; border-radius: 8px; font-size: 1rem; font-weight: 600; cursor: pointer; }
        .btn-primary:hover { background: #c49520; }
        .success-message { background: rgba(76, 175, 80, 0.1); border: 1px solid rgba(76, 175, 80, 0.3); color: #4caf50; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
        .error-message { background: rgba(255, 77, 77, 0.1); border: 1px solid rgba(255, 77, 77, 0.3); color: #ff4d4d; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
        .loading { display: none; text-align: center; color: #daa520; }
    </style>
</head>
<body>
    <div class="admin-header">
        <div class="logo"><i class="fas fa-user"></i> Editar Perfil</div>
        <a href="dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Voltar</a>
    </div>
    
    <div class="container">
        <h1>Informações do Perfil</h1>
        
        <div id="message"></div>
        <div class="loading" id="loading">Salvando...</div>
        
        <form id="formPerfil">
            <div class="form-group">
                <label>Nome Completo</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            
            <div class="form-group">
                <label>Título Profissional</label>
                <input type="text" id="titulo" name="titulo" placeholder="Ex: Desenvolvedor Full Stack" required>
            </div>
            
            <div class="form-group">
                <label>Sobre Você</label>
                <textarea id="descricao" name="descricao" placeholder="Escreva uma descrição sobre você e sua experiência"></textarea>
            </div>
            
            <div class="form-group">
                <label>URL da Foto</label>
                <input type="url" id="fotoUrl" name="fotoUrl" placeholder="https://exemplo.com/foto.jpg">
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" id="email" name="email">
            </div>
            
            <div class="form-group">
                <label>Telefone</label>
                <input type="tel" id="telefone" name="telefone">
            </div>
            
            <div class="form-group">
                <label>LinkedIn</label>
                <input type="url" id="linkedin" name="linkedin" placeholder="https://linkedin.com/in/seu-perfil">
            </div>
            
            <div class="form-group">
                <label>GitHub</label>
                <input type="url" id="github" name="github" placeholder="https://github.com/seu-usuario">
            </div>
            
            <div class="form-group">
                <label>Escolaridade</label>
                <textarea id="escolaridade" name="escolaridade" placeholder="Descreva sua formação acadêmica"></textarea>
            </div>
            
            <button type="submit" class="btn-primary"><i class="fas fa-save"></i> Salvar Alterações</button>
        </form>
    </div>
    
    <script>
        // Carregar dados do perfil
        fetch('<%= request.getContextPath() %>/ServletPerfil')
            .then(res => res.json())
            .then(perfil => {
                document.getElementById('nome').value = perfil.nome || '';
                document.getElementById('titulo').value = perfil.titulo || '';
                document.getElementById('descricao').value = perfil.descricao || '';
                document.getElementById('fotoUrl').value = perfil.fotoUrl || '';
                document.getElementById('email').value = perfil.email || '';
                document.getElementById('telefone').value = perfil.telefone || '';
                document.getElementById('linkedin').value = perfil.linkedin || '';
                document.getElementById('github').value = perfil.github || '';
                document.getElementById('escolaridade').value = perfil.escolaridade || '';
            });
        
        // Salvar perfil
        document.getElementById('formPerfil').addEventListener('submit', function(e) {
            e.preventDefault();
            
            document.getElementById('loading').style.display = 'block';
            document.getElementById('message').innerHTML = '';
            
            const formData = new FormData(this);
            
            fetch('<%= request.getContextPath() %>/ServletPerfil', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                document.getElementById('loading').style.display = 'none';
                if (data.success) {
                    document.getElementById('message').innerHTML = '<div class="success-message"><i class="fas fa-check-circle"></i> ' + data.message + '</div>';
                } else {
                    document.getElementById('message').innerHTML = '<div class="error-message"><i class="fas fa-exclamation-circle"></i> Erro: ' + data.error + '</div>';
                }
            })
            .catch(err => {
                document.getElementById('loading').style.display = 'none';
                document.getElementById('message').innerHTML = '<div class="error-message">Erro ao salvar!</div>';
            });
        });
    </script>
</body>
</html>
