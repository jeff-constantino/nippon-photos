<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelVendas" %>
<%@ page import="model.ModelContas" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            <div class="content-wrapper" style="min-height: calc(92vh - 70px);">
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

                                                <a class="nav-link" href="<%= request.getContextPath() %>/ServletVendas" style="font-size: large;color: #f5c102; font-weight: bold"> Vendas </a>
                                            </button>

                                            <!-- Modal -->


                            </div>

                        </div>
                        <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                            <a class="icon-lg mdi mdi-hexagon-multiple text-warning ml-auto"
                               href="<%= request.getContextPath() %>/principal/vendas.jsp"></a>

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
                                <a class="nav-link" href="<%= request.getContextPath() %>/ServletFechaDia" style="font-size: large;color: red; font-weight: bold"> Finalizar Dia </a>

                                <!-- Modal -->

                            </div>

                        </div>
                        <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                            <a class="icon-lg mdi mdi-power text-danger ml-auto"
                               href="<%= request.getContextPath() %>/ServletFechaDia"></a>
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
                                 <div class="table-responsive">
                                     <h2 class="text-center">CONTAS A PAGAR NOS PRÓXIMOS 7 DIAS</h2>
                                    <table class="table table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>Número do Pedido</th>
                                            <th>Empresa</th>
                                            <th>Itens</th>
                                            <th>Valor</th>
                                            <th>Data de Pedido</th>
                                            <th>Data de Pagamento</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${not empty contasVencendo}">
                                                <c:forEach var="conta" items="${contasVencendo}">
                                                    <tr>
                                                        <td><c:out value="${conta.numero_pedido}"/></td>
                                                        <td><c:out value="${conta.empresa}"/></td>
                                                        <td><c:out value="${conta.itens}"/></td>
                                                        <td><fmt:formatNumber value="${conta.valor}" type="currency" currencySymbol="R$" /></td>
                                                        <td><fmt:formatDate value="${conta.data_de_pedido}" pattern="dd/MM/yyyy"/></td>
                                                        <td><fmt:formatDate value="${conta.data_de_pagamento}" pattern="dd/MM/yyyy"/></td>

                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6">Nenhuma conta vencendo nos próximos 7 dias.</td>
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
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <h2 class="text-center">CONTAS ATRASADAS</h2>
                                    <table class="table table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>Número do Pedido</th>
                                            <th>Empresa</th>
                                            <th>Itens</th>
                                            <th>Valor</th>
                                            <th>Data de Pedido</th>
                                            <th>Data de Pagamento</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${not empty contasVencidas}">
                                                <c:forEach var="conta" items="${contasVencidas}">
                                                    <tr>
                                                        <td><c:out value="${conta.numero_pedido}"/></td>
                                                        <td><c:out value="${conta.empresa}"/></td>
                                                        <td><c:out value="${conta.itens}"/></td>
                                                        <td><fmt:formatNumber value="${conta.valor}" type="currency" currencySymbol="R$" /></td>
                                                        <td><fmt:formatDate value="${conta.data_de_pedido}" pattern="dd/MM/yyyy"/></td>
                                                        <td><fmt:formatDate value="${conta.data_de_pagamento}" pattern="dd/MM/yyyy"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6" class="text-center">Nenhuma conta vencida.</td>
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
<!-- content-wrapper ends -->
<!-- partial:partials/_footer.html -->
<jsp:include page="footer.jsp"></jsp:include>
<!-- partial -->
</div>
<!-- main-panel ends -->
</div>
<!-- page-body-wrapper ends -->
</div>




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




<script type="text/javascript">


   $(document).ready(function () {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem

            // Remove a mensagem da sessão após exibi-la
            $.post("${pageContext.request.contextPath}/ServletVendas", { acao: "limparMsg" });
        }
    });
       $(function () {

        $("#dataVenda").datepicker({
            dateFormat: 'dd/mm/yy',
            dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
            dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S', 'D'],
            dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
            monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
            monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
            nextText: 'Próximo',
            prevText: 'Anterior'
        });
    });

    function limparFormVendas(){
        var elementos =document.getElementById("formUser").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }


</script>
<!-- container-scroller -->
<!-- plugins:js -->
<jsp:include page="pluginsJS.jsp"></jsp:include>
<!-- End custom js for this page -->
</body>
</html>
