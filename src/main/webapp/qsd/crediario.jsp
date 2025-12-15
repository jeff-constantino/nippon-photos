<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Crediário</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #3A86FF;
            transition: background-color 0.5s ease;
        }
        .card-preta {
            background-color: #000000;
            color: #ffffff;
            border-radius: 12px;
        }
        .card-preta .form-control,
        .card-preta .form-select {
            background-color: #1c1c1c;
            color: #ffffff;
            border: 1px solid #444;
        }
        .card-preta .form-control::placeholder {
            color: #bbbbbb;
        }
        .btn-dourado {
            background-color: #DAA520;
            color: #000000;
            font-weight: 600;
            border: none;
            transition: background-color 0.3s ease;
        }
        .btn-dourado:hover {
            background-color: #c9a117;
        }
        .color-picker-container {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            margin-bottom: 1rem;
        }
        .color-picker-container label {
            margin-right: 0.5rem;
            font-weight: bold;
        }
        .color-picker-container input[type="color"] {
            width: 44px;
            height: 44px;
            border: 2px solid #333;
            border-radius: 5px;
            cursor: pointer;
        }
        .status-pago {
            color: #28a745;
            font-weight: bold;
        }
        .status-receber {
            color: #dc3545;
            font-weight: bold;
        }
        .alert {
            margin-top: 1rem;
        }
        .total-box {
            background-color: #1c1c1c;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
        }
        .total-recebido {
            color: #28a745;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .total-receber {
            color: #dc3545;
            font-size: 1.2rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container-fluid py-4 px-4">

    <c:if test="${not empty msg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row mb-4">
        <div class="col-12">
            <div class="card card-preta">
                <div class="card-body">
                    <h4 class="card-title text-center mb-3">RESULTADO DA BUSCA</h4>

                    <div class="table-responsive">
                        <table class="table table-dark table-bordered mb-0">
                            <thead>
                            <tr>
                                <th>Data</th>
                                <th>Nome</th>
                                <th>Empresa</th>
                                <th>Produtos</th>
                                <th>Valor Total</th>
                                <th>Status</th>
                                <th>Opções</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty listaCreditos}">
                                    <c:forEach items="${listaCreditos}" var="item">
                                        <tr>
                                            <td><fmt:formatDate value="${item.datavenda}" pattern="dd/MM/yyyy"/></td>
                                            <td>${item.cliente}</td>
                                            <td>${item.empresa}</td>
                                            <td>${item.produtos}</td>
                                            <td>R$ <fmt:formatNumber value="${item.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                            <td>
                                                <span class="${item.status == 'Pago' ? 'status-pago' : 'status-receber'}">
                                                        ${item.status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${item.status == 'A Receber'}">
                                                    <a href="<%= request.getContextPath() %>/ServletCredQSD?acao=carregar&id=${item.id}"
                                                       class="btn btn-sm btn-dourado">
                                                        Receber
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center">Nenhum resultado</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center mt-3">
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalBusca">Buscar</button>
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalLancamento">Vender</button>
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalRelatorio">Relatórios</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12 color-picker-container">
            <label id="color-picker-label" class="text-dark">Alterar cor de fundo:</label>
            <input type="color" id="background-color-picker" value="#DAA520">
        </div>
    </div>
</div>

<!-- MODAL LANÇAMENTO -->
<div class="modal fade" id="modalLancamento" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Lançar Crediário</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<%= request.getContextPath() %>/ServletCredQSD" method="post">
                <input type="hidden" name="acao" value="salvar">
                <input type="hidden" name="cliente" id="hiddenCliente">
                <input type="hidden" name="empresa" id="hiddenEmpresa">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Data</label>
                            <input type="date" class="form-control" name="datavenda" id="datavenda" required>
                        </div>
                        <div class="col-12 col-md-6 col-lg-8">
                            <label class="form-label">Cliente</label>
                            <select id="clienteSelect" class="form-select" required>
                                <option value="">Selecione um cliente cadastrado</option>
                                <option value="novo">Adicionar Novo Cliente</option>
                                <c:forEach items="${listaClientes}" var="cli">
                                    <option value="${cli.cliente}|${cli.empresa}">${cli.cliente} - ${cli.empresa}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div id="novoClienteFields" style="display: none;">
                        <div class="row mb-3">
                            <div class="col-12 col-md-6 col-lg-8">
                                <label class="form-label">Nome</label>
                                <input type="text" class="form-control" id="novoNome" placeholder="Nome do cliente">
                            </div>
                            <div class="col-12 col-lg-6">
                                <label class="form-label">Empresa</label>
                                <input type="text" class="form-control" id="novaEmpresa" placeholder="Empresa">
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <label class="form-label">Produtos</label>
                            <textarea class="form-control" rows="4" name="produtos" id="produtos"
                                      placeholder="Descrição dos produtos" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Valor Total</label>
                            <input type="text" class="form-control" name="valor" id="valor"
                                   placeholder="R$ 0,00" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-dourado">Salvar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL BUSCA -->
<div class="modal fade" id="modalBusca" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Buscar Crediário</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<%= request.getContextPath() %>/ServletCredQSD" method="get">
                <input type="hidden" name="acao" value="buscar">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Cliente</label>
                            <select name="clienteBusca" id="clienteBusca" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${listaClientes}" var="cli">
                                    <option value="${cli.cliente}|${cli.empresa}">${cli.cliente} - ${cli.empresa}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                    <button type="submit" class="btn btn-dourado">Buscar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL RELATÓRIO -->
<div class="modal fade" id="modalRelatorio" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Relatórios Gerenciais</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<%= request.getContextPath() %>/ServletCredQSD" method="get">
                <input type="hidden" name="acao" value="relatorio">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Cliente</label>
                            <select name="clienteRelatorio" id="clienteRelatorio" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${listaClientes}" var="cli">
                                    <option value="${cli.cliente}|${cli.empresa}">${cli.cliente} - ${cli.empresa}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12 col-md-3 col-lg-4">
                            <label class="form-label">Data Início</label>
                            <input type="date" class="form-control" name="dataInicio" id="dataInicio">
                        </div>
                        <div class="col-12 col-md-3 col-lg-4">
                            <label class="form-label">Data Fim</label>
                            <input type="date" class="form-control" name="dataFim" id="dataFim">
                        </div>
                    </div>

                    <c:if test="${not empty listaRelatorio}">
                        <div class="table-responsive">
                            <table class="table table-dark table-bordered mb-0">
                                <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Empresa</th>
                                    <th>Status</th>
                                    <th>Valor Pago</th>
                                    <th>Forma de Pagamento</th>
                                    <th>Data de Pagamento</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${listaRelatorio}" var="rel">
                                    <tr>
                                        <td>${rel.cliente}</td>
                                        <td>${rel.empresa}</td>
                                        <td>
                                            <span class="${rel.status == 'Pago' ? 'status-pago' : 'status-receber'}">
                                                    ${rel.status}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${rel.valorpago != null}">
                                                    R$ <fmt:formatNumber value="${rel.valorpago}" minFractionDigits="2" maxFractionDigits="2"/>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${rel.forma != null ? rel.forma : '-'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${rel.datapagamento != null}">
                                                    <fmt:formatDate value="${rel.datapagamento}" pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="total-box">
                            <div class="row">
                                <div class="col-md-6">
                                    <p class="total-recebido mb-2">
                                        Total Recebido: R$ <fmt:formatNumber value="${totalRecebido}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <p class="total-receber mb-2">
                                        Total A Receber: R$ <fmt:formatNumber value="${totalAReceber}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                    <button type="submit" class="btn btn-dourado">Buscar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL RECEBER -->
<div class="modal fade" id="modalReceber" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Receber Pagamento</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<%= request.getContextPath() %>/ServletCredQSD" method="post">
                <input type="hidden" name="acao" value="receber">
                <input type="hidden" name="id" value="${modelReceber.id}">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Data de recebimento</label>
                            <input type="date" class="form-control" name="datapagamento"
                                   id="datapagamento" required>
                        </div>
                        <div class="col-12 col-md-6 col-lg-8">
                            <label class="form-label">Nome</label>
                            <input type="text" class="form-control" value="${modelReceber.cliente}" readonly>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12 col-lg-6">
                            <label class="form-label">Empresa</label>
                            <input type="text" class="form-control" value="${modelReceber.empresa}" readonly>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12">
                            <label class="form-label">Produtos</label>
                            <textarea class="form-control" rows="4" readonly>${modelReceber.produtos}</textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Valor Total</label>
                            <input type="text" class="form-control"
                                   value="R$ <fmt:formatNumber value="${modelReceber.valor}" minFractionDigits="2" maxFractionDigits="2"/>"
                                   readonly>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Forma de Pagamento</label>
                            <select name="forma" id="forma" class="form-select" required>
                                <option value="">Selecione...</option>
                                <option value="Dinheiro">Dinheiro</option>
                                <option value="Crédito">Crédito</option>
                                <option value="Débito">Débito</option>
                                <option value="Pix">Pix</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Desconto</label>
                            <div class="input-group">
                              <div class="input-group-prepend">
                                                                        <span class="input-group-text"
                                                                              style="color: #f2a654; font-weight: bold; background: #1c1c1c">%</span>
                            </div>
                            <input type="text" class="form-control" name="desconto" id="desconto"
                                    value="">
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12 col-md-6 col-lg-4">
                            <label class="form-label">Valor Pago</label>
                            <input type="text" class="form-control" name="valorpago" id="valorpago"
                                   placeholder="R$ 0,00" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-dourado">Confirmar Recebimento</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {

        // ==========================================================
        // FUNÇÃO: Ajusta a data final para o último dia do mês
        // ==========================================================
        function ajustarDataFinal() {
            const dataInicioEl = document.getElementById('dataInicio');
            const dataFimEl = document.getElementById('dataFim');

            if (!dataInicioEl || !dataInicioEl.value) {
                if (dataFimEl) {
                    dataFimEl.value = '';
                }
                return;
            }

            const partes = dataInicioEl.value.split('-');
            const ano = parseInt(partes[0], 10);
            const mes = parseInt(partes[1], 10) - 1;

            const ultimoDia = new Date(ano, mes + 1, 0);
            const diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
            const mesFinal = String(mes + 1).padStart(2, '0');

            if (dataFimEl) {
                dataFimEl.value = `${ano}-${mesFinal}-${diaFinal}`;
            }
        }

        // ==========================================================
        // MODAL DE LANÇAMENTO: define data de hoje automaticamente
        // ==========================================================
        const modalLancamentoEl = document.getElementById('modalLancamento');
        if (modalLancamentoEl) {
            modalLancamentoEl.addEventListener('shown.bs.modal', function () {
                const campoData = document.getElementById('datavenda');
                if (campoData && !campoData.value) {
                    const hoje = new Date().toISOString().split('T')[0];
                    campoData.value = hoje;
                }
            });
        }

        // ==========================================================
        // MODAL DE RELATÓRIO: inicializa datas ao abrir
        // ==========================================================
        const modalRelatorioEl = document.getElementById('modalRelatorio');
        if (modalRelatorioEl) {
            modalRelatorioEl.addEventListener('shown.bs.modal', function () {
                const dataInicio = document.getElementById('dataInicio');

                if (dataInicio && !dataInicio.value) {
                    const hoje = new Date();
                    const ano = hoje.getFullYear();
                    const mes = hoje.getMonth();

                    dataInicio.value = `${ano}-${String(mes + 1).padStart(2, '0')}-01`;
                    ajustarDataFinal();
                }
            });
        }

        // ==========================================================
        // EVENTO: ao mudar a data inicial, recalcula a data final
        // ==========================================================
        const dataInicioRelatorio = document.getElementById('dataInicio');
        if (dataInicioRelatorio) {
            dataInicioRelatorio.addEventListener('change', ajustarDataFinal);
        }

    });
</script>

</body>
</html>