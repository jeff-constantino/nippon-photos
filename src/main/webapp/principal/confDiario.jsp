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
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table">


                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modal1">
                                                <h4>Buscar Fechamento</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal2">
                                                <h4>Buscar Conferência</h4>
                                            </button>

<%--                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">--%>
<%--                                                <h4>Configurações Gerais</h4>--%>
<%--                                            </button>--%>
                                        </div>


                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <%--TODOS MODAIS  --%>
                <div class="row">
                    <div class="col-sm-4 grid-margin">



                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal1" data-bs-backdrop="static"
                                         data-bs-keyboard="false"
                                         tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Buscar Fechamento </h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>

                                                <div class="container-fluid">
                                                    <div class="page-body">

                                                        <div class="row">
                                                            <div class="col-auto">
                                                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="page-body">

                                                            <div class="row">
                                                                <div class="col-sm-12">

                                                                    <div class="card">
                                                                        <div class="card-block">
                                                                            <form action="<%= request.getContextPath() %>/ServletConfDiario"
                                                                                  method="get" id="formConfModal"
                                                                                  name="formConfModal">
                                                                                <input type="hidden" name="acao"
                                                                                       value="buscaFechamentoDiario"/>
                                                                                <div class="form-row align-items-center">
                                                                                    <div class="col-auto d-flex align-items-end">
                                                                                        <div class="mr-2">
                                                                                            <label for="data_fechamento">Data
                                                                                                Fechamento</label>
                                                                                            <input type="date"
                                                                                                   class="form-control"
                                                                                                   id="data_fechamento"
                                                                                                   name="data_fechamento"
                                                                                                   value="">
                                                                                        </div>
                                                                                        <div>
                                                                                            <button type="submit"
                                                                                                    class="btn btn-outline-success">
                                                                                                Buscar Fechamento
                                                                                            </button>
                                                                                        </div>
                                                                                    </div>
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
                    <div class="col-sm-4 grid-margin">


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!--INSERIR BOTÃO 2 AQUI-->
                                    <!-- Button trigger modal -->


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticRanking">BUSCAR CONFERÊNCIA</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="page-body">

                                                            <div class="row">
                                                                <div class="col-sm-12">

                                                                    <div class="card">
                                                                        <div class="card-block">
                                                                            <form action="<%= request.getContextPath() %>/ServletConfDiario"
                                                                                  method="get" id="buscaConfModal"
                                                                                  name="buscaConfModal">
                                                                                <input type="hidden" name="acao"
                                                                                       value="buscaConfDiario"/>
                                                                                <div class="form-row align-items-center">
                                                                                    <div class="col-auto d-flex align-items-end">
                                                                                        <div class="mr-2">
                                                                                            <label for="data_conferencia">Data
                                                                                                Fechamento</label>
                                                                                            <input type="date"
                                                                                                   class="form-control"
                                                                                                   id="data_conferencia"
                                                                                                   name="data_conferencia"
                                                                                                   value="">
                                                                                        </div>
                                                                                        <div>
                                                                                            <button type="submit"
                                                                                                    class="btn btn-outline-success">
                                                                                                Buscar Fechamento
                                                                                            </button>
                                                                                        </div>
                                                                                    </div>
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
                                                    <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>



                        </div>
                    </div>
                    <div class="col-sm-4 grid-margin">


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!--INSERIR BOTÃO 3 AQUI-->
                                    <!-- Button trigger modal -->


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
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

                <%--BLOCO 1                --%>
                <style>
                    .minha-tabela {
                        border-collapse: collapse; /* Remove espaço entre as bordas */
                        width: 100%; /* Opcional: para garantir que a tabela ocupe toda a largura */
                    }

                    .minha-tabela td, .minha-tabela th {
                        padding: 2px; /* Diminui o padding das células */
                        vertical-align: middle; /* Alinha verticalmente ao meio */
                        font-size: 14px; /* Ajusta o tamanho da fonte (opcional) */
                    }
                </style>
                <form id="formAtualizar" method="POST" action="<%= request.getContextPath() %>/ServletConfDiario">

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <h4 class="card-title" style="text-align: center">VALORES</h4>
                                <div class="table-responsive"  style="overflow-x: hidden;overflow-y: hidden">
                                    <table class="table">
                                        <div  class="row mt-3 text-center d-flex justify-content-center">
                                            <div class="col-2" hidden="hidden">

                                                <label class="float-label">id:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="id" name="id"
                                                       placeholder="" value="${conf_diario.id}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       >
                                            </div>
                                            <div class="col-2">

                                                <label style="color: #f2a654" class="float-label">DINHEIRO INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_din" name="valor_din"
                                                       placeholder="" value="${conf_diario.valor_din}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       >
                                            </div>
                                            <div class="col-2">
                                                <label style="color: #f2a654" class="float-label">DÉBITO INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb" name="valor_deb"
                                                       placeholder="" value="${conf_diario.valor_deb}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       >
                                            </div>

                                            <div class="col-2">
                                                <label style="color: #f2a654" class="float-label">CRÉDITO INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred" name="valor_cred"
                                                       placeholder="" value="${conf_diario.valor_cred}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       >
                                            </div>

                                            <div class="col-2">
                                                <label style="color: #f2a654" class="float-label">PIX INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix" name="valor_pix"
                                                       placeholder="" value="${conf_diario.valor_pix}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       >
                                            </div>

                                        </div>


                                        <div  class="row mt-3 text-center d-flex justify-content-center">
                                            <div class="col-2">

                                                <label class="float-label">DINHEIRO ENTREGUE:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_din_real" name="valor_din_real"
                                                       placeholder="" value="${conf_diario.valor_din_real}" required
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>
                                            <div class="col-2">
                                                <label class="float-label">DÉBITO NA CONTA:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb_real" name="valor_deb_real"
                                                       placeholder="" value="${conf_diario.valor_deb_real}" required
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>



                                            <div class="col-2">
                                                <label class="float-label">CRÉDITO NA CONTA:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred_real" name="valor_cred_real"
                                                       placeholder="" value="${conf_diario.valor_cred_real}" required
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>



                                            <div class="col-2">
                                                <label class="float-label">PIX NA CONTA:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix_real" name="valor_pix_real"
                                                       placeholder="" value="${conf_diario.valor_pix_real}" required
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>


                                        </div>

                                        <div  class="row mt-3 text-center d-flex justify-content-center">
                                            <div class="col-2">

                                                <label style="color: #f2a654" class="float-label">DINHEIRO DIF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_din_dif" name="valor_din_dif"
                                                       placeholder="" value="${conf_diario.valor_din_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"
                                                 tabindex="-1">
                                            </div>
                                            <div class="col-2">
                                                <label style="color: #f2a654" class="float-label">DÉBITO DIF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb_dif" name="valor_deb_dif"
                                                       placeholder="" value="${conf_diario.valor_deb_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"  tabindex="-1"
                                                >
                                            </div>

                                            <div class="col-2">
                                                <label style="color: #f2a654" class="float-label">CRÉDITO DIF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred_dif" name="valor_cred_dif"
                                                       placeholder="" value="${conf_diario.valor_cred_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"  tabindex="-1"
                                                >
                                            </div>

                                            <div class="col-2">
                                                <label style="color: #f2a654" class="float-label">PIX DIF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix_dif" name="valor_pix_dif"
                                                       placeholder="" value="${conf_diario.valor_pix_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"  tabindex="-1"
                                                >
                                            </div>

                                        </div>
                                        <div class="col-12">
                                            <label class="float-label" style="text-align: center">OBSERVAÇÕES:</label>
                                            <span class="form-bar"></span>
                                            <input type="text" class="form-control"
                                                   id="observacao" name="observacao"
                                                   placeholder="" value="${conf_diario.observacao}"
                                                   style="text-align: center; font-weight: bold"
                                            >
                                        </div>

                                    </table>
                                </div>

                           </div>
                        </div>
                    </div>
                </div>



                <%--BLOCO 2--%>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RIBBON</h4>
                                <div class="table-responsive" style="overflow-x: hidden; overflow-y: hidden">
                                    <table class="table">
                                        <div  class="row mt-3 text-center d-flex justify-content-center">

                                            <div class="row mt-3">
                                                <div class="col-lg-12 text-center">
                                                    <h5 style="color: white">CONFERÊNCIA DE RIBBONS</h5>
                                                </div>

                                            </div>
                                            <div class="col-4">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 1 Anterior</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="ribbon_1_conf" name="old_ribbon_1" value="${conf_diario.old_ribbon_1}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 2 Anterior</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="ribbon_2_conf" name="old_ribbon_2" value="${conf_diario.old_ribbon_2}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label>Ribbon 1 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_1_atual" name="ribbon_1_atual" value="${conf_diario.ribbon_1_atual}">

                                                        <label style="color: #f2a654">Revelado 1</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="rev_ribbon_1" name="rev_ribbon_1"  value="${conf_diario.rev_ribbon_1}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                                style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="dif_ribbon_1" name="dif_ribbon_1" >




                                                    </div>

                                                    <div class="col-6">
                                                        <label>Ribbon 2 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_2_atual" name="ribbon_2_atual" value="${conf_diario.ribbon_2_atual}">

                                                        <label style="color: #f2a654">Revelado 2</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="rev_ribbon_2" name="rev_ribbon_2"  value="${conf_diario.rev_ribbon_2}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="dif_ribbon_2" name="dif_ribbon_2" >
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 3 Anterior</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="ribbon_3_conf" name="old_ribbon_3" value="${conf_diario.old_ribbon_3}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 4 Anterior</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="ribbon_4_conf" name="old_ribbon_4" value="${conf_diario.old_ribbon_4}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label>Ribbon 3 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_3_atual" name="ribbon_3_atual" value="${conf_diario.ribbon_3_atual}">

                                                        <label style="color: #f2a654">Revelado 3</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="rev_ribbon_3" name="rev_ribbon_3"   value="${conf_diario.rev_ribbon_3}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="dif_ribbon_3" name="dif_ribbon_3" >
                                                    </div>

                                                    <div class="col-6">
                                                        <label>Ribbon 4 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_4_atual" name="ribbon_4_atual" value="${conf_diario.ribbon_4_atual}">

                                                        <label style="color: #f2a654">Revelado 4</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="rev_ribbon_4" name="rev_ribbon_4"   value="${conf_diario.rev_ribbon_4}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="dif_ribbon_4" name="dif_ribbon_4" >
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 5 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="ribbon_5_conf" name="old_ribbon_5" value="${conf_diario.old_ribbon_5}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 6 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="ribbon_6_conf" name="old_ribbon_6" value="${conf_diario.old_ribbon_6}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label>Ribbon 5 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_5_atual" name="ribbon_5_atual" value="${conf_diario.ribbon_5_atual}">

                                                        <label style="color: #f2a654">Revelado 5</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="rev_ribbon_5" name="rev_ribbon_5"  value="${conf_diario.rev_ribbon_5}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="dif_ribbon_5" name="dif_ribbon_5" >
                                                    </div>

                                                    <div class="col-6">
                                                        <label>Ribbon 6 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_6_atual" name="ribbon_6_atual" value="${conf_diario.ribbon_6_atual}">

                                                        <label style="color: #f2a654">Revelado 6</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="rev_ribbon_6" name="rev_ribbon_6"   value="${conf_diario.rev_ribbon_6}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="dif_ribbon_6" name="dif_ribbon_6" >
                                                    </div>
                                                </div>
                                            </div>

