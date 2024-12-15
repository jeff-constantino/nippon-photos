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
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalPDV">
                                                <h4>Venda Diária</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalPDV" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Vendas do dia</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <form action="<%= request.getContextPath() %>/ServletFechaDia"
                                                                      method="get" id="formFechaTotal"
                                                                      name="formFechaTotal">
                                                                    <input type="hidden" name="acao"
                                                                           value="buscaData"/>
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
                                                                                    Gerar Fechamento
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>


                                                                </form>
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR</button>
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
                                        <form action="<%= request.getContextPath() %>/ServletFechaDia"
                                              method="post" id="formBuscarFechamento"
                                              name="formBuscarFechamento">
                                            <input type="hidden" name="acao" value="">
                                            <div class="col-sm-1">
                                                <label class="float-label">ID:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control" id="FechaId"
                                                       name="id" placeholder=""
                                                       style="background-color: black" readonly
                                                       value="${fechamento != null ? fechamento.id : ''}">
                                            </div>
                                            <div class="col-6">
                                                <div class="col-auto">
                                                    <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-3">
                                                    <label for="dataFechamento">Data do
                                                        Fechamento:</label>
                                                    <input type="date" class="form-control"
                                                           id="dataFechamento"
                                                           name="data_fechamento" required
                                                           value="${fechamento != null ? fechamento.data_fechamento : ''}">
                                                </div>

                                                <div class="col-6">
                                                    <label class="float-label">Observações:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control"
                                                           id="observacao" name="observacao"
                                                           placeholder=""
                                                           style="background-color: black" readonly
                                                           value="${fechamento != null ? fechamento.observacao : ''}">
                                                </div>

                                                <div class="col-2">
                                                    <label class="float-label">TOTAL DE
                                                        FOTOS:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control"
                                                           id="total_total" name="total_total"
                                                           placeholder=""
                                                           style="background-color: white; color: black"
                                                           disabled>
                                                </div>
                                            </div>

                                            <!-- Seções para FOTOS, ENCARTE e DIGITAIS em linha -->
                                            <div class="row mt-3">
                                                <div class="col-4 text-center">
                                                    <h5 style="color: #f2a654">FOTOS</h5>
                                                </div>
                                                <div class="col-4 text-center">
                                                    <h5 style="color: #00d25b">ENCARTES</h5>
                                                </div>
                                                <div class="col-4 text-center">
                                                    <h5 style="color: fuchsia">DIGITAIS</h5>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <!-- Inputs para FOTOS -->
                                                <div class="col-4">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Fotos
                                                                Dinheiro</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #f2a654; color: black; font-weight: bold"
                                                                   disabled id="total_ft_din"
                                                                   name="total_ft_din"
                                                                   value="${fechamento != null ? fechamento.total_ft_din : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Fotos
                                                                Débito</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #f2a654; color: black; font-weight: bold"
                                                                   disabled id="total_ft_deb"
                                                                   name="total_ft_deb"
                                                                   value="${fechamento != null ? fechamento.total_ft_deb : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Fotos
                                                                Crédito</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #f2a654; color: black; font-weight: bold"
                                                                   disabled id="total_ft_cred"
                                                                   name="total_ft_cred"
                                                                   value="${fechamento != null ? fechamento.total_ft_cred : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Fotos
                                                                Pix</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #f2a654; color: black; font-weight: bold"
                                                                   disabled id="total_ft_pix"
                                                                   name="total_ft_pix"
                                                                   value="${fechamento != null ? fechamento.total_ft_pix : ''}">
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Inputs para ENCARTE -->
                                                <div class="col-4">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <label style="color: #00d25b">Encartes
                                                                Dinheiro</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #73b307; color: black; font-weight: bold"
                                                                   disabled id="total_enc_din"
                                                                   name="total_enc_din"
                                                                   value="${fechamento != null ? fechamento.total_enc_din : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #00d25b">Encartes
                                                                Débito</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #73b307; color: black; font-weight: bold"
                                                                   disabled id="total_enc_deb"
                                                                   name="total_enc_deb"
                                                                   value="${fechamento != null ? fechamento.total_enc_deb : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #00d25b">Encartes
                                                                Crédito</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #73b307; color: black; font-weight: bold"
                                                                   disabled id="total_enc_cred"
                                                                   name="total_enc_cred"
                                                                   value="${fechamento != null ? fechamento.total_enc_cred : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #00d25b">Encartes
                                                                Pix</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: #73b307; color: black; font-weight: bold"
                                                                   disabled id="total_enc_pix"
                                                                   name="total_enc_pix"
                                                                   value="${fechamento != null ? fechamento.total_enc_pix : ''}">
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Inputs para DIGITAIS -->
                                                <div class="col-4">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <label style="color: fuchsia">Digitais
                                                                Dinheiro</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: fuchsia; color: black; font-weight: bold"
                                                                   disabled id="total_dig_din"
                                                                   name="total_dig_din"
                                                                   value="${fechamento != null ? fechamento.total_dig_din : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: fuchsia">Digitais
                                                                Débito</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: fuchsia; color: black; font-weight: bold"
                                                                   disabled id="total_dig_deb"
                                                                   name="total_dig_deb"
                                                                   value="${fechamento != null ? fechamento.total_dig_deb : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: fuchsia">Digitais
                                                                Crédito</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: fuchsia; color: black; font-weight: bold"
                                                                   disabled id="total_dig_cred"
                                                                   name="total_dig_cred"
                                                                   value="${fechamento != null ? fechamento.total_dig_cred : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: fuchsia">Digitais
                                                                Pix</label>
                                                            <input type="number"
                                                                   class="form-control"
                                                                   placeholder=""
                                                                   style="background-color: fuchsia; color: black; font-weight: bold"
                                                                   disabled id="total_dig_pix"
                                                                   name="total_dig_pix"
                                                                   value="${fechamento != null ? fechamento.total_dig_pix : ''}">
                                                        </div>

                                                    </div>

                                                </div>
                                                <%--  Ribbons--%>
                                                <!-- Seções para FOTOS, ENCARTE e DIGITAIS em linha -->
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
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_1_conf" name="ribbon_1_conf"
                                                                   value="${fechamento != null ? fechamento.ribbon_1_conf : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 2 Conf</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_2_conf" name="ribbon_2_conf"
                                                                   value="${fechamento != null ? fechamento.ribbon_2_conf : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 1 Atual</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_1" name="ribbon_1"
                                                                   value="${fechamento != null ? fechamento._ribbon_1_atual : ''}">

                                                            <label style="color: #f2a654">Diferença</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   id="dif_ribbon_1" name="dif_ribbon_1" readonly>
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 2 Atual</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_2" name="ribbon_2"
                                                                   value="${fechamento != null ? fechamento.ribbon_2_atual : ''}">
                                                            <label style="color: #f2a654">Diferença</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   id="dif_ribbon_2" name="dif_ribbon_2" readonly>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Inputs para ENCARTE -->
                                                <div class="col-4">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 3 Conf</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_3_conf" name="ribbon_3_conf"
                                                                   value="${fechamento != null ? fechamento.ribbon_3_conf : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 4 Conf</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_4_conf" name="ribbon_4_conf"
                                                                   value="${fechamento != null ? fechamento.ribbon_4_conf : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 3 Atual</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_3" name="ribbon_3"
                                                                   value="${fechamento != null ? fechamento.ribbon_3_atual : ''}">
                                                            <label style="color: #f2a654">Diferença</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   id="dif_ribbon_3" name="dif_ribbon_3" readonly>
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: #f2a654">Ribbon 4 Atual</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_4" name="ribbon_4"
                                                                   value="${fechamento != null ? fechamento.ribbon_4_atual : ''}">
                                                            <label style="color: white">Diferença</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   id="dif_ribbon_4" name="dif_ribbon_4" readonly>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Inputs para DIGITAIS -->
                                                <div class="col-4">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <label style="color: f2a654">Ribbon 5 Conf</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_5_conf" name="ribbon_5_conf"
                                                                   value="${fechamento != null ? fechamento.ribbon_5_conf : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: f2a654">Ribbon 6 Conf</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_6_conf" name="ribbon_6_conf"
                                                                   value="${fechamento != null ? fechamento.ribbon_6_conf : ''}">
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: f2a654">Ribbon 5 Atual</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_5" name="ribbon_5"
                                                                   value="${fechamento != null ? fechamento.ribbon_5_atual : ''}">
                                                            <label style="color: f2a654">Diferença</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   id="dif_ribbon_5" name="dif_ribbon_5" readonly>
                                                        </div>

                                                        <div class="col-6">
                                                            <label style="color: f2a654">Ribbon 6 Atual</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   disabled id="ribbon_6" name="ribbon_6"
                                                                   value="${fechamento != null ? fechamento.ribbon_6_atual : ''}">
                                                            <label style="color: f2a654">Diferença</label>
                                                            <input type="number" class="form-control" placeholder=""
                                                                   style="background-color: white; color: black; font-weight: bold"
                                                                   id="dif_ribbon_6" name="dif_ribbon_6" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <input type="submit" class="btn btn-primary"
                                                           value="Atualizar Fechamento">
                                                </div>
                                            </div>
                                        </form>
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
</SCRIPT>


</body>
</html>
