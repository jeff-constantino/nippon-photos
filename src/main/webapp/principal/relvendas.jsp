<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
                                                                <div class="alert alert-info">${msg}</div>
                                                            </c:if>
                                                            <form action="<%= request.getContextPath() %>/ServletRelVenda" method="get" id="formDataVenda" name="formDataVenda">
                                                                <input type="hidden" name="acao" value="imprimirRelatorioVendas">
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
                                                                        <select class="form-control" id="funcionarioId" name="funcionarioId">
                                                                            <option value="">Selecione um Funcionário</option>
                                                                            <c:forEach var="funcionario" items="${funcionariosAtivos}">
                                                                                <option value="${funcionario.id}"
                                                                                        <c:if test="${funcionario.id == funcionarioId}">selected</c:if>
                                                                                >${funcionario.nome}</option>
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
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
                                <h4 class="card-title" STYLE="text-align: center">RELATÓRIO DE VENDAS</h4>

                                <div style="height: 300px; overflow-y: auto ">
                                    <table class="table" id="tabelarelvendas">
                                        <thead>
                                        <tr>

                                            <th scope="col">Id Venda</th>
                                            <th scope="col">NOME</th>
                                            <th scope="col">DATA</th>
                                            <th scope="col">Ft Din</th>
                                            <th scope="col">Ft Deb</th>
                                            <th scope="col">Ft Cred</th>
                                            <th scope="col">Ft Pix</th>

                                            <th scope="col">Enc Din</th>
                                            <th scope="col">Enc Deb</th>
                                            <th scope="col">Enc Cred</th>
                                            <th scope="col">Enc Pix</th>

                                            <th scope="col">Dig Din</th>
                                            <th scope="col">Dig Deb</th>
                                            <th scope="col">Dig Cred</th>
                                            <th scope="col">Dig Pix</th>

                                            <th scope="col">Sobras</th>



                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasList}" var="mv">
                                            <tr>
                                                <td>
                                                    <c:out value="${mv.venda_id}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.nome}"></c:out>
                                                </td>

                                                <td>
                                                    <c:out value="${mv.data_venda}"></c:out>
                                                </td>

                                                <td>
                                                    <c:out value="${mv.prod1_din}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod1_deb}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod1_cred}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod1_pix}"></c:out>
                                                </td>


                                                <td>
                                                    <c:out value="${mv.prod2_din}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod2_deb}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod2_cred}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod2_pix}"></c:out>
                                                </td>

                                                <td>
                                                    <c:out value="${mv.prod3_din}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod3_deb}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod3_cred}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.prod3_pix}"></c:out>
                                                </td>
                                                <td>
                                                    <c:out value="${mv.sobras}"></c:out>
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

<script>
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
