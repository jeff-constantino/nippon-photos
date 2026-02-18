<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                <div class="row">

                </div>
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table">


                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalDRE">
                                                <h4>Gerar DRE</h4>
                                            </button>

                                            <div class="card-body" style="text-align: center">
                                                <h2 style="text-transform: uppercase;">${mesAno}</h2>
                                            </div>



                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalBusca">
                                                <h4>Buscar DRE</h4>
                                            </button>
                                        </div>



                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <%--TODOS MODAIS  --%>
                <div class="row">
                    <div class="col-sm-4 grid-margin">



                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">


                                    <div class="modal fade" id="modalDRE" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticBackdropLabel">Vendas do dia</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <c:choose>
                                                        <c:when test="${empty mesesNaoFechados}">
                                                            <div>
                                                                <i class="fas fa-info-circle"></i>
                                                                Não há meses pendentes para gerar o relatório DRE.
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="mb-3">Selecione um mês para gerar o relatório:</p>
                                                            <div class="table-responsive">
                                                                <table class="table table-hover">

                                                                    <tbody>
                                                                    <c:forEach var="mesAno" items="${mesesNaoFechados}">
                                                                        <tr>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${mesAno.mes == 1}">Janeiro</c:when>
                                                                                    <c:when test="${mesAno.mes == 2}">Fevereiro</c:when>
                                                                                    <c:when test="${mesAno.mes == 3}">Março</c:when>
                                                                                    <c:when test="${mesAno.mes == 4}">Abril</c:when>
                                                                                    <c:when test="${mesAno.mes == 5}">Maio</c:when>
                                                                                    <c:when test="${mesAno.mes == 6}">Junho</c:when>
                                                                                    <c:when test="${mesAno.mes == 7}">Julho</c:when>
                                                                                    <c:when test="${mesAno.mes == 8}">Agosto</c:when>
                                                                                    <c:when test="${mesAno.mes == 9}">Setembro</c:when>
                                                                                    <c:when test="${mesAno.mes == 10}">Outubro</c:when>
                                                                                    <c:when test="${mesAno.mes == 11}">Novembro</c:when>
                                                                                    <c:when test="${mesAno.mes == 12}">Dezembro</c:when>
                                                                                </c:choose>
                                                                                / ${mesAno.ano}
                                                                            </td>
                                                                            <td>
                                                                                <form action="<%= request.getContextPath() %>/ServletDre" method="get">
                                                                                    <input type="hidden" name="acao" value="relatorioMes">
                                                                                    <input type="hidden" name="mes" value="${mesAno.mes}">
                                                                                    <input type="hidden" name="ano" value="${mesAno.ano}">
                                                                                    <button type="submit" class="btn btn-primary btn-sm">
                                                                                        <i class="fas fa-file-pdf"></i> Gerar Relatório
                                                                                    </button>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
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
                    <div class="col-sm-4 grid-margin">



                    </div>
                    <div class="col-sm-4 grid-margin">


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <div class="modal fade" id="modalBusca" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered modal-md"> <!-- tamanho médio -->
                                            <div class="modal-content">
                                                <div class="modal-header justify-content-center">
                                                    <h5 class="modal-title text-center w-100" id="modalBuscaLabel">Buscar Fechamento</h5>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="<%= request.getContextPath() %>/ServletDre" method="get" id="formBuscaDre">
                                                        <input type="hidden" name="acao" value="buscarDre">
                                                        <div class="row g-3">
                                                            <div class="col-12 col-md-6">
                                                                <label for="mesBusca" class="form-label">Selecione o Mês</label>
                                                                <select class="form-select" id="mesBusca" name="mes" required>
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
                                                            <div class="col-12 col-md-6">
                                                                <label for="anoBusca" class="form-label">Selecione o Ano</label>
                                                                <select class="form-select" id="anoBusca" name="ano" required>
                                                                    <option value="">-- Selecione --</option>
                                                                    <%
                                                                        java.util.Calendar calBusca = java.util.Calendar.getInstance();
                                                                        int anoAtualBusca = calBusca.get(java.util.Calendar.YEAR);
                                                                        for(int i = 0; i < 20; i++) {
                                                                            int anoBusca = anoAtualBusca - i;
                                                                    %>
                                                                    <option value="<%= anoBusca %>" <%= (i == 0) ? "selected" : "" %>><%= anoBusca %></option>
                                                                    <% } %>
                                                                </select>
                                                            </div>
                                                            <div class="col-12 text-center mt-3">
                                                                <button type="submit" class="btn btn-success w-50">Buscar DRE</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer justify-content-center">
                                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">FECHAR</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>


                        </div>
                    </div>
                </div>
                <form id="formDre" method="post"
                      action="<%=request.getContextPath()%>/ServletDre">
                    <input type="hidden" name="acao" value="gravarDRE"/>
                    <%--CONTEUDO PAGINA--%>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-6 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title" style="text-align: center">RECEITAS OPERACIONAIS</h4>
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="tabelaReceita">
                                                    <thead class="thead-light">
                                                    <tr>
                                                        <th scope="col" style="font-size: 1.0rem">TIPO</th>
                                                        <th scope="col" style="font-size: 1.0rem">VALOR</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:set var="receitaDinheiro" value="0" />
                                                    <c:set var="receitaDebito" value="0" />
                                                    <c:set var="receitaCredito" value="0" />
                                                    <c:set var="receitaPix" value="0" />
                                                    <c:set var="impostos" value="0" />
                                                    <c:set var="receitaBruta" value="0" />

                                                    <c:forEach items="${vendasMesList}" var="vl">
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Dinheiro</td>
                                                            <td style="font-size: 1.0rem"><fmt:formatNumber value="${vl.valor_din_mes}" type="currency" currencySymbol="R$" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Débito</td>
                                                            <td style="font-size: 1.0rem"><fmt:formatNumber value="${vl.valor_deb_mes}" type="currency" currencySymbol="R$" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Crédito</td>
                                                            <td style="font-size: 1.0rem"><fmt:formatNumber value="${vl.valor_cred_mes}" type="currency" currencySymbol="R$" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Pix</td>
                                                            <td style="font-size: 1.0rem"><fmt:formatNumber value="${vl.valor_pix_mes}" type="currency" currencySymbol="R$" /></td>
                                                        </tr>
                                                        <c:set var="receitaDinheiro" value="${receitaDinheiro+ vl.valor_din_mes}" />
                                                        <c:set var="receitaDebito" value="${receitaDebito + vl.valor_deb_mes}" />
                                                        <c:set var="receitaCredito" value="${receitaCredito + vl.valor_cred_mes}" />
                                                        <c:set var="receitaPix" value="${receitaPix + vl.valor_pix_mes}" />
                                                        <c:set var="receitaBruta" value="${receitaDinheiro + receitaDebito + receitaCredito + receitaPix}" />
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Receita Bruta</td>
                                                            <td style="font-size: 1.0rem"><fmt:formatNumber value="${receitaBruta}" type="currency" currencySymbol="R$" /></td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title" style="text-align: center">DESPESAS OPERACIONAIS</h4>
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="tabelaDespesas">
                                                    <thead class="thead-light">
                                                    <tr>
                                                        <th scope="col" style="font-size: 1.0rem">TIPO</th>
                                                        <th scope="col" style="font-size: 1.0rem">VALOR</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:set var="ribbons" value="0" />
                                                    <c:set var="encartes" value="0" />
                                                    <c:set var="jurosCartoes" value="0" />
                                                    <c:set var="despesasOperacionais" value="0" />
                                                    <c:set var="lucroBruto" value="0" />
                                                    <c:set var="totalCustosOperacionais" value="0" />
                                                    <c:forEach items="${vendasMesList}" var="vl">
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Ribbons</td>
                                                            <td style="font-size: 1.0rem">
                                                                <fmt:formatNumber value="${vl.total_ribbons}" type="currency" currencySymbol="R$" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Encartes</td>
                                                            <td style="font-size: 1.0rem">
                                                                <fmt:formatNumber value="${vl.valor_enc}" type="currency" currencySymbol="R$" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Juros dos Cartões</td>
                                                            <td style="font-size: 1.0rem">
                                                                <fmt:formatNumber value="${vl.juros_cartoes}" type="currency" currencySymbol="R$" />
                                                            </td>
                                                        </tr>
                                                        <c:set var="despesaAtual" value="${vl.total_ribbons + vl.valor_enc + vl.juros_cartoes}" />
                                                        <tr>
                                                            <td style="font-size: 1.0rem">Despesas Operacionais</td>
                                                            <td style="font-size: 1.0rem">
                                                                <fmt:formatNumber value="${despesaAtual}" type="currency" currencySymbol="R$" />
                                                            </td>
                                                        </tr>
                                                        <c:set var="totalCustosOperacionais" value="${totalCustosOperacionais + despesaAtual}" />
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12 grid-margin">
                                    <div class="card">
                                        <div class="card-body">
                                            <h4 class="card-title" style="text-align: center">CALCULO FINANCEIRO</h4>
                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="receitaBrt" style="font-size: 1.0rem;">RECEITA BRUTA</label>
                                                    <input type="text" class="form-control money" id="receitaBrt" name="receitaBrt" style=" color: black; font: bold; font-size: 1.0rem"
                                                           value="<fmt:formatNumber value="${receitaBruta}" pattern="#,##0.00" />" readonly>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="custosOpr" style="font-size: 1.0rem;">CUSTOS OPERACIONAL</label>
                                                    <input type="text" class="form-control money" id="custosOpr" name="custosOpr" style="color: #ff0000; font: bold; font-size: 1.0rem"
                                                           value="<fmt:formatNumber value="${totalCustosOperacionais}" pattern="#,##0.00" />" readonly>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="lucroBrt" style="font-size: 1.0rem;">LUCRO BRUTO</label>
                                                    <input type="text" class="form-control money" id="lucroBrt" name="lucroBrt" style="font: bold; font-size: 1.0rem; color: black"
                                                           value="<fmt:formatNumber value="${receitaBruta-totalCustosOperacionais}" pattern="#,##0.00" />" readonly>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="impostoVenda" style="font-size: 1.0rem;">IMPOSTOS SOBRE VENDAS</label>
                                                    <input type="text" class="form-control" id="impostoVenda" name="impostoVenda" style="font-size: 1.0rem; color: #ff0000" readonly>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="despAdm" style="font-size: 1.0rem;">DESPESAS ADMINISTRATIVAS</label>
                                                    <input type="text" class="form-control" id="despAdm" name="despAdm" style="font-size: 1.0rem; color: #ff0000" readonly>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="lucroLqd" style="font-size: 1.0rem;">LUCRO LIQUIDO </label>
                                                    <input type="text" class="form-control" id="lucroLqd" name="lucroLqd" style="font-size: 1.0rem;" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 grid-margin">
                            <div class="card">
                                <div class="card-body">

                                    <h4 class="card-title" style="text-align: center">IMPOSTOS SOBRE VENDAS</h4>
                                    <div class="row">
                                        <div class="col-6 mb-3">
                                            <label for="icms" style="font-size: 1.0rem;">ISS</label>
                                            <input type="text" class="form-control money" id="icms" name="icms" style="font-size: 1.0rem;" value="${icmsValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="pis" style="font-size: 1.0rem;">PIS</label>
                                            <input type="text" class="form-control money" id="pis" name="pis" style="font-size: 1.0rem;" value="${pisValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="cofins" style="font-size: 1.0rem;">COFINS</label>
                                            <input type="text" class="form-control money" id="cofins" name="cofins" style="font-size: 1.0rem;" value="${cofinsValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="inss" style="font-size: 1.0rem;">INSS</label>
                                            <input type="text" class="form-control money" id="inss" name="inss" style="font-size: 1.0rem;" value="${inssValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="irpj" style="font-size: 1.0rem;">IRPJ</label>
                                            <input type="text" class="form-control money" id="irpj" name="irpj" style="font-size: 1.0rem;" value="${irpjValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="csll" style="font-size: 1.0rem;">CSLL</label>
                                            <input type="text" class="form-control money" id="csll" name="csll" style="font-size: 1.0rem;" value="${csllValue}">
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <label for="totalImpostos" style="font-size: 1.0rem; font-weight: bold;">TOTAL IMPOSTOS</label>
                                            <input type="text" class="form-control money" id="totalImpostos" name="totalImpostos" style="font-size: 1.0rem; color: black; font: bold" readonly>
                                        </div>
                                    </div>

                                    <h4 class="card-title" style="text-align: center; margin-top: 2rem;">DESPESAS ADMINISTRATIVAS</h4>
                                    <div class="row">
                                        <div class="col-6 mb-3">
                                            <label for="aluguel" style="font-size: 1.0rem;" hidden="hidden">aluguel</label>
                                            <input type="text" class="form-control money" id="aluguel" name="aluguel" style="font-size: 1.0rem;" value="${aluguelValue}" disabled hidden="hidden">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="salarios" style="font-size: 1.0rem;">Salários</label>
                                            <input type="text" class="form-control money" id="salarios" name="salarios" style="font-size: 1.0rem; color: black" value="${valorTotalSalarios}" readonly>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="contas" style="font-size: 1.0rem;">Contas</label>
                                            <input type="text" class="form-control money" id="contas" name="contas" style="font-size: 1.0rem; color: black" value="${valorTotalContas}" readonly>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="despesasGerais" style="font-size: 1.0rem;">Despesas Gerais</label>
                                            <input type="text" class="form-control money" id="despesasGerais" name="despesasGerais" style="font-size: 1.0rem; color: black" value="${valorTotalDespesas}" readonly>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="bonificacoes" style="font-size: 1.0rem;">Bonificações</label>
                                            <input type="text" class="form-control money" id="bonificacoes" name="bonificacoes" style="font-size: 1.0rem;" value="${bonificacoesValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="prestacoes" style="font-size: 1.0rem;">Prestações de Equipamentos</label>
                                            <input type="text" class="form-control money" id="prestacoes" name="prestacoes" style="font-size: 1.0rem;" value="${prestacoesValue}">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="internet" style="font-size: 1.0rem;" hidden="hidden">Internet</label>
                                            <input type="text" class="form-control money" id="internet" name="internet" style="font-size: 1.0rem;" value="${internetValue}" disabled hidden="hidden">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="outrasDesp" style="font-size: 1.0rem;">Outras Despesas</label>
                                            <input type="text" class="form-control money" id="outrasDesp" name="obsDesp" style="font-size: 1.0rem;" value="${obsDespValue}">
                                        </div>
                                        <div class="col-12 mb-3">
                                            <label for="obsDesp" style="font-size: 1.0rem;">Observações</label>
                                            <textarea
                                                    class="form-control"
                                                    id="obsDesp"
                                                    name="obsDesp"
                                                    rows="4"
                                                    style="font-size: 1.0rem;"><c:out value="${obsDespValue}" /></textarea>
                                        </div>


                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-12 mb-3">
                                            <label for="totalDespesasAdm" style="font-size: 1.0rem; font-weight: bold;">TOTAL DESPESAS ADM</label>
                                            <input type="text" class="form-control money" id="totalDespesasAdm" name="totalDespesasAdm" style="font-size: 1.0rem; color: black ;font: bold" readonly>
                                        </div>
                                    </div>

                                    <div style="text-align: center; margin-top: 15px;">
                                        <button type="submit" class="btn btn-outline-success" style="font-size: large">
                                            Gravar DRE
                                        </button>
                                    </div>
                                    <div style="text-align: center; margin-top: 10px;">
                                        <button type="button" class="btn btn-outline-primary" style="font-size: large"
                                                onclick="exportarParaExcel()">
                                            <i class="fas fa-file-excel"></i> Exportar para Excel
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
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;"> <div class="modal-header" style="border-bottom: none;">

        </div>
            <div class="modal-body" style="color: black;">
                <p style="font-size: 1.5em; text-align: center">${msg}</p> </div>
            <div class="modal-footer" style="border-top: none;">
                <h1 class="modal-title" style="color: black; font-size: 0.8em;">aperte ESC para fechar</h1>
            </div>
        </div>
    </div>
