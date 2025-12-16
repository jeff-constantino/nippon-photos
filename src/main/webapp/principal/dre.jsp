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
                                                <!-- Card 1 -->
                                                <h2 style="text-transform: uppercase;">${mesAno}</h2>
                                            </div>



                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">
                                                <h4>Configurações Gerais</h4>
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


                                    <!-- Modal -->
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
                                                            <div class="alert alert-info">
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


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!--INSERIR BOTÃO 2 AQUI-->
                                    <!-- Button trigger modal -->


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticRanking">RANKING</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <div class="col-lg-6 grid-margin stretch-card">
                                                                <H5>CORPO DO RANKING</H5>
                                                            </div>




                                                        </div>

                                                    </div>

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


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!--INSERIR BOTÃO 3 AQUI-->
                                    <!-- Button trigger modal -->


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticFinalizar">FINALIZAR</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <div class="col-lg-6 grid-margin stretch-card">
                                                                <H5>CORPO DA FINALIZAÇÃO</H5>
                                                            </div>




                                                        </div>

                                                    </div>

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
                                <form method="post" action="<%=request.getContextPath()%>/ServletDre">
                                    <input type="hidden" name="acao" value="gravarDRE">
                                    <h4 class="card-title" style="text-align: center">IMPOSTOS SOBRE VENDAS</h4>
                                    <div class="row">
                                        <div class="col-6 mb-3">
                                            <label for="icms" style="font-size: 1.0rem;">ICMS</label>
                                            <input type="text" class="form-control money" id="icms" name="icms" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="pis" style="font-size: 1.0rem;">PIS</label>
                                            <input type="text" class="form-control money" id="pis" name="pis" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="cofins" style="font-size: 1.0rem;">COFINS</label>
                                            <input type="text" class="form-control money" id="cofins" name="cofins" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="inss" style="font-size: 1.0rem;">INSS</label>
                                            <input type="text" class="form-control money" id="inss" name="inss" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="irpj" style="font-size: 1.0rem;">IRPJ</label>
                                            <input type="text" class="form-control money" id="irpj" name="irpj" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="csll" style="font-size: 1.0rem;">CSLL</label>
                                            <input type="text" class="form-control money" id="csll" name="csll" style="font-size: 1.0rem;">
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
                                            <label for="aluguel" style="font-size: 1.0rem;">Aluguel</label>
                                            <input type="text" class="form-control money" id="aluguel" name="aluguel" style="font-size: 1.0rem;">
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
                                            <input type="text" class="form-control money" id="bonificacoes" name="bonificacoes" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="prestacoes" style="font-size: 1.0rem;">Prestações de Equipamentos</label>
                                            <input type="text" class="form-control money" id="prestacoes" name="prestacoes" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="internet" style="font-size: 1.0rem;">Internet</label>
                                            <input type="text" class="form-control money" id="internet" name="internet" style="font-size: 1.0rem;">
                                        </div>
                                        <div class="col-6 mb-3">
                                            <label for="outrasDesp" style="font-size: 1.0rem;">Outras Despesas</label>
                                            <input type="text" class="form-control money" id="outrasDesp" name="outrasDesp" style="font-size: 1.0rem;">
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
                                    <!-- NOVO BOTÃO EXPORTAR EXCEL -->
                                    <div style="text-align: center; margin-top: 10px;">
                                        <button type="button" class="btn btn-outline-primary" style="font-size: large"
                                                onclick="exportarParaExcel()">
                                            <i class="fas fa-file-excel"></i> Exportar para Excel
                                        </button>
                                    </div>
                                </form>
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
       const modal = document.getElementById('modalDRE'); // Substitua 'meuModal' pelo ID do seu modal
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

   // CALCULOS DA DRE
   // Função para converter valor monetário para número
   function parseMoneyToNumber(value) {
       if (!value) return 0;
       let cleanValue = value.toString().trim();

       // Remove símbolos de moeda (R$, espaços, etc.)
       cleanValue = cleanValue.replace(/[R$\s]/g, '');

       // Se já está formatado como moeda brasileira (tem vírgula)
       if (cleanValue.includes(',')) {
           // Remove pontos (separadores de milhares) e substitui vírgula por ponto
           cleanValue = cleanValue.replace(/\./g, '').replace(',', '.');
           return parseFloat(cleanValue) || 0;
       }

       // Se é só números ou tem apenas pontos
       if (cleanValue.includes('.')) {
           // Verifica se tem mais de um ponto (formato brasileiro: 1.234.567)
           const pontosCount = (cleanValue.match(/\./g) || []).length;
           if (pontosCount > 1) {
               // É formato brasileiro com separadores de milhares, remove pontos
               return parseFloat(cleanValue.replace(/\./g, '')) || 0;
           } else {
               // É um decimal normal (formato americano: 1234.56)
               return parseFloat(cleanValue) || 0;
           }
       }

       // É apenas números inteiros
       return parseFloat(cleanValue) || 0;
   }

   // Função para formatar número como moeda brasileira
   function formatToCurrency(value) {
       // Arredonda para 2 casas decimais para evitar problemas de precisão
       const roundedValue = Math.round(value * 100) / 100;

       return roundedValue.toLocaleString('pt-BR', {
           minimumFractionDigits: 2,
           maximumFractionDigits: 2
       });
   }

   // Função para calcular total dos impostos
   function calculateTotalImpostos() {
       const icms = parseMoneyToNumber(document.getElementById('icms').value);
       const pis = parseMoneyToNumber(document.getElementById('pis').value);
       const cofins = parseMoneyToNumber(document.getElementById('cofins').value);
       const inss = parseMoneyToNumber(document.getElementById('inss').value);
       const irpj = parseMoneyToNumber(document.getElementById('irpj').value);
       const csll = parseMoneyToNumber(document.getElementById('csll').value);

       const total = icms + pis + cofins + inss + irpj + csll;

       // Atualiza o campo total impostos
       document.getElementById('totalImpostos').value = formatToCurrency(total);

       // Atualiza o campo impostos sobre vendas no bloco cálculo financeiro
       document.getElementById('impostoVenda').value = formatToCurrency(total);

       // Recalcula o lucro líquido
       calculateLucroLiquido();
   }

   // Função para calcular total das despesas administrativas
   function calculateTotalDespesasAdm() {
       const aluguel = parseMoneyToNumber(document.getElementById('aluguel').value);
       const salarios = parseMoneyToNumber(document.getElementById('salarios').value);
       const contas = parseMoneyToNumber(document.getElementById('contas').value);
       const despesasGerais = parseMoneyToNumber(document.getElementById('despesasGerais').value);
       const bonificacoes = parseMoneyToNumber(document.getElementById('bonificacoes').value);
       const prestacoes = parseMoneyToNumber(document.getElementById('prestacoes').value);
       const internet = parseMoneyToNumber(document.getElementById('internet').value);
       const outrasDesp = parseMoneyToNumber(document.getElementById('outrasDesp').value);

       const total = aluguel + salarios + contas + despesasGerais + bonificacoes + prestacoes + internet + outrasDesp;

       // Atualiza o campo total despesas administrativas
       document.getElementById('totalDespesasAdm').value = formatToCurrency(total);

       // Atualiza o campo despesas administrativas no bloco cálculo financeiro
       document.getElementById('despAdm').value = formatToCurrency(total);

       // Recalcula o lucro líquido
       calculateLucroLiquido();
   }

   // Função para calcular o lucro líquido
   function calculateLucroLiquido() {
       const lucroBruto = parseMoneyToNumber(document.getElementById('lucroBrt').value);
       const impostoVenda = parseMoneyToNumber(document.getElementById('impostoVenda').value);
       const despAdm = parseMoneyToNumber(document.getElementById('despAdm').value);

       const lucroLiquido = lucroBruto - impostoVenda - despAdm;

       // Atualiza o campo lucro líquido
       document.getElementById('lucroLqd').value = formatToCurrency(lucroLiquido);

       // Aplica cor baseada no resultado
       const lucroField = document.getElementById('lucroLqd');
       if (lucroLiquido > 0) {
           lucroField.style.color = '#28a745'; // Verde para lucro
           lucroField.style.fontWeight = 'bold';
       } else if (lucroLiquido < 0) {
           lucroField.style.color = '#dc3545'; // Vermelho para prejuízo
           lucroField.style.fontWeight = 'bold';
       } else {
           lucroField.style.color = '#000000'; // Cinza para zero
           lucroField.style.fontWeight = 'bold';
       }
   }

   // Função para aplicar máscara monetária enquanto digita
   function applyMoneyMask(input) {
       let value = input.value.replace(/\D/g, ''); // Remove tudo que não é dígito

       if (value === '') {
           input.value = '';
           return;
       }

       // Converte para número e divide por 100 para obter os centavos
       let numericValue = parseInt(value) / 100;

       // Formata como moeda brasileira
       input.value = numericValue.toLocaleString('pt-BR', {
           minimumFractionDigits: 2,
           maximumFractionDigits: 2
       });
   }

   // Função para verificar se o campo está readonly
   function isFieldReadonly(field) {
       return field.hasAttribute('readonly') || field.readOnly;
   }

   // Função para adicionar máscara monetária aos campos
   function addMoneyMaskToFields() {
       // Campos de impostos
       const impostoFields = ['icms', 'pis', 'cofins', 'inss', 'irpj', 'csll'];

       // Campos de despesas administrativas
       const despesaFields = ['aluguel', 'salarios', 'contas', 'despesasGerais', 'bonificacoes', 'prestacoes', 'internet', 'outrasDesp'];

       // Combina todos os campos que precisam de máscara
       const allFields = [...impostoFields, ...despesaFields];

       allFields.forEach(fieldId => {
           const field = document.getElementById(fieldId);
           if (field) {
               // Evento para aplicar máscara enquanto digita (só se não for readonly)
               field.addEventListener('input', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       applyMoneyMask(e.target);
                   }
               });

               // Evento para garantir formatação ao sair do campo (só se não for readonly)
               field.addEventListener('blur', function(e) {
                   if (!isFieldReadonly(e.target) && e.target.value && !e.target.value.includes(',')) {
                       // Se o valor não tem vírgula, adiciona ,00
                       if (e.target.value) {
                           let numericValue = parseFloat(e.target.value.replace(/\./g, ''));
                           if (!isNaN(numericValue)) {
                               e.target.value = numericValue.toLocaleString('pt-BR', {
                                   minimumFractionDigits: 2,
                                   maximumFractionDigits: 2
                               });
                           }
                       }
                   }
               });

               // Permite apenas números, vírgula e ponto (só se não for readonly)
               field.addEventListener('keypress', function(e) {
                   if (isFieldReadonly(e.target)) return;

                   const allowedKeys = ['Backspace', 'Delete', 'ArrowLeft', 'ArrowRight', 'Tab'];
                   if (allowedKeys.includes(e.key)) return;

                   if (!/\d/.test(e.key)) {
                       e.preventDefault();
                   }
               });

               // NOVO: Previne a reaplicação de máscara em campos readonly quando recebem foco
               field.addEventListener('focus', function(e) {
                   if (isFieldReadonly(e.target)) {
                       // Remove o foco imediatamente para evitar problemas
                       e.target.blur();
                   }
               });
           }
       });
   }

   // NOVA FUNÇÃO: Para definir valor em campo sem disparar eventos de máscara
   function setFieldValueSafely(fieldId, value) {
       const field = document.getElementById(fieldId);
       if (field) {
           // Temporariamente remove os event listeners
           const isReadonly = isFieldReadonly(field);

           // Tratamento especial para o campo "contas" - força arredondamento para 2 casas decimais
           if (fieldId === 'contas') {
               let numValue;
               if (typeof value === 'number') {
                   numValue = value;
               } else if (typeof value === 'string') {
                   numValue = parseFloat(value);
               }

               if (!isNaN(numValue)) {
                   // Arredonda para 2 casas decimais para evitar problemas de precisão
                   const roundedValue = Math.round(numValue * 100) / 100;
                   field.value = formatToCurrency(roundedValue);
                   return;
               }
           }

           // Se não é readonly, aplica formatação
           if (!isReadonly) {
               if (typeof value === 'number') {
                   field.value = formatToCurrency(value);
               } else {
                   field.value = value;
               }
           } else {
               // Para campos readonly, define o valor diretamente formatado
               if (typeof value === 'number') {
                   field.value = formatToCurrency(value);
               } else if (typeof value === 'string' && value.includes('.') && !value.includes(',')) {
                   // Se recebeu um valor decimal com ponto, converte para formato brasileiro
                   const numValue = parseFloat(value);
                   if (!isNaN(numValue)) {
                       field.value = formatToCurrency(numValue);
                   } else {
                       field.value = value;
                   }
               } else {
                   field.value = value;
               }
           }
       }
   }

   // Função para inicializar todos os event listeners
   function initializeCalculations() {
       // Inicializa as máscaras monetárias
       addMoneyMaskToFields();

       // Event listeners para campos de impostos (só para campos não readonly)
       const impostoFields = ['icms', 'pis', 'cofins', 'inss', 'irpj', 'csll'];
       impostoFields.forEach(fieldId => {
           const field = document.getElementById(fieldId);
           if (field) {
               field.addEventListener('input', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       calculateTotalImpostos();
                   }
               });
               field.addEventListener('blur', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       calculateTotalImpostos();
                   }
               });
           }
       });

       // Event listeners para campos de despesas administrativas (só para campos não readonly)
       const despesaFields = ['aluguel', 'salarios', 'contas', 'despesasGerais', 'bonificacoes', 'prestacoes', 'internet', 'outrasDesp'];
       despesaFields.forEach(fieldId => {
           const field = document.getElementById(fieldId);
           if (field) {
               field.addEventListener('input', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       calculateTotalDespesasAdm();
                   }
               });
               field.addEventListener('blur', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       calculateTotalDespesasAdm();
                   }
               });
           }
       });

       // Event listeners para campos do cálculo financeiro que podem afetar o lucro líquido
       const calculoFields = ['lucroBrt', 'impostoVenda', 'despAdm'];
       calculoFields.forEach(fieldId => {
           const field = document.getElementById(fieldId);
           if (field) {
               field.addEventListener('input', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       calculateLucroLiquido();
                   }
               });
               field.addEventListener('blur', function(e) {
                   if (!isFieldReadonly(e.target)) {
                       calculateLucroLiquido();
                   }
               });
           }
       });

       // Calcula os valores iniciais quando a página carrega
       calculateTotalImpostos();
       calculateTotalDespesasAdm();
       calculateLucroLiquido();
   }

   // Função para recalcular tudo quando dados vêm do backend
   function recalculateAll() {
       calculateTotalImpostos();
       calculateTotalDespesasAdm();
       calculateLucroLiquido();
   }

   // NOVA FUNÇÃO: Para usar quando preencher campos via AJAX/Backend
   function populateFieldFromBackend(fieldId, value) {
       setFieldValueSafely(fieldId, value);
   }

   // Inicializa quando o DOM estiver carregado
   document.addEventListener('DOMContentLoaded', function() {
       initializeCalculations();
   });

   // Também inicializa quando o modal é aberto (caso os dados venham depois)
   document.addEventListener('shown.bs.modal', function() {
       setTimeout(() => {
           recalculateAll();
       }, 100);
   });

   // Funções globais para usar externamente
   window.recalculateDRE = recalculateAll;
   window.populateFieldFromBackend = populateFieldFromBackend;
   window.setFieldValueSafely = setFieldValueSafely;

   $('#formDre').submit(function() {
       const receitaBruta = parseMoneyToNumber($('#receitaBrt').val());
       const custosOpr = parseMoneyToNumber($('#custosOpr').val());

       $('#hiddenReceitaBruta').val(receitaBruta);
       $('#hiddenCustosOpr').val(custosOpr);
       $('#hiddenLucroBrt').val(receitaBruta - custosOpr);

       // Os outros campos já estão em modo readonly, mas é bom garantir
       const salarios = parseMoneyToNumber($('#salarios').val());
       const contas = parseMoneyToNumber($('#contas').val());
       const despesasGerais = parseMoneyToNumber($('#despesasGerais').val());

       $('#hiddenSalarios').val(salarios);
       $('#hiddenContas').val(contas);
       $('#hiddenDespesasGerais').val(despesasGerais);
   });
   function exportarParaExcel() {
       // Pega todos os valores dos campos
       const params = new URLSearchParams({
           acao: 'exportarExcel',
           icms: document.getElementById('icms').value || '0',
           pis: document.getElementById('pis').value || '0',
           cofins: document.getElementById('cofins').value || '0',
           inss: document.getElementById('inss').value || '0',
           irpj: document.getElementById('irpj').value || '0',
           csll: document.getElementById('csll').value || '0',
           aluguel: document.getElementById('aluguel').value || '0',
           bonificacoes: document.getElementById('bonificacoes').value || '0',
           prestacoes: document.getElementById('prestacoes').value || '0',
           internet: document.getElementById('internet').value || '0',
           outrasDesp: document.getElementById('outrasDesp').value || '0'
       });

       // Abre o download em nova janela
       window.location.href = '<%= request.getContextPath() %>/ServletDre?' + params.toString();
   }
</SCRIPT>


</body>
</html>
