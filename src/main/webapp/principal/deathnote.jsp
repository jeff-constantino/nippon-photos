<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalADV">
                                                <h4>ADVERTÊNCIAS</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalADV" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Advertências </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
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

                                                                                    <form class="form-material" id="formBuscaFuncionario1"
                                                                                          method="get"
                                                                                          action="<%= request.getContextPath() %>/ServletVendas">

                                                                                        <div class="row">

                                                                                            <div class="col-4">


                                                                                                <input type="text" class="form-control"
                                                                                                       id="nomeBusca1" name="nome" placeholder=""
                                                                                                       style="background-color: black" REQUIRED
                                                                                                       autofocus>

                                                                                            </div>

                                                                                            <div>


                                                                                                <button type="button"
                                                                                                        class="btn btn-outline-primary waves-effect waves-light"
                                                                                                        onclick="limparbuscaFuncionario();">Novo
                                                                                                </button>
                                                                                                <button type="button"
                                                                                                        class="btn btn-outline-success waves-effect waves-light"
                                                                                                        onclick="buscarFunc();">Pesquisar
                                                                                                </button>


                                                                                                <%--  BOTOES MODAL busca--%>
                                                                                            </div>
                                                                                            <div style="overflow-x: hidden">
                                                                                                <div style="height: 300px; overflow-y: auto ">
                                                                                                    <table class="table"
                                                                                                           id="tabelabuscafuncionario1">
                                                                                                        <thead>
                                                                                                        <tr>
                                                                                                            <th scope="col">ID</th>
                                                                                                            <th scope="col">NOME</th>
                                                                                                            <th scope="col">OPÇÕES</th>

                                                                                                        </tr>
                                                                                                        </thead>
                                                                                                        <tbody>

                                                                                                        </tbody>
                                                                                                    </table>

                                                                                                </div>
                                                                                            </div>
                                                                                            <span id="totalResultados1"></span>

                                                                                        </div>

                                                                                    </form>

                                                                                    <form action="<%= request.getContextPath() %>/ServletVendas"
                                                                                          method="post" id="formBuscarVenda" name="formBuscarVenda">
                                                                                        <input type="hidden" name="acao" value="">

                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label for="outer_dataVenda">Data da Advertência</label>
                                                                                                <input type="date" class="form-control"
                                                                                                       id="outer_dataVenda" name="dataVenda"
                                                                                                       required
                                                                                                       value="${formattedDataVenda != null ? formattedDataVenda : ''}">
                                                                                            </div>
                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label">ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="vendedor_id" name="vendedor_id"
                                                                                                       placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${modelVendas.id}">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label class="float-label">FUNCIONÁRIO:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="vendedor" name="nome" placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${modelVendas.nome}">
                                                                                            </div>

                                                                                        </div>




                                                                                        <div class="row">

                                                                                            <div class="col">
                                                                                                <div class="row">
                                                                                                    <div class="mb-3">
                                                                                                        <label style="color: #f2a654">MOTIVO</label>
                                                                                                        <textarea type="text" class="form-control"
                                                                                                               style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                               id="adv_motivo" name="adv_motivo"
                                                                                                               required
                                                                                                               value=""/></textarea>

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
                                                                                                    onclick="limparFormVendas();">Limpar
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi  mdi mdi-alert text-warning ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalADV" ></i>
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
                                            <button type="button" class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#modalFalta">
                                                <h4>FALTAS</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalFalta" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Faltas </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
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

                                                                                    <form class="form-material" id="formBuscaFuncionario2"
                                                                                          method="get"
                                                                                          action="<%= request.getContextPath() %>/ServletVendas">

                                                                                        <div class="row">

                                                                                            <div class="col-4">


                                                                                                <input type="text" class="form-control"
                                                                                                       id="nomeBusca2" name="nome" placeholder=""
                                                                                                       style="background-color: black" REQUIRED
                                                                                                       autofocus>

                                                                                            </div>

                                                                                            <div>


                                                                                                <button type="button"
                                                                                                        class="btn btn-outline-primary waves-effect waves-light"
                                                                                                        onclick="limparbuscaFuncionario();">Novo
                                                                                                </button>
                                                                                                <button type="button"
                                                                                                        class="btn btn-outline-success waves-effect waves-light"
                                                                                                        onclick="buscarFunc();">Pesquisar
                                                                                                </button>


                                                                                                <%--  BOTOES MODAL busca--%>
                                                                                            </div>
                                                                                            <div style="overflow-x: hidden">
                                                                                                <div style="height: 300px; overflow-y: auto ">
                                                                                                    <table class="table"
                                                                                                           id="tabelabuscafuncionario2">
                                                                                                        <thead>
                                                                                                        <tr>
                                                                                                            <th scope="col">ID</th>
                                                                                                            <th scope="col">NOME</th>
                                                                                                            <th scope="col">OPÇÕES</th>

                                                                                                        </tr>
                                                                                                        </thead>
                                                                                                        <tbody>

                                                                                                        </tbody>
                                                                                                    </table>

                                                                                                </div>
                                                                                            </div>
                                                                                            <span id="totalResultados2"></span>

                                                                                        </div>

                                                                                    </form>

                                                                                    <form action="<%= request.getContextPath() %>/ServletVendas"
                                                                                          method="post" id="formBuscarVenda" name="formBuscarVenda">
                                                                                        <input type="hidden" name="acao" value="">

                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label for="outer_dataVenda">Data da Falta</label>
                                                                                                <input type="date" class="form-control"
                                                                                                       id="outer_dataVenda" name="dataVenda"
                                                                                                       required
                                                                                                       value="${formattedDataVenda != null ? formattedDataVenda : ''}">
                                                                                            </div>
                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label">ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="vendedor_id" name="vendedor_id"
                                                                                                       placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${modelVendas.id}">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label class="float-label">FUNCIONÁRIO:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="vendedor" name="nome" placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${modelVendas.nome}">
                                                                                            </div>

                                                                                        </div>




                                                                                        <div class="row">

                                                                                            <div class="col">
                                                                                                <div class="row">
                                                                                                    <div class="mb-3">
                                                                                                        <label style="color: #f2a654">OBSERVAÇÕES</label>
                                                                                                        <textarea type="text" class="form-control"
                                                                                                                  style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                                  id="falta_obs" name="falta_obs"
                                                                                                                  required
                                                                                                                  value=""/></textarea>

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
                                                                                                    onclick="limparFormVendas();">Limpar
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi  mdi-snapchat text-light ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalFalta" ></i>
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
                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalSuspensao">
                                                <h4>SUSPENSÃO</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalSuspensao" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Suspensão </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
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

                                                                                    <form class="form-material" id="formBuscaFuncionario3"
                                                                                          method="get"
                                                                                          action="<%= request.getContextPath() %>/ServletVendas">

                                                                                        <div class="row">

                                                                                            <div class="col-4">


                                                                                                <input type="text" class="form-control"
                                                                                                       id="nomeBusca3" name="nome" placeholder=""
                                                                                                       style="background-color: black" REQUIRED
                                                                                                       autofocus>

                                                                                            </div>

                                                                                            <div>


                                                                                                <button type="button"
                                                                                                        class="btn btn-outline-primary waves-effect waves-light"
                                                                                                        onclick="limparbuscaFuncionario();">Novo
                                                                                                </button>
                                                                                                <button type="button"
                                                                                                        class="btn btn-outline-success waves-effect waves-light"
                                                                                                        onclick="buscarFunc();">Pesquisar
                                                                                                </button>


                                                                                                <%--  BOTOES MODAL busca--%>
                                                                                            </div>
                                                                                            <div style="overflow-x: hidden">
                                                                                                <div style="height: 300px; overflow-y: auto ">
                                                                                                    <table class="table"
                                                                                                           id="tabelabuscafuncionario3">
                                                                                                        <thead>
                                                                                                        <tr>
                                                                                                            <th scope="col">ID</th>
                                                                                                            <th scope="col">NOME</th>
                                                                                                            <th scope="col">OPÇÕES</th>

                                                                                                        </tr>
                                                                                                        </thead>
                                                                                                        <tbody>

                                                                                                        </tbody>
                                                                                                    </table>

                                                                                                </div>
                                                                                            </div>
                                                                                            <span id="totalResultados3"></span>

                                                                                        </div>

                                                                                    </form>

                                                                                    <form action="<%= request.getContextPath() %>/ServletVendas"
                                                                                          method="post" id="formBuscarVenda" name="formBuscarVenda">
                                                                                        <input type="hidden" name="acao" value="">

                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label for="outer_dataVenda">Data da Falta</label>
                                                                                                <input type="date" class="form-control"
                                                                                                       id="outer_dataVenda" name="dataVenda"
                                                                                                       required
                                                                                                       value="${formattedDataVenda != null ? formattedDataVenda : ''}">
                                                                                            </div>
                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label">ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="vendedor_id" name="vendedor_id"
                                                                                                       placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${modelVendas.id}">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label class="float-label">FUNCIONÁRIO:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="vendedor" name="nome" placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${modelVendas.nome}">
                                                                                            </div>

                                                                                        </div>




                                                                                        <div class="row">

                                                                                            <div class="col">
                                                                                                <div class="row">
                                                                                                    <div class="mb-3">
                                                                                                        <label style="color: #f2a654">MOTIVO:</label>
                                                                                                        <textarea type="text" class="form-control"
                                                                                                                  style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                                  id="susp_motivo" name="susp_motivo"
                                                                                                                  required
                                                                                                                  value=""/></textarea>

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
                                                                                                    onclick="limparFormVendas();">Limpar
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-block-helper text-danger ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalSuspensao" ></i>
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
                                <h4 class="card-title">DEATH NOTE</h4>
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