</div>
<script>
    /* ===============================
       MENSAGEM VIA MODAL
       =============================== */
    $(document).ready(function () {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show');
            const url = "${pageContext.request.contextPath}/ServletVendas";
            $.post(url, { acao: "limparMsg" });
        }
    });

    /* ===============================
        PATCH PARA COMPATIBILIDADE DO JQUERY (MS.IE fix)
        =============================== */
    if (typeof $.browser === 'undefined') {
        $.browser = {};
        $.browser.msie = false;
    }

    /* ===============================
       NAVEGAÇÃO POR SETAS
       =============================== */
    function navigateFocusableElements(event) {
        const focusableElements = Array.from(
            document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')
        ).filter(element => !element.disabled && element.tabIndex !== -1);

        if (!focusableElements.length) return;

        const currentElement = document.activeElement;
        if (!focusableElements.includes(currentElement)) return;

        let index = focusableElements.indexOf(currentElement);

        if (event.key === 'ArrowRight' || event.key === 'ArrowDown') index++;
        if (event.key === 'ArrowLeft' || event.key === 'ArrowUp') index--;

        index = (index + focusableElements.length) % focusableElements.length;
        focusableElements[index].focus();
    }

    document.addEventListener('keydown', navigateFocusableElements);

    /* Bloqueia setas em input number */
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function (event) {
            if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                event.preventDefault();
            }
        });
    });

    /* ===============================
       DATAS (BLINDADAS)
       =============================== */
    function setData() {
        const dataInicialEl = document.getElementById("dataInicial");
        const dataFinalEl = document.getElementById("dataFinal");
        if (!dataInicialEl || !dataFinalEl || !dataInicialEl.value) return;

        const partes = dataInicialEl.value.split('-');
        const ano = parseInt(partes[0], 10);
        const mes = parseInt(partes[1], 10) - 1;

        const ultimoDia = new Date(ano, mes + 1, 0);
        dataFinalEl.value =
            ano + '-' +
            String(mes + 1).padStart(2, '0') + '-' +
            String(ultimoDia.getDate()).padStart(2, '0');
    }

    function initializeDates() {
        const dataInicialEl = document.getElementById("dataInicial");
        const dataFinalEl = document.getElementById("dataFinal");
        if (!dataInicialEl || !dataFinalEl) return;

        const today = new Date();
        const ano = today.getFullYear();
        const mes = today.getMonth();

        dataInicialEl.value =
            ano + '-' + String(mes + 1).padStart(2, '0') + '-01';

        dataFinalEl.value =
            ano + '-' + String(mes + 1).padStart(2, '0') +
            '-' + String(new Date(ano, mes + 1, 0).getDate()).padStart(2, '0');
    }

    /* ===============================
       FUNÇÕES MONETÁRIAS
       =============================== */
    function parseMoneyToNumber(value) {
        if (!value) return 0;
        value = value.toString().replace(/[R$\s]/g, '').replace(/\./g, '').replace(',', '.');
        return parseFloat(value) || 0;
    }

    function formatToCurrency(value) {
        return (Math.round(value * 100) / 100).toLocaleString('pt-BR', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }

    /* ===============================
       INICIALIZAÇÃO DAS MÁSCARAS
       =============================== */
    function initializeMasks() {
        if (typeof $.fn.maskMoney !== 'undefined') {
            $('.money').maskMoney({
                prefix: 'R$ ',
                thousands: '.',
                decimal: ',',
                allowZero: true,
                allowNegative: true,
                affixesStay: true
            });

            $('.money').each(function() {
                if ($(this).attr('readonly')) {
                    const value = parseMoneyToNumber($(this).val());
                    $(this).val(formatToCurrency(value));
                }
            });
        }
    }

    /* ===============================
       CÁLCULOS
       =============================== */
    const INPUT_IMPOSTOS = ['icms', 'pis', 'cofins', 'inss', 'irpj', 'csll'];
    const INPUT_DESPESAS_ADM = ['aluguel', 'salarios', 'contas', 'despesasGerais', 'bonificacoes', 'prestacoes', 'internet', 'outrasDesp'];

    function calculateTotalImpostos() {
        let total = 0;
        INPUT_IMPOSTOS.forEach(id => {
            const element = document.getElementById(id);
            if (element) total += parseMoneyToNumber(element.value);
        });
        document.getElementById('totalImpostos').value = formatToCurrency(total);
        document.getElementById('impostoVenda').value = formatToCurrency(total);
        calculateLucroLiquido();
    }

    function calculateTotalDespesasAdm() {
        let total = 0;
        INPUT_DESPESAS_ADM.forEach(id => {
            const element = document.getElementById(id);
            if (element) total += parseMoneyToNumber(element.value);
        });
        document.getElementById('totalDespesasAdm').value = formatToCurrency(total);
        document.getElementById('despAdm').value = formatToCurrency(total);
        calculateLucroLiquido();
    }

    function calculateLucroLiquido() {
        const lucroBruto = parseMoneyToNumber(document.getElementById('lucroBrt')?.value);
        const impostoVenda = parseMoneyToNumber(document.getElementById('impostoVenda')?.value);
        const despAdm = parseMoneyToNumber(document.getElementById('despAdm')?.value);

        const lucro = lucroBruto - impostoVenda - despAdm;

        const campo = document.getElementById('lucroLqd');
        if (campo) {
            campo.value = formatToCurrency(lucro);
            campo.style.color = lucro >= 0 ? '#28a745' : '#dc3545';
            campo.style.fontWeight = 'bold';
        }
    }

    function recalculateAll() {
        calculateTotalImpostos();
        calculateTotalDespesasAdm();
    }

    function initializeCalculations() {
        recalculateAll();
        const camposImpostos = INPUT_IMPOSTOS.map(id => document.getElementById(id)).filter(e => e);
        const camposDespesas = ['aluguel', 'bonificacoes', 'prestacoes', 'internet', 'outrasDesp']
            .map(id => document.getElementById(id)).filter(e => e);

        camposImpostos.forEach(input => {
            $(input).on('change keyup', calculateTotalImpostos);
        });

        camposDespesas.forEach(input => {
            $(input).on('change keyup', calculateTotalDespesasAdm);
        });

        const lucroBrt = document.getElementById('lucroBrt');
        if (lucroBrt) {
            $(lucroBrt).on('change keyup', calculateLucroLiquido);
        }
    }

    /* ===============================
       INICIALIZAÇÃO GERAL
       =============================== */
    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('modalDRE');
        if (modal) {
            modal.addEventListener('shown.bs.modal', function () {
                initializeDates();
                initializeMasks();
                recalculateAll();
            });
        }

        const dataInicial = document.getElementById("dataInicial");
        if (dataInicial) {
            dataInicial.addEventListener('change', setData);
        }

        initializeMasks();
        initializeCalculations();
        preencherCamposDRE(); // Chama a função de preenchimento
    });

    /* ===============================
       SUBMIT DO FORM
       =============================== */
    const EDITABLE_MONEY_FIELDS = [
        'icms', 'pis', 'cofins', 'inss', 'irpj', 'csll',
        'aluguel', 'bonificacoes', 'prestacoes', 'internet', 'outrasDesp'
    ];

    $('#formDre').on('submit', function (event) {
        EDITABLE_MONEY_FIELDS.forEach(id => {
            const input = $('#' + id);
            if (input.length > 0) {
                const valorNumerico = parseMoneyToNumber(input.val());
                $('<input>').attr({
                    type: 'hidden',
                    name: id,
                    value: valorNumerico
                }).appendTo('#formDre');
                input.prop('disabled', true);
            }
        });
        return true;
    });

    /* ===============================
       EXPORTAR EXCEL
       =============================== */
    function exportarParaExcel() {
        const paramsMap = { acao: 'exportarExcel' };
        EDITABLE_MONEY_FIELDS.forEach(id => {
            const input = document.getElementById(id);
            paramsMap[id] = parseMoneyToNumber(input?.value || '0');
        });

        paramsMap.receitaBrt = parseMoneyToNumber(document.getElementById('receitaBrt')?.value || '0');
        paramsMap.custosOpr = parseMoneyToNumber(document.getElementById('custosOpr')?.value || '0');
        paramsMap.lucroBrt = parseMoneyToNumber(document.getElementById('lucroBrt')?.value || '0');
        paramsMap.totalImpostos = parseMoneyToNumber(document.getElementById('totalImpostos')?.value || '0');
        paramsMap.totalDespesasAdm = parseMoneyToNumber(document.getElementById('totalDespesasAdm')?.value || '0');
        paramsMap.lucroLqd = parseMoneyToNumber(document.getElementById('lucroLqd')?.value || '0');

        const params = new URLSearchParams(paramsMap);
        window.location.href = '<%= request.getContextPath() %>/ServletDre?' + params.toString();
    }

    /* ===============================
       PREENCHER CAMPOS DA DRE CARREGADA
       =============================== */
    function preencherCamposDRE() {
        const campos = {
            'icms': '${icmsValue}',
            'pis': '${pisValue}',
            'cofins': '${cofinsValue}',
            'inss': '${inssValue}',
            'irpj': '${irpjValue}',
            'csll': '${csllValue}',
            'aluguel': '${aluguelValue}',
            'bonificacoes': '${bonificacoesValue}',
            'prestacoes': '${prestacoesValue}',
            'internet': '${internetValue}',
            'outrasDesp': '${outrasDespValue}',
            'obsDesp': '${obsDespValue}'
        };

        Object.keys(campos).forEach(id => {
            const valor = campos[id];
            // CORREÇÃO AQUI: Enganando a IDE/JSP Parser com concatenação
            if (valor && valor.trim() !== '' && !valor.includes('$' + '{')) {
                const input = document.getElementById(id);
                if (input) {
                    const valorNumerico = parseFloat(valor.replace(',', '.'));
                    if (!isNaN(valorNumerico)) {
                        input.value = 'R$ ' + valorNumerico.toLocaleString('pt-BR', {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        });

                    }
                }
            }
        });

        setTimeout(() => {
            recalculateAll();
        }, 100);
    }
</script>



</body>
</html>
