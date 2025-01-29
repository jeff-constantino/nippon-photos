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

                                                            <form action="<%= request.getContextPath() %>/ServletRelMes" method="get" id="formBuscaMes" name="formBuscaMes">
                                                                <input type="hidden" name="acao" value="relatorioMes">
                                                                <div class="form-row align-items-center">
                                                                    <div class="col-auto">
                                                                        <label for="dataInicial">Data Inicial</label>
                                                                        <input type="date" class="form-control" id="dataInicial" name="dataInicial" required value="${dataInicial}">
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
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">


                                <h4 class="card-title" style="text-align: center">RELATÓRIO DE VENDAS</h4>

                                <div style="overflow-x: hidden">
                                    <table class="table table-bordered" id="tabelames">
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col">DATA</th>
                                            <th scope="col">TOTAL DE FOTOS</th>
                                            <th scope="col">TOTAL DE ENCARTES</th>
                                            <th scope="col">TOTAL DE DIGITAIS</th>
                                            <th scope="col">TOTAL DE SOBRAS</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasMes}" var="vm">
                                            <tr>
                                                <td><c:out value="${vl.data_fechamento}"></c:out></td>
                                                <td><c:out value="${vl.total_ft}"></c:out></td>
                                                <td><c:out value="${vl.total_enc}"></c:out></td>
                                                <td><c:out value="${vl.total_dig}"></c:out></td>
                                                <td><c:out value="${vl.total_sobras}"></c:out></td>


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
                                <h4 class="card-title" style="text-align: center">RELATÓRIO POR DIA</h4>

                                <div style="overflow-x: hidden">
                                    <table class="table table-bordered" id="tabelavendasmes">
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col">DATA</th>
                                            <th scope="col">TOTAL DE FOTOS</th>
                                            <th scope="col">TOTAL DE ENCARTES</th>
                                            <th scope="col">TOTAL DE DIGITAIS</th>
                                            <th scope="col">TOTAL DE SOBRAS</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasMesList}" var="vl">
                                            <tr>
                                                <td><c:out value="${vl.formattedDate}"></c:out></td>
                                                <td><c:out value="${vl.total_ft}"></c:out></td>
                                                <td><c:out value="${vl.total_enc}"></c:out></td>
                                                <td><c:out value="${vl.total_dig}"></c:out></td>
                                                <td><c:out value="${vl.total_sobras}"></c:out></td>


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

    $(document).ready(function() {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem
        }
    });

    // Função para navegar entre elementos focáveis com as setas
    function navigateFocusableElements(event) {
        // Lista de elementos que podem receber foco, excluindo elementos com tabindex -1
        const focusableElements = Array.from(
            document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')
        ).filter(element => !element.disabled && element.tabIndex !== -1); // Filtra elementos desabilitados e tabindex -1

        if (focusableElements.length === 0) return; // Se não houver elementos focáveis, sai da função

        const currentElement = document.activeElement; // Elemento atual com foco
        let currentIndex = focusableElements.indexOf(currentElement); // Índice do elemento atual

        switch (event.key) {
            case 'ArrowRight': // Seta para a direita
            case 'ArrowDown': // Seta para baixo
                currentIndex = (currentIndex + 1) % focusableElements.length; // Próximo elemento
                break;
            case 'ArrowLeft': // Seta para a esquerda
            case 'ArrowUp': // Seta para cima
                currentIndex = (currentIndex - 1 + focusableElements.length) % focusableElements.length; // Elemento anterior
                break;
            default:
                return; // Ignora outras teclas
        }

        focusableElements[currentIndex].focus(); // Define o foco no elemento correspondente
    }

    // Adiciona o evento keydown ao documento
    document.addEventListener('keydown', navigateFocusableElements);

    // Bloqueia a alteração de valor com as setas nos inputs do tipo number
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                event.preventDefault(); // Impede a alteração do valor
            }
        });
    });

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
