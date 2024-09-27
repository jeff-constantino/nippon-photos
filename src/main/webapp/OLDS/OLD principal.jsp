<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelVendas" %><%--
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
                <div class="row">
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                                            <!--INSERIR BOTÃO 1 AQUI--><!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal"
                                                    data-bs-target="#modalPDV">
                                                <h4>Venda Diária</h4>
                                            </button>

                                            <!-- Modal -->

                                            <div class="modal fade" id="modalPDV" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Venda Diária</h5>

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

                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <div class="page-body">

                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">


                                                                                    <form class="form-material"  action="<%= request.getContextPath() %>/ServletUsuarioController" method="post" id="formUser" >
                                                                                        <div class="col-sm-12">
                                                                                            <!-- Basic Form Inputs card start -->
                                                                                            <div class="card">
                                                                                                <div class="card-block">





                                                                                                    <div class="row">
                                                                                                        <div class="col">
                                                                                                            <label for="dataVenda">Data
                                                                                                                da Venda</label>
                                                                                                            <input type="date"
                                                                                                                   class="form-control"
                                                                                                                   id="dataVenda"
                                                                                                                   name="dataVenda"
                                                                                                                   value="${modelVendas.dataVenda}">
                                                                                                        </div>


                                                                                                        <div class="col">
                                                                                                            <label class="float-label" >ID</label>
                                                                                                            <input type="text"
                                                                                                                   class="form-control"
                                                                                                                   id="vendaId"
                                                                                                                   name="vendaId"
                                                                                                                   placeholder="">
                                                                                                        </div>
                                                                                                        <div class="col-6">
                                                                                                            <label class="float-label" >Nome</label>
                                                                                                            <input type="text"
                                                                                                                   class="form-control"
                                                                                                                   id="vendaNome"
                                                                                                                   name="vendaNome"
                                                                                                                   placeholder=""
                                                                                                                   style="background-color: black">

                                                                                                        </div>
                                                                                                        <div class="col-2">
                                                                                                            <label class="float-label" >Total</label>
                                                                                                            <input type="text"
                                                                                                                   class="form-control"
                                                                                                                   id="vendaTotal"
                                                                                                                   name="vendaTotal"
                                                                                                                   placeholder=""
                                                                                                                   DISABLED
                                                                                                                   style="background-color: black">
                                                                                                        </div>
                                                                                                    </div>

                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="fotos"
                                                                                                               placeholder="" HIDDEN="">
                                                                                                        <label for="fotos"
                                                                                                               style="color: #f2a654; padding-left: 120px;padding-top: 10px; font-size: 30px">FOTOS</label>
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="encartes"
                                                                                                               placeholder="" HIDDEN="">
                                                                                                        <label for="encartes"
                                                                                                               STYLE="color: #00d25b; padding-left: 90px;padding-top: 10px; font-size: 30px">ENCARTES</label>
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="digitais"
                                                                                                               placeholder="" HIDDEN="">
                                                                                                        <label for="digitais"
                                                                                                               style="color: fuchsia; padding-left: 100px;padding-top: 10px; font-size: 30px">DIGITAIS</label>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <DIV></DIV>
                                                                                                        <DIV></DIV>
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">DINHEIRO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_din"
                                                                                                               name="prod1_din"
                                                                                                               style="background-color: white; color: black">

                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_din_valor"
                                                                                                               name="prod1_din_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #DAA520">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">DINHEIRO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_din"
                                                                                                               name="prod2_din"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_din_valor"
                                                                                                               name="prod2_din_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #2b542c">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">DINHEIRO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_din"
                                                                                                               name="prod3_din"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_din_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #6a008a">
                                                                                                    </div>

                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <DIV></DIV>
                                                                                                        <DIV></DIV>
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">DÉBITO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_deb"
                                                                                                               name="prod1_deb"
                                                                                                               style="background-color: white; color: black">

                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_deb_valor"
                                                                                                               name="prod1_deb_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #DAA520">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">DÉBITO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_deb"
                                                                                                               name="prod2_deb"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_deb_valor"
                                                                                                               name="prod2_deb_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #2b542c">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">DÉBITO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_deb"
                                                                                                               name="prod3_deb"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_deb_valor"
                                                                                                               name="prod3_deb_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #6a008a">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <DIV></DIV>
                                                                                                        <DIV></DIV>
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">CRÉDITO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_cred"
                                                                                                               name="prod1_cred"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">

                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_cred_valor"
                                                                                                               name="prod1_cred_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #DAA520">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">CRÉDITO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_cred"
                                                                                                               name="prod2_cred"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_cred_valor"
                                                                                                               name="prod2_cred_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #2b542c">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">CRÉDITO</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_cred"
                                                                                                               name="prod3_cred"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_cred_valor"
                                                                                                               name="prod3_cred_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #6a008a">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <DIV></DIV>
                                                                                                        <DIV></DIV>
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">PIX</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_pix"
                                                                                                               name="prod1_pix"
                                                                                                               style="background-color: white; color: black">

                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #f2a654">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod1_pix_valor"
                                                                                                               name="prod1_pix_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #DAA520">
                                                                                                    </div>

                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">PIX</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_pix"
                                                                                                               name="prod2_pix"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: #00d25b">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod2_pix_valor"
                                                                                                               name="prod2_pix_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #2b542c">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">PIX</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_pix"
                                                                                                               name="prod3_pix"
                                                                                                               placeholder=""
                                                                                                               style="background-color: white; color: black">
                                                                                                    </div>
                                                                                                    <div class="col">
                                                                                                        <label  class="float-label"
                                                                                                                style="color: fuchsia">VALOR</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="prod3_pix_valor"
                                                                                                               name="prod3_pix_valor"
                                                                                                               placeholder="" DISABLED
                                                                                                               STYLE="background-color: #6a008a">
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row">
                                                                                                    <div class="col-2">
                                                                                                        <DIV></DIV>
                                                                                                        <DIV></DIV>
                                                                                                        <label  class="float-label" >SOBRAS</label>
                                                                                                        <input type="text"
                                                                                                               class="form-control"
                                                                                                               id="sobras"
                                                                                                               name="sobras"
                                                                                                               placeholder=""
                                                                                                               style="background-color: #58151c">

                                                                                                    </div>
                                                                                                    <div class="col-2">
                                                                                                        <label>RIBBON</label>
                                                                                                        <select class="form-select" id="ribbon" name="ribbon">
                                                                                                            <option disabled="disabled">Tamanho do Papel</option>
                                                                                                            <option style="color: #00d25b" value="10x15"  <%
                                                                                                                ModelVendas modelVendas =(ModelVendas) request.getAttribute("modelVendas");
