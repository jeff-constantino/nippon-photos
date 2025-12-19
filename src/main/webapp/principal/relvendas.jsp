<%--
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
                                                    <c:if test="${not empty msg}">
                                                        <div>
                                                            <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                        </div>
                                                    </c:if>
                                                    <form action="<%= request.getContextPath() %>/ServletRelVenda" method="get" id="formDataVenda" name="formDataVenda">
                                                        <input type="hidden" name="acao" value="imprimirRelatorioVendas">
                                                        <div class="form-row align-items-center">
                                                            <div class="col-auto">
                                                                <label for="dataInicial">Data Inicial</label>
                                                                <input type="date" class="form-control" id="dataInicial" name="dataInicial" required onchange="setData()"  value="${dataInicial}">
                                                            </div>
                                                            <div class="col-auto">
                                                                <label for="dataFinal">Data Final</label>
                                                                <input type="date" class="form-control" id="dataFinal" name="dataFinal" required value="${dataFinal}">
                                                            </div>
                                                            <div class="col-auto">
                                                                <label>Funcionário</label>
                                                                <select class="form-control" id="funcionarioId" name="funcionarioId">
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
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <h4 class="card-title text-center">RELATÓRIO DE VENDAS</h4>

                                <%-- SEÇÃO DE TOTAIS NO TOPO --%>
                                <%-- Calculando os totais --%>
                                <c:set var="totalProd1Din" value="0" />
                                <c:set var="totalProd1Deb" value="0" />
                                <c:set var="totalProd1Cred" value="0" />
                                <c:set var="totalProd1Pix" value="0" />
                                <c:set var="totalProd2Din" value="0" />
                                <c:set var="totalProd2Deb" value="0" />
                                <c:set var="totalProd2Cred" value="0" />
                                <c:set var="totalProd2Pix" value="0" />
                                <c:set var="totalProd3Din" value="0" />
                                <c:set var="totalProd3Deb" value="0" />
                                <c:set var="totalProd3Cred" value="0" />
                                <c:set var="totalProd3Pix" value="0" />
                                <c:set var="totalSobras" value="0" />

                                <c:forEach items="${vendasList}" var="mv">
                                    <c:set var="totalProd1Din" value="${totalProd1Din + mv.prod1_din}" />
                                    <c:set var="totalProd1Deb" value="${totalProd1Deb + mv.prod1_deb}" />
                                    <c:set var="totalProd1Cred" value="${totalProd1Cred + mv.prod1_cred}" />
                                    <c:set var="totalProd1Pix" value="${totalProd1Pix + mv.prod1_pix}" />
                                    <c:set var="totalProd2Din" value="${totalProd2Din + mv.prod2_din}" />
                                    <c:set var="totalProd2Deb" value="${totalProd2Deb + mv.prod2_deb}" />
                                    <c:set var="totalProd2Cred" value="${totalProd2Cred + mv.prod2_cred}" />
                                    <c:set var="totalProd2Pix" value="${totalProd2Pix + mv.prod2_pix}" />
                                    <c:set var="totalProd3Din" value="${totalProd3Din + mv.prod3_din}" />
                                    <c:set var="totalProd3Deb" value="${totalProd3Deb + mv.prod3_deb}" />
                                    <c:set var="totalProd3Cred" value="${totalProd3Cred + mv.prod3_cred}" />
                                    <c:set var="totalProd3Pix" value="${totalProd3Pix + mv.prod3_pix}" />
                                    <c:set var="totalSobras" value="${totalSobras + mv.sobras}" />
                                </c:forEach>

                                <c:set var="totalFT" value="${totalProd1Din + totalProd1Deb + totalProd1Cred + totalProd1Pix}" />
                                <c:set var="totalENC" value="${totalProd2Din + totalProd2Deb + totalProd2Cred + totalProd2Pix}" />
                                <c:set var="totalDIGI" value="${totalProd3Din + totalProd3Deb + totalProd3Cred + totalProd3Pix}" />

                                <%-- Cards dos totais gerais --%>
                                <div class="row text-center mt-4 mb-4">
                                    <div class="col-md-4">
                                        <div class="card" style="background-color: #28a745;">
                                            <div class="card-body">
                                                <h5 style="color: white;">TOTAL FOTOS</h5>
                                                <h2 style="color: white; font-weight: bold;">${totalFT}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card" style="background-color: #007bff;">
                                            <div class="card-body">
                                                <h5 style="color: white;">TOTAL ENCARTES</h5>
                                                <h2 style="color: white; font-weight: bold;">${totalENC}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card" style="background-color: #ffc107;">
                                            <div class="card-body">
                                                <h5 style="color: white;">TOTAL DIGITAIS</h5>
                                                <h2 style="color: white; font-weight: bold;">${totalDIGI}</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- Tabela de resumo dos totais --%>
                                <div class="table-responsive mb-4">
                                    <table class="table table-bordered">
                                        <thead class="table-secondary">
                                        <tr>
                                            <th></th>
                                            <th>Ft Din</th>
                                            <th>Ft Deb</th>
                                            <th>Ft Cred</th>
                                            <th>Ft Pix</th>
                                            <th style="background-color: #28a745; color: white;">Total FT</th>
                                            <th>Enc Din</th>
                                            <th>Enc Deb</th>
                                            <th>Enc Cred</th>
                                            <th>Enc Pix</th>
                                            <th>Dig Din</th>
                                            <th>Dig Deb</th>
                                            <th>Dig Cred</th>
                                            <th>Dig Pix</th>
                                            <th>Sobras</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr style="font-size: 1.1rem; font-weight: bold;">
                                            <td style="color:#f2a654">TOTAL:</td>
                                            <td style="color:#f2a654">${totalProd1Din}</td>
                                            <td style="color:#f2a654">${totalProd1Deb}</td>
                                            <td style="color:#f2a654">${totalProd1Cred}</td>
                                            <td style="color:#f2a654">${totalProd1Pix}</td>
                                            <td style="color:#28a745; font-size: 1.3rem;">${totalFT}</td>
                                            <td style="color:#f2a654">${totalProd2Din}</td>
                                            <td style="color:#f2a654">${totalProd2Deb}</td>
                                            <td style="color:#f2a654">${totalProd2Cred}</td>
                                            <td style="color:#f2a654">${totalProd2Pix}</td>
                                            <td style="color:#f2a654">${totalProd3Din}</td>
                                            <td style="color:#f2a654">${totalProd3Deb}</td>
                                            <td style="color:#f2a654">${totalProd3Cred}</td>
                                            <td style="color:#f2a654">${totalProd3Pix}</td>
                                            <td style="color:#f2a654">${totalSobras}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <%-- TABELA DETALHADA COM SCROLL --%>
                                <h5 class="text-center mb-3">Detalhamento das Vendas</h5>
                                <div style="max-height: 600px; overflow-y: auto; overflow-x: auto;">
                                    <table class="table table-striped table-bordered table-hover" id="tabelarelvendas">
                                        <thead style="position: sticky; top: 0; background-color: #2a3038; z-index: 10;">
                                        <tr>
                                            <th scope="col">NOME</th>
                                            <th scope="col">DATA</th>
                                            <th scope="col">Ft Din</th>
                                            <th scope="col">Ft Deb</th>
                                            <th scope="col">Ft Cred</th>
                                            <th scope="col">Ft Pix</th>
                                            <th scope="col" style="color:#28a745;">Total FT</th>
                                            <th scope="col">Enc Din</th>
                                            <th scope="col">Enc Deb</th>
                                            <th scope="col">Enc Cred</th>
                                            <th scope="col">Enc Pix</th>
                                            <th scope="col">Dig Din</th>
                                            <th scope="col">Dig Deb</th>
                                            <th scope="col">Dig Cred</th>
                                            <th scope="col">Dig Pix</th>
                                            <th scope="col">Sobras</th>
                                            <th scope="col">Id Venda</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasList}" var="mv">
                                            <tr>
                                                <td><c:out value="${mv.nome}" /></td>
                                                <td><fmt:formatDate value="${mv.data_venda}" pattern="dd/MM/yyyy"/></td>
                                                <td><c:out value="${mv.prod1_din}" /></td>
                                                <td><c:out value="${mv.prod1_deb}" /></td>
                                                <td><c:out value="${mv.prod1_cred}" /></td>
                                                <td><c:out value="${mv.prod1_pix}" /></td>
                                                <td style="color:#daa520; font-weight:bold;">
                                                    <c:out value="${mv.prod1_din + mv.prod1_deb + mv.prod1_cred + mv.prod1_pix}" />
                                                </td>
                                                <td><c:out value="${mv.prod2_din}" /></td>
                                                <td><c:out value="${mv.prod2_deb}" /></td>
                                                <td><c:out value="${mv.prod2_cred}" /></td>
                                                <td><c:out value="${mv.prod2_pix}" /></td>
                                                <td><c:out value="${mv.prod3_din}" /></td>
                                                <td><c:out value="${mv.prod3_deb}" /></td>
                                                <td><c:out value="${mv.prod3_cred}" /></td>
                                                <td><c:out value="${mv.prod3_pix}" /></td>
                                                <td><c:out value="${mv.sobras}" /></td>
                                                <td><c:out value="${mv.venda_id}" /></td>
                                            </tr>
                                        </c:forEach>
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
<!-- container-scroller -->
<!-- plugins:js -->
<jsp:include page="pluginsJS.jsp"></jsp:include>
<!-- End custom js for this page -->


<!-- Modal HTML -->
<div class="modal" id="msgModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;">
            <div class="modal-header" style="border-bottom: none;">

            </div>
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
</script>
</body>
</html>