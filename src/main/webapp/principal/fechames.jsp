<%@ page import="model.ModelConfiguracao" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Recupera a lista de juros do atributo "configsJuros" que foi passado pela Servlet
    List<ModelConfiguracao> configsJuros = (List<ModelConfiguracao>) request.getAttribute("configsJuros");

    // Verifica se a lista não é nula e se contém pelo menos um elemento
    ModelConfiguracao juros = configsJuros != null && !configsJuros.isEmpty() ? configsJuros.get(0) : null;
%>
<!DOCTYPE html>
<html lang="pt-br">
<jsp:include page="header.jsp"></jsp:include>

<body>
<div class="container-scroller">
    <!-- partial:partials/_sidebar.html -->
    <jsp:include page="sidebar.jsp"></jsp:include>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="navbar.jsp"></jsp:include>
        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper" style="min-height: calc(98vh - 100px);">
                <div class="row">

                </div>

                <div class="row">
                    <div class="col-sm-4 grid-margin">


                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
<!-- Modal -->
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
                                                                          <button type="submit" class="btn btn-primary">Imprimir Relatório</button>
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
                                        </div>

                                    </div>


                        </div>
                    </div>


                </div>
                <div class="row">
                    <div class="col-sm-4 grid-margin">


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!-- Modal -->
                                    <div class="modal fade" id="modalBusca" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
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
                                                                <button type="submit" class="btn btn-primary">Imprimir Relatório</button>
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
                                </div>

                            </div>


                        </div>
                    </div>


                </div>
              <form method="post" action="<%=request.getContextPath()%>/ServletFechaMes">
                <div class="row">
                    <div class="row">
                        <!-- Card Esquerda -->
                        <div class="col-lg-4 grid-margin">
                            <div class="card">
                                <div class="card-body text-center">
                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                        <h4>GERAR FECHAMENTO</h4>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Card Centro -->
                        <div class="col-lg-4 grid-margin">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h2 style="text-transform: uppercase;">${mesAno}</h2>
                                </div>
                            </div>
                        </div>

                        <!-- Card Direita -->
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

                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <h4 class="card-title" style="text-align: center">RESUMO DO MÊS</h4>

                                <div class="table-responsive">

                                <table class="table table-bordered text-center" id="tabelavendasmes"> <!-- Adicionando text-center -->
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
                                                            <fmt:formatNumber
                                                                    value="${(vl.total_ft + vl.total_sobras) / vl.qtd_ribbon}"
                                                                    pattern="0.00"/>
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


                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
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
                                        <!-- Área para o gráfico com altura reduzida -->
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
                                                    maintainAspectRatio: false, // Permite ajustar a altura
                                                    animation: {
                                                        duration: 1500,
                                                        easing: 'easeInOutCubic'
                                                    },
                                                    scales: {
                                                        y: {
                                                            beginAtZero: false,
                                                            ticks: { font: { size: 14, weight: 'bold' } }
                                                        },
                                                        x: {
                                                            ticks: {
                                                                font: { size: 14, weight: 'bold' },
                                                                callback: function(value, index) {
                                                                    return nomesVendas[index] + '\n(' + totalVendas[index] + ')';
                                                                }
                                                            }
                                                        }
                                                    },
                                                    plugins: {
                                                        legend: {
                                                            labels: { font: { size: 14, weight: 'bold' } }
                                                        }
                                                    }
                                                }
                                            });
                                        </script>

                                    </table>


                                </div>

                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            <%--parte 2--%>

                <div class="row">
                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">VALORES ANOTADOS</h4>
                                <!-- Table Content -->
                                <div class="table-responsive">

                                <table class="table table-bordered" id="tabelavaloresmes" >
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
                                <!-- Table Content -->
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
                                <!-- Table Content -->
                                 <div class="table-responsive">

                                 <table class="table table-bordered" id="tabelavalorescontames">
                                        <div class="row">
                                            <div class="col-6 mb-3">
                                                <label for="debitoVm" style="font-size: 0.8rem;">DÉBITO V/M</label>
                                                <input type="text" class="form-control money" id="debitoVm" name="debitoVm"  style="font-size: 0.8rem;">
                                            </div>
                                            <div class="col-6 mb-3">
                                                <label for="jurosDebitoVm" style="font-size: 0.8rem;">JUROS</label>
                                                <input type="text" class="form-control money" id="jurosDebitoVm" name="jurosDebitoVm" style="font-size: 0.8rem;">
                                            </div>

                                            <div class="col-6 mb-3">
                                                <label for="creditoVm" style="font-size: 0.8rem;">CRÉDITO V/M</label>
                                                <input type="text" class="form-control money" id="creditoVm" name="creditoVm" style="font-size: 0.8rem;">

                                            </div>
                                            <div class="col-6 mb-3">
                                                <label for="jurosCreditoVm" style="font-size: 0.8rem;">JUROS</label>
                                                <input type="text" class="form-control money" id="jurosCreditoVm" name="jurosCreditoVm" style="font-size: 0.8rem;">
                                            </div>

                                            <div class="col-6 mb-3">
                                                <label for="debitoOutros" style="font-size: 0.8rem;">DÉBITO OUTROS</label>
                                                <input type="text" class="form-control money" id="debitoOutros" name="debitoOutros" style="font-size: 0.8rem;">
                                            </div>
                                            <div class="col-6 mb-3">
                                                <label for="jurosDebitoOutros" style="font-size: 0.8rem;">JUROS</label>
                                                <input type="text" class="form-control money" id="jurosDebitoOutros" name="jurosDebitoOutros" style="font-size: 0.8rem;">
                                            </div>

                                            <div class="col-6 mb-3">
                                                <label for="creditoOutros" style="font-size: 0.8rem;">CRÉDITO OUTROS</label>
                                                <input type="text" class="form-control money" id="creditoOutros" name="creditoOutros" style="font-size: 0.8rem;">
                                            </div>
                                            <div class="col-6 mb-3">
                                                <label for="jurosCreditoOutros" style="font-size: 0.8rem;">JUROS</label>
                                                <input type="text" class="form-control money" id="jurosCreditoOutros" name="jurosCreditoOutros" style="font-size: 0.8rem;">
                                            </div>
                                        </div>


                                    </table>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            <%--parte 3--%>
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
                                                <td>
                                                    <fmt:formatNumber value="${despesa.valor_despesa}" type="currency" currencySymbol="R$" />
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${despesa.data_despesa}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td><c:out value="${despesa.pagamento_despesa}"/></td>
                                                <td><c:out value="${despesa.id_despesa}"/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>

                                        <!-- Exibir o valor total das despesas -->
                                        <tr>
                                            <td colspan="6" style="font-weight: bold; color: #DAA520; font-size: 1.2rem; text-align: center;">
                                                Valor Total das Despesas:
                                                <fmt:formatNumber value="${valorTotalDespesas}" type="currency" currencySymbol="R$" />
                                            </td>
                                        </tr>

                                    </table>



                                </div>
                            </div>
                        </div>
                    </div>

                </div>
<%--PARTE 4--%>
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

                                            <td><c:out
                                                    value="${contas.numero_pedido}"/></td>
                                            <td><c:out value="${contas.empresa}"/></td>
                                            <td><c:out value="${contas.itens}"/></td>
                                            <td><fmt:formatNumber value="${contas.valor}"
                                                                  type="currency"
                                                                  currencySymbol="R$"/></td>
                                            <td><fmt:formatDate
                                                    value="${contas.data_de_pedido}"
                                                    pattern="dd/MM/yyyy"/></td>
                                            <td><fmt:formatDate
                                                    value="${contas.data_de_pagamento}"
                                                    pattern="dd/MM/yyyy"/></td>
                                            <td><c:out value="${contas.status}"/></td>
                                            <td><c:out value="${contas.pagamento}"/></td>
                                            <td><c:out value="${contas.conta_id}"/></td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="9" style="font-weight: bold; color: #DAA520; font-size: 1.2rem; text-align: center;">
                                            Valor Total das Contas:
                                            <fmt:formatNumber value="${valorTotalContas}" type="currency" currencySymbol="R$" />
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
                                            <td>
                                                <fmt:formatNumber value="${empty vl.valor_vale_total ? 0 : vl.valor_vale_total}" type="currency" currencySymbol="R$" />
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${empty vl.desconto_mes ? 0 : vl.desconto_mes}" type="currency" currencySymbol="R$" />
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
                    <div class="col-md-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RESUMO FINANCEIRO</h4>
                                <div class="table-responsive">
                                <table class="table table-bordered" id="tabelafinanceiromes">
                                    <div class="row">
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="receitas" style="font-size: 1.2rem">RECEITA BRUTA</label>
                                            <input type="text" class="form-control money" id="receitas" name="receitas"  style="font-size: 1.2rem" value="${totalDinheiroReal + totalDebitoReal + totalCreditoReal + totalPixReal}">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="receitas" style="font-size: 1.2rem">RECEITA DINHEIRO</label>
                                            <input type="text" class="form-control money" id="receitadin" name="receitadin"  style="font-size: 1.2rem" value="${totalDinheiroReal}">
                                        </div>

                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="receitacartoes" style="font-size: 1.2rem">RECEITA CARTÕES</label>
                                            <input type="text" class="form-control money" id="receitacartoes" name="receitacartoes"  style="font-size: 1.2rem" value="${totalDebitoReal + totalCreditoReal}">
                                        </div>

                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="receitacartoes" style="font-size: 1.2rem">RECEITA PIX</label>
                                            <input type="text" class="form-control money" id="receitapix" name="receitapix"  style="font-size: 1.2rem" value="${totalPixReal}">
                                        </div>


                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="despesas" style="font-size: 1.2rem">DESPESA TOTAL</label>
                                            <input type="text" class="form-control money" id="despesas" name="despesas" style="font-size: 1.2rem" value="${valorTotalDespesas}">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="despesasdin" style="font-size: 1.2rem">DESPESAS EM DINHEIRO</label>
                                            <input type="text" class="form-control money" id="despesasdin" name="despesasdin" style="font-size: 1.2rem" value="${valorDespesasDin}">
                                        </div>

                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="contas" style="font-size: 1.2rem">CONTAS PAGAS</label>
                                            <input type="text" class="form-control money" id="contas" name="contas" style="font-size: 1.2rem" value="${valorTotalContas}">

                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="salarios" style="font-size: 1.2rem">SALÁRIOS LIQUÍDOS</label>
                                            <input type="text" class="form-control money" id="salarios" name="salarios" style="font-size: 1.2rem" value="${valorTotalSalarios}">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="vales" style="font-size: 1.2rem">VALES</label>
                                            <input type="text" class="form-control money" id="vales" name="vales" style="font-size: 1.2rem" value="${vendasMesList[0].valor_vale_total}">
                                        </div>

                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="descontos" style="font-size: 1.2rem">DESCONTOS</label>
                                            <input type="text" class="form-control money" id="descontos" name="descontos" style="font-size: 1.2rem;" value="${vendasMesList[0].desconto_mes}">
                                        </div>

                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="sangria" style="font-size: 1.2rem">SANGRIA DE CAIXA</label>
                                            <input type="text" class="form-control money" id="sangria" name="sangria" style="font-size: 1.2rem" value="0">
                                        </div>


                                        <div class="col-3 mb-3" style="text-align: center">
                                                <label for="saldo" style="font-size: 1.2rem; color: #DAA520">SALDO EM CAIXA</label>
                                            <input type="text" class="form-control money" id="saldo" name="saldo" style="font-size: 1.2rem;color: #DAA520" value=" ">
                                        </div>
                                    </div>


                                </table>
                                </div>
                                <div style="text-align: center; margin-top: 20px;">
                                    <button type="submit" class="btn btn-outline-success" STYLE="font-size: large">
                                        Gravar Fechamento do Mês
                                    </button>

                                </div>
                            </div>
                        </div>

                    </div>


                </div>
                </form>

                
            </div>
            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <jsp:include page="footer.jsp"></jsp:include>
            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<jsp:include page="pluginsJS.jsp"></jsp:include>
