<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (request.getParameter("logout") != null) { session.invalidate(); response.sendRedirect("index.jsp"); return; }
    if (request.getParameter("acaoLogin") != null) {
        if ("jd".equals(request.getParameter("login")) && "Jos3di@s".equals(request.getParameter("senha"))) session.setAttribute("logado", true);
    }
    boolean estaLogado = session.getAttribute("logado") != null && (boolean) session.getAttribute("logado");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Estoque Master</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-bottom: 80px; background-color: #020202; }
        .card-estoque { border-radius: 18px; color: #fff; cursor: pointer; transition: 0.2s; min-height: 160px; border: none; display: flex; align-items: center; justify-content: center; text-align: center; }
        .card-estoque:hover { transform: scale(1.02); filter: brightness(1.1); }
        .bg-cadastro { background-color: #ffbd00; color: #000; }
        .bg-relatorio { background-color: #6c757d; }
        .bg-entrada { background-color: #00a6fb; }
        .bg-saida { background-color: #dd1c1a; }
        .bg-troca { background-color: #5a189a; }

        .footer { position: fixed; bottom: 0; left: 0; right: 0; text-align: center; padding: 15px; background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(10px); border-top: 1px solid #daa520; color: #fff; font-size: 13px; z-index: 1000; }
        .footer a { color: #ffd700; text-decoration: none; font-weight: 700; transition: all 0.3s; }
        .footer a:hover { color: #fff; text-shadow: 0 0 10px #daa520; text-decoration: underline; }

        .produto-info { display: none; padding: 8px; background: #f0f0f0; border-radius: 5px; margin-top: 5px; font-size: 0.85rem; }
        .produto-info.show { display: block; }

        @media (max-width: 768px) {
            .card-estoque { min-height: 140px; }
            .card-estoque h5 { font-size: 1.1rem; }
            .footer { font-size: 12px; padding: 12px; }
        }
    </style>
</head>
<body>
<div class="container py-4">
    <% if (!estaLogado) { %>
    <div class="row justify-content-center mt-5"><div class="col-md-4"><div class="card p-4 shadow-sm">
        <h4 class="text-center mb-4">Acesso</h4>
        <form action="index.jsp" method="post"><input type="hidden" name="acaoLogin" value="1">
            <input type="text" name="login" class="form-control mb-3" placeholder="Usuário" required>
            <input type="password" name="senha" class="form-control mb-3" placeholder="Senha" required>
            <button type="submit" class="btn btn-primary w-100">Entrar</button></form></div></div></div>
    <% } else { %>

    <div class="d-flex justify-content-between align-items-center mb-2">
        <h4>📦 Controle de Estoque</h4>
        <a href="index.jsp?logout=true" class="btn btn-outline-danger btn-sm">Sair</a>
    </div>

    <c:if test="${not empty param.msg}">
        <div class="alert alert-dismissible fade show mb-3
            ${param.msg == 'duplicado' ? 'alert-warning' :
              param.msg == 'sucesso' ? 'alert-success' : 'alert-info'}" role="alert">
            <c:choose>
                <c:when test="${param.msg == 'sucesso'}">✅ Operação realizada com sucesso!</c:when>
                <c:when test="${param.msg == 'erro'}">❌ Erro ao processar dados no banco.</c:when>
                <c:when test="${param.msg == 'erro_relatorio'}">⚠️ Erro ao gerar relatório.</c:when>
                <c:when test="${param.msg == 'informe_datas'}">📅 Selecione as datas inicial e final.</c:when>
                <c:when test="${param.msg == 'duplicado'}">
                    ⚠️ <strong>Código de barras já cadastrado!</strong><br>
                    <strong>Produto:</strong> ${param.nome}<br>
                    <strong>Marca:</strong> ${param.marca}<br>
                    <strong>Peso:</strong> ${param.peso}
                </c:when>
            </c:choose>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-3">
        <div class="col-12"><div class="card card-estoque bg-relatorio" data-bs-toggle="modal" data-bs-target="#modalRelatorio"><h5>📊 Relatórios</h5></div></div>
        <div class="col-6"><div class="card card-estoque bg-cadastro" data-bs-toggle="modal" data-bs-target="#modalCadastro"><h5>📝 Cadastro</h5></div></div>
        <div class="col-6"><div class="card card-estoque bg-troca" data-bs-toggle="modal" data-bs-target="#modalTroca"><h5>🔄 Trocas</h5></div></div>
        <div class="col-6"><div class="card card-estoque bg-entrada" data-bs-toggle="modal" data-bs-target="#modalEntrada"><h5>➕ Entrada</h5></div></div>
        <div class="col-6"><div class="card card-estoque bg-saida" data-bs-toggle="modal" data-bs-target="#modalSaida"><h5>➖ Saída</h5></div></div>
    </div>
    <% } %>
</div>

<!-- Modal Cadastro -->
<div class="modal fade" id="modalCadastro" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content bg-cadastro border-0"><div class="modal-header border-0"><h5>Novo Produto</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
    <form action="<%= request.getContextPath() %>/ServletEstoque" method="post" class="modal-body" id="formCadastro">
        <input type="hidden" name="acao" value="cadastrar">
        <input type="text" name="codBarra" id="codBarraCadastro" class="form-control mb-2" placeholder="Código de Barras" required>
        <input type="text" name="nome" class="form-control mb-2" placeholder="Nome do Produto" required>

        <div class="mb-2">
            <select name="marca" id="marcaSelect" class="form-select">
                <option value="">Selecione a Marca</option>
                <option value="__NOVO__">➕ Adicionar Nova Marca</option>
            </select>
            <input type="text" name="marcaNova" id="marcaNovaInput" class="form-control mt-2" placeholder="Digite a nova marca" style="display:none;">
        </div>

        <div class="mb-2">
            <select name="peso" id="pesoSelect" class="form-select">
                <option value="">Selecione o Peso</option>
                <option value="__NOVO__">➕ Adicionar Novo Peso</option>
            </select>
            <input type="text" name="pesoNovo" id="pesoNovoInput" class="form-control mt-2" placeholder="Digite o novo peso (Ex: 1kg, 500g)" style="display:none;">
        </div>

        <div class="row g-2">
            <div class="col"><input type="number" step="0.01" name="valorCompra" class="form-control" placeholder="R$ Compra"></div>
            <div class="col"><input type="number" step="0.01" name="valorVenda" class="form-control" placeholder="R$ Venda"></div>
        </div>
        <input type="number" name="estoqueInicial" class="form-control mt-2" placeholder="Estoque Inicial" value="0">
        <button type="submit" class="btn btn-dark w-100 mt-3 py-2 fw-bold">Salvar Produto</button>
    </form></div></div></div>

<!-- Modal Entrada -->
<div class="modal fade" id="modalEntrada" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content bg-entrada text-white border-0"><div class="modal-header border-0"><h5>Entrada de Estoque</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
    <form action="<%= request.getContextPath() %>/ServletEstoque" method="post" class="modal-body">
        <input type="hidden" name="acao" value="entrada">
        <input type="text" name="codBarra" id="codBarraEntrada" class="form-control mb-2" placeholder="Código de Barras" required>
        <div id="infoEntrada" class="produto-info text-dark"></div>
        <input type="number" name="quantidade" class="form-control mb-2" placeholder="Quantidade" required>
        <select name="motivo" class="form-select mb-2">
            <option value="REVENDA">Revenda</option>
            <option value="PRODUCAO">Produção</option>
        </select>
        <button type="submit" class="btn btn-light w-100 fw-bold" style="color:#00a6fb">Confirmar</button>
    </form></div></div></div>

<!-- Modal Saída -->
<div class="modal fade" id="modalSaida" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content bg-saida text-white border-0"><div class="modal-header border-0"><h5>Saída de Estoque</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
    <form action="<%= request.getContextPath() %>/ServletEstoque" method="post" class="modal-body">
        <input type="hidden" name="acao" value="saida">
        <input type="text" name="codBarra" id="codBarraSaida" class="form-control mb-2" placeholder="Código de Barras" required>
        <div id="infoSaida" class="produto-info text-dark"></div>
        <input type="number" name="quantidade" class="form-control mb-2" placeholder="Quantidade" required>
        <select name="motivo" class="form-select mb-2">
            <option value="VENDA">Venda</option>
            <option value="BRINDE">Brinde</option>
            <option value="AVARIA">Avaria</option>
        </select>
        <textarea name="observacao" class="form-control mb-2" placeholder="Observações"></textarea>
        <button type="submit" class="btn btn-light w-100 text-danger fw-bold">Confirmar Saída</button>
    </form></div></div></div>

<!-- Modal Troca -->
<div class="modal fade" id="modalTroca" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content bg-troca text-white border-0"><div class="modal-header border-0"><h5>Troca / Devolução</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
    <form action="<%= request.getContextPath() %>/ServletEstoque" method="post" class="modal-body">
        <input type="hidden" name="acao" value="troca">
        <label class="small">Cód. Barra Saindo (Troca):</label>
        <input type="text" name="codBarraSaindo" id="codBarraTrocaSaindo" class="form-control mb-2" placeholder="Vazio para Devolução">
        <div id="infoTrocaSaindo" class="produto-info text-dark"></div>
        <label class="small">Cód. Barra Entrando (Devolução):</label>
        <input type="text" name="codBarraEntrando" id="codBarraTrocaEntrando" class="form-control mb-2" required>
        <div id="infoTrocaEntrando" class="produto-info text-dark"></div>
        <textarea name="observacao" class="form-control mb-2" placeholder="Observações"></textarea>
        <button type="submit" class="btn btn-light w-100 fw-bold" style="color:#5a189a">Processar</button>
    </form></div></div></div>

<!-- Modal Relatório -->
<div class="modal fade" id="modalRelatorio" tabindex="-1"><div class="modal-dialog modal-dialog-centered"><div class="modal-content bg-relatorio text-white border-0"><div class="modal-header border-0"><h5>Filtros de Relatório</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
    <form action="<%= request.getContextPath() %>/ServletEstoque" method="get" class="modal-body" id="formRelatorio">
        <div id="divDatas" class="row g-2 mb-3">
            <div class="col-6"><label class="small">Início</label><input type="date" name="dataInicio" class="form-control"></div>
            <div class="col-6"><label class="small">Fim</label><input type="date" name="dataFim" class="form-control"></div>
        </div>
        <select name="filtro" id="filtroRelatorio" class="form-select mb-3">
            <option value="DETALHADO">Detalhado</option>
            <option value="RESUMIDO">Resumido (Saldos)</option>
            <option value="ENTRADA">Entradas</option>
            <option value="SAIDA">Saídas</option>
            <option value="ESTOQUE_BAIXO">Estoque Baixo (≤5)</option>
            <option value="TODOS_PRODUTOS">Todos os Produtos</option>
        </select>
        <button type="submit" class="btn btn-dark w-100 py-2">Consultar</button>
    </form></div></div></div>

<div class="footer">Desenvolvido por <a href="https://jeffconstantino.dev" target="_blank" rel="noopener">Jeff Constantino</a></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = '<%= request.getContextPath() %>';

    // Carrega marcas e pesos ao abrir modal de cadastro
    document.getElementById('modalCadastro').addEventListener('shown.bs.modal', function() {
        fetch(contextPath + '/ServletEstoque?acao=listarMarcas')
            .then(r => r.json())
            .then(marcas => {
                const select = document.getElementById('marcaSelect');
                // Remove opções antigas (mantém as 2 primeiras: "Selecione" e "Adicionar Nova")
                while (select.options.length > 2) {
                    select.remove(2);
                }
                // Adiciona marcas do banco
                marcas.forEach(m => {
                    const option = document.createElement('option');
                    option.value = m;
                    option.textContent = m;
                    select.appendChild(option);
                });
            });

        fetch(contextPath + '/ServletEstoque?acao=listarPesos')
            .then(r => r.json())
            .then(pesos => {
                const select = document.getElementById('pesoSelect');
                // Remove opções antigas (mantém as 2 primeiras)
                while (select.options.length > 2) {
                    select.remove(2);
                }
                // Adiciona pesos do banco
                pesos.forEach(p => {
                    const option = document.createElement('option');
                    option.value = p;
                    option.textContent = p;
                    select.appendChild(option);
                });
            });
    });

    // Controla exibição do campo "Nova Marca"
    document.getElementById('marcaSelect').addEventListener('change', function() {
        const inputNovo = document.getElementById('marcaNovaInput');
        if (this.value === '__NOVO__') {
            inputNovo.style.display = 'block';
            inputNovo.required = true;
        } else {
            inputNovo.style.display = 'none';
            inputNovo.required = false;
            inputNovo.value = '';
        }
    });

    // Controla exibição do campo "Novo Peso"
    document.getElementById('pesoSelect').addEventListener('change', function() {
        const inputNovo = document.getElementById('pesoNovoInput');
        if (this.value === '__NOVO__') {
            inputNovo.style.display = 'block';
            inputNovo.required = true;
        } else {
            inputNovo.style.display = 'none';
            inputNovo.required = false;
            inputNovo.value = '';
        }
    });

    // Busca produto ao digitar código de barras
    function buscarProduto(inputId, infoId) {
        const input = document.getElementById(inputId);
        const infoDiv = document.getElementById(infoId);

        // Adiciona evento de blur (quando sai do campo)
        input.addEventListener('blur', function() {
            buscarEExibir(this.value.trim(), infoDiv);
        });

        // Adiciona evento de tecla Enter
        input.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                buscarEExibir(this.value.trim(), infoDiv);
            }
        });
    }

    function buscarEExibir(codBarra, infoDiv) {
        if (!codBarra) {
            infoDiv.classList.remove('show');
            infoDiv.innerHTML = '';
            return;
        }

        infoDiv.innerHTML = '🔍 Buscando produto...';
        infoDiv.classList.add('show');

        fetch(contextPath + '/ServletEstoque?acao=buscarProduto&codBarra=' + encodeURIComponent(codBarra))
            .then(response => response.text())
            .then(text => {
                try {
                    const produto = JSON.parse(text);

                    if (produto && produto.nome) {
                        const marca = produto.marca && produto.marca !== '' ? produto.marca : 'N/A';
                        const peso = produto.peso && produto.peso !== '' ? produto.peso : 'N/A';

                        infoDiv.innerHTML = '<strong>' + produto.nome + '</strong><br>Marca: ' + marca + ' | Peso: ' + peso;
                        infoDiv.classList.add('show');
                    } else {
                        infoDiv.innerHTML = '⚠️ Produto não encontrado';
                        infoDiv.classList.add('show');
                    }
                } catch (e) {
                    infoDiv.innerHTML = '❌ Erro ao processar resposta';
                    infoDiv.classList.add('show');
                }
            })
            .catch(error => {
                infoDiv.innerHTML = '❌ Erro ao buscar produto';
                infoDiv.classList.add('show');
            });
    }

    buscarProduto('codBarraEntrada', 'infoEntrada');
    buscarProduto('codBarraSaida', 'infoSaida');
    buscarProduto('codBarraTrocaSaindo', 'infoTrocaSaindo');
    buscarProduto('codBarraTrocaEntrando', 'infoTrocaEntrando');

    // Controle de datas obrigatórias no relatório
    document.getElementById('filtroRelatorio').addEventListener('change', function() {
        const divDatas = document.getElementById('divDatas');
        const inputs = divDatas.querySelectorAll('input');

        if (this.value === 'ESTOQUE_BAIXO' || this.value === 'TODOS_PRODUTOS') {
            divDatas.style.display = 'none';
            inputs.forEach(i => i.removeAttribute('required'));
        } else {
            divDatas.style.display = '';
            inputs.forEach(i => i.setAttribute('required', 'required'));
        }
    });
</script>
</body>
</html>