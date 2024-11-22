
<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelVendas" %>
<%@ page import="dao.DAOFechaDia" %>
<%@ page import="model.ModelFechaDia" %>
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
            <div class="content-wrapper" style="min-height: calc(100vh - 70px);">
                <div class="row">
                    <div class="col-xl-12">

                        <div class="modal fade" id="modalLancaFechamento" data-bs-backdrop="static"
                             data-bs-keyboard="false"
                             tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog modal-xl mt-5">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Lançamento de vendas </h5>

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

                        <div class="modal fade" id="modalBuscaFechamento" data-bs-backdrop="static"
                             data-bs-keyboard="false"  aria-labelledby="staticBackdropLabel"
                             aria-hidden="true">
                            <div class="modal-dialog modal-xl mt-5">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Selecione a Data do Fechamento</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="<%= request.getContextPath() %>/ServletFechaDia"
                                              method="get" id="formBuscaFechamento">
                                            <input type="hidden" name="acao" value="buscarfechamento"/>
                                            <div class="col-3">
                                                <label  class="form-label">Data do Fechamento :</label>
                                                <div class="input-group">
                                                    <input type="date" class="form-control" id="data_fecha"
                                                           name="data_fechamento" required
                                                           placeholder=""/>
                                                    <button type="submit" class="btn btn-outline-success">
                                                        Buscar
                                                    </button>
                                                </div>

                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-light"
                                                data-bs-dismiss="modal">Sair
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">

                                <div class="card-body" >
                                    <button type="button" class="btn btn-outline-warning"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalLancaFechamento">
                                        <h4>Finalizar Dia</h4>
                                    </button>
                                    <button type="button" class="btn btn-outline-danger"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalBuscaFechamento">
                                        <h4>Pesquisar Fechamentos</h4>
                                    </button>


                                    <%--PAGINA PRINCIPAL                  --%>

                                    <form action="<%= request.getContextPath() %>/ServletFechaDia"
                                          method="post" id="formBuscarFechamento">

                                        <div class="col-sm-1">
                                            <label class="float-label">ID:</label>
                                            <span class="form-bar"></span>
                                            <input type="text" class="form-control" id="FechaId"
                                                   name="id" placeholder=""
                                                   style="text-align: center; background-color: black" readonly
                                                   value="${fechamento.id}">
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
                                                       value="${fechamento.data_fechamento}">
                                            </div>

                                            <div class="col-6">
                                                <label class="float-label">Observações:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="observacao" name="observacao"
                                                       placeholder=""
                                                       style="text-align: center; background-color: white; color: black"
                                                       value="${fechamento.observacao}">
                                            </div>

                                            <%
                                                ModelFechaDia fechamento = (ModelFechaDia) request.getAttribute("fechamento");
                                                // Inicializar totalFotos e totalInformado como 0 para evitar NullPointerException
                                                int totalFotos = 0;
                                                int totalInformado = 0;

                                                if (fechamento != null) {
                                                    // Obtém os valores do fechamento
                                                    int totalFtDin = fechamento.getTotal_ft_din();
                                                    int totalFtDeb = fechamento.getTotal_ft_deb();
                                                    int totalFtCred = fechamento.getTotal_ft_cred();
                                                    int totalFtPix = fechamento.getTotal_ft_pix();

                                                    // Realizar a soma das fotos
                                                    totalFotos = totalFtDin + totalFtDeb + totalFtCred + totalFtPix;

                                                    // Calcular o total informado somando totalFotos e fechamento.sobras
                                                    totalInformado = totalFotos + fechamento.getSobras();
                                                }
                                            %>

                                            <div class="col-2">
                                                <label class="float-label">TOTAL DE FOTOS :</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="total_total" name="total_total"
                                                       placeholder="" value="<%= totalFotos %>"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
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
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               readonly id="total_ft_din"
                                                               name="total_ft_din"
                                                               value="${fechamento.total_ft_din}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Fotos
                                                            Débito</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               readonly  id="_total_ft_deb"
                                                               name="total_ft_deb"
                                                               value="${fechamento.total_ft_deb}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Fotos
                                                            Crédito</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               readonly  id="_total_ft_cred"
                                                               name="total_ft_cred"
                                                               value="${fechamento.total_ft_cred}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Fotos
                                                            Pix</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               readonly  id="_total_ft_pix"
                                                               name="total_ft_pix"
                                                               value="${fechamento.total_ft_pix}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">SOBRAS</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               id="sobras"
                                                               name="sobras"
                                                               value="${fechamento.sobras}">
                                                    </div>
                                                    <div class="col-6">
                                                        <label style="color: white">Descontos</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="desconto"
                                                               name="desconto"
                                                               value="${fechamento.desconto}">
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
                                                               style="text-align: center; background-color: #73b307; color: black; font-weight: bold"
                                                               readonly  id="_total_enc_din"
                                                               name="total_enc_din"
                                                               value="${fechamento.total_enc_din}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #00d25b">Encartes
                                                            Débito</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #73b307; color: black; font-weight: bold"
                                                               readonly  id="_total_enc_deb"
                                                               name="total_enc_deb"
                                                               value="${fechamento.total_enc_deb}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #00d25b">Encartes
                                                            Crédito</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #73b307; color: black; font-weight: bold"
                                                               readonly  id="_total_enc_cred"
                                                               name="total_enc_cred"
                                                               value="${fechamento.total_enc_cred}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #00d25b">Encartes
                                                            Pix</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: #73b307; color: black; font-weight: bold"
                                                               readonly  id="_total_enc_pix"
                                                               name="total_enc_pix"
                                                               value="${fechamento.total_enc_pix}">
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
                                                               style="text-align: center; background-color: fuchsia; color: black; font-weight: bold"
                                                               readonly  id="_total_dig_din"
                                                               name="total_dig_din"
                                                               value="${fechamento.total_dig_din}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: fuchsia">Digitais
                                                            Débito</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: fuchsia; color: black; font-weight: bold"
                                                               readonly  id="_total_dig_deb"
                                                               name="total_dig_deb"
                                                               value="${fechamento.total_dig_deb}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: fuchsia">Digitais
                                                            Crédito</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: fuchsia; color: black; font-weight: bold"
                                                               readonly  id="_total_dig_cred"
                                                               name="total_dig_cred"
                                                               value="${fechamento.total_dig_cred}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: fuchsia">Digitais
                                                            Pix</label>
                                                        <input type="number"
                                                               class="form-control"
                                                               placeholder=""
                                                               style="text-align: center; background-color: fuchsia; color: black; font-weight: bold"
                                                               readonly  id="_total_dig_pix"
                                                               name="total_dig_pix"
                                                               value="${fechamento.total_dig_pix}">
                                                    </div>

                                                </div>


                                            </div>
