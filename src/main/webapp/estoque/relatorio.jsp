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
            <a href="${pageContext.request.contextPath}/estoque/index.jsp" class="btn btn-secondary btn-sm">Voltar</a>
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

<div class="footer">Desenvolvido por <a href="https://jeffconstantino.dev" target="_blank" rel="noopener">Jeff Constantino</a></div>

<script>
    document.getElementById('inputBusca').addEventListener('keyup', function() {
        let filtro = this.value.toLowerCase();
        let linhas = document.getElementById('corpoTabela').getElementsByTagName('tr');
        for (let i = 0; i < linhas.length; i++) {
            let texto = linhas[i].innerText.toLowerCase();
            linhas[i].style.display = texto.includes(filtro) ? '' : 'none';
        }
    });
</script>
</body>
</html>