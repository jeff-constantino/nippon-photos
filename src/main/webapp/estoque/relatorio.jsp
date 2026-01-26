<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório de Estoque</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-bottom: 90px; background-color: #f8f9fa; }
        .table-resumo { font-size: 0.9rem; vertical-align: middle; }

        .footer { position: fixed; bottom: 0; left: 0; right: 0; text-align: center; padding: 15px; background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(10px); border-top: 1px solid #daa520; color: #fff; font-size: 13px; z-index: 1000; }
        .footer a { color: #ffd700; text-decoration: none; font-weight: 700; transition: all 0.3s; }
        .footer a:hover { color: #fff; text-shadow: 0 0 10px #daa520; text-decoration: underline; }

        @media (max-width: 768px) { .table-resumo { font-size: 0.75rem; } }
    </style>
</head>
<body>
<div class="container-fluid py-4">
    <div class="bg-white p-3 p-md-4 shadow-sm rounded-4 border">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="m-0">Relatório: ${tipoRelatorio}</h4>
            <div>
                <button onclick="exportarExcel()" class="btn btn-success btn-sm me-2">📥 Exportar Excel</button>
                <a href="${pageContext.request.contextPath}/estoque/index.jsp" class="btn btn-secondary btn-sm">Voltar</a>
            </div>
        </div>

        <div class="mb-3">
            <input type="text" id="inputBusca" class="form-control" placeholder="🔍 Pesquisar itens nesta lista...">
        </div>

        <div class="table-responsive">
            <table class="table table-hover border" id="tabelaDados">
                <c:choose>
                    <c:when test="${tipoRelatorio == 'RESUMIDO'}">
                        <thead class="table-primary text-center">
                        <tr>
                            <th class="text-start">Produto / Marca / Peso</th>
                            <th>Est. Inicial</th>
                            <th>Entradas</th>
                            <th>Saídas</th>
                            <th>Est. Final</th>
                        </tr>
                        </thead>
                        <tbody id="corpoTabela">
                        <c:forEach items="${listaResumida}" var="r">
                            <tr class="text-center">
                                <td class="text-start"><strong>${r.nome}</strong><br><small class="text-muted">${r.marca} | ${r.peso}</small></td>
                                <td>${r.estoqueInicialNoPeriodo}</td>
                                <td class="text-success fw-bold">+${r.entradasNoPeriodo}</td>
                                <td class="text-danger fw-bold">-${r.saidasNoPeriodo}</td>
                                <td class="table-info fw-bold">${r.estoqueAtual}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:when>

                    <c:when test="${tipoRelatorio == 'ESTOQUE_BAIXO'}">
                        <thead class="table-warning text-center">
                        <tr>
                            <th>Cód. Barras</th>
                            <th class="text-start">Produto / Marca / Peso</th>
                            <th>Estoque Atual</th>
                        </tr>
                        </thead>
                        <tbody id="corpoTabela">
                        <c:forEach items="${listaProdutos}" var="p">
                            <tr class="text-center ${p.estoqueAtual == 0 ? 'table-danger' : ''}">
                                <td><small>${p.codBarra}</small></td>
                                <td class="text-start"><strong>${p.nome}</strong><br><small class="text-muted">${p.marca} | ${p.peso}</small></td>
                                <td class="fw-bold">${p.estoqueAtual}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:when>

                    <c:when test="${tipoRelatorio == 'TODOS_PRODUTOS'}">
                        <thead class="table-info text-center">
                        <tr>
                            <th>Cód. Barras</th>
                            <th class="text-start">Produto / Marca / Peso</th>
                            <th>Estoque</th>
                            <th>Ação</th>
                        </tr>
                        </thead>
                        <tbody id="corpoTabela">
                        <c:forEach items="${listaProdutos}" var="p">
                            <tr class="text-center">
                                <td><small>${p.codBarra}</small></td>
                                <td class="text-start"><strong>${p.nome}</strong><br><small class="text-muted">${p.marca} | ${p.peso}</small></td>
                                <td class="fw-bold">${p.estoqueAtual}</td>
                                <td>
                                    <button class="btn btn-sm btn-primary" onclick="editarProduto(${p.produtoId}, '${p.codBarra}', '${p.nome}', '${p.marca}', '${p.peso}', ${p.estoqueAtual})">
                                        ✏️ Editar
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:when>

                    <c:otherwise>
                        <thead class="table-dark">
                        <tr><th>Data</th><th>Produto / Detalhes</th><th>Tipo</th><th>Qtd</th><th>Observação</th></tr>
                        </thead>
                        <tbody id="corpoTabela">
                        <c:forEach items="${movimentacoes}" var="m">
                            <tr>
                                <td><fmt:formatDate value="${m.dataMovimentoDate}" pattern="dd/MM HH:mm"/></td>
                                <td><strong>${m.nome}</strong><br><small class="text-muted">${m.marca} | ${m.peso}</small></td>
                                <td><span class="badge ${m.tipoMovimento == 'ENTRADA' ? 'bg-success' : 'bg-danger'}">${m.tipoMovimento}</span></td>
                                <td class="fw-bold">${m.quantidade}</td>
                                <td><small>${m.motivo} ${m.observacao}</small></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:otherwise>
                </c:choose>
            </table>
        </div>
    </div>
</div>

<!-- Modal Editar Produto -->
<div class="modal fade" id="modalEditar" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5>✏️ Editar Produto</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/ServletEstoque" method="post" class="modal-body">
                <input type="hidden" name="acao" value="atualizar">
                <input type="hidden" name="produtoId" id="editProdutoId">

                <label class="small fw-bold">Código de Barras</label>
                <input type="text" name="codBarra" id="editCodBarra" class="form-control mb-2" required>

                <label class="small fw-bold">Nome</label>
                <input type="text" name="nome" id="editNome" class="form-control mb-2" required>

                <label class="small fw-bold">Marca</label>
                <input type="text" name="marca" id="editMarca" class="form-control mb-2">

                <label class="small fw-bold">Peso</label>
                <input type="text" name="peso" id="editPeso" class="form-control mb-2">

                <label class="small fw-bold">Estoque Atual</label>
                <input type="number" name="estoqueAtual" id="editEstoque" class="form-control mb-2" required>

                <button type="submit" class="btn btn-primary w-100 mt-3">💾 Salvar Alterações</button>
            </form>
        </div>
    </div>
</div>

<div class="footer">Desenvolvido por <a href="https://jeffconstantino.dev" target="_blank" rel="noopener">Jeff Constantino</a></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
    document.getElementById('inputBusca').addEventListener('keyup', function() {
        let filtro = this.value.toLowerCase();
        let linhas = document.getElementById('corpoTabela').getElementsByTagName('tr');
        for (let i = 0; i < linhas.length; i++) {
            let texto = linhas[i].innerText.toLowerCase();
            linhas[i].style.display = texto.includes(filtro) ? '' : 'none';
        }
    });

    function editarProduto(id, codBarra, nome, marca, peso, estoque) {
        document.getElementById('editProdutoId').value = id;
        document.getElementById('editCodBarra').value = codBarra;
        document.getElementById('editNome').value = nome;
        document.getElementById('editMarca').value = marca || '';
        document.getElementById('editPeso').value = peso || '';
        document.getElementById('editEstoque').value = estoque;

        const modal = new bootstrap.Modal(document.getElementById('modalEditar'));
        modal.show();
    }

    function exportarExcel() {
        const tabela = document.getElementById('tabelaDados');
        const tipoRelatorio = '${tipoRelatorio}';

        // Clona a tabela para manipular
        const tabelaClone = tabela.cloneNode(true);

        // Processa todas as células que contêm nome/marca/peso
        const celulas = tabelaClone.querySelectorAll('td');
        celulas.forEach(celula => {
            // Se a célula contém um <strong> e um <br>, processa
            const strong = celula.querySelector('strong');
            const small = celula.querySelector('small');

            if (strong && small) {
                const nome = strong.textContent.trim();
                const detalhes = small.textContent.trim();
                // Substitui o conteúdo HTML por texto formatado com espaços
                celula.innerHTML = nome + ' - ' + detalhes;
            }

            // Remove botões se existirem
            const botao = celula.querySelector('button');
            if (botao) {
                celula.parentElement.removeChild(celula);
            }
        });

        // Remove a coluna "Ação" se for relatório de todos os produtos
        if (tipoRelatorio === 'TODOS_PRODUTOS') {
            const rows = tabelaClone.querySelectorAll('tr');
            rows.forEach(row => {
                const cells = row.querySelectorAll('th, td');
                if (cells.length > 0) {
                    const lastCell = cells[cells.length - 1];
                    if (lastCell.textContent.includes('Ação') || lastCell.querySelector('button')) {
                        lastCell.remove();
                    }
                }
            });
        }

        // Converte para workbook
        const wb = XLSX.utils.table_to_book(tabelaClone, {sheet: "Relatório"});

        // Gera nome do arquivo com data
        const dataHora = new Date().toLocaleString('pt-BR').replace(/[/:]/g, '-').replace(', ', '_');
        const nomeArquivo = 'Relatorio_' + tipoRelatorio + '_' + dataHora + '.xlsx';

        // Faz o download
        XLSX.writeFile(wb, nomeArquivo);
    }
</script>
</body>
</html>