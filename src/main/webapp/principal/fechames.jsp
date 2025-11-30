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
                    <div class="col-lg-3 grid-margin">
                        <div class="card" >
                            <div class="card-body" style="text-align: center">
                                <!-- Card 1 -->
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <c:if test="${not empty msg}">
                                    <div>
                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                    </div>
                                </c:if>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-3 grid-margin">
                        <div class="card" >
                            <div class="card-body" style="text-align: center">
                                <!-- Card 1 -->
                                <h2 style="text-transform: uppercase;">${mesAno}</h2>
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

                             <form method="post" action="<%=request.getContextPath()%>/ServletFechaMes">
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
                                    <div style="align-items: center">

                                        <button type="submit" class="btn btn-outline-success" STYLE="font-size: large">
                                            Gravar Fechamento do Mês
                                        </button>
                                    </div>
                                </div>
                                </form>
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
                                <h4 class="card-title" style="text-align: center">FINANCEIRO</h4>
                                <div class="table-responsive">
                                <table class="table table-bordered" id="tabelafinanceiromes">
                                    <div class="row">
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="receitas" style="font-size: 1.2rem">RECEITA DE VENDAS</label>
                                            <input type="text" class="form-control money" id="receitas" name="receitas"  style="font-size: 1.2rem" value="${totalDinheiro + totalDebito + totalCredito + totalPix}">
                                        </div>


                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="despesas" style="font-size: 1.2rem">DESPESA TOTAL</label>
                                            <input type="text" class="form-control money" id="despesas" name="despesas" style="font-size: 1.2rem" value="${valorTotalDespesas}">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="despesadin" style="font-size: 1.2rem">DESPESAS EM DINHEIRO</label>
                                            <input type="text" class="form-control money" id="despesadin" name="despesadin" style="font-size: 1.2rem" value="${valorDespesasDin}">
                                        </div>

                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="contas" style="font-size: 1.2rem">CONTAS PAGAS</label>
                                            <input type="text" class="form-control money" id="contas" name="contas" style="font-size: 1.2rem" value="${valorTotalContas}">

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
                                            <input type="text" class="form-control money" id="sangria" name="sangria" style="font-size: 1.2rem; background: #FFFFFF; color: black" value="0">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="salarios" style="font-size: 1.2rem">SALARIOS</label>
                                            <input type="text" class="form-control money" id="salarios" name="salarios" style="font-size: 1.2rem; background: #FFFFFF; color: black" value="${valorTotalSalarios}">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                            <label for="receitas" style="font-size: 1.2rem">RECEITA EM DINHEIRO</label>
                                            <input type="text" class="form-control money" id="receita_din" name="receita_din"  style="font-size: 1.2rem" value="${vendasMesList[0].valor_din_mes}">
                                        </div>
                                        <div class="col-3 mb-3" style="text-align: center">
                                                <label for="saldo" style="font-size: 1.2rem; color: #DAA520">SALDO EM CAIXA</label>
                                            <input type="text" class="form-control money" id="saldo" name="saldo" style="font-size: 1.2rem;color: #DAA520" value=" ">
                                        </div>
                                    </div>


                                </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                
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
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem

            // Remove a mensagem da sessão após exibi-la
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
                event.preventDefault(); // Impede a alteração do valor
            }
        });
    });

    // Adiciona o evento keydown ao documento
    document.addEventListener('keydown', navigateFocusableElements);
    // Fim de navegação por setas




    // Inicializa o tooltip com um delay reduzido para aparecer mais rápido
    $(document).ready(function(){
        $('#tooltipButton').tooltip({
            delay: { "show": 100, "hide": 100 } // O tooltip vai aparecer em 100ms
        });
    });





    function setData() {
        // Obtém o valor do campo dataInicial
        var dataInicial = document.getElementById("dataInicial").value;

        if (dataInicial) {
            // Divide a data inicial em dia, mês e ano
            var partesData = dataInicial.split('-'); // Assume que o formato é yyyy-mm-dd
            var ano = parseInt(partesData[0], 10);
            var mes = parseInt(partesData[1], 10) - 1; // Mês é 0-based no JavaScript
            var dia = parseInt(partesData[2], 10);

            // Cria um objeto Date com os valores extraídos
            var data = new Date(ano, mes, dia);

            // Verifica se a data é válida
            if (!isNaN(data.getTime())) {
                // Calcula o último dia do mês da data inicial
                var ultimoDia = new Date(ano, mes + 1, 0);

                // Formata a data final no padrão yyyy-mm-dd
                var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
                var mesFinal = String(mes + 1).padStart(2, '0'); // Ajusta o mês para exibição (1-12)
                var dataFinal = ano + '-' + mesFinal + '-' + diaFinal;

                // Define o valor do campo dataFinal
                document.getElementById("dataFinal").value = dataFinal;
            } else {
                console.error("Data inicial inválida.");
                document.getElementById("dataFinal").value = ""; // Limpa o campo se a data for inválida
            }
        } else {
            console.error("Data inicial não selecionada.");
            document.getElementById("dataFinal").value = ""; // Limpa o campo se a data inicial estiver vazia
        }
    }

    // Função para inicializar os campos de data ao abrir o modal
    function initializeDates() {
        // Obtém a data atual
        var today = new Date();

        // Formata a data inicial no padrão yyyy-mm-dd
        var diaInicial = String(today.getDate()).padStart(2, '0');
        var mesInicial = String(today.getMonth() + 1).padStart(2, '0');
        var anoInicial = today.getFullYear();
        var dataInicial = anoInicial + '-' + mesInicial + '-' + diaInicial;

        // Calcula o último dia do mês atual
        var ultimoDia = new Date(anoInicial, today.getMonth() + 1, 0);

        // Formata a data final no padrão yyyy-mm-dd
        var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
        var mesFinal = String(today.getMonth() + 1).padStart(2, '0'); // Usa o mês da data inicial
        var anoFinal = today.getFullYear();
        var dataFinal = anoFinal + '-' + mesFinal + '-' + diaFinal;

        // Define os valores dos campos
        document.getElementById("dataInicial").value = dataInicial;
        document.getElementById("dataFinal").value = dataFinal;
    }

    // Inicializa os campos de data quando o modal é aberto
    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('modalData'); // Substitua 'meuModal' pelo ID do seu modal
        if (modal) {
            modal.addEventListener('shown.bs.modal', function () {
                // Verifica se os campos já foram inicializados
                if (!document.getElementById("dataInicial").value) {
                    initializeDates();
                }
            });
        }

        // Adiciona o evento onchange ao campo dataInicial
        document.getElementById("dataInicial").addEventListener('change', setData);
    });


    // Aplica a máscara em todos os inputs com a classe .money
    $(".money").maskMoney({
        showSymbol: true,
        symbol: "R$ ",
        decimal: ",",
        thousands: "."
    });

    function removerMascara(valor) {
        return valor.replace(/\./g, '').replace(',', '.').replace('R$ ', '');
    }

    // Remove a máscara de todos os inputs com a classe .money ao enviar o formulário
    $("#formConta").on("submit", function(e) {
        $(".money").each(function() {
            var valorSemMascara = removerMascara($(this).val());
            $(this).val(valorSemMascara);
        });
    });

    // Passa os valores de juros para o JavaScript
    var debitoVmJuros = <%= juros != null ? juros.getDeb_visa_master() : 0 %>;
    var creditoVmJuros = <%= juros != null ? juros.getCred_visa_master() : 0 %>;
    var debitoOutrosJuros = <%= juros != null ? juros.getDeb_outros() : 0 %>;
    var creditoOutrosJuros = <%= juros != null ? juros.getCred_outros() : 0 %>;


    // Função para formatar o valor monetário (substitui vírgula por ponto)
    function formatarValorMonetario(valor) {
        return parseFloat(valor.replace(/\./g, '').replace(',', '.')) || 0;
    }

    // Função para calcular os juros de débito Visa/Master
    function calcularJurosDebitoVm() {
        var debitoVm = formatarValorMonetario(document.getElementById('debitoVm').value);
        var jurosCalculado = debitoVm * debitoVmJuros;
        document.getElementById('jurosDebitoVm').value = jurosCalculado.toFixed(2).replace('.', ',');
    }

    // Função para calcular os juros de crédito Visa/Master
    function calcularJurosCreditoVm() {
        var creditoVm = formatarValorMonetario(document.getElementById('creditoVm').value);
        var jurosCalculado = creditoVm * creditoVmJuros;
        document.getElementById('jurosCreditoVm').value = jurosCalculado.toFixed(2).replace('.', ',');
    }

    // Função para calcular os juros de débito outros
    function calcularJurosDebitoOutros() {
        var debitoOutros = formatarValorMonetario(document.getElementById('debitoOutros').value);
        var jurosCalculado = debitoOutros * debitoOutrosJuros;
        document.getElementById('jurosDebitoOutros').value = jurosCalculado.toFixed(2).replace('.', ',');
    }

    // Função para calcular os juros de crédito outros
    function calcularJurosCreditoOutros() {
        var creditoOutros = formatarValorMonetario(document.getElementById('creditoOutros').value);
        var jurosCalculado = creditoOutros * creditoOutrosJuros;
        document.getElementById('jurosCreditoOutros').value = jurosCalculado.toFixed(2).replace('.', ',');
    }

    // Adiciona listeners para os campos
    function adicionarListeners() {
        // Débito Visa/Master
        var debitoVm = document.getElementById('debitoVm');
        debitoVm.addEventListener('input', calcularJurosDebitoVm);
        debitoVm.addEventListener('blur', calcularJurosDebitoVm);

        // Crédito Visa/Master
        var creditoVm = document.getElementById('creditoVm');
        creditoVm.addEventListener('input', calcularJurosCreditoVm);
        creditoVm.addEventListener('blur', calcularJurosCreditoVm);

        // Débito Outros
        var debitoOutros = document.getElementById('debitoOutros');
        debitoOutros.addEventListener('input', calcularJurosDebitoOutros);
        debitoOutros.addEventListener('blur', calcularJurosDebitoOutros);

        // Crédito Outros
        var creditoOutros = document.getElementById('creditoOutros');
        creditoOutros.addEventListener('input', calcularJurosCreditoOutros);
        creditoOutros.addEventListener('blur', calcularJurosCreditoOutros);
    }

    // Executa os cálculos ao carregar a página
    $(document).ready(function() {
        adicionarListeners();
        calcularJurosDebitoVm();
        calcularJurosCreditoVm();
        calcularJurosDebitoOutros();
        calcularJurosCreditoOutros();
    });
    function limparMascara(valor) {
        if (!valor) return 0;

        // Remove qualquer repetição de "R$"
        valor = valor.replace(/R\$/g, "").trim();

        // Remove espaços
        valor = valor.replace(/\s+/g, "");

        // Agora remove apenas pontos de milhares
        valor = valor.replace(/\./g, "");

        // Troca vírgula por ponto
        valor = valor.replace(",", ".");

        return parseFloat(valor) || 0;
    }



    // FIX para o erro do maskMoney com jQuery 3.7.1
    if (!$.browser) {
        $.browser = {};
    }
    $.browser.msie = false;

    // Função para limpar máscara
    function limparMascara(valor) {
        if (valor === undefined || valor === null || valor === '') return 0;

        let s = String(valor).trim();

        // Remove qualquer caractere que não seja número, vírgula ou ponto
        s = s.replace(/[^\d,\.]/g, '');

        // Se estiver vazio após limpeza
        if (s === '') return 0;

        // Identifica se usa vírgula (formato BR) ou ponto (formato US/servidor)
        const temVirgula = s.indexOf(',') > -1;
        const temPonto = s.indexOf('.') > -1;

        if (temVirgula && temPonto) {
            // Formato: 1.234,56 (BR com milhares)
            s = s.replace(/\./g, '').replace(',', '.');
        } else if (temVirgula && !temPonto) {
            // Formato: 1234,56 (BR sem milhares)
            s = s.replace(',', '.');
        } else if (temPonto && !temVirgula) {
            // Formato: 1234.56 (US) ou 1.234 (BR com milhares, sem centavos)
            const partes = s.split('.');
            if (partes.length > 2 || (partes.length === 2 && partes[1].length > 2)) {
                // É separador de milhar: 1.234 ou 1.234.567
                s = s.replace(/\./g, '');
            }
            // Senão, é decimal: 1234.56
        }

        const n = parseFloat(s);
        return isNaN(n) ? 0 : n;
    }

    // Função para formatar valor monetário manualmente
    function formatarMoeda(valor) {
        if (!valor) return '';

        // Remove tudo que não é número
        let numero = valor.toString().replace(/\D/g, '');

        // Converte para centavos
        numero = (parseFloat(numero) / 100).toFixed(2);

        // Formata com separadores
        let partes = numero.split('.');
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');

        return 'R$ ' + partes.join(',');
    }

    // Função para aplicar máscara manualmente em um campo
    function aplicarMascaraManual(campo) {
        let valor = $(campo).val();

        // Remove tudo que não é número
        let apenasNumeros = valor.replace(/\D/g, '');

        // Se estiver vazio, limpa o campo
        if (!apenasNumeros) {
            $(campo).val('');
            return;
        }

        // Formata
        let valorFormatado = formatarMoeda(apenasNumeros);
        $(campo).val(valorFormatado);
    }

    // Função para calcular saldo
    function calcularSaldo() {
        let receita_din = limparMascara($("#receita_din").val());
        let despDin  = limparMascara($("#despesadin").val());
        let sangria  = limparMascara($("#sangria").val());
        let salarios = limparMascara($("#salarios").val());
        let saldo = receita_din - despDin - sangria - salarios;

        // Formata o valor com separador de milhar
        let valorFormatado = saldo.toFixed(2);
        let partes = valorFormatado.split('.');

        // Adiciona separador de milhar
        partes[0] = partes[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');

        // Junta tudo com vírgula como separador decimal
        valorFormatado = partes.join(',');

        $("#saldo").val('R$ ' + valorFormatado);
    }

    $(document).ready(function() {
        // Aplica a máscara maskMoney APENAS nos campos que NÃO são sangria, salarios e despesadin
        $(".money").not("#sangria, #salarios, #despesadin").maskMoney({
            showSymbol: true,
            symbol: "R$ ",
            decimal: ",",
            thousands: "."
        });

        // Remove a classe .money dos campos sangria, salários e despesadin para evitar conflitos
        $("#sangria, #salarios, #despesadin").removeClass('money');

        // Remove TODOS os eventos anteriores desses campos
        $("#sangria, #salarios, #despesadin").off();

        // Aplica máscara manual no campo SANGRIA
        $("#sangria").on('input', function(e) {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });

        $("#sangria").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        // Aplica máscara manual no campo SALÁRIOS
        $("#salarios").on('input', function(e) {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });

        $("#salarios").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        // Aplica máscara manual no campo DESPESAS EM DINHEIRO
        $("#despesadin").on('input', function(e) {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 100);
        });

        $("#despesadin").on('blur', function() {
            aplicarMascaraManual(this);
            setTimeout(calcularSaldo, 50);
        });

        // Evento Enter
        $("#sangria, #salarios, #despesadin").on('keypress', function(e) {
            if (e.which === 13) {
                e.preventDefault();
                $(this).blur();
            }
        });

        // Calcula o saldo inicial
        setTimeout(function() {
            calcularSaldo();
        }, 500);
    });

    // Calcula quando a página carregar completamente
    window.addEventListener('load', function() {
        setTimeout(calcularSaldo, 600);
    });
</script>
</body>
</html>
