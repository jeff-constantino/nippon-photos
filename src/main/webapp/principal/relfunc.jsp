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
                    <div class="col-sm-4 grid-margin">


                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
<!-- Modal -->
                                            <div class="modal fade" id="modalData" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                          <div class="modal-body">

                                                            <form action="<%= request.getContextPath() %>/ServletFuncionario" method="get" id="formVendaTotal" name="formVendaTotal">
                                                                <input type="hidden" name="acao" value="imprimirVendasFuncionario">
                                                                <div class="form-row align-items-center">
                                                                    <div class="col-auto">
                                                                        <label for="dataInicial">Data Inicial</label>
                                                                        <input type="date" class="form-control" id="dataInicial" name="dataInicial" value="${dataInicial}">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <label for="dataFinal">Data Final</label>
                                                                        <input type="date" class="form-control" id="dataFinal" name="dataFinal" value="${dataFinal}">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <label>Funcionário</label>
                                                                        <select class="form-control" id="funcionarioId" name="funcionarioId" required>
                                                                            <option value="">Selecione um Funcionário</option>
                                                                            <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                <c:if test="${funcionario.status == 'ATIVO'}">
                                                                                    <option value="${funcionario.id}"
                                                                                            class="text-success"
                                                                                            <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                            ${funcionario.nome}
                                                                                    </option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                <c:if test="${funcionario.status != 'ATIVO'}">
                                                                                    <option value="${funcionario.id}"
                                                                                            class="text-danger"
                                                                                            <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                            ${funcionario.nome}
                                                                                    </option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </select>

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
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <c:if test="${not empty msg}">
                                    <div>
                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                    </div>
                                </c:if>


                                <div class="row align-items-center mb-3">
                                    <div class="col-2">
                                        <label class="float-label">ID:</label>
                                        <span class="form-bar"></span>
                                        <input type="text" class="form-control" id="FechaId"
                                               name="id" placeholder=""
                                               style="text-align: center; background-color: black" readonly
                                               value="${funcionarioId}">
                                    </div>

                                    </div>


                                <h4 class="card-title" style="text-align: center">VENDAS TOTAIS DO FUNCIONÁRIO</h4>

                                <div style="overflow-x: hidden; overflow-y: hidden;">
                                    <table class="table table-bordered" id="tabelafuncvendas">
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col">NOME</th>
                                            <th scope="col">TOTAL DE FOTOS</th>
                                            <th scope="col">TOTAL DE ENCARTES</th>
                                            <th scope="col">TOTAL DE DIGITAIS</th>
                                            <th scope="col">TOTAL DE SOBRAS</th>
                                            <th scope="col">APROVEITAMENTO</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasFuncionarioList}" var="mv">
                                            <tr>
                                                <td><c:out value="${mv.nome}"></c:out></td>
                                                <td><c:out value="${mv.ft_total}"></c:out></td>
                                                <td><c:out value="${mv.enc_total}"></c:out></td>
                                                <td><c:out value="${mv.dig_total}"></c:out></td>
                                                <td><c:out value="${mv.sobras}"></c:out></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${mv.sobras + mv.ft_total > 0}">
                                                            <fmt:formatNumber value="${(mv.ft_total * 100) / (mv.sobras + mv.ft_total)}" maxFractionDigits="2" />%
                                                        </c:when>
                                                        <c:otherwise>
                                                            0%
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>


                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>

                                    <!-- Controles de paginação -->
                                    <div class="pagination">
                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                            <a href="ServletFuncionario?acao=imprimirRelatorioVendas&pagina=${i}"
                                               class="page-link ${i == paginaAtual ? 'active' : ''}">${i}</a>
                                        </c:forEach>
                                    </div>
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

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">


                                <h4 class="card-title" STYLE="text-align: center">HISTÓRICO DE CONDUTA</h4>

                                <div  style="overflow-x: hidden; overflow-y: hidden;">
                                    <table class="table table-bordered" id="tabelafuncconduta">
                                        <thead class="thead-light">
                                        <tr>

                                            <th scope="col">TODAL DE ATRASOS</th>
                                            <th scope="col">TOTAL DE FALTAS</th>
                                            <th scope="col">TOTAL DE ADVERTÊNCIAS</th>
                                            <th scope="col">TOTAL DE SUSPENSÕES</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${}" var="hc">
                                            <tr>

                                                <td>
                                                    <c:out value="${hc.atrasos_total}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.faltas_total}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.advertencias_total}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.suspensoes_total}"></c:out>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>

                                    </table>
                                    <!-- Controles de paginação -->
                                    <div class="pagination">

                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                            <a href="ServletFuncionario?acao=imprimirRelatorioVendas&pagina=${i}" class="page-link ${i == paginaAtual ? 'active' : ''}">${i}</a>
                                        </c:forEach>

                                    </div>

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
<%-- 3 PARTE--%>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">


                                <h4 class="card-title" STYLE="text-align: center">FINANCEIRO</h4>

                                <div  style="overflow-x: hidden; overflow-y: hidden;">
                                    <table class="table table-bordered" id="tabelafuncfinanceiro">
                                        <thead class="thead-light">
                                        <tr>


                                            <th scope="col">NOME</th>

                                            <th scope="col">TODAL DE ATRASOS</th>
                                            <th scope="col">TOTAL DE FALTAS</th>
                                            <th scope="col">TOTAL DE ADVERTÊNCIAS</th>
                                            <th scope="col">TOTAL DE SUSPENSÕES</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${}" var="hc">
                                            <tr>
                                                <td>
                                                    <c:out value="${hc.nome}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.atrasos_total}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.faltas_total}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.advertencias_total}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.suspensoes_total}"></c:out>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>

                                    </table>
                                    <!-- Controles de paginação -->
                                    <div class="pagination">

                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                            <a href="ServletFuncionario?acao=imprimirRelatorioVendas&pagina=${i}" class="page-link ${i == paginaAtual ? 'active' : ''}">${i}</a>
                                        </c:forEach>

                                    </div>

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
                                <div class="row align-items-center">
                                    <table class="table table-bordered" id="tabelafuncfinanceiro2">
                                        <thead class="thead-light">
                                        <tr>

                                            <th scope="col">SALÁRIO BRUTO</th>
                                            <th scope="col">VALES</th>
                                            <th scope="col">INSS</th>
                                            <th scope="col">FGTS</th>

                                            <th scope="col">DESCONTOS TOTAIS</th>
                                            <th scope="col">SALÁRIO LIQUÍDO</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${}" var="hc">
                                            <tr>

                                                <td>
                                                    <c:out value="${hc.salario_bruto}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.vales_mes}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.inss}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.fgts}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.descontos_mes}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${hc.salario_liquido}"></c:out>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>

                                    </table>


                                </div>

                                <div class="table-responsive mt-3">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
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



    window.onload = function() {
        fetch('ServletRelVenda')
            .then(response => response.text())
            .then(data => {
                document.getElementById('resultado').innerHTML = data;
            })
            .catch(error => console.error('Erro:', error));
    }
    // Inicializa o tooltip com um delay reduzido para aparecer mais rápido
    $(document).ready(function(){
        $('#tooltipButton').tooltip({
            delay: { "show": 100, "hide": 100 } // O tooltip vai aparecer em 100ms
        });
    });
</script>
</body>
</html>