//                                                                                                        System.out.println(modelVendas);
                                                                                                                if (modelVendas != null && modelVendas.getRibbon().equalsIgnoreCase("10x15")){
                                                                                                                    out.print(" ");
                                                                                                                    out.print("selected=\"selected\"");
                                                                                                                    out.print(" ");
                                                                                                                }%>>10x15</option>

                                                                                                            <option style="color: #bf3322" value="15x20" <%
                                                                                                                modelVendas =(ModelVendas) request.getAttribute("modelVendas");
                                                                                                                if (modelVendas != null && modelVendas.getRibbon().equalsIgnoreCase("15x20")){
                                                                                                                    out.print(" ");
                                                                                                                    out.print("selected=\"selected\"");
                                                                                                                    out.print(" ");
                                                                                                                }%>>15x20</option>

                                                                                                        </select>
                                                                                                    </div>

                                                                                                </div>

                                                                                            </div>
                                                                                        </div>



                                                                                    </form>

                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparFormVendas();" >Novo</button>
                                                                                <button  class="btn btn-outline-success waves-effect waves-light" >Cadastrar</button>
                                                                                <%--  BOTOES MODAL--%>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                                            <%--FIM MODAL VENDAS--%>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-hexagon-multiple text-warning ml-auto" type="button"
                                           data-bs-toggle="modal" data-bs-target="#modalPDV"></i>
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
                                                    data-bs-target="#modal2">
                                                <h4>Desempenho</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false"
                                                 tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticRanking">RANKING</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
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
                                                            <button type="button" class="btn btn-outline-light"
                                                                    data-bs-dismiss="modal">SAIR
                                                            </button>
                                                            <button type="button" class="btn btn-outline-warning">ENVIAR</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-star text-success ml-auto" type="button"
                                           data-bs-toggle="modal" data-bs-target="#modal2"></i>
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
                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                                    data-bs-target="#modal3">
                                                <h4>Finalizar Dia</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false"
                                                 tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticFinalizar">FINALIZAR</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
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
                                                            <button type="button" class="btn btn-outline-light"
                                                                    data-bs-dismiss="modal">SAIR
                                                            </button>
                                                            <button type="button" class="btn btn-outline-warning">ENVIAR</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-power text-danger ml-auto" type="button" data-bs-toggle="modal"
                                           data-bs-target="#modal3"></i>
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
<script type="text/javascript">
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
