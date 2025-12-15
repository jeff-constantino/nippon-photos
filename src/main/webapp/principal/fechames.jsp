<%@ page import="model.ModelConfiguracao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    List<ModelConfiguracao> configsJuros = (List<ModelConfiguracao>) request.getAttribute("configsJuros");
    ModelConfiguracao juros = configsJuros != null && !configsJuros.isEmpty() ? configsJuros.get(0) : null;

    // Gera lista de anos (20 anos para trás)
    Calendar cal = Calendar.getInstance();
    int anoAtual = cal.get(Calendar.YEAR);
%>
<!DOCTYPE html>
<html lang="pt-br">
<jsp:include page="header.jsp"></jsp:include>

<body>
<div class="container-scroller">
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="navbar.jsp"></jsp:include>
        <div class="main-panel">
            <div class="content-wrapper" style="min-height: calc(98vh - 100px);">

                <!-- MODAL GERAR FECHAMENTO -->
                <div class="modal fade" id="modalData" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl mt-5">
                        <div class="modal-content">
                            <div class="modal-body">
                                <form action="<%= request.getContextPath() %>/ServletFechaMes" method="get" id="formBuscaMes" name="formBuscaMes">
                                    <input type="hidden" name="acao" value="relatorioMes">
                                    <div class="form-row align-items-center">
                                        <div class="col-auto">
                                            <label for="dataInicial">Data Inicial</label>
                                            <input type="date" class="form-control" id="dataInicial" name="dataInicial" required onchange="setData()" value="${dataInicial}">
                                        </div>
                                        <div class="col-auto">
                                            <label for="dataFinal">Data Final</label>
                                            <input type="date" class="form-control" id="dataFinal" name="dataFinal" required value="${dataFinal}">
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" class="btn btn-primary">Gerar Relatório</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- MODAL BUSCAR FECHAMENTO -->
                <div class="modal fade" id="modalBusca" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg mt-5">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Buscar Fechamento Gravado</h5>
                            </div>
                            <div class="modal-body">
                                <form action="<%= request.getContextPath() %>/ServletFechaMes" method="get" id="formBuscaFechamento">
                                    <input type="hidden" name="acao" value="buscarFechamento">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label for="mesBusca">Selecione o Mês</label>
                                            <select class="form-control" id="mesBusca" name="mes" required>
                                                <option value="">-- Selecione --</option>
                                                <option value="1">Janeiro</option>
                                                <option value="2">Fevereiro</option>
                                                <option value="3">Março</option>
                                                <option value="4">Abril</option>
                                                <option value="5">Maio</option>
                                                <option value="6">Junho</option>
                                                <option value="7">Julho</option>
                                                <option value="8">Agosto</option>
                                                <option value="9">Setembro</option>
                                                <option value="10">Outubro</option>
                                                <option value="11">Novembro</option>
                                                <option value="12">Dezembro</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="anoBusca">Selecione o Ano</label>
                                            <select class="form-control" id="anoBusca" name="ano" required>
                                                <option value="">-- Selecione --</option>
                                                <% for(int i = 0; i < 20; i++) {
                                                    int ano = anoAtual - i;
                                                %>
                                                <option value="<%= ano %>" <%= (i == 0) ? "selected" : "" %>><%= ano %></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-12 text-center">
                                            <button type="submit" class="btn btn-success">Buscar Fechamento</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR</button>
                            </div>
                        </div>
                    </div>
                </div>

                <form method="post" action="<%=request.getContextPath()%>/ServletFechaMes">
                    <input type="hidden" name="acao" value="gravarFechamento">

                    <div class="row">
                        <div class="col-lg-4 grid-margin">
                            <div class="card">
                                <div class="card-body text-center">
                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                        <h4>GERAR FECHAMENTO</h4>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 grid-margin">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h2 style="text-transform: uppercase;">${mesAno}</h2>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 grid-margin">
                            <div class="card">
                                <div class="card-body text-center">
                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalBusca">
                                        <h4>BUSCAR FECHAMENTO</h4>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">RESUMO DO MÊS</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered text-center" id="tabelavendasmes">
                                            <thead class="thead-light">
                                            <tr>
                                                <th scope="col">TOTAL DE FOTOS</th>
                                                <th scope="col">TOTAL DE ENCARTES</th>
                                                <th scope="col">TOTAL DE DIGITAIS</th>
                                                <th scope="col">TOTAL DE SOBRAS</th>
                                                <th scope="col">QTD RIBBONS (KITS)</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${vendasMesList}" var="vl">
                                                <tr>
                                                    <td><c:out value="${vl.total_ft}"/></td>
                                                    <td><c:out value="${vl.total_enc}"/></td>
                                                    <td><c:out value="${vl.total_dig}"/></td>
                                                    <td><c:out value="${vl.total_sobras}"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${vl.qtd_ribbon != null && vl.qtd_ribbon != 0}">
                                                                <fmt:formatNumber value="${(vl.total_ft + vl.total_sobras) / vl.qtd_ribbon}" pattern="0.00"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:out value="Não aplicável"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">RANKING DE VENDAS</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tabelaRankingmes">
                                            <div style="width: 100%; max-height: 150px; height: 150px;">
                                                <canvas id="vendasChart" style="max-height: 150px;"></canvas>
                                            </div>
                                            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                            <script>
                                                const ctxVendas = document.getElementById('vendasChart').getContext('2d');
                                                var nomesVendas = [];
                                                var totalVendas = [];
                                                <c:forEach var="venda" items="${vendasList}">
                                                nomesVendas.push("${venda.nome}");
                                                totalVendas.push(${venda.totalFotosVendidas});
                                                </c:forEach>
                                                const vendasChart = new Chart(ctxVendas, {
                                                    type: 'bar',
                                                    data: {
                                                        labels: nomesVendas,
                                                        datasets: [{
                                                            label: 'Fotos Vendidas',
                                                            data: totalVendas,
                                                            backgroundColor: ['rgba(50,205,50)', 'rgba(54, 162, 235)', 'rgba(255, 206, 86)', 'rgba(75, 192, 192)', 'rgba(153, 102, 255)', 'rgba(255, 99, 132)'],
                                                            borderColor: ['rgba(107,142,35, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 99, 132, 1)'],
                                                            borderWidth: 1
                                                        }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        maintainAspectRatio: false,
                                                        animation: { duration: 1500, easing: 'easeInOutCubic' },
                                                        scales: {
                                                            y: { beginAtZero: false, ticks: { font: { size: 14, weight: 'bold' } } },
                                                            x: { ticks: { font: { size: 14, weight: 'bold' }, callback: function(value, index) { return nomesVendas[index] + '\n(' + totalVendas[index] + ')'; } } }
                                                        },
                                                        plugins: { legend: { labels: { font: { size: 14, weight: 'bold' } } } }
                                                    }
                                                });
                                            </script>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">VALORES ANOTADOS</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tabelavaloresmes">
                                            <thead class="thead-light">
                                            <tr>
                                                <th scope="col" style="font-size: 1.2rem">TIPO</th>
                                                <th scope="col" style="font-size: 1.2rem">VALOR</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:set var="totalDinheiro" value="0" />
                                            <c:set var="totalDebito" value="0" />
                                            <c:set var="totalCredito" value="0" />
                                            <c:set var="totalPix" value="0" />
                                            <c:forEach items="${vendasMesList}" var="vl">
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Dinheiro</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_din_mes}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Débito</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_deb_mes}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Crédito</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_cred_mes}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Pix</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_pix_mes}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <c:set var="totalDinheiro" value="${totalDinheiro + vl.valor_din_mes}" />
                                                <c:set var="totalDebito" value="${totalDebito + vl.valor_deb_mes}" />
                                                <c:set var="totalCredito" value="${totalCredito + vl.valor_cred_mes}" />
                                                <c:set var="totalPix" value="${totalPix + vl.valor_pix_mes}" />
                                            </c:forEach>
                                            </tbody>
                                            <tfoot>
                                            <tr>
                                                <td style="color: #DAA520; font-size: 1.2rem">Total Geral:</td>
                                                <td style="color: #DAA520; font-size: 1.2rem">
                                                    <fmt:formatNumber value="${totalDinheiro + totalDebito + totalCredito + totalPix}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">VALORES REAIS</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tabelavaloresrealmes">
                                            <thead class="thead-light">
                                            <tr>
                                                <th scope="col" style="font-size: 1.2rem">TIPO</th>
                                                <th scope="col" style="font-size: 1.2rem">VALOR</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:set var="totalDinheiroReal" value="0" />
                                            <c:set var="totalDebitoReal" value="0" />
                                            <c:set var="totalCreditoReal" value="0" />
                                            <c:set var="totalPixReal" value="0" />
                                            <c:forEach items="${vendasMesList}" var="vl">
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Dinheiro</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_din_mes_real}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Débito</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_deb_mes_real}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Crédito</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_cred_mes_real}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: 1.2rem">Total Pix</td>
                                                    <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_pix_mes_real}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                                <c:set var="totalDinheiroReal" value="${totalDinheiroReal + vl.valor_din_mes_real}" />
                                                <c:set var="totalDebitoReal" value="${totalDebitoReal + vl.valor_deb_mes_real}" />
                                                <c:set var="totalCreditoReal" value="${totalCreditoReal + vl.valor_cred_mes_real}" />
                                                <c:set var="totalPixReal" value="${totalPixReal + vl.valor_pix_mes_real}" />
                                            </c:forEach>
                                            </tbody>
                                            <tfoot>
                                            <tr>
                                                <td style="color: #DAA520; font-size: 1.2rem">Total Geral:</td>
                                                <td style="color: #DAA520; font-size: 1.2rem"><fmt:formatNumber value="${totalDinheiroReal + totalDebitoReal + totalCreditoReal + totalPixReal}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">VALORES CONTA</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tabelavalorescontames">
                                            <div class="row">
                                                <div class="col-6 mb-3">
                                                    <label for="debitoVm" style="font-size: 0.8rem;">DÉBITO V/M</label>
                                                    <input type="text" class="form-control money" id="debitoVm" name="debitoVm" style="font-size: 0.8rem;" value="${fechamentoExistente.debitoVm}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="jurosDebitoVm" style="font-size: 0.8rem;">JUROS</label>
                                                    <input type="text" class="form-control money" id="jurosDebitoVm" name="jurosDebitoVm" style="font-size: 0.8rem;" value="${fechamentoExistente.jurosdebvm}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="creditoVm" style="font-size: 0.8rem;">CRÉDITO V/M</label>
                                                    <input type="text" class="form-control money" id="creditoVm" name="creditoVm" style="font-size: 0.8rem;" value="${fechamentoExistente.creditoVm}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="jurosCreditoVm" style="font-size: 0.8rem;">JUROS</label>
                                                    <input type="text" class="form-control money" id="jurosCreditoVm" name="jurosCreditoVm" style="font-size: 0.8rem;" value="${fechamentoExistente.juroscredvm}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="debitoOutros" style="font-size: 0.8rem;">DÉBITO OUTROS</label>
                                                    <input type="text" class="form-control money" id="debitoOutros" name="debitoOutros" style="font-size: 0.8rem;" value="${fechamentoExistente.debitoOutros}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="jurosDebitoOutros" style="font-size: 0.8rem;">JUROS</label>
                                                    <input type="text" class="form-control money" id="jurosDebitoOutros" name="jurosDebitoOutros" style="font-size: 0.8rem;" value="${fechamentoExistente.jurosdeboutros}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="creditoOutros" style="font-size: 0.8rem;">CRÉDITO OUTROS</label>
                                                    <input type="text" class="form-control money" id="creditoOutros" name="creditoOutros" style="font-size: 0.8rem;" value="${fechamentoExistente.creditoOutros}">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="jurosCreditoOutros" style="font-size: 0.8rem;">JUROS</label>
                                                    <input type="text" class="form-control money" id="jurosCreditoOutros" name="jurosCreditoOutros" style="font-size: 0.8rem;" value="${fechamentoExistente.juroscredoutros}">
                                                </div>
                                            </div>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">DESPESAS DO MÊS</h4>
                                    <div class="table-responsive">
                                        <table class="table" id="tabelareldespesas">
                                            <thead>
                                            <tr>
                                                <th scope="col">Nome Despesa</th>
                                                <th scope="col">Descrição</th>
                                                <th scope="col">Valor</th>
                                                <th scope="col">Data</th>
                                                <th scope="col">Forma de Pagamento</th>
                                                <th scope="col">Id Despesa</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${despesasMes}" var="despesa">
                                                <tr>
                                                    <td><c:out value="${despesa.nome_despesa}"/></td>
                                                    <td><c:out value="${despesa.descricao_despesa}"/></td>
                                                    <td><fmt:formatNumber value="${despesa.valor_despesa}" type="currency" currencySymbol="R$" /></td>
                                                    <td><fmt:formatDate value="${despesa.data_despesa}" pattern="dd/MM/yyyy"/></td>
                                                    <td><c:out value="${despesa.pagamento_despesa}"/></td>
                                                    <td><c:out value="${despesa.id_despesa}"/></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                            <tr>
                                                <td colspan="6" style="font-weight: bold; color: #DAA520; font-size: 1.2rem; text-align: center;">
                                                    Valor Total das Despesas: <fmt:formatNumber value="${valorTotalDespesas}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">CONTAS PAGAS NO MÊS</h4>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th>Nº Pedido</th>
                                                <th>Empresa</th>
                                                <th>Itens</th>
                                                <th>Valor</th>
                                                <th>Pedido</th>
                                                <th>Pagamento</th>
                                                <th>Status</th>
                                                <th>Pagamento</th>
                                                <th>ID</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="contas" items="${contasMes}">
                                                <tr>
                                                    <td><c:out value="${contas.numero_pedido}"/></td>
                                                    <td><c:out value="${contas.empresa}"/></td>
                                                    <td><c:out value="${contas.itens}"/></td>
                                                    <td><fmt:formatNumber value="${contas.valor}" type="currency" currencySymbol="R$"/></td>
                                                    <td><fmt:formatDate value="${contas.data_de_pedido}" pattern="dd/MM/yyyy"/></td>
                                                    <td><fmt:formatDate value="${contas.data_de_pagamento}" pattern="dd/MM/yyyy"/></td>
                                                    <td><c:out value="${contas.status}"/></td>
                                                    <td><c:out value="${contas.pagamento}"/></td>
                                                    <td><c:out value="${contas.conta_id}"/></td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <td colspan="9" style="font-weight: bold; color: #DAA520; font-size: 1.2rem; text-align: center;">
                                                    Valor Total das Contas: <fmt:formatNumber value="${valorTotalContas}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">OUTRAS DESPESAS DO MÊS</h4>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th>TOTAL DE VALES</th>
                                                <th>TOTAL DE DESCONTOS</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="vl" items="${vendasMesList}">
                                                <tr>
                                                    <td><fmt:formatNumber value="${empty vl.valor_vale_total ? 0 : vl.valor_vale_total}" type="currency" currencySymbol="R$" /></td>
                                                    <td><fmt:formatNumber value="${empty vl.desconto_mes ? 0 : vl.desconto_mes}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">RESUMO FINANCEIRO</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tabelafinanceiromes">
                                            <div class="row">
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="receitas" style="font-size: 1.2rem">RECEITA BRUTA</label>
                                                    <input type="text" class="form-control money" id="receitas" name="receitas" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.receitas : (totalDinheiroReal + totalDebitoReal + totalCreditoReal + totalPixReal)}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="receitadin" style="font-size: 1.2rem">RECEITA DINHEIRO</label>
                                                    <input type="text" class="form-control money" id="receitadin" name="receitadin" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.receitadin : totalDinheiroReal}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="receitacartoes" style="font-size: 1.2rem">RECEITA CARTÕES</label>
                                                    <input type="text" class="form-control money" id="receitacartoes" name="receitacartoes" style="font-size: 1.2rem" value="${totalDebitoReal + totalCreditoReal}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="receitapix" style="font-size: 1.2rem">RECEITA PIX</label>
                                                    <input type="text" class="form-control money" id="receitapix" name="receitapix" style="font-size: 1.2rem" value="${totalPixReal}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="despesas" style="font-size: 1.2rem">DESPESA TOTAL</label>
                                                    <input type="text" class="form-control money" id="despesas" name="despesas" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.despesas : valorTotalDespesas}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="despesasdin" style="font-size: 1.2rem">DESPESAS EM DINHEIRO</label>
                                                    <input type="text" class="form-control money" id="despesasdin" name="despesasdin" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.despesasdin : valorDespesasDin}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="contas" style="font-size: 1.2rem">CONTAS PAGAS</label>
                                                    <input type="text" class="form-control money" id="contas" name="contas" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.contas : valorTotalContas}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="salarios" style="font-size: 1.2rem">SALÁRIOS LIQUÍDOS</label>
                                                    <input type="text" class="form-control money" id="salarios" name="salarios" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.salarios : valorTotalSalarios}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="vales" style="font-size: 1.2rem">VALES</label>
                                                    <input type="text" class="form-control money" id="vales" name="vales" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.vales : (empty vendasMesList[0].valor_vale_total ? 0 : vendasMesList[0].valor_vale_total)}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="descontos" style="font-size: 1.2rem">DESCONTOS</label>
                                                    <input type="text" class="form-control money" id="descontos" name="descontos" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.descontos : (empty vendasMesList[0].desconto_mes ? 0 : vendasMesList[0].desconto_mes)}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="sangria" style="font-size: 1.2rem">SANGRIA DE CAIXA</label>
                                                    <input type="text" class="form-control money" id="sangria" name="sangria" style="font-size: 1.2rem" value="${fechamentoExistente != null ? fechamentoExistente.sangria : 0}">
                                                </div>
                                                <div class="col-3 mb-3" style="text-align: center">
                                                    <label for="saldo" style="font-size: 1.2rem; color: #DAA520">SALDO EM CAIXA</label>
                                                    <input type="text" class="form-control money" id="saldo" name="saldo" style="font-size: 1.2rem;color: #DAA520" value="${fechamentoExistente != null ? fechamentoExistente.saldo : ''}">
                                                </div>
                                            </div>
                                        </table>
                                    </div>
                                    <div style="text-align: center; margin-top: 20px;">
                                        <button type="submit" class="btn btn-outline-success" style="font-size: large">
                                            ${fechamentoExistente != null ? 'Atualizar' : 'Gravar'} Fechamento do Mês
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
</div>

