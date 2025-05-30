<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelVendas" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div class="content-wrapper" style="min-height: calc(100vh - 70px);">
                <div class="row">
                    <div class="col-xl-12">


                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">

                                <div class="card-body">


                                    <%--PAGINA PRINCIPAL                  --%>

                                    <div class="modal fade" id="modalBuscaVenda" data-bs-backdrop="static"
                                         data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
                                         aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Pesquisa de Vendas</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="<%= request.getContextPath() %>/ServletVendas"
                                                          method="get" id="formBuscaVenda">
                                                        <input type="hidden" name="acao" value="gerenciarVenda"/>
                                                        <div class="col-3">
                                                            <label for="venda_id" class="form-label">ID da
                                                                Venda:</label>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="venda_id"
                                                                       name="venda_id" required
                                                                       placeholder="Digite o ID da venda"/>
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

                                    <div class="modal fade" id="modalLancaVenda" data-bs-backdrop="static"
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
                                                                    <!-- Basic Form Inputs card start -->
                                                                    <div class="card">
                                                                        <div class="card-block">

                                                                            <form class="form-material"
                                                                                  id="formBuscaFuncionario"
                                                                                  method="get"
                                                                                  action="<%= request.getContextPath() %>/ServletVendas">

                                                                                <div class="row">

                                                                                    <div class="col-4">


                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               id="nomeBusca"
                                                                                               name="nome"
                                                                                               placeholder=""
                                                                                               style="background-color: black"
                                                                                               REQUIRED
                                                                                               AUTOFOCUS
                                                                                               autocomplete="off">

                                                                                    </div>

                                                                                    <div>



                                                                                        <button type="button"
                                                                                                class="btn btn-outline-success waves-effect waves-light"
                                                                                                onclick="buscarFunc();">
                                                                                            Pesquisar
                                                                                        </button>


                                                                                        <%--  BOTOES MODAL busca--%>
                                                                                    </div>
                                                                                    <div style="overflow-x: hidden">
                                                                                        <div style="height: 300px; overflow-y: auto ">
                                                                                            <table class="table"
                                                                                                   id="tabelabuscafuncionario">
                                                                                                <thead>
                                                                                                <tr>
                                                                                                    <th scope="col">ID
                                                                                                    </th>
                                                                                                    <th scope="col">
                                                                                                        NOME
                                                                                                    </th>
                                                                                                    <th scope="col">
                                                                                                        OPÇÕES
                                                                                                    </th>

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
                                                                            <!-- Adicione o formulário da venda aqui -->
                                                                            <form action="<%= request.getContextPath() %>/ServletVendas"
                                                                                  method="post" id="formBuscarVenda"
                                                                                  name="formBuscarVenda">
                                                                                <input type="hidden" name="acao"
                                                                                       value="">
                                                                                <div class="col-sm-1">
                                                                                    <label class="float-label">VENDA
                                                                                        ID:</label>
                                                                                    <span class="form-bar"></span>
                                                                                    <input type="text"
                                                                                           class="form-control"
                                                                                           id="venda_id"
                                                                                           name="venda_id"
                                                                                           placeholder=""
                                                                                           style="background-color: black"
                                                                                           readonly
                                                                                           value="${modelVendas.venda_id}">
                                                                                </div>
                                                                                <div class="col-6">
                                                                                    <div class="col-auto">
                                                                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-3">
                                                                                        <label for="outer_dataVenda">Data
                                                                                            da Venda</label>
                                                                                        <input type="date"
                                                                                               class="form-control"
                                                                                               id="outer_dataVenda"
                                                                                               name="dataVenda"
                                                                                               required
                                                                                               value="${formattedDataVenda != null ? formattedDataVenda : ''}">
                                                                                    </div>
                                                                                    <div class="col-sm-1">
                                                                                        <label class="float-label">ID:</label>
                                                                                        <span class="form-bar"></span>
                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               id="vendedor_id"
                                                                                               name="vendedor_id"
                                                                                               placeholder=""
                                                                                               style="background-color: black"
                                                                                               readonly
                                                                                               value="${modelVendas.id}">
                                                                                    </div>
                                                                                    <div class="col-6">
                                                                                        <label class="float-label">FUNCIONÁRIO:</label>
                                                                                        <span class="form-bar"></span>
                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               id="vendedor" name="nome"
                                                                                               placeholder=""
                                                                                               style="background-color: black"
                                                                                               readonly
                                                                                               value="${modelVendas.nome}">
                                                                                    </div>
                                                                                    <div class="col-2">
                                                                                        <label class="float-label">TOTAL
                                                                                            DE FOTOS:</label>
                                                                                        <span class="form-bar"></span>
                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               id="total"
                                                                                               name="total"
                                                                                               placeholder=""
                                                                                               style="background-color: white; color: black"
                                                                                               readonly
                                                                                               oninput="buscarValorModal('total')">
                                                                                    </div>
                                                                                </div>


                                                                                <!-- Seções para FOTOS, ENCARTE e DIGITAIS em linha -->
                                                                                <div class="row mt-3">
                                                                                    <div class="col-4 text-center">
                                                                                        <h5 style="color: #f2a654">
                                                                                            FOTOS</h5>
                                                                                    </div>
                                                                                    <div class="col-4 text-center">
                                                                                        <h5 STYLE="color: #00d25b">
                                                                                            ENCARTES</h5>
                                                                                    </div>
                                                                                    <div class="col-4 text-center">
                                                                                        <h5 style="color: fuchsia">
                                                                                            DIGITAIS</h5>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row">
                                                                                    <!-- Inputs para FOTOS -->
                                                                                    <div class="col-4">
                                                                                        <div class="row">
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">DINHEIRO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       id="prod1_din"
                                                                                                       name="prod1_din"
                                                                                                       required
                                                                                                       value="${modelVendas.prod1_din}"
                                                                                                       oninput="buscarValorModal('prod1_din')"/>
                                                                                                <!-- Passando 1 como argumento -->
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       id="prod1_din_valor"
                                                                                                       name="prod1_din_valor"
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       value="${valorProd1}"
                                                                                                       disabled>
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">DÉBITO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       id="prod1_deb"
                                                                                                       name="prod1_deb"
                                                                                                       required
                                                                                                       value="${modelVendas.prod1_deb}"
                                                                                                       oninput="buscarValorModal('prod1_deb')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod1_deb_valor"
                                                                                                       name="prod1_deb_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">CREDITO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       id="prod1_cred"
                                                                                                       name="prod1_cred"
                                                                                                       required
                                                                                                       value="${modelVendas.prod1_cred}"
                                                                                                       oninput="buscarValorModal('prod1_cred')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod1_cred_valor"
                                                                                                       name="prod1_cred_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">PIX</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       id="prod1_pix"
                                                                                                       name="prod1_pix"
                                                                                                       required
                                                                                                       value="${modelVendas.prod1_pix}"
                                                                                                       oninput="buscarValorModal('prod1_pix')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod1_pix_valor"
                                                                                                       name="prod1_pix_valor">
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                    <!-- Inputs para ENCARTE -->
                                                                                    <div class="col-4">
                                                                                        <div class="row">
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">DINHEIRO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       id="prod2_din"
                                                                                                       name="prod2_din"
                                                                                                       required
                                                                                                       value="${modelVendas.prod2_din}"
                                                                                                       oninput="buscarValorModal('prod2_din')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod2_din_valor"
                                                                                                       name="prod2_din_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">DÉBITO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       id="prod2_deb"
                                                                                                       name="prod2_deb"
                                                                                                       required
                                                                                                       value="${modelVendas.prod2_deb}"
                                                                                                       oninput="buscarValorModal('prod2_deb')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod2_deb_valor"
                                                                                                       name="prod2_deb_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">CREDITO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       id="prod2_cred"
                                                                                                       name="prod2_cred"
                                                                                                       required
                                                                                                       value="${modelVendas.prod2_cred}"
                                                                                                       oninput="buscarValorModal('prod2_cred')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod2_cred_valor"
                                                                                                       name="prod2_cred_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">PIX</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       id="prod2_pix"
                                                                                                       name="prod2_pix"
                                                                                                       required
                                                                                                       value="${modelVendas.prod2_pix}"
                                                                                                       oninput="buscarValorModal('prod2_pix')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod2_pix_valor"
                                                                                                       name="prod2_pix_valor">
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                    <!-- Inputs para DIGITAIS -->
                                                                                    <div class="col-4">
                                                                                        <div class="row">
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">DINHEIRO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       id="prod3_din"
                                                                                                       name="prod3_din"
                                                                                                       required
                                                                                                       value="${modelVendas.prod3_din}"
                                                                                                       oninput="buscarValorModal('prod3_din')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod3_din_valor"
                                                                                                       name="prod3_din_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">DÉBITO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       id="prod3_deb"
                                                                                                       name="prod3_deb"
                                                                                                       required
                                                                                                       value="${modelVendas.prod3_deb}"
                                                                                                       oninput="buscarValorModal('prod3_deb')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod3_deb_valor"
                                                                                                       name="prod3_deb_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">CREDITO</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       id="prod3_cred"
                                                                                                       name="prod3_cred"
                                                                                                       required
                                                                                                       value="${modelVendas.prod3_cred}"
                                                                                                       oninput="buscarValorModal('prod3_cred')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod3_cred_valor"
                                                                                                       name="prod3_cred_valor">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">PIX</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       id="prod3_pix"
                                                                                                       name="prod3_pix"
                                                                                                       required
                                                                                                       value="${modelVendas.prod3_pix}"
                                                                                                       oninput="buscarValorModal('prod3_pix')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="number"
                                                                                                       class="form-control"
                                                                                                       placeholder=""
                                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                                       disabled
                                                                                                       id="prod3_pix_valor"
                                                                                                       name="prod3_pix_valor">
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                    <!-- Campo para SOBRAS -->
                                                                                    <div class="col-2">
                                                                                        <label>SOBRAS</label>
                                                                                        <input type="number"
                                                                                               class="form-control"
                                                                                               id="sobras" name="sobras"
                                                                                               placeholder=""
                                                                                               value="${modelVendas.sobras}" required
                                                                                               oninput="calcularAproveitamento()">
                                                                                    </div>
                                                                                    <div class="col-2">
                                                                                        <label>IMPRESSORA</label>
                                                                                        <select class="form-control" name="ribbon_selecionado" aria-label="Ribbon Select" id="ribbon_selecionado" onchange="calcularDiferenca()">
                                                                                            <option value="" selected>Selecione o Ribbon</option>
                                                                                            <option value="ribbon1">Ribbon 1</option>
                                                                                            <option value="ribbon2">Ribbon 2</option>
                                                                                            <option value="ribbon3">Ribbon 3</option>
                                                                                            <option value="ribbon4">Ribbon 4</option>
                                                                                            <option value="ribbon5">Ribbon 5</option>
                                                                                            <option value="ribbon6">Ribbon 6</option>
                                                                                        </select>
                                                                                    </div>

                                                                                    <div class="col-2">
                                                                                        <label>RIBBON ATUAL</label>
                                                                                        <input type="number"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               style="background-color: black; color: white; font-weight: bold"
                                                                                               id="ribbon_atual"
                                                                                               name="ribbon_atual"
                                                                                               readonly tabindex="-1"
                                                                                               value="" >
                                                                                    </div>
                                                                                    <div class="col-2">
                                                                                        <label>INFORMADO</label>
                                                                                        <input type="number"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               style="background-color: white; color: black; font-weight: bold"
                                                                                               id="ribbon_inf"
                                                                                               name="ribbon_inf"
                                                                                               required
                                                                                               value=""
                                                                                               oninput="calcularDiferenca()">
                                                                                    </div>

                                                                                    <div class="col-2">
                                                                                        <label>DIFERENÇA</label>
                                                                                        <input type="number"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                               id="ribbon_dif"
                                                                                               name="ribbon_dif"
                                                                                               required
                                                                                               value=""
                                                                                               readonly tabindex="-1">
                                                                                    </div>


                                                                                    <div class="col-2">
                                                                                        <label>RIBBON</label>
                                                                                        <select class="form-select"
                                                                                                id="ribbon"
                                                                                                name="ribbon" required
                                                                                                value="${modelVendas.ribbon}">
                                                                                            <option disabled>Tamanho do
                                                                                                Papel
                                                                                            </option>
                                                                                            <option style="color: #00d25b"
                                                                                                    value="AUTORIZADO"
                                                                                                    <%
                                                                                                        ModelVendas modelVendas = (ModelVendas) request.getAttribute("modelVendas");
                                                                                                        if (modelVendas != null && modelVendas.getRibbon().equalsIgnoreCase("AUTORIZADO")) {
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }
                                                                                                    %>>AUTORIZADO
                                                                                            </option>
                                                                                            <option style="color: #bf3322"
                                                                                                    value="DESCONTAR"
                                                                                                    <%
                                                                                                        modelVendas = (ModelVendas) request.getAttribute("modelVendas");
                                                                                                        if (modelVendas != null && modelVendas.getRibbon().equalsIgnoreCase("DESCONTAR")) {
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }
                                                                                                    %>>DESCONTAR
                                                                                            </option>


                                                                                        </select>

                                                                                    </div>
                                                                                    <div class="col-2">
                                                                                        <label>APROVEITAMENTO</label>
                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                               id="aproveitamento"
                                                                                               name="aproveitamento"
                                                                                               required
                                                                                               value=""
                                                                                               readonly tabindex="-1">

                                                                                    </div>


                                                                                </div>


                                                                                <br>


                                                                                <div>
                                                                                    <button class="btn btn-outline-success waves-effect waves-light">
                                                                                        Salvar
                                                                                    </button>
                                                                                    <button type="button"
                                                                                            class="btn btn-outline-warning waves-effect waves-light"
                                                                                            onclick="limparFormVendas();">
                                                                                        Limpar
                                                                                    </button>

                                                                                </div>

                                                                            </form>
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


                                    <div class="row ">
                                        <div class="col-12 grid-margin">
                                            <div class="card">

                                                <div class="card-body">


                                                    <button type="button" class="btn btn-outline-warning"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#modalLancaVenda">
                                                        <h4>Lançamentos</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-danger"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#modalBuscaVenda">
                                                        <h4>Buscar Venda</h4>
                                                    </button>
                                                    <div class="table-responsive" style="overflow-x: hidden">
                                                        <table class="table">
                                                            <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                                            <form action="<%= request.getContextPath() %>/ServletVendas"
                                                                  method="post"
                                                                  id="formVendido" name="formBuscarVenda">
                                                                <input type="hidden" name="acao" value="">
                                                                <div class="col-sm-1">
                                                                    <label class="float-label">VENDA ID:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control"
                                                                           id="outer_venda_id"
                                                                           name="venda_id" placeholder=""
                                                                           style="background-color: black" readonly
                                                                           value="${modelVendasConsulta.venda_id}">
                                                                </div>
                                                                <div class="col-6">
                                                                    <div class="col-auto">
                                                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-3">
                                                                        <label for="outer_dataVenda">Data da
                                                                            Venda:</label>
                                                                        <input type="date" class="form-control"
                                                                               id="dataVenda" name="dataVenda" required
                                                                               value="${formattedDataVenda != null ? formattedDataVenda : ''}">
                                                                    </div>


                                                                    <div class="col-sm-1">
                                                                        <label class="float-label">ID:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control"
                                                                               id="outer_vendedor_id"
                                                                               name="vendedor_id" placeholder=""
                                                                               style="background-color: black" readonly
                                                                               value="${modelVendasConsulta.vendedor_id}">
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <label class="float-label">FUNCIONÁRIO:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control"
                                                                               id="outer_vendedor"
                                                                               name="nome" placeholder=""
                                                                               style="background-color: black" readonly
                                                                               value="${modelVendasConsulta.nome}">
                                                                    </div>

                                                                    <div class="col-2">
                                                                        <label class="float-label">TOTAL DE
                                                                            FOTOS:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control"
                                                                               id="outer_total"
                                                                               name="outer_total" placeholder=""
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
                                                                        <h5 STYLE="color: #00d25b">ENCARTES</h5>
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
                                                                                <label style="color: #f2a654">DINHEIRO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       id="outer_prod1_din"
                                                                                       name="prod1_din" required
                                                                                       value="${modelVendasConsulta.prod1_din}"
                                                                                       oninput="buscarValor('outer_prod1_din')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod1_din_valor"
                                                                                       name="prod1_din_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">DÉBITO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       id="outer_prod1_deb"
                                                                                       name="prod1_deb" required
                                                                                       value="${modelVendasConsulta.prod1_deb}"
                                                                                       oninput="buscarValor('outer_prod1_deb')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod1_deb_valor"
                                                                                       name="prod1_deb_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">CREDITO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       id="outer_prod1_cred"
                                                                                       name="prod1_cred" required
                                                                                       value="${modelVendasConsulta.prod1_cred}"
                                                                                       oninput="buscarValor('outer_prod1_cred')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod1_cred_valor"
                                                                                       name="prod1_cred_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">PIX</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       id="outer_prod1_pix"
                                                                                       name="prod1_pix" required
                                                                                       value="${modelVendasConsulta.prod1_pix}"
                                                                                       oninput="buscarValor('outer_prod1_pix')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod1_pix_valor"
                                                                                       name="prod1_pix_valor">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Inputs para ENCARTE -->
                                                                    <div class="col-4">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">DINHEIRO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #73b307; color: black; font-weight: bold"
                                                                                       id="outer_prod2_din"
                                                                                       name="prod2_din" required
                                                                                       value="${modelVendasConsulta.prod2_din}"
                                                                                       oninput="buscarValor('outer_prod2_din')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod2_din_valor"
                                                                                       name="prod2_din_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">DÉBITO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       id="outer_prod2_deb"
                                                                                       name="prod2_deb" required
                                                                                       value="${modelVendasConsulta.prod2_deb}"
                                                                                       oninput="buscarValor('outer_prod2_deb')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod2_deb_valor"
                                                                                       name="prod2_deb_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">CREDITO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       id="outer_prod2_cred"
                                                                                       name="prod2_cred" required
                                                                                       value="${modelVendasConsulta.prod2_cred}"
                                                                                       oninput="buscarValor('outer_prod2_cred')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod2_cred_valor"
                                                                                       name="prod2_cred_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">PIX</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       id="outer_prod2_pix"
                                                                                       name="prod2_pix" required
                                                                                       value="${modelVendasConsulta.prod2_pix}"
                                                                                       oninput="buscarValor('outer_prod2_pix')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       STYLE="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod2_pix_valor"
                                                                                       name="prod2_pix_valor">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Inputs para DIGITAIS -->
                                                                    <div class="col-4">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">DINHEIRO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       id="outer_prod3_din"
                                                                                       name="prod3_din" required
                                                                                       value="${modelVendasConsulta.prod3_din}"
                                                                                       oninput="buscarValor('outer_prod3_din')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod3_din_valor"
                                                                                       name="prod3_din_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">DÉBITO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       id="outer_prod3_deb"
                                                                                       name="prod3_deb" required
                                                                                       value="${modelVendasConsulta.prod3_deb}"
                                                                                       oninput="buscarValor('outer_prod3_deb')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod3_deb_valor"
                                                                                       name="prod3_deb_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">CREDITO</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       id="outer_prod3_cred"
                                                                                       name="prod3_cred" required
                                                                                       value="${modelVendasConsulta.prod3_cred}"
                                                                                       oninput="buscarValor('outer_prod3_cred')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod3_cred_valor"
                                                                                       name="prod3_cred_valor">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">PIX</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       id="outer_prod3_pix"
                                                                                       name="prod3_pix" required
                                                                                       value="${modelVendasConsulta.prod3_pix}"
                                                                                       oninput="buscarValor('outer_prod3_pix')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled
                                                                                       id="outer_prod3_pix_valor"
                                                                                       name="prod3_pix_valor">
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                    <div class="col-4">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <label style="color: #777777">SOBRAS</label>
                                                                                <input type="number"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: #777777; color: black; font-weight: bold"
                                                                                       id="outer_sobras" name="sobras"
                                                                                       required
                                                                                       value="${modelVendasConsulta.sobras}">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label>RIBBON</label>
                                                                                <select class="form-select" id="ribbon2"
                                                                                        name="ribbon"
                                                                                        required
                                                                                        value="${modelVendas.ribbon}">
                                                                                    <option disabled>Tamanho do Papel
                                                                                    </option>
                                                                                    <option style="color: #00d25b"
                                                                                            value="AUTORIZADO"
                                                                                            <%
                                                                                                modelVendas = (ModelVendas) request.getAttribute("modelVendas");
                                                                                                if (modelVendas != null && modelVendas.getRibbon().equalsIgnoreCase("AUTORIZADO")) {
                                                                                                    out.print("selected=\"selected\"");
                                                                                                }
                                                                                            %>>AUTORIZADO
                                                                                    </option>
                                                                                    <option style="color: #bf3322"
                                                                                            value="DESCONTAR"
                                                                                            <%
                                                                                                modelVendas = (ModelVendas) request.getAttribute("modelVendas");
                                                                                                if (modelVendas != null && modelVendas.getRibbon().equalsIgnoreCase("DESCONTAR")) {
                                                                                                    out.print("selected=\"selected\"");
                                                                                                }
                                                                                            %>>DESCONTAR
                                                                                    </option>

                                                                                </select>
                                                                            </div>


                                                                        </div>


                                                                    </div>
                                                                </div>


                                                                <div>

                                                                    <div>
                                                                        <button class="btn btn-outline-success waves-effect waves-light">
                                                                            Atualizar
                                                                        </button>

                                                                        <button type="button"
                                                                                class="btn btn-outline-warning waves-effect waves-light"
                                                                                onclick="limparFormVendido();">Limpar
                                                                        </button>

                                                                        <button class="btn btn-outline-danger waves-effect waves-light" name="acao" value="deletar">
                                                                            Excluir Venda
                                                                        </button>

                                                                    </div>
                                                                </div>
                                                            </form>


                                                        </table>
                                                        <h5>Último Lançamento:</h5>


                                                        <div style="overflow-x: hidden">
                                                            <div style="height: 300px; overflow-y: auto;">


                                                                <table class="table" id="tabelaVendaDia">
                                                                    <thead>
                                                                    <tr>
                                                                        <th scope="col">Opções</th>
                                                                        <th scope="col">Nome</th>
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
                                                                        <th scope="col">Ribbon</th>
                                                                        <th scope="col">ID Vendedor</th>
                                                                        <th scope="col">Data</th>
                                                                        <th scope="col">ID Venda</th>

                                                                    </tr>
                                                                    </thead>

                                                                    <tbody>
                                                                    <c:choose>
                                                                        <c:when test="${not empty listaVendasDoDia}">
                                                                            <c:forEach var="vd"
                                                                                       items="${listaVendasDoDia}">
                                                                                <tr>
                                                                                    <td>
                                                                                        <a class="btn btn-outline-success waves-effect waves-light"
                                                                                           href="<%= request.getContextPath() %>/ServletVendas?acao=gerenciarVenda&venda_id=${vd.venda_id}">Gerenciar</a>
                                                                                    </td>
                                                                                    <td><c:out value="${vd.nome}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod1_din}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod1_deb}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod1_cred}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod1_pix}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod2_din}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod2_deb}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod2_cred}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod2_pix}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod3_din}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod3_deb}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod3_cred}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.prod3_pix}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.sobras}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.ribbon}"/></td>
                                                                                    <td><c:out
                                                                                            value="${vd.vendedor_id}"/></td>
                                                                                    <td><fmt:formatDate value="${vd.data_venda}" pattern="dd/MM/yyyy"/></td>


                                                                                    <td><c:out
                                                                                            value="${vd.venda_id}"/></td>


                                                                                </tr>
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <tr>
                                                                                <td colspan="15">Nenhuma venda
                                                                                    encontrada para o dia.
                                                                                </td>
                                                                            </tr>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    </tbody>

                                                                </table>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
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


    <!-- Modal HTML -->
    <div class="modal" id="msgModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;">
                <!-- Borda preta -->
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


    <SCRIPT type="text/javascript">

        $(document).ready(function () {
            var msg = "${msg}";
            if (msg) {
                $('#msgModal').modal('show'); // Exibe o modal com a mensagem

                // Remove a mensagem da sessão após exibi-la
                $.post("${pageContext.request.contextPath}/ServletVendas", { acao: "limparMsg" });
            }
        });


        // Função para navegar entre elementos focáveis com as setas
        function navigateFocusableElements(event) {
            const focusableElements = Array.from(
                document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')
            ).filter(element => !element.disabled && element.tabIndex !== -1);

            if (focusableElements.length === 0) return;

            const currentElement = document.activeElement;
            if (!focusableElements.includes(currentElement)) return;

            let currentIndex = focusableElements.indexOf(currentElement);

            switch (event.key) {
                case 'ArrowRight':
                case 'ArrowDown':
                    currentIndex = (currentIndex + 1) % focusableElements.length;
                    break;
                case 'ArrowLeft':
                case 'ArrowUp':
                    currentIndex = (currentIndex - 1 + focusableElements.length) % focusableElements.length;
                    break;
                default:
                    return;
            }

            focusableElements[currentIndex].focus();
        }

        // Bloqueia a alteração de valor com as setas nos inputs do tipo number
        document.querySelectorAll('input[type="number"]').forEach(input => {
            input.addEventListener('keydown', function(event) {
                if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                    event.preventDefault(); // Impede a alteração do valor
                }
            });
        });

        // Adiciona o evento keydown ao documento
        document.addEventListener('keydown', navigateFocusableElements);
        // Fim de navegação por setas


        // Adiciona o evento de teclado ao carregar a página
        window.onload = function() {
            document.addEventListener('keydown', navigateFocusableElements);
        };

        function deletaVenda() {
            const vendaId = document.getElementById('venda_id').value; // Obtém o ID da venda
            if (confirm("Tem certeza que deseja excluir esta venda?")) {
                $.ajax({
                    method: 'POST',
                    url: '<%= request.getContextPath() %>/ServletVendas',
                    data: {acao: 'deletar', venda_id: vendaId},
                    success: function (response) {
                        alert("Venda excluída com sucesso!");
                        location.reload(); // Atualiza a página
                    },
                    error: function (xhr, status, errorThrown) {
                        alert('Erro ao excluir a venda: ' + xhr.responseText);
                    }
                });
            }
        }



        function limparFormVendas() {
            document.getElementById('formBuscarVenda').reset(); // Limpa o formulário

        }

        function buscarFunc() {
            var nomeBusca = document.getElementById('nomeBusca').value;

            if (nomeBusca != null && nomeBusca.trim() != '') {
                var urlAction = document.getElementById('formBuscaFuncionario').action;

                $.ajax({
                    method: 'GET',
                    url: urlAction,
                    data: "nome=" + encodeURIComponent(nomeBusca) + '&acao=buscaruserajax',
                    dataType: 'json',
                    success: function (json) {
                        $('#tabelabuscafuncionario > tbody > tr').remove();
                        for (var p = 0; p < json.length; p++) {
                            $('#tabelabuscafuncionario > tbody').append(
                                '<tr> <td>' + json[p].id + '</td> <td>' + json[p].nome +
                                '</td> <td> <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="verEditar(' + json[p].id + ', \'' + json[p].nome + '\')">Selecionar</button></td></tr>'
                            );
                        }
                        document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
                    },
                    error: function (xhr, status, errorThrown) {
                        alert('Erro ao Pesquisar o Funcionário: ' + xhr.responseText);
                    }
                });
            }
        }


        function verEditar(id, nome) {
            document.getElementById('vendedor_id').value = id;
            document.getElementById('vendedor').value = nome;

            // Rola até o fim do modal
            var modal = $('#modalLancaVenda'); // Substitua pelo ID do seu modal
            modal.animate({scrollTop: modal[0].scrollHeight}, 1000); // Rola suavemente para o fim em 1 segundo
        }


        function limparFormVendas() {
            // Limpa os campos do formulário
            $('#formBuscarVenda')[0].reset();
        }

        function limparFormVendido() {
            // Limpa os campos do formulário
            $('#formVendido')[0].reset();
        }


        let produtos = []; // Array para armazenar os valores dos produtos

        function buscarValor(produtoId) {
            const quantidade = document.getElementById(produtoId).value;

            // Verifica se o array de produtos está vazio
            if (produtos.length === 0) {
                // Chama o servidor para buscar os valores
                const xhr = new XMLHttpRequest();
                xhr.open('GET', `ServletVendas?acao=buscarValoresProdutos`, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        // Preenche o array de produtos com os valores retornados
                        produtos = JSON.parse(xhr.responseText);
                        calcularValor(quantidade, produtoId); // Calcular valor após receber os produtos
                    } else {
                    }
                };
                xhr.send();
            } else {
                calcularValor(quantidade, produtoId); // Se os produtos já foram carregados, calcular o valor imediatamente
            }
        }

        function calcularValor(quantidade, produtoId) {

            const prod = produtos[0]; // Considerando que você só tem um produto na lista

            if (prod) {
                let valorProduto;

                switch (produtoId) {
                    case 'outer_prod1_din':
                    case 'outer_prod1_deb':
                    case 'outer_prod1_cred':
                    case 'outer_prod1_pix':
                        valorProduto = parseFloat(prod.conf1_valor);
                        break;
                    case 'outer_prod2_din':
                    case 'outer_prod2_deb':
                    case 'outer_prod2_cred':
                    case 'outer_prod2_pix':
                        valorProduto = parseFloat(prod.conf2_valor);
                        break;
                    case 'outer_prod3_din':
                    case 'outer_prod3_deb':
                    case 'outer_prod3_cred':
                    case 'outer_prod3_pix':
                        valorProduto = parseFloat(prod.conf3_valor);
                        break;
                    default:
                        console.log('Produto não encontrado');
                        return;
                }

                const valorTotal = quantidade * valorProduto; // Calcula o valor total
                document.getElementById(produtoId + '_valor').value = valorTotal.toFixed(2); // Mostrando duas casas decimais

                atualizarTotal(); // Atualiza o total geral
            } else {
            }
        }

        function atualizarTotal() {
            let total = 0;
            // Soma as quantidades digitadas apenas dos campos do prod1
            ['outer_prod1_din', 'outer_prod1_deb', 'outer_prod1_cred', 'outer_prod1_pix'].forEach(id => {
                const quantidade = parseFloat(document.getElementById(id).value) || 0; // Pega o valor ou 0 se estiver vazio
                total += quantidade;
            });
            document.getElementById('outer_total').value = total; // Atualiza o valor total no campo
        }

        // Funções para o modal
        function buscarValorModal(produtoId) {
            const quantidade = document.getElementById(produtoId).value;

            if (produtos.length === 0) {
                const xhr = new XMLHttpRequest();
                xhr.open('GET', `ServletVendas?acao=buscarValoresProdutos`, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        produtos = JSON.parse(xhr.responseText);
                        calcularValorModal(quantidade, produtoId);
                    } else {
                    }
                };
                xhr.send();
            } else {
                calcularValorModal(quantidade, produtoId);
            }
        }

        function calcularValorModal(quantidade, produtoId) {

            // Acessando o array 'configs' dentro de produtos
            const prod = produtos.configs[0]; // Acessando o primeiro produto da lista

            if (prod) {
                let valorProduto;

                switch (produtoId) {
                    case 'prod1_din':
                    case 'prod1_deb':
                    case 'prod1_cred':
                    case 'prod1_pix':
                        valorProduto = parseFloat(prod.conf1_valor);
                        break;
                    case 'prod2_din':
                    case 'prod2_deb':
                    case 'prod2_cred':
                    case 'prod2_pix':
                        valorProduto = parseFloat(prod.conf2_valor);
                        break;
                    case 'prod3_din':
                    case 'prod3_deb':
                    case 'prod3_cred':
                    case 'prod3_pix':
                        valorProduto = parseFloat(prod.conf3_valor);
                        break;
                    default:
                        console.log('Produto não encontrado no modal');
                        return;
                }

                const valorTotal = quantidade * valorProduto;
                document.getElementById(produtoId + '_valor').value = valorTotal.toFixed(2);

                atualizarTotalModal(); // Atualiza o total geral do modal
            } else {
                console.log('Produto não encontrado no modal');
            }
        }


        function atualizarTotalModal() {
            let total = 0;
            // Soma as quantidades digitadas apenas dos campos do prod1
            ['prod1_din', 'prod1_deb', 'prod1_cred', 'prod1_pix'].forEach(id => {
                const quantidade = parseFloat(document.getElementById(id).value) || 0;
                total += quantidade;
            });
            document.getElementById('total').value = total;
        }











        document.addEventListener('DOMContentLoaded', function() {
            // Inicializando a variável controles
            let controles = [];

            // Fazendo a requisição ao servlet usando XMLHttpRequest
            const xhr = new XMLHttpRequest();
            xhr.open('GET', 'ServletVendas?acao=buscarValoresProdutos', true);

            xhr.onload = function() {
                if (xhr.status === 200) {
                    const data = JSON.parse(xhr.responseText);
                    console.log('Resposta do servidor:', data); // Log da resposta do servidor
                    controles = data.controles || []; // Preenche a variável controles com os dados recebidos
                    console.log('Valores dos controles recebidos:', controles); // Log dos valores recebidos

                    // Adiciona o event listener para o select após carregar os valores
                    document.getElementById('ribbon_selecionado').addEventListener('change', function() {
                        const ribbonSelecionado = this.value;
                        const ribbonIndex = parseInt(ribbonSelecionado.replace("ribbon", "")) - 1;

                        console.log('Ribbon selecionado:', ribbonSelecionado, 'Index:', ribbonIndex); // Log da seleção

                        if (controles.length > 0 && ribbonIndex >= 0 && ribbonIndex < 6) {
                            const valorRibbon = controles[ribbonIndex];
                            const valorTroca = controles[ribbonIndex + 6] || 0; // Garantir que valorTroca tenha um default
                            const valorFim = controles[ribbonIndex + 12] || 0; // Garantir que valorFim tenha um default
                            const valorTotal = valorRibbon + valorTroca - valorFim;

                            document.getElementById('ribbon_atual').value = valorTotal; // Atualiza o campo "ribbon_atual" com o valor retornado
                            console.log('Valor atualizado no campo ribbon_atual:', valorTotal); // Log do valor atualizado

                            calcularDiferenca(); // Calcula a diferença imediatamente após atualizar o valor atual
                        } else {
                            console.error('Dados invalidos ou faltando para o controle.');
                        }
                    });
                } else {
                    console.error('Erro ao buscar os valores:', xhr.statusText);
                }
            };

            xhr.send();
        });

        function calcularDiferenca() {
            const ribbonAtual = parseFloat(document.getElementById("ribbon_atual").value) || 0;
            const ribbonInf = parseFloat(document.getElementById("ribbon_inf").value) || 0;
            const ribbonSobras = parseFloat(document.getElementById("sobras").value) || 0;
            const ribbonTotal = parseFloat(document.getElementById("total").value) || 0;
            const ribbonDif = document.getElementById("ribbon_dif");

            ribbonDif.value = (ribbonInf + ribbonSobras + ribbonTotal) - ribbonAtual;
            console.log('Cálculo da diferença - Atual:', ribbonAtual, 'Informado:', ribbonInf, 'Diferença:', ribbonDif.value, 'Valores:', ribbonSobras, ribbonTotal);
        }


        function calcularAproveitamento() {
            const vendas = parseFloat(document.getElementById('total').value) || 0;
            const sobras = parseFloat(document.getElementById('sobras').value) || 0;
            const producao = vendas + sobras;

            const aproveitamento = producao > 0 ? (vendas / producao) * 100 : 0;
            document.getElementById('aproveitamento').value = aproveitamento.toFixed(2) + " %"; // mostra com 2 casas decimais
        }



    </SCRIPT>


</div>
</body>
</html>