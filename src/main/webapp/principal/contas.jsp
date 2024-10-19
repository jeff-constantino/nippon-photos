<%@ page import="model.ModelContas" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.DAOContas" %>

<%@ page import="model.ModelVendas" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    DAOContas daoContas = new DAOContas(); // Certifique-se de que a conexão esteja configurada corretamente
    String action = request.getParameter("action");

    if ("buscarContasVencendoEm7Dias".equals(action)) {
        List<ModelContas> contasVencendo = daoContas.buscarContasVencendoEm7Dias();
        request.setAttribute("contasVencendo", contasVencendo);
    }
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
            <div class="content-wrapper">
                <div class="row">

                </div>
                <div class="row">
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                                            <!--INSERIR BOTÃO 1 AQUI--><!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal"
                                                    data-bs-target="#modalContas">
                                                <h4>Lançar Contas</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalContas" data-bs-backdrop="static"
                                                 data-bs-keyboard="false" tabindex="-1"
                                                 aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Contas </h5>

                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>

                                                        <div class="container-fluid">
                                                            <div class="page-body">

                                                                <div class="row">
                                                                    <div class="col-auto">
                                                                        <span span style="color:#f2a654">${msg}</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">


                                                                                    <form action="<%= request.getContextPath() %>/ServletContas"
                                                                                          method="post" id="lançarConta"
                                                                                          name="lançarConta">
                                                                                        <input type="hidden" name="acao"
                                                                                               value="">
                                                                                        <input type="hidden"
                                                                                               id="valorOriginal"
                                                                                               name="valorOriginal">

                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label for="dataCompra">Data
                                                                                                    da Compra</label>
                                                                                                <input type="date"
                                                                                                       class="form-control"
                                                                                                       id="data_de_pedido"
                                                                                                       name="data_de_pedido"
                                                                                                       required
                                                                                                       value="${formattedDataCompra != null ? formattedDataCompra : ''}">
                                                                                            </div>
                                                                                            <div class="col-3">
                                                                                                <label for="dataPagamento">Data
                                                                                                    de Pagamento</label>
                                                                                                <input type="date"
                                                                                                       class="form-control"
                                                                                                       id="data_de_pagamento"
                                                                                                       name="data_de_pagamento"
                                                                                                       value="${formattedDataPagamento != null ? formattedDataPagamento : ''}">
                                                                                            </div>

                                                                                            <div class="col-3">

                                                                                                <label class="float-label">Nº
                                                                                                    PEDIDO:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text"
                                                                                                       class="form-control"
                                                                                                       id="pedido"
                                                                                                       name="numero_pedido"
                                                                                                       placeholder=""
                                                                                                       style="background-color: black"
                                                                                                       value="${modelContas.numero_pedido != null ? modelContas.numero_pedido : ''}">


                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label class="float-label">EMPRESA:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text"
                                                                                                       class="form-control"
                                                                                                       id="empresa"
                                                                                                       name="empresa"
                                                                                                       placeholder=""
                                                                                                       style="background-color: black;  text-transform: uppercase;"
                                                                                                       value="${modelContas.empresa != null ? modelContas.empresa : ''}">
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="row">
                                                                                            <div class="col">
                                                                                                <div class="row">
                                                                                                    <div class="mb-3">
                                                                                                        <label style="color: #f2a654">ITENS
                                                                                                            DO
                                                                                                            PEDIDO</label>
                                                                                                        <textarea
                                                                                                                class="form-control"
                                                                                                                style="background-color: #f2a654; color: black; font-weight: bold;  text-transform: uppercase;"
                                                                                                                id="itens"
                                                                                                                name="itens"
                                                                                                                required>${modelContas.itens != null ? modelContas.itens : ''}</textarea>
                                                                                                    </div>
                                                                                                    <div class="row">
                                                                                                        <div class="col-3">
                                                                                                            <label style="color: #f2a654">VALOR</label>
                                                                                                            <div class="input-group">
                                                                                                                <div class="input-group-prepend">
                                                                                                                    <span class="input-group-text"
                                                                                                                          style="color: #f2a654; font-weight: bold">R$</span>
                                                                                                                </div>
                                                                                                                <!-- Campo de entrada para valor formatado -->
                                                                                                                <input type="text"
                                                                                                                       class="form-control"
                                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                                       id="valorExibido"
                                                                                                                       name="valorExibido"
                                                                                                                       required
                                                                                                                       oninput="formatarValor(this);"
                                                                                                                       value="${modelContas.valor != null ? modelContas.valor : ''}">
                                                                                                                <!-- Valor formatado -->

                                                                                                                <!-- Campo oculto para o valor bruto sem formatação -->
                                                                                                                <input type="hidden"
                                                                                                                       id="valorBruto"
                                                                                                                       name="valor"
                                                                                                                       value="">

                                                                                                            </div>
                                                                                                        </div>


                                                                                                        <div class="col-3">
                                                                                                            <label>STATUS</label>
                                                                                                            <select class="form-select"
                                                                                                                    id="status"
                                                                                                                    name="status"
                                                                                                                    required>
                                                                                                                <option style="color: #00d25b"
                                                                                                                        value="Pago" ${modelContas.status == 'Pago' ? 'selected' : ''}>
                                                                                                                    Pago
                                                                                                                </option>
                                                                                                                <option style="color: #bf3322"
                                                                                                                        value="A Pagar" ${modelContas.status == 'A Pagar' ? 'selected' : ''}>
                                                                                                                    A
                                                                                                                    Pagar
                                                                                                                </option>
                                                                                                            </select>
                                                                                                        </div>

                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>


                                                                                        <br>

                                                                                        <div>
                                                                                            <button class="btn btn-outline-success waves-effect waves-light">
                                                                                                Salvar
                                                                                            </button>
                                                                                            <button type="button"
                                                                                                    class="btn btn-outline-warning waves-effect waves-light"
                                                                                                    onclick="limparFormLancar();">
                                                                                                Limpar
                                                                                            </button>
                                                                                        </div>
                                                                                    </form>


                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light"
                                                                    data-bs-dismiss="modal">SAIR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                                            <!--INSERIR BOTÃO 2 AQUI-->
                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal"
                                                    data-bs-target="#modalListContas">
                                                <h4>Todas as Contas</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalListContas" data-bs-backdrop="static"
                                                 data-bs-keyboard="false" tabindex="-1"
                                                 aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5 modal-dialog-scrollable ">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticRanking">TODAS AS
                                                                CONTAS</h5>

                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <div class="col-lg-6 grid-margin stretch-card">

                                                                        <table class="table table-striped table-bordered">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>Nº Pedido</th>
                                                                                <th>Empresa</th>
                                                                                <th>Itens</th>
                                                                                <th>Valor</th>
                                                                                <th>Pedido</th>
                                                                                <th>Pagamento</th>
                                                                                <th>Status</th>
                                                                                <th>ID</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <c:choose>
                                                                                <c:when test="${not empty todasContas}"> <!-- Aqui você pode querer chamar um método que retorna todas as contas -->
                                                                                    <c:forEach var="conta"
                                                                                               items="${todasContas}">
                                                                                        <tr>
                                                                                            <td><c:out
                                                                                                    value="${conta.numero_pedido}"/></td>
                                                                                            <td><c:out
                                                                                                    value="${conta.empresa}"/></td>
                                                                                            <td><c:out
                                                                                                    value="${conta.itens}"/></td>
                                                                                            <td><fmt:formatNumber
                                                                                                    value="${conta.valor}"
                                                                                                    type="currency"
                                                                                                    currencySymbol="R$"/></td>
                                                                                            <td><fmt:formatDate
                                                                                                    value="${conta.data_de_pedido}"
                                                                                                    pattern="dd/MM/yyyy"/></td>
                                                                                            <td><fmt:formatDate
                                                                                                    value="${conta.data_de_pagamento}"
                                                                                                    pattern="dd/MM/yyyy"/></td>
                                                                                            <td><c:out
                                                                                                    value="${conta.status}"/></td>
                                                                                            <td><c:out
                                                                                                    value="${conta.conta_id}"/></td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <tr>
                                                                                        <td colspan="8">Nenhuma conta
                                                                                            encontrada.
                                                                                        </td>
                                                                                    </tr>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>


                                                                </div>

                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light"
                                                                    data-bs-dismiss="modal">SAIR
                                                            </button>
                                                            <button type="button" class="btn btn-outline-warning">
                                                                ENVIAR
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>


                                    </div>


                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">


                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                                    data-bs-target="#modalBaixarVenda">
                                                <h4>Baixar Conta</h4>
                                            </button>

                                            <div class="modal fade" id="modalBaixarVenda" data-bs-backdrop="static"
                                                 data-bs-keyboard="false" tabindex="-1"
                                                 aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Baixar Conta</h5>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="<%= request.getContextPath() %>/ServletContas" method="post" id="formBaixarVenda">
                                                                <input type="hidden" name="acao" value="baixar"/>
                                                                <div class="col-3">
                                                                    <label for="numero_pedido" class="form-label">Número do Pedido:</label>
                                                                    <div class="input-group">
                                                                        <input type="text" class="form-control" id="numero_pedido" name="numero_pedido" required placeholder="Digite o Nº do pedido"/>
                                                                        <button type="submit" class="btn btn-outline-success">Baixar</button>
                                                                    </div>
                                                                </div>
                                                            </form>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light"
                                                                    data-bs-dismiss="modal">Sair
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <span style="color:#1ad76b; text-align: center">${msg}</span>
                                    <h4 class="card-title">PAGINA INICIAL</h4>
                                    <div class="table-responsive">


                                        <form action="<%= request.getContextPath() %>/ServletContas" method="post"
                                              style="overflow-x: hidden" id="formContas">


                                            <div class="row">
                                                <div class="col-3">
                                                    <label for="data_de_pedido2">Data da Compra</label>
                                                    <input type="date" class="form-control" id="data_de_pedido2"
                                                           name="data_de_pedido" required
                                                           value="${formattedDataCompra != null ? formattedDataCompra : ''}">
                                                </div>
                                                <div class="col-3">
                                                    <label for="data_de_pagamento2">Data de Pagamento</label>
                                                    <input type="date" class="form-control" id="data_de_pagamento2"
                                                           name="data_de_pagamento"
                                                           value="${formattedDataPagamento != null ? formattedDataPagamento : ''}">
                                                </div>
                                                <div class="col-2">
                                                    <label class="float-label">Nº PEDIDO:</label>
                                                    <input type="text" class="form-control" id="pedido2"
                                                           name="numero_pedido" placeholder=""
                                                           style="background-color: black"
                                                           value="${modelContas.numero_pedido != null ? modelContas.numero_pedido : ''}">
                                                </div>
                                                <div class="col-4">
                                                    <label class="float-label">ID:</label>
                                                    <input type="text" class="form-control" id="idPedido"
                                                           name="idPedido" placeholder=""
                                                           style="background-color: black; text-transform: uppercase;"
                                                           value="${modelContas.conta_id != null ? modelContas.conta_id : ''}">
                                                </div>
                                            </div>


                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <label class="float-label">EMPRESA:</label>
                                                            <span class="form-bar"></span>
                                                            <input type="text" class="form-control"
                                                                   id="empresa2" name="empresa" placeholder=""
                                                                   style="background-color: black;  text-transform: uppercase;"
                                                                   value="${modelContas.empresa != null ? modelContas.empresa : ''}">
                                                        </div>
                                                        <div class="mb-3">
                                                            <label style="color: #f2a654">ITENS DO PEDIDO</label>
                                                            <textarea class="form-control"
                                                                      style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;"
                                                                      id="itens2" name="itens"
                                                                      required>${modelContas.itens != null ? modelContas.itens : ''}</textarea>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-3">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-prepend">
                                                                        <span class="input-group-text"
                                                                              style="color: #f2a654; font-weight: bold">R$</span>
                                                                    </div>
                                                                    <input type="text" class="form-control"
                                                                           style="background-color: #f2a654; color: black; font-weight: bold"
                                                                           id="valor2" name="valor2"
                                                                           required oninput="formatarValor(this);">
                                                                    <!-- Outro valor -->

                                                                    <!-- Campo oculto para o valor bruto do segundo campo -->
                                                                    <input type="hidden" id="valorBruto2" name="valor2"
                                                                           value="">
                                                                </div>
                                                            </div>

                                                            <div class="col-3">
                                                                <label>STATUS</label>
                                                                <select class="form-select" id="status2" name="status"
                                                                        required>
                                                                    <option style="color: #00d25b"
                                                                            value="PAGO" ${modelContas.status == 'PAGO' ? 'selected' : ''}>
                                                                        PAGO
                                                                    </option>
                                                                    <option style="color: #bf3322"
                                                                            value="A PAGAR" ${modelContas.status == 'A PAGAR' ? 'selected' : ''}>
                                                                        A PAGAR
                                                                    </option>
                                                                </select>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <br>

                                            <div>
                                                <input type="hidden" name="acao" value="atualizar">
                                                <button type="submit" class="btn btn-outline-success">Atualizar</button>
                                                <button type="button"
                                                        class="btn btn-outline-warning waves-effect waves-light"
                                                        onclick="limparFormContas();">Limpar
                                                </button>
                                                <button type="button"
                                                        class="btn btn-outline-danger waves-effect waves-light"
                                                        onclick="deletaConta();">Excluir Conta
                                                </button>
                                            </div>
                                        </form>


                                    </div>
                                    <div class="row ">
                                        <div class="col-12 grid-margin">
                                            <div class="card">
                                                <div class="card-body">

                                                    <div class="table-responsive">
                                                        <h2 style="text-align: center">CONTAS DOS ÚLTIMOS 60 DIAS</h2>
                                                        <table class="table table-striped table-bordered">
                                                            <thead>
                                                            <tr>
                                                                <th>Opções</th>
                                                                <th>Nº Pedido</th>
                                                                <th>Empresa</th>
                                                                <th>Itens</th>
                                                                <th>Valor</th>
                                                                <th>Pedido</th>
                                                                <th>Pagamento</th>
                                                                <th>Status</th>
                                                                <th>ID</th>


                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:choose>
                                                                <c:when test="${not empty contasRecentes}">
                                                                    <c:forEach var="conta" items="${contasRecentes}">
                                                                        <tr>
                                                                            <td>
                                                                                <button class="btn btn-outline-primary"
                                                                                        onclick="editarConta(this, '${conta.conta_id}', '${conta.data_de_pedido}', '${conta.data_de_pagamento}', '${conta.valor}', '${conta.status}', '${conta.itens}', '${conta.numero_pedido}', '${conta.empresa}')">
                                                                                    Editar
                                                                                </button>
                                                                            </td>
                                                                            <td><c:out
                                                                                    value="${conta.numero_pedido}"/></td>
                                                                            <td><c:out value="${conta.empresa}"/></td>
                                                                            <td><c:out value="${conta.itens}"/></td>
                                                                            <td><fmt:formatNumber value="${conta.valor}"
                                                                                                  type="currency"
                                                                                                  currencySymbol="R$"/></td>
                                                                            <td><fmt:formatDate
                                                                                    value="${conta.data_de_pedido}"
                                                                                    pattern="dd/MM/yyyy"/></td>
                                                                            <td><fmt:formatDate
                                                                                    value="${conta.data_de_pagamento}"
                                                                                    pattern="dd/MM/yyyy"/></td>
                                                                            <td><c:out value="${conta.status}"/></td>
                                                                            <td><c:out value="${conta.conta_id}"/></td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <tr>
                                                                        <td colspan="7">Nenhuma conta encontrada.</td>
                                                                    </tr>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            </tbody>

                                                        </table>
                                                    </div>

                                                </div>
                                            </div>
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
                <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;">
                    <div class="modal-header" style="border-bottom: none;">
                        <h5 class="modal-title">Mensagem</h5>
                    </div>
                    <div class="modal-body" style="color: black;">
                        <p style="font-size: 1.5em; text-align: center">${msg}</p> <!-- Mensagem aqui -->
                    </div>
                    <div class="modal-footer" style="border-top: none;">
                        <h1 class="modal-title" style="color: black; font-size: 0.8em;">Aperte ESC para fechar</h1>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>


            $(document).ready(function () {
                var msg = "${msg}";
                if (msg) {
                    $('#msgModal').modal('show'); // Exibe o modal com a mensagem
                }
            });


            function editarConta(button, conta_id, dataPedido, dataPagamento, valor, status, itens, numeroPedido, empresa) {
                // Preencher os campos do formulário com os dados da conta
                document.getElementById('idPedido').value = conta_id; // ID da conta
                document.getElementById('data_de_pedido2').value = formatarData(dataPedido); // Data de Pedido
                document.getElementById('data_de_pagamento2').value = formatarData(dataPagamento); // Data de Pagamento
                document.getElementById('pedido2').value = numeroPedido; // Número do Pedido
                document.getElementById('itens2').value = itens; // Itens do Pedido
                document.getElementById('valor2').value = valor; // Valor
                document.getElementById('status2').value = status; // Status

                // Preencher o campo EMPRESA
                document.getElementById('empresa2').value = empresa; // Preenche o campo EMPRESA

                // Caso precise manipular o valor bruto, descomente a linha abaixo
                document.getElementById('valorBruto2').value = valor; // Valor bruto, se necessário
            }


            // Função para formatar a data no formato 'yyyy-mm-dd' para o campo date
            function formatarData(data) {
                const partes = data.split('/');
                return partes[2] + '-' + partes[1] + '-' + partes[0]; // Converte 'dd/MM/yyyy' para 'yyyy-MM-dd'
            }


            function formatarData(data) {
                // Função para formatar a data no formato 'yyyy-MM-dd' (necessário para input type="date")
                var partes = data.split('/');
                if (partes.length === 3) {
                    return `${partes[2]}-${partes[1]}-${partes[0]}`; // Converte 'dd/MM/yyyy' para 'yyyy-MM-dd'
                }
                return data;
            }


            function formatarValor(input) {
                // Remove caracteres não numéricos
                let valor = input.value.replace(/\D/g, '');

                // Formata o valor para exibição
                if (valor) {
                    valor = (valor / 100).toFixed(2); // Converte para formato decimal
                    valor = valor.replace('.', ','); // Troca ponto por vírgula

                    // Adiciona separadores de milhar
                    valor = valor.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
                }

                // Atualiza o campo de exibição
                input.value = valor;

                // Atualiza o campo oculto com o valor sem formatação
                const valorSemFormatacao = valor.replace(/\./g, '').replace(',', '.'); // Remove formatação e usa ponto como separador decimal

                // Atualiza o campo oculto correspondente
                if (input.id === "valorExibido") {
                    document.getElementById('valorBruto').value = valorSemFormatacao; // Atualiza o campo oculto para valorExibido
                } else if (input.id === "valor2") {
                    document.getElementById('valorBruto2').value = valorSemFormatacao; // Atualiza o campo oculto para valor2
                }
            }

            function deletaConta() {
                const contaID = document.getElementById('idPedido').value; // Obtém o ID da conta
                if (confirm("Tem certeza que deseja excluir a conta " + contaID + "?")) {
                    $.ajax({
                        method: 'GET', // Mudando para GET
                        url: '<%= request.getContextPath() %>/ServletContas',
                        data: {acao: 'deletar', conta_id: contaID}, // Usando conta_id
                        success: function (response) {
                            alert("Conta excluída com sucesso!");
                            location.reload(); // Atualiza a página
                        },
                        error: function (xhr, status, errorThrown) {
                            alert('Erro ao excluir a conta: ' + xhr.responseText);
                        }
                    });
                }
            }


            function limparFormContas() {
                // Limpa os campos do formulário
                $('#formContas')[0].reset();
            }

            function limparFormLancar() {
                // Limpa os campos do formulário
                $('#lançarConta')[0].reset();
            }


        </script>


</body>
</html>