<%--  Ribbons--%>

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
                                                               tabindex="-1" readonly id="ribbon_1_conf" name="old_ribbon_1" value="${fechamento.old_ribbon_1}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 2 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_2_conf" name="old_ribbon_2" value="${fechamento.old_ribbon_2}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 1 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_1_atual" name="ribbon_1_atual" value="${fechamento.total_ribbon_1}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               readonly style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_1" name="dif_ribbon_1" >




                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 2 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_2_atual" name="ribbon_2_atual" value="${fechamento.total_ribbon_2}">

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
                                                               tabindex="-1" readonly id="ribbon_3_conf" name="old_ribbon_3" value="${fechamento.old_ribbon_3}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 4 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_4_conf" name="old_ribbon_4" value="${fechamento.old_ribbon_4}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 3 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_3_atual" name="ribbon_3_atual" value="${fechamento.total_ribbon_3}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_3" name="dif_ribbon_3" readonly>
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 4 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_4_atual" name="ribbon_4_atual" value="${fechamento.total_ribbon_4}">

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
                                                               tabindex="-1" readonly id="ribbon_5_conf" name="old_ribbon_5" value="${fechamento.old_ribbon_5}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 6 Conf</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="ribbon_6_conf" name="old_ribbon_6" value="${fechamento.old_ribbon_6}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 5 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_5_atual" name="ribbon_5_atual" value="${fechamento.total_ribbon_5}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_5" name="dif_ribbon_5" readonly>
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 6 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_6_atual" name="ribbon_6_atual" value="${fechamento.total_ribbon_6}">

                                                        <label style="color: #f2a654">Diferença</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                               tabindex="-1" readonly id="dif_ribbon_6" name="dif_ribbon_6" readonly>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row mt-3 text-center d-flex justify-content-center">
                                            <div class="col-auto">
                                                <h5 style="color: white">TOTAL REVELADO</h5>
                                                <input type="number" class="form-control"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold; width: 150px;"
                                                       id="total_rev" name="total_rev" readonly>
                                            </div>
                                            <div class="col-auto">
                                                <h5 style="color: white">TOTAL INFORMADO</h5>
                                                <input type="number" class="form-control"
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold; width: 150px;" value="<%= totalInformado %>"
                                                       id="total_inf" name="total_inf" readonly>
                                            </div>
                                        </div>


                                        <div class="row mt-3">
                                            <div class="col-lg-12 text-center">
                                                <h5 style="color: white">CONFERÊNCIA DE VALORES</h5>
                                            </div>
                                        </div>

                                        <div  class="row mt-3 text-center d-flex justify-content-center">
                                            <div class="col-2">

                                                <label class="float-label">TOTAL DINHEIRO:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_din" name="valor_din"
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
                                            </div>
                                            <div class="col-2">
                                                <label class="float-label">TOTAL DÉBITO:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb" name="valor_deb"
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">TOTAL CRÉDITO:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred" name="valor_cred"
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: #f2a654; color: black; font-weight: bold"
                                                       readonly>
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">TOTAL PIX:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix" name="valor_pix"
                                                       placeholder="" value=""
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
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>
                                            <div class="col-2">
                                                <label class="float-label">DÉBITO NA CONTA :</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_deb_real" name="valor_deb_real"
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">CRÉDITO NA CONTA :</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_cred_real" name="valor_cred_real"
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>

                                            <div class="col-2">
                                                <label class="float-label">PIX NA CONTA:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="valor_pix_real" name="valor_pix_real"
                                                       placeholder="" value=""
                                                       style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                >
                                            </div>

                                        </div>




                                        <div class="row mt-3">
                                            <div class="col-4">
                                                <button type="submit" class="btn btn-outline-success"
                                                        value="Realizar Fechamento">Realizar Fechamento </button>
                                                <button type="button" class="btn btn-outline-light" onclick="enviarAtualizar()">Atualizar Fechamento</button>
                                            </div>
                                        </div>


                                    </form>

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
        $(document).ready(function() {
            var msg = "${msg}";
            if (msg) {
                $('#msgModal').modal('show'); // Exibe o modal com a mensagem
            }
        });



        // Chamar a função ao carregar a página para inicializar o total
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

        // // Chamar a função quando qualquer campo que participa do cálculo for alterado
        // document.getElementById('total_ft_din').addEventListener('input', calcularTotalFotos);
        // document.getElementById('total_ft_deb').addEventListener('input', calcularTotalFotos);
        // document.getElementById('total_ft_cred').addEventListener('input', calcularTotalFotos);
        // document.getElementById('total_ft_pix').addEventListener('input', calcularTotalFotos);

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







        function enviarAtualizar() {
            var form = document.getElementById('formBuscarFechamento');
            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'acao';
            input.value = 'atualizarFechamento';
            form.appendChild(input);
            form.submit();
        }


        // Configurações obtidas do backend, com validação para evitar NaN
        const conf1_valor = parseFloat("${conf1_valor}") || 0;
        const conf2_valor = parseFloat("${conf2_valor}") || 0;
        const conf3_valor = parseFloat("${conf3_valor}") || 0;



        // Função para calcular e exibir os resultados
        function calcularValores() {
            // FOTOS
            const fotos_din = parseFloat(document.getElementById("total_ft_din").value || 0);
            const fotos_deb = parseFloat(document.getElementById("_total_ft_deb").value || 0);
            const fotos_cred = parseFloat(document.getElementById("_total_ft_cred").value || 0);
            const fotos_pix = parseFloat(document.getElementById("_total_ft_pix").value || 0);

            // ENCARTES
            const encartes_din = parseFloat(document.getElementById("_total_enc_din").value || 0);
            const encartes_deb = parseFloat(document.getElementById("_total_enc_deb").value || 0);
            const encartes_cred = parseFloat(document.getElementById("_total_enc_cred").value || 0);
            const encartes_pix = parseFloat(document.getElementById("_total_enc_pix").value || 0);

            // DIGITAIS
            const digitais_din = parseFloat(document.getElementById("_total_dig_din").value || 0);
            const digitais_deb = parseFloat(document.getElementById("_total_dig_deb").value || 0);
            const digitais_cred = parseFloat(document.getElementById("_total_dig_cred").value || 0);
            const digitais_pix = parseFloat(document.getElementById("_total_dig_pix").value || 0);

            // Valor do desconto
            const desconto = parseFloat(document.getElementById("desconto").value || 0);

            // Totais por tipo de pagamento
            const total_dinheiro =
                (fotos_din * conf1_valor) +
                (encartes_din * conf2_valor) +
                (digitais_din * conf3_valor) -
                desconto;

            const total_debito = (fotos_deb * conf1_valor) + (encartes_deb * conf2_valor) + (digitais_deb * conf3_valor);
            const total_credito = (fotos_cred * conf1_valor) + (encartes_cred * conf2_valor) + (digitais_cred * conf3_valor);
            const total_pix = (fotos_pix * conf1_valor) + (encartes_pix * conf2_valor) + (digitais_pix * conf3_valor);

            // Exibindo os valores nos campos correspondentes
            document.getElementById("valor_din").value = total_dinheiro.toFixed(2);
            document.getElementById("valor_deb").value = total_debito.toFixed(2);
            document.getElementById("valor_cred").value = total_credito.toFixed(2);
            document.getElementById("valor_pix").value = total_pix.toFixed(2);
        }

        // Adiciona um listener ao campo de desconto
        document.getElementById("desconto").addEventListener("input", calcularValores);




    </SCRIPT>
</body>
</html>