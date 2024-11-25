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
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalBusca">
                                                <h4>Buscar Fechamento</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modal2">
                                                <h4>Configurações de Materiais</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">
                                                <h4>Configurações Gerais</h4>
                                            </button>
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
                                    <div class="modal fade" id="modalBusca" data-bs-backdrop="static"
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
                                                                                       value="buscaConfDiario"/>
                                                                                <div class="form-row align-items-center">
                                                                                    <div class="col-auto d-flex align-items-end">
                                                                                        <div class="mr-2">
                                                                                            <label for="data_fechamento">Data
                                                                                                Fechamento</label>
                                                                                            <input type="date"
                                                                                                   class="form-control"
                                                                                                   id="data_fechamento"
                                                                                                   name="data_fechamento"
                                                                                                   value="${data_fechamento}">
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
                                                       readonly>
                                            </div>
                                            <div class="col-2">

                                                <label class="float-label">DINHEIRO INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_din" name="valor_din"
                                                       placeholder="" value="${conf_diario.valor_din}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
                                            </div>
                                            <div class="col-2">
                                                <label class="float-label">DÉBITO INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb" name="valor_deb"
                                                       placeholder="" value="${conf_diario.valor_deb}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">CRÉDITO INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred" name="valor_cred"
                                                       placeholder="" value="${conf_diario.valor_cred}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">PIX INF:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix" name="valor_pix"
                                                       placeholder="" value="${conf_diario.valor_pix}"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
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
                                                <label class="float-label">DÉBITO APÓS 24H:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb_24h" name="valor_deb_24h"
                                                       placeholder="" value="${conf_diario.valor_deb_24h}" required
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
                                                <label class="float-label">CRÉDITO APÓS 24H:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred_24h" name="valor_cred_24h"
                                                       placeholder="" value="${conf_diario.valor_cred_24h}" required
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

                                                <label class="float-label">DINHEIRO:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_din_dif" name="valor_din_dif"
                                                       placeholder="" value="${conf_diario.valor_din_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"
                                                readonly>
                                            </div>
                                            <div class="col-2">
                                                <label class="float-label">DÉBITO:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb_dif" name="valor_deb_dif"
                                                       placeholder="" value="${conf_diario.valor_deb_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"READONLY
                                                >
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">CRÉDITO :</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred_dif" name="valor_cred_dif"
                                                       placeholder="" value="${conf_diario.valor_cred_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold"READONLY
                                                >
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">PIX:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix_dif" name="valor_pix_dif"
                                                       placeholder="" value="${conf_diario.valor_pix_dif}"
                                                       style="text-align: center; background-color: black; color: white; font-weight: bold" READONLY
                                                >
                                            </div>

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
                                                        <label style="color: #f2a654">Ribbon 1 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_1_conf" name="old_ribbon_1" value="${conf_diario.old_ribbon_1}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 2 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_2_conf" name="old_ribbon_2" value="${conf_diario.old_ribbon_2}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 1 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_1_atual" name="ribbon_1_atual" value="${conf_diario.total_ribbon_1}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               readonly style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_1" name="dif_ribbon_1" >




                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 2 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_2_atual" name="ribbon_2_atual" value="${conf_diario.total_ribbon_2}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_2" name="dif_ribbon_2" readonly>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 3 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_3_conf" name="old_ribbon_3" value="${conf_diario.old_ribbon_3}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 4 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_4_conf" name="old_ribbon_4" value="${conf_diario.old_ribbon_4}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 3 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_3_atual" name="ribbon_3_atual" value="${conf_diario.total_ribbon_3}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_3" name="dif_ribbon_3" readonly>
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 4 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_4_atual" name="ribbon_4_atual" value="${conf_diario.total_ribbon_4}">

                                                        <label style="color: white">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_4" name="dif_ribbon_4" readonly>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 5 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_5_conf" name="old_ribbon_5" value="${conf_diario.old_ribbon_5}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 6 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_6_conf" name="old_ribbon_6" value="${conf_diario.old_ribbon_6}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 5 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_5_atual" name="ribbon_5_atual" value="${conf_diario.total_ribbon_5}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_5" name="dif_ribbon_5" readonly>
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 6 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_6_atual" name="ribbon_6_atual" value="${conf_diario.total_ribbon_6}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_6" name="dif_ribbon_6" readonly>
                                                    </div>
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
                                <h4 class="card-title" style="text-align: center">DESPESAS E DESCONTOS</h4>
                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->


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



    document.addEventListener('DOMContentLoaded', function () {
        // Função para calcular a diferença e atualizar os campos
        function calcularDiferenças() {
            // Obtém os valores dos campos
            var valorDin = parseFloat(document.getElementById('valor_din').value.replace(',', '.')) || 0;
            var valorDinReal = parseFloat(document.getElementById('valor_din_real').value.replace(',', '.')) || 0;

            var valorDeb = parseFloat(document.getElementById('valor_deb').value.replace(',', '.')) || 0;
            var valorDebReal = parseFloat(document.getElementById('valor_deb_real').value.replace(',', '.')) || 0;
            var valorDeb24h = parseFloat(document.getElementById('valor_deb_24h').value.replace(',', '.')) || 0;

            var valorCred = parseFloat(document.getElementById('valor_cred').value.replace(',', '.')) || 0;
            var valorCredReal = parseFloat(document.getElementById('valor_cred_real').value.replace(',', '.')) || 0;
            var valorCred24h = parseFloat(document.getElementById('valor_cred_24h').value.replace(',', '.')) || 0;

            var valorPix = parseFloat(document.getElementById('valor_pix').value.replace(',', '.')) || 0;
            var valorPixReal = parseFloat(document.getElementById('valor_pix_real').value.replace(',', '.')) || 0;

            // Calcula as diferenças
            var valorDinDif =  valorDinReal - valorDin;
            var valorDebDif = (valorDebReal + valorDeb24h) - valorDeb ;
            var valorCredDif = (valorCredReal + valorCred24h) - valorCred ;
            var valorPixDif = valorPixReal - valorPix ;

            // Atualiza os campos de diferença
            atualizarCampo('valor_din_dif', valorDinDif);
            atualizarCampo('valor_deb_dif', valorDebDif);
            atualizarCampo('valor_cred_dif', valorCredDif);
            atualizarCampo('valor_pix_dif', valorPixDif);
        }

        // Função para atualizar o campo e mudar a cor conforme o valor
        function atualizarCampo(campoId, valor) {
            var campo = document.getElementById(campoId);
            campo.value = valor.toFixed(2);  // Formata o número para 2 casas decimais

            if (valor < 0) {
                campo.style.color = 'red';  // Se negativo, cor vermelha
                campo.value = '-' + Math.abs(valor).toFixed(2);  // Adiciona o sinal negativo
            } else {
                campo.style.color = 'green';  // Se positivo, cor verde
            }
        }

        // Adiciona evento para recalcular as diferenças quando os campos forem alterados
        var campos = [
            'valor_din', 'valor_din_real', 'valor_deb', 'valor_deb_real', 'valor_deb_24h',
            'valor_cred', 'valor_cred_real', 'valor_cred_24h', 'valor_pix', 'valor_pix_real'
        ];

        campos.forEach(function (campoId) {
            document.getElementById(campoId).addEventListener('input', calcularDiferenças);
        });

        // Calcula as diferenças inicialmente
        calcularDiferenças();
    });









    window.onload = function() {
        atualizarDiferencas(); // Inicializa as diferenças
        calcularTotalDif(); // Inicializa o total de revisões
        calcularDiferencas()

    };






    function calcularDiferencas() {
        // Ribbon 1
        const ribbon1Conf = parseFloat(document.getElementById('ribbon_1_conf').value) || 0;
        const ribbon1Atual = parseFloat(document.getElementById('ribbon_1_atual').value) || 0;
        document.getElementById('dif_ribbon_1').value = ribbon1Conf - ribbon1Atual;

        // Ribbon 2
        const ribbon2Conf = parseFloat(document.getElementById('ribbon_2_conf').value) || 0;
        const ribbon2Atual = parseFloat(document.getElementById('ribbon_2_atual').value) || 0;
        document.getElementById('dif_ribbon_2').value = ribbon2Conf - ribbon2Atual;

        // Ribbon 3
        const ribbon3Conf = parseFloat(document.getElementById('ribbon_3_conf').value) || 0;
        const ribbon3Atual = parseFloat(document.getElementById('ribbon_3_atual').value) || 0;
        document.getElementById('dif_ribbon_3').value = ribbon3Conf - ribbon3Atual;

        // Ribbon 4
        const ribbon4Conf = parseFloat(document.getElementById('ribbon_4_conf').value) || 0;
        const ribbon4Atual = parseFloat(document.getElementById('ribbon_4_atual').value) || 0;
        document.getElementById('dif_ribbon_4').value = ribbon4Conf - ribbon4Atual;

        // Ribbon 5
        const ribbon5Conf = parseFloat(document.getElementById('ribbon_5_conf').value) || 0;
        const ribbon5Atual = parseFloat(document.getElementById('ribbon_5_atual').value) || 0;
        document.getElementById('dif_ribbon_5').value = ribbon5Conf - ribbon5Atual;

        // Ribbon 6
        const ribbon6Conf = parseFloat(document.getElementById('ribbon_6_conf').value) || 0;
        const ribbon6Atual = parseFloat(document.getElementById('ribbon_6_atual').value) || 0;
        document.getElementById('dif_ribbon_6').value = ribbon6Conf - ribbon6Atual;
    }

    // Função para calcular o total de diferenças
    function calcularTotalDif() {
        const difRibbon1 = parseFloat(document.getElementById('dif_ribbon_1').value) || 0;
        const difRibbon2 = parseFloat(document.getElementById('dif_ribbon_2').value) || 0;
        const difRibbon3 = parseFloat(document.getElementById('dif_ribbon_3').value) || 0;
        const difRibbon4 = parseFloat(document.getElementById('dif_ribbon_4').value) || 0;
        const difRibbon5 = parseFloat(document.getElementById('dif_ribbon_5').value) || 0;
        const difRibbon6 = parseFloat(document.getElementById('dif_ribbon_6').value) || 0;

        const total = difRibbon1 + difRibbon2 + difRibbon3 + difRibbon4 + difRibbon5 + difRibbon6;

        document.getElementById('total_rev').value = total;
    }
    // Adiciona event listeners para os campos _atual
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('ribbon_1_atual').addEventListener('input', calcularDiferencas);
        document.getElementById('ribbon_2_atual').addEventListener('input', calcularDiferencas);
        document.getElementById('ribbon_3_atual').addEventListener('input', calcularDiferencas);
        document.getElementById('ribbon_4_atual').addEventListener('input', calcularDiferencas);
        document.getElementById('ribbon_5_atual').addEventListener('input', calcularDiferencas);
        document.getElementById('ribbon_6_atual').addEventListener('input', calcularDiferencas);

        // Chama a função ao carregar a página para calcular as diferenças iniciais
        calcularDiferencas();
    });
    // Adicionando listeners para os campos _atual
    document.getElementById('ribbon_1_atual').addEventListener('input', atualizarDiferencas);
    document.getElementById('ribbon_2_atual').addEventListener('input', atualizarDiferencas);
    document.getElementById('ribbon_3_atual').addEventListener('input', atualizarDiferencas);
    document.getElementById('ribbon_4_atual').addEventListener('input', atualizarDiferencas);
    document.getElementById('ribbon_5_atual').addEventListener('input', atualizarDiferencas);
    document.getElementById('ribbon_6_atual').addEventListener('input', atualizarDiferencas);

    // Adicionando listeners para os campos dif_
    document.getElementById('dif_ribbon_1').addEventListener('input', calcularTotalDif);
    document.getElementById('dif_ribbon_2').addEventListener('input', calcularTotalDif);
    document.getElementById('dif_ribbon_3').addEventListener('input', calcularTotalDif);
    document.getElementById('dif_ribbon_4').addEventListener('input', calcularTotalDif);
    document.getElementById('dif_ribbon_5').addEventListener('input', calcularTotalDif);
    document.getElementById('dif_ribbon_6').addEventListener('input', calcularTotalDif);



    // Função para atualizar as diferenças quando os campos _atual forem alterados
    function atualizarDiferencas() {
        const ribbon1Conf = parseFloat(document.getElementById('ribbon_1_conf').value) || 0;
        const ribbon1Atual = parseFloat(document.getElementById('ribbon_1_atual').value) || 0;
        document.getElementById('dif_ribbon_1').value = ribbon1Conf - ribbon1Atual;

        const ribbon2Conf = parseFloat(document.getElementById('ribbon_2_conf').value) || 0;
        const ribbon2Atual = parseFloat(document.getElementById('ribbon_2_atual').value) || 0;
        document.getElementById('dif_ribbon_2').value = ribbon2Conf - ribbon2Atual;

        const ribbon3Conf = parseFloat(document.getElementById('ribbon_3_conf').value) || 0;
        const ribbon3Atual = parseFloat(document.getElementById('ribbon_3_atual').value) || 0;
        document.getElementById('dif_ribbon_3').value = ribbon3Conf - ribbon3Atual;

        const ribbon4Conf = parseFloat(document.getElementById('ribbon_4_conf').value) || 0;
        const ribbon4Atual = parseFloat(document.getElementById('ribbon_4_atual').value) || 0;
        document.getElementById('dif_ribbon_4').value = ribbon4Conf - ribbon4Atual;

        const ribbon5Conf = parseFloat(document.getElementById('ribbon_5_conf').value) || 0;
        const ribbon5Atual = parseFloat(document.getElementById('ribbon_5_atual').value) || 0;
        document.getElementById('dif_ribbon_5').value = ribbon5Conf - ribbon5Atual;

        const ribbon6Conf = parseFloat(document.getElementById('ribbon_6_conf').value) || 0;
        const ribbon6Atual = parseFloat(document.getElementById('ribbon_6_atual').value) || 0;
        document.getElementById('dif_ribbon_6').value = ribbon6Conf - ribbon6Atual;

        // Atualiza a soma total de diferenças
        calcularTotalDif();
    }
</SCRIPT>


</body>
</html>