<%--SOBRAS E TOTAIS--%>
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-3">
                                                        <label style="color: #f2a654">SOBRAS</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="sobras" name="sobras" value="${conf_diario.sobras}">
                                                    </div>

                                                    <div class="col-3">
                                                        <label style="color: #f2a654">TOTAL REVELADO</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="total_revelado" name="total_revelado" value="${conf_diario.total_revelado}">
                                                    </div>
                                                    <div class="col-3">
                                                        <label style="color: #f2a654">TOTAL REVELADO</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="total_informado" name="total_informado" value="${conf_diario.total_informado}">
                                                    </div>

                                                    <div class="col-3">
                                                        <label style="color: #f2a654">DIFERENÇA RIBBONS</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1"  id="total_dif" name="total_dif" value="${conf_diario.total_dif}">
                                                    </div>
                                                </div>
                                            </div>




                                        </div>
                                        <div class="col-12">
                                            <div class="row">
                                                <div class="col-12">
                                                    <label >OBSERVAÇÕES RIBBON</label>
                                                    <input class="form-control" placeholder=""
                                                           style="text-align: center; font-weight: bold"
                                                           id="observacao_ribbon" name="observacao_ribbon" value="${conf_diario.observacao_ribbon}">
                                                </div>


                                            </div>
                                        </div>


                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--BLOCO 3--%>

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RESUMO DO DIA</h4>
                                <div class="table-responsive" style="overflow-x: hidden; overflow-y: hidden">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                        <div class="row mt-3 text-center d-flex justify-content-center">
                                            <!-- Linha 1: Data de Fechamento -->
                                            <div class="col-12 mb-3 d-flex justify-content-center">
                                                <div class="mr-2" style="max-width: 250px; width: 100%;">
                                                    <label style="color: #f2a654">Data Fechamento</label>
                                                    <input type="date"
                                                           class="form-control"
                                                           id="data_fechamento2"
                                                           name="data_fechamento"
                                                           style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                           value="${conf_diario.data_fechamento}"  tabindex="-1">
                                                </div>
                                            </div>

                                            <!-- Linha 2: Outros Itens -->
                                            <div class="col-12 d-flex justify-content-between">
                                                <div class="d-flex flex-column align-items-center me-2">
                                                    <label style="color: #f2a654">DESCONTOS</label>
                                                    <input type="number" class="form-control" style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                           tabindex="-1"  id="desconto" name="desconto" value="${conf_diario.desconto}">
                                                </div>
                                                <div class="d-flex flex-column align-items-center me-2">
                                                    <label style="color: #f2a654">DESPESAS DO DIA</label>
                                                    <input type="number" class="form-control" style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                           tabindex="-1"  id="valor_despesa_total" name="valor_despesa_total" value="${conf_diario.valor_despesa_total}">
                                                </div>
                                                <div class="d-flex flex-column align-items-center me-2">
                                                    <label style="color: #f2a654">VALES DO DIA</label>
                                                    <input type="number" class="form-control" style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                           tabindex="-1"  id="valor_vale_total" name="valor_vale_total" value="${conf_diario.valor_vale_total}">
                                                </div>
                                                <div class="d-flex flex-column align-items-center">
                                                    <label style="color: #f2a654">VENDA TOTAL DO DIA</label>
                                                    <input type="number" class="form-control" style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                           tabindex="-1"  id="venda_total_dia" name="venda_total_dia" value="${conf_diario.venda_total_dia}">
                                                </div>
                                            </div>
                                        </div>

                                    </table>
                                    <button class="btn btn-outline-success waves-effect waves-light"  type="submit">
                                        Atualizar
                                    </button>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
             </form>


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

    document.addEventListener('DOMContentLoaded', function () {
        // Valores que vêm do banco de dados


        // Função para calcular a diferença e atualizar os campos
        function calcularDiferenças() {
            // Obtém os valores dos campos
            var valorDin = parseFloat(document.getElementById('valor_din').value.replace(',', '.')) || 0;
            var valorDinReal = parseFloat(document.getElementById('valor_din_real').value.replace(',', '.')) || 0;

            var valorDeb = parseFloat(document.getElementById('valor_deb').value.replace(',', '.')) || 0;
            var valorDebReal = parseFloat(document.getElementById('valor_deb_real').value.replace(',', '.')) || 0;


            var valorCred = parseFloat(document.getElementById('valor_cred').value.replace(',', '.')) || 0;
            var valorCredReal = parseFloat(document.getElementById('valor_cred_real').value.replace(',', '.')) || 0;


            var valorPix = parseFloat(document.getElementById('valor_pix').value.replace(',', '.')) || 0;
            var valorPixReal = parseFloat(document.getElementById('valor_pix_real').value.replace(',', '.')) || 0;

            // Calcula as diferenças
            var valorDinDif = valorDinReal - valorDin;
            var valorDebDif = (valorDebReal ) - (valorDeb); // Inclui valor do banco
            var valorCredDif = (valorCredReal) - (valorCred); // Inclui valor do banco
            var valorPixDif = valorPixReal - valorPix;

            // Atualiza os campos de diferença
            atualizarCampo('valor_din_dif', valorDinDif);
            atualizarCampo('valor_deb_dif', valorDebDif);
            atualizarCampo('valor_cred_dif', valorCredDif);
            atualizarCampo('valor_pix_dif', valorPixDif);
        }

        // Função para atualizar o campo e mudar a cor conforme o valor
        function atualizarCampo(campoId, valor) {
            var campo = document.getElementById(campoId);
            campo.value = valor.toFixed(2); // Formata o número para 2 casas decimais

            if (valor < 0) {
                campo.style.color = 'red'; // Se negativo, cor vermelha
                campo.value = '-' + Math.abs(valor).toFixed(2); // Adiciona o sinal negativo
            } else {
                campo.style.color = 'green'; // Se positivo, cor verde
            }
        }

        // Adiciona evento para recalcular as diferenças quando os campos forem alterados
        var campos = [
            'valor_din', 'valor_din_real', 'valor_deb', 'valor_deb_real',
            'valor_cred', 'valor_cred_real', 'valor_pix', 'valor_pix_real'
        ];

        campos.forEach(function (campoId) {
            document.getElementById(campoId).addEventListener('input', calcularDiferenças);
        });

        // Calcula as diferenças inicialmente
        calcularDiferenças();
    });




    window.onload = function() {
        // Função para calcular e alterar a cor da diferença
        function calcularDiferenca(ribbonAtualId, oldRibbonId, revRibbonId, difRibbonId) {
            var totalRibbon = parseFloat(document.getElementById(ribbonAtualId).value) || 0;
            var oldRibbon = parseFloat(document.getElementById(oldRibbonId).value) || 0;
            var revRibbon = parseFloat(document.getElementById(revRibbonId).value) || 0;

            var diferenca = oldRibbon - (totalRibbon + revRibbon);

            // Exibindo o valor da diferença no campo difRibbonId
            var difRibbon = document.getElementById(difRibbonId);
            difRibbon.value = diferenca.toFixed(0); // Exibe o valor sem casas decimais

            // Mudando a cor dependendo da diferença
            if (diferenca < 0) {
                difRibbon.style.backgroundColor = '#f8d7da'; // Vermelho para negativo
                difRibbon.style.color = 'red';
            } else {
                difRibbon.style.backgroundColor = '#d4edda'; // Verde para positivo
                difRibbon.style.color = 'green';
            }

            return diferenca; // Retorna a diferença calculada
        }

        // Variável para somar as diferenças
        var totalDiferenca = 0;

        // Função para atualizar o total da diferença
        function atualizarTotalDiferenca() {
            totalDiferenca = 0;

            // Chamar a função para cada ribbon e somar as diferenças
            totalDiferenca += calcularDiferenca("ribbon_1_atual", "ribbon_1_conf", "rev_ribbon_1", "dif_ribbon_1");
            totalDiferenca += calcularDiferenca("ribbon_2_atual", "ribbon_2_conf", "rev_ribbon_2", "dif_ribbon_2");
            totalDiferenca += calcularDiferenca("ribbon_3_atual", "ribbon_3_conf", "rev_ribbon_3", "dif_ribbon_3");
            totalDiferenca += calcularDiferenca("ribbon_4_atual", "ribbon_4_conf", "rev_ribbon_4", "dif_ribbon_4");
            totalDiferenca += calcularDiferenca("ribbon_5_atual", "ribbon_5_conf", "rev_ribbon_5", "dif_ribbon_5");
            totalDiferenca += calcularDiferenca("ribbon_6_atual", "ribbon_6_conf", "rev_ribbon_6", "dif_ribbon_6");

            // Exibir o total da diferença no campo total_dif
            document.getElementById("total_dif").value = totalDiferenca.toFixed(0); // Exibe o total sem casas decimais
        }

        // Chamar a função inicial para calcular o total
        atualizarTotalDiferenca();

        // Adicionar eventos de input para recalcular sempre que o valor de um campo "_atual" mudar
        document.getElementById("ribbon_1_atual").addEventListener("input", atualizarTotalDiferenca);
        document.getElementById("ribbon_2_atual").addEventListener("input", atualizarTotalDiferenca);
        document.getElementById("ribbon_3_atual").addEventListener("input", atualizarTotalDiferenca);
        document.getElementById("ribbon_4_atual").addEventListener("input", atualizarTotalDiferenca);
        document.getElementById("ribbon_5_atual").addEventListener("input", atualizarTotalDiferenca);
        document.getElementById("ribbon_6_atual").addEventListener("input", atualizarTotalDiferenca);
    };



    document.addEventListener("DOMContentLoaded", function () {
        // Seleciona os inputs
        const valorDin = document.getElementById("valor_din");
        const valorDeb = document.getElementById("valor_deb");
        const valorCred = document.getElementById("valor_cred");
        const valorPix = document.getElementById("valor_pix");
        const venda_total_dia = document.getElementById("venda_total_dia");

        // Função para calcular a soma
        function calcularTotal() {
            const din = parseFloat(valorDin.value) || 0;
            const deb = parseFloat(valorDeb.value) || 0;
            const cred = parseFloat(valorCred.value) || 0;
            const pix = parseFloat(valorPix.value) || 0;

            // Atualiza o valor total
            const total = din + deb + cred + pix;
            venda_total_dia.value = total.toFixed(2); // Formata com duas casas decimais
        }

        // Executa o cálculo no carregamento inicial
        calcularTotal();

        // Adiciona listeners caso os valores sejam alterados dinamicamente
        [valorDin, valorDeb, valorCred, valorPix].forEach(input => {
            input.addEventListener("input", calcularTotal);
        });
    });


</SCRIPT>


</body>
</html>