<jsp:include page="pluginsJS.jsp"></jsp:include>

<div class="modal" id="msgModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;">
            <div class="modal-header" style="border-bottom: none;"></div>
            <div class="modal-body" style="color: black;">
                <p style="font-size: 1.5em; text-align: center">${msg}</p>
            </div>
            <div class="modal-footer" style="border-top: none;">
                <h1 class="modal-title" style="color: black; font-size: 0.8em;">aperte ESC para fechar</h1>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show');
            $.post("${pageContext.request.contextPath}/ServletFechaMes", { acao: "limparMsg" });
        }
    });

    function navigateFocusableElements(event) {
        const focusableElements = Array.from(document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')).filter(element => !element.disabled && element.tabIndex !== -1);
        if (focusableElements.length === 0) return;
        const currentElement = document.activeElement;
        if (!focusableElements.includes(currentElement)) return;
        let currentIndex = focusableElements.indexOf(currentElement);
        switch (event.key) {
            case 'ArrowRight':
            case 'ArrowDown':
                currentIndex = (currentIndex + 1) % focusableElements.length;
                break;
            case 'ArrowLeft':
            case 'ArrowUp':
                currentIndex = (currentIndex - 1 + focusableElements.length) % focusableElements.length;
                break;
            default:
                return;
        }
        focusableElements[currentIndex].focus();
    }

    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                event.preventDefault();
            }
        });
    });

    document.addEventListener('keydown', navigateFocusableElements);

    $(document).ready(function(){
        $('#tooltipButton').tooltip({ delay: { "show": 100, "hide": 100 } });
    });

    function setData() {
        var dataInicial = document.getElementById("dataInicial").value;
        if (dataInicial) {
            var partesData = dataInicial.split('-');
            var ano = parseInt(partesData[0], 10);
            var mes = parseInt(partesData[1], 10) - 1;
            var dia = parseInt(partesData[2], 10);
            var data = new Date(ano, mes, dia);
            if (!isNaN(data.getTime())) {
                var ultimoDia = new Date(ano, mes + 1, 0);
                var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
                var mesFinal = String(mes + 1).padStart(2, '0');
                var dataFinal = ano + '-' + mesFinal + '-' + diaFinal;
                document.getElementById("dataFinal").value = dataFinal;
            } else {
                console.error("Data inicial inválida.");
                document.getElementById("dataFinal").value = "";
            }
        } else {
            console.error("Data inicial não selecionada.");
            document.getElementById("dataFinal").value = "";
        }
    }

    function initializeDates() {
        var today = new Date();
        var diaInicial = String(today.getDate()).padStart(2, '0');
        var mesInicial = String(today.getMonth() + 1).padStart(2, '0');
        var anoInicial = today.getFullYear();
        var dataInicial = anoInicial + '-' + mesInicial + '-' + diaInicial;
        var ultimoDia = new Date(anoInicial, today.getMonth() + 1, 0);
        var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
        var mesFinal = String(today.getMonth() + 1).padStart(2, '0');
        var anoFinal = today.getFullYear();
        var dataFinal = anoFinal + '-' + mesFinal + '-' + diaFinal;
        document.getElementById("dataInicial").value = dataInicial;
        document.getElementById("dataFinal").value = dataFinal;
    }

    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('modalData');
        if (modal) {
            modal.addEventListener('shown.bs.modal', function () {
                if (!document.getElementById("dataInicial").value) {
                    initializeDates();
                }
            });
        }
        document.getElementById("dataInicial").addEventListener('change', setData);
    });

    var debitoVmJuros = <%= juros != null ? juros.getDeb_visa_master() : 0 %>;
    var creditoVmJuros = <%= juros != null ? juros.getCred_visa_master() : 0 %>;
    var debitoOutrosJuros = <%= juros != null ? juros.getDeb_outros() : 0 %>;
    var creditoOutrosJuros = <%= juros != null ? juros.getCred_outros() : 0 %>;

    if (!$.browser) { $.browser = {}; }
    $.browser.msie = false;

    function limparMascara(valor) {
        if (valor === undefined || valor === null || valor === '') return 0;
        let s = String(valor).trim();
        s = s.replace(/[^\d,\.]/g, '');
        if (s === '') return 0;
        const temVirgula = s.indexOf(',') > -1;
        const temPonto = s.indexOf('.') > -1;
        if (temVirgula && temPonto) {
            s = s.replace(/\./g, '').replace(',', '.');
        } else if (temVirgula && !temPonto) {
            s = s.replace(',', '.');
        } else if (temPonto && !temVirgula) {
            const partes = s.split('.');
            if (partes.length > 2 || (partes.length === 2 && partes[1].length > 2)) {
                s = s.replace(/\./g, '');
            }
        }
        const n = parseFloat(s);
        return isNaN(n) ? 0 : n;
    }

    function formatarMoeda(valor) {
        if (!valor) return '';
        let numero = valor.toString().replace(/\D/g, '');
        numero = (parseFloat(numero) / 100).toFixed(2);
        let partes = numero.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        return 'R$ ' + partes.join(',');
    }

    function aplicarMascaraManual(campo) {
        let valor = $(campo).val();
        let apenasNumeros = valor.replace(/\D/g, '');
        if (!apenasNumeros) {
            $(campo).val('');
            return;
        }
        let valorFormatado = formatarMoeda(apenasNumeros);
        $(campo).val(valorFormatado);
    }

    function calcularJurosDebitoVm() {
        var debitoVm = limparMascara(document.getElementById('debitoVm').value);
        var jurosCalculado = debitoVm * debitoVmJuros;
        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');
        document.getElementById('jurosDebitoVm').value = valorFormatado;
    }

    function calcularJurosCreditoVm() {
        var creditoVm = limparMascara(document.getElementById('creditoVm').value);
        var jurosCalculado = creditoVm * creditoVmJuros;
        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');
        document.getElementById('jurosCreditoVm').value = valorFormatado;
    }

    function calcularJurosDebitoOutros() {
        var debitoOutros = limparMascara(document.getElementById('debitoOutros').value);
        var jurosCalculado = debitoOutros * debitoOutrosJuros;
        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');
        document.getElementById('jurosDebitoOutros').value = valorFormatado;
    }

    function calcularJurosCreditoOutros() {
        var creditoOutros = limparMascara(document.getElementById('creditoOutros').value);
        var jurosCalculado = creditoOutros * creditoOutrosJuros;
        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');
        document.getElementById('jurosCreditoOutros').value = valorFormatado;
    }

    function calcularSaldo() {
        let receitadin = limparMascara($("#receitadin").val());
        let despDin = limparMascara($("#despesasdin").val());
        let sangria = limparMascara($("#sangria").val());
        let salarios = limparMascara($("#salarios").val());
        let vales = limparMascara($("#vales").val());
        let saldo = receitadin - despDin - sangria - salarios - vales;
        let valorFormatado = saldo.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = partes.join(',');
        $("#saldo").val('R$ ' + valorFormatado);
    }

    $(document).ready(function() {
        const camposManual = ['#debitoVm', '#jurosDebitoVm', '#creditoVm', '#jurosCreditoVm', '#debitoOutros', '#jurosDebitoOutros', '#creditoOutros', '#jurosCreditoOutros', '#sangria', '#salarios', '#despesasdin', '#vales'];
        $(camposManual.join(', ')).removeClass('money');
        $(camposManual.join(', ')).off();
        $(".money").not(camposManual.join(', ')).maskMoney({ showSymbol: true, symbol: "R$ ", decimal: ",", thousands: "." });

        setTimeout(function() {
            $(".money").not(camposManual.join(', ')).each(function() {
                let campo = $(this);
                let valor = campo.val();
                if (valor && valor.trim() !== '') {
                    let valorLimpo = limparMascara(valor);
                    let valorFormatado = valorLimpo.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                    campo.val('R$ ' + valorFormatado);
                }
            });
        }, 100);

        $("#debitoVm").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularJurosDebitoVm, 100); });
        $("#debitoVm").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularJurosDebitoVm, 50); });
        $("#creditoVm").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularJurosCreditoVm, 100); });
        $("#creditoVm").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularJurosCreditoVm, 50); });
        $("#debitoOutros").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularJurosDebitoOutros, 100); });
        $("#debitoOutros").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularJurosDebitoOutros, 50); });
        $("#creditoOutros").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularJurosCreditoOutros, 100); });
        $("#creditoOutros").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularJurosCreditoOutros, 50); });
        $("#sangria").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 100); });
        $("#sangria").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 50); });
        $("#salarios").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 100); });
        $("#salarios").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 50); });
        $("#despesasdin").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 100); });
        $("#despesasdin").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 50); });
        $("#vales").on('input', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 100); });
        $("#vales").on('blur', function() { aplicarMascaraManual(this); setTimeout(calcularSaldo, 50); });

        $(camposManual.join(', ')).on('keypress', function(e) {
            if (e.which === 13) {
                e.preventDefault();
                $(this).blur();
            }
        });

        setTimeout(function() {
            calcularJurosDebitoVm();
            calcularJurosCreditoVm();
            calcularJurosDebitoOutros();
            calcularJurosCreditoOutros();
            calcularSaldo();
        }, 500);
    });

    window.addEventListener('load', function() {
        setTimeout(function() {
            calcularJurosDebitoVm();
            calcularJurosCreditoVm();
            calcularJurosDebitoOutros();
            calcularJurosCreditoOutros();
            calcularSaldo();
        }, 600);
    });

    $("#formConta, form").on("submit", function() {
        const camposParaLimpar = ['receitas', 'despesas', 'despesasdin', 'contas', 'salarios', 'vales', 'descontos', 'sangria', 'receitadin', 'saldo', 'debitoVm', 'jurosDebitoVm', 'creditoVm', 'jurosCreditoVm', 'debitoOutros', 'jurosDebitoOutros', 'creditoOutros', 'jurosCreditoOutros'];
        camposParaLimpar.forEach(function(nomeCampo) {
            let campo = document.getElementById(nomeCampo);
            if (campo && campo.value) {
                let valorLimpo = limparMascara(campo.value);
                campo.value = valorLimpo.toFixed(2);
            }
        });
    });
</script>
</body>
</html>