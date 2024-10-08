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
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                                            <!--INSERIR BOTÃO 1 AQUI--><!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                                <h4>Relatório por Data</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalData" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Selecione a data Inicial e Final</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <h5>teste</h5>

                                                            <form action="<%= request.getContextPath() %>/ServletVendas" method="get" id="formDataVenda" name="formDataVenda">
                                                                <input type="hidden" name="acao"value="imprimirRelatorioVendas">
                                                                <div class="form-row align-items-center">
                                                                    <div class="col-auto">
                                                                        <label class="sr-only" for="dataInicial">Data Inicial</label>
                                                                        <input type="date" class="form-control" id="dataInicial" name="dataInicial" value="${dataInicial}">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <label class="sr-only" for="dataFinal">Data Final</label>
                                                                        <input type="date" class="form-control" id="dataFinal" name="dataFinal" value="${dataFinal}">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <button type="submit" class="btn btn-primary">Imprimir Relatório</button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                            <div style="height: 300px; overflow-y: auto ">
                                                                <table class="table" id="tabelarelvendas">
                                                                    <thead>
                                                                    <tr>
                                                                        <th scope="col">Opções</th>
                                                                        <th scope="col">Id Venda</th>
                                                                        <th scope="col">NOME</th>
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
                                                                        <th scope="col">DATA</th>


                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <c:forEach items="${listaVendas}" var="mv">
                                                                        <tr>
                                                                            <td>
                                                                                <a class="btn btn-outline-success waves-effect waves-light"
                                                                                   href="<%= request.getContextPath() %>/ServletVendas?acao=gerenciarVenda&venda_id=${mv.venda_id}">Gerenciar</a>
                                                                            </td>
                                                                            <td>
                                                                                <c:out value="${mv.venda_id}"></c:out>
                                                                            </td>
                                                                            <td>
                                                                                <c:out value="${mv.nome}"></c:out>
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
                                                                            <td>
                                                                                <c:out value="${mv.data_venda}"></c:out>
                                                                            </td>


                                                                        </tr>

                                                                    </c:forEach>



                                                                    </tbody>
                                                                </table>

                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                                            <button type="button" class="btn btn-outline-warning">ENVIAR</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-hexagon-multiple text-warning ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalPDV" ></i>
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
                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modal2">
                                                <h4>Desempenho</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                                            <button type="button" class="btn btn-outline-warning">ENVIAR</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-star text-success ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modal2" ></i>
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
                                            <!--INSERIR BOTÃO 3 AQUI-->
                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">
                                                <h4>Finalizar Dia</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                                            <button type="button" class="btn btn-outline-warning">ENVIAR</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-power text-danger ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modal3" ></i>
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
                                <h4 class="card-title">PAGINA INICIAL</h4>
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
</body>
</html>