<!-- End custom js for this page -->


<!-- Modal HTML -->
<div class="modal" id="msgModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;"> <!-- Borda preta -->
            <div class="modal-header" style="border-bottom: none;">

                <!-- Removido o botão "X" -->
            </div>
            <div class="modal-body" style="color: black;">
                <p style="font-size: 1.5em; text-align: center">${msg}</p> <!-- Mensagem aqui -->
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
            $.post("${pageContext.request.contextPath}/ServletVendas", { acao: "limparMsg" });
        }
    });

    // Função para navegar entre elementos focáveis com as setas
    function navigateFocusableElements(event) {
        const focusableElements = Array.from(
            document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')
        ).filter(element => !element.disabled && element.tabIndex !== -1);

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

    // Bloqueia a alteração de valor com as setas nos inputs do tipo number
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                event.preventDefault();
            }
        });
    });

    document.addEventListener('keydown', navigateFocusableElements);

    // Inicializa o tooltip
    $(document).ready(function(){
        $('#tooltipButton').tooltip({
            delay: { "show": 100, "hide": 100 }
        });
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

    // Passa os valores de juros para o JavaScript
    var debitoVmJuros = <%= juros != null ? juros.getDeb_visa_master() : 0 %>;
    var creditoVmJuros = <%= juros != null ? juros.getCred_visa_master() : 0 %>;
    var debitoOutrosJuros = <%= juros != null ? juros.getDeb_outros() : 0 %>;
    var creditoOutrosJuros = <%= juros != null ? juros.getCred_outros() : 0 %>;

    // ============================================================================
    // FIX PARA O ERRO DO MASKMONEY COM JQUERY 3.7.1
    // ============================================================================
    if (!$.browser) {
        $.browser = {};
    }
    $.browser.msie = false;

    // Função para limpar máscara
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

    // Função para formatar valor monetário manualmente
    function formatarMoeda(valor) {
        if (!valor) return '';

        let numero = valor.toString().replace(/\D/g, '');
        numero = (parseFloat(numero) / 100).toFixed(2);

        let partes = numero.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');

        return 'R$ ' + partes.join(',');
    }

    // Função para aplicar máscara manualmente em um campo
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

    // ============================================================================
    // CÁLCULO DE JUROS (COM MÁSCARA MANUAL)
    // ============================================================================

    // Função para calcular os juros de débito Visa/Master
    function calcularJurosDebitoVm() {
        var debitoVm = limparMascara(document.getElementById('debitoVm').value);
        var jurosCalculado = debitoVm * debitoVmJuros;

        // Formata o resultado manualmente
        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');

        document.getElementById('jurosDebitoVm').value = valorFormatado;
    }

    // Função para calcular os juros de crédito Visa/Master
    function calcularJurosCreditoVm() {
        var creditoVm = limparMascara(document.getElementById('creditoVm').value);
        var jurosCalculado = creditoVm * creditoVmJuros;

        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');

        document.getElementById('jurosCreditoVm').value = valorFormatado;
    }

    // Função para calcular os juros de débito outros
    function calcularJurosDebitoOutros() {
        var debitoOutros = limparMascara(document.getElementById('debitoOutros').value);
        var jurosCalculado = debitoOutros * debitoOutrosJuros;

        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');

        document.getElementById('jurosDebitoOutros').value = valorFormatado;
    }

    // Função para calcular os juros de crédito outros
    function calcularJurosCreditoOutros() {
        var creditoOutros = limparMascara(document.getElementById('creditoOutros').value);
        var jurosCalculado = creditoOutros * creditoOutrosJuros;

        let valorFormatado = jurosCalculado.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = 'R$ ' + partes.join(',');

        document.getElementById('jurosCreditoOutros').value = valorFormatado;
    }

    // Função para calcular saldo
    function calcularSaldo() {
        let receitadin = limparMascara($("#receitadin").val());
        let despDin  = limparMascara($("#despesasdin").val());
        let sangria  = limparMascara($("#sangria").val());
        let salarios = limparMascara($("#salarios").val());
        let vales = limparMascara($("#vales").val());
        let saldo = receitadin - despDin - sangria - salarios-vales;

        let valorFormatado = saldo.toFixed(2);
        let partes = valorFormatado.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        valorFormatado = partes.join(',');

        $("#saldo").val('R$ ' + valorFormatado);
    }

    // ============================================================================
    // INICIALIZAÇÃO DOS CAMPOS
    // ============================================================================

    $(document).ready(function() {
        // Lista de campos que usarão máscara MANUAL
        const camposManual = [
            '#debitoVm', '#jurosDebitoVm',
            '#creditoVm', '#jurosCreditoVm',
            '#debitoOutros', '#jurosDebitoOutros',
            '#creditoOutros', '#jurosCreditoOutros',
            '#sangria', '#salarios', '#despesasdin', '#vales'
        ];

        // Remove a classe .money desses campos para evitar conflitos
        $(camposManual.join(', ')).removeClass('money');

        // Remove TODOS os eventos anteriores desses campos
        $(camposManual.join(', ')).off();

        // Aplica a máscara maskMoney APENAS nos campos que NÃO estão na lista manual
        $(".money").not(camposManual.join(', ')).maskMoney({
            showSymbol: true,
            symbol: "R$ ",
            decimal: ",",
            thousands: "."
        });

        // Formata os campos que já vêm preenchidos do servidor
        setTimeout(function() {
            $(".money").not(camposManual.join(', ')).each(function() {
                let campo = $(this);
                let valor = campo.val();

                if (valor && valor.trim() !== '') {
                    let valorLimpo = limparMascara(valor);

                    // Formata manualmente usando toLocaleString
                    let valorFormatado = valorLimpo.toLocaleString('pt-BR', {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                    });

                    campo.val('R$ ' + valorFormatado);
                }
            });
        }, 100);

        // ========================================================================
        // APLICA MÁSCARA MANUAL NOS CAMPOS DE DÉBITO/CRÉDITO
        // ========================================================================

        // Débito Visa/Master
        $("#debitoVm").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosDebitoVm, 100);
        });
        $("#debitoVm").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosDebitoVm, 50);
        });

        // Crédito Visa/Master
        $("#creditoVm").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosCreditoVm, 100);
        });
        $("#creditoVm").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosCreditoVm, 50);
        });

        // Débito Outros
        $("#debitoOutros").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosDebitoOutros, 100);
        });
        $("#debitoOutros").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosDebitoOutros, 50);
        });

        // Crédito Outros
        $("#creditoOutros").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosCreditoOutros, 100);
        });
        $("#creditoOutros").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularJurosCreditoOutros, 50);
        });

        // ========================================================================
        // MÁSCARA MANUAL PARA SANGRIA, SALÁRIOS E DESPESAS
        // ========================================================================

        $("#sangria").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });
        $("#sangria").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        $("#salarios").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });
        $("#salarios").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        $("#despesasdin").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });
        $("#despesasdin").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        $("#vales").on('input', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });
        $("#vales").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        // Evento Enter para todos os campos manuais
        $(camposManual.join(', ')).on('keypress', function(e) {
            if (e.which === 13) {
                e.preventDefault();
                $(this).blur();
            }
        });

        // Calcula os valores iniciais
        setTimeout(function() {
            calcularJurosDebitoVm();
            calcularJurosCreditoVm();
            calcularJurosDebitoOutros();
            calcularJurosCreditoOutros();
            calcularSaldo();
        }, 500);
    });

    // Calcula quando a página carregar completamente
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
        const camposParaLimpar = [
            'receitas', 'despesas', 'despesasdin', 'contas',
            'salarios', 'vales', 'descontos', 'sangria',
            'receitadin', 'saldo',
            'debitoVm', 'jurosDebitoVm',
            'creditoVm', 'jurosCreditoVm',
            'debitoOutros', 'jurosDebitoOutros',
            'creditoOutros', 'jurosCreditoOutros'
        ];

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
