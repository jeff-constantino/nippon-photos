<%@ page import="model.ModelLogin" %><%--
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
            <div class="content-wrapper">
                <div class="row">

                </div>

                <!-- Modal -->
                <div class="modal fade" id="modalBuscaVenda" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" >Pesquisa de Funcionário </h5>

                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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

                            <div class="modal-body" >
                                <div class="container-fluid">
                                    <div class="page-body">

                                        <div class="row">
                                            <div class="col-sm-12">
                                                <!-- Basic Form Inputs card start -->
                                                <div class="card">
                                                    <div class="card-block">

                                                        <form class="form-material"  id="formBuscaUser" method="get" action="<%= request.getContextPath() %>/ServletVendas">

                                                            <div class="row">




                                                                <div class="col-sm-1">
                                                                    <label class="float-label" >ID:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="idBusca" name="id" placeholder="" >
                                                                </div>
                                                                <div class="col-4">
                                                                    <label class="float-label">FUNCIONÁRIO:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="nomeBusca" name="nome" placeholder=""  style="background-color: black" REQUIRED  autofocus>

                                                                </div>

                                                                <div>
                                                                    <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparbuscaForm();" >Novo</button>
                                                                    <button  type="button" class="btn btn-outline-success waves-effect waves-light" onclick="buscarFuncionario();">Pesquisar</button>
                                                                    <%--  BOTOES MODAL busca--%>
                                                                </div>
                                                                <div style="overflow-x: hidden">
                                                                    <div style="height: 300px; overflow-y: auto ">
                                                                        <table class="table" id="tabelabusca">
                                                                            <thead>
                                                                            <tr>
                                                                                <th scope="col">ID</th>
                                                                                <th scope="col">NOME</th>
                                                                                <th scope="col">Selecionar</th>

                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>

                                                                            </tbody>
                                                                        </table>

                                                                    </div>
                                                                </div>
                                                                <span id="totalResultados"></span>

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
                                <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                <%--FIM MODAL BUSCA--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-4 grid-margin">



                </div>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">

                            <div class="card-body" >

                                <h4 class="card-title">Vendas do Dia</h4>

                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalBuscaVenda">
                                    <h4>Buscar Funcionário</h4>
                                </button>
                                <div class="table-responsive"style="overflow-x: hidden">
                                    <table class="table" >
 <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                        <form action="<%= request.getContextPath() %>/ServletVendas" method="post" id="formBuscarUser2" name="formBuscarUser2" >
                                            <input type="hidden" name="acao" acao value="">
                                            <div class="col-sm-1">
                                                <label class="float-label" >VENDA ID:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control" id="venda_id" name="venda_id" placeholder=""  readonly value="${modelVendas.venda_id}">
                                            </div>
                                            <div class="col-6">
                                                <div class="col-auto">
                                                    <span span style="color:#1ad76b">${msg}</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">
                                                    <label for="dataVenda">Data
                                                        da Venda</label>
                                                    <input type="date"
                                                           class="form-control"
                                                           id="dataVenda"
                                                           name="dataVenda"
                                                           >
                                                </div>

                                                <div class="col-sm-1">
                                                    <label class="float-label" >ID:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control" id="vendedor_id" name="vendedor_id"   value="${modelVendas.vendedor_id}">
                                                </div>
                                                <div class="col-6">
                                                    <label class="float-label">FUNCIONÁRIO:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control" id="vendedor" name="nome" placeholder=""  style="background-color: black" value="${modelVendas.nome}">

                                                </div>
                                                <div class="col-2">
                                                    <label class="float-label">TOTAL DE FOTOS:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control" id="nome" name="nome" placeholder=""  style="background-color: black">

                                                </div>
<%--inicio dos produtos      --%>
<%--                                                <div style="overflow-x: hidden">--%>
<%--                                                    <div style="overflow-y: auto ">--%>
<%--                                                        <table class="table" id="NADA">--%>
<%--                                                            <thead>--%>
<%--                                                            <tr>--%>
<%--                                                                <th scope="col">FOTOS</th>--%>
<%--                                                                <th scope="col">ENCARTES</th>--%>
<%--                                                                <th scope="col">DIGITAIS</th>--%>
<%--                                                            </tr>--%>
<%--                                                            </thead>--%>
<%--                                                        </table>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>

                                                <br>

                                                <div>
                                                    <button  class="btn btn-outline-success waves-effect waves-light" >Salvar</button>
                                                    <button type="button"  class="btn btn-outline-danger waves-effect waves-light" onclick="criarDeleteComAjax();" >Excluir</button>
                                                </div>

                                            </div>

                                        </form>

                                    </table>
                                    <h5>Lançamentos do Dia:</h5>






                                    <div style="overflow-x: hidden">
                                        <div style="height: 300px; overflow-y: auto ">
                                            <table class="table" id="tabelabuscaview">
                                                <thead>
                                                <tr>

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


                                                </tr>
                                                </thead>
                                                <tbody>



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
<SCRIPT type="text/javascript">






</SCRIPT>
</body>
</html>
