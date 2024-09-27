<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelVendas" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

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
                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalVenda">
                                                <h4>Lançamento Diário</h4>
                                            </button>

                                            <!-- Modal -->

                                            <div class="modal fade" id="modalVenda" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Pesquisa de Funcionário</h5>

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

                                                                                    <%--busca Funcionário                                                               --%>
                                                                                    <form class="form-material" id="formBuscaFuncionario" method="get" action="<%= request.getContextPath() %>/ServletVendas">
                                                                                        <div class="col-4">
                                                                                            <label class="float-label">FUNCIONÁRIO:</label>
                                                                                            <span class="form-bar"></span>
                                                                                            <input type="text" class="form-control" id="nomeFunc" name="nome" placeholder="" style="background-color: black" required autofocus>
                                                                                        </div>
                                                                                        <div>
                                                                                            <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparbuscaFuncionario();">Novo</button>
                                                                                            <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="buscarFunc();">Pesquisar</button>
                                                                                        </div>
                                                                                        <div style="overflow-x: hidden">
                                                                                            <div style="height: 300px; overflow-y: auto;">
                                                                                                <table class="table" id="tabelabuscafuncionario">
                                                                                                    <thead>
                                                                                                    <tr>
                                                                                                        <th scope="col">ID</th>
                                                                                                        <th scope="col">NOME</th>
                                                                                                        <th scope="col">OPÇÕES</th>
                                                                                                    </tr>
                                                                                                    </thead>
                                                                                                    <tbody>
                                                                                                    <!-- Resultados serão inseridos aqui -->
                                                                                                    </tbody>
                                                                                                </table>
                                                                                            </div>
                                                                                        </div>
                                                                                        <span id="totalResultados"></span>
                                                                                    </form>




                                                                                    <form action="<%= request.getContextPath() %>/ServletVendas" method="post" id="formVenda" name="formVenda">
                                                                                        <input type="hidden" name="acao" value="">
                                                                                        <div class="col-sm-1">
                                                                                            <label class="float-label">VENDA ID:</label>
                                                                                            <span class="form-bar"></span>
                                                                                            <input type="text" class="form-control" id="venda_id" name="venda_id" placeholder="" style="background-color: black" readonly value="${modelVendas.venda_id}" disabled>
                                                                                        </div>
                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label for="dataVenda">Data da Venda</label>
                                                                                                <input type="date" class="form-control" id="dataVenda" name="dataVenda">
                                                                                            </div>

                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label">ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="vendedor_id" name="vendedor_id" placeholder="" style="background-color: black" readonly value="${modelVendas.vendedor_id}">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label class="float-label">FUNCIONÁRIO:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="nomeFunc" name="nome" placeholder="" style="background-color: black" readonly value="${modelVendas.nome}">
                                                                                            </div>

                                                                                            <div class="col-2">
                                                                                                <label class="float-label">TOTAL DE FOTOS:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="totalFotos" name="nome" placeholder="" style="background-color: white; color: black" disabled>
                                                                                            </div>
                                                                                        </div>

                                                                                        <!-- Seções para FOTOS, ENCARTE e DIGITAIS em linha -->
                                                                                        <div class="row mt-3">
                                                                                            <div class="col-4 text-center">
                                                                                                <h5  style="color: #f2a654">FOTOS</h5>
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
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_din" name="prod1_din" required value="${modelVendas.prod1_din}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_din_valor" name="prod1_din_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">DÉBITO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_deb" name="prod1_deb" required value="${modelVendas.prod1_deb}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_deb_valor" name="prod1_deb_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">CREDITO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_cred" name="prod1_cred" required value="${modelVendas.prod1_cred}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_cred_valor" name="prod1_cred_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">PIX</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_pix" name="prod1_pix" required value="${modelVendas.prod1_pix}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: #f2a654">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_pix_valor" name="prod1_pix_valor">
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <!-- Inputs para ENCARTE -->
                                                                                            <div class="col-4">
                                                                                                <div class="row">
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">DINHEIRO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: #73b307; color: black; font-weight: bold" id="prod2_din" name="prod2_din" required value="${modelVendas.prod2_din}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_din_valor" name="prod2_din_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">DÉBITO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="prod2_deb" name="prod2_deb" required value="${modelVendas.prod2_deb}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_deb_valor" name="prod2_deb_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">CREDITO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="prod2_cred" name="prod2_cred" required value="${modelVendas.prod2_cred}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_cred_valor" name="prod2_cred_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">PIX</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="prod2_pix" name="prod2_pix" required value="${modelVendas.prod2_pix}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label STYLE="color: #00d25b">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_pix_valor" name="prod2_pix_valor">
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <!-- Inputs para DIGITAIS -->
                                                                                            <div class="col-4">
                                                                                                <div class="row">
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">DINHEIRO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_din" name="prod3_din" required value="${modelVendas.prod3_din}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_din_valor" name="prod3_din_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">DÉBITO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_deb" name="prod3_deb" required value="${modelVendas.prod3_deb}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_deb_valor" name="prod3_deb_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">CREDITO</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_cred" name="prod3_cred" required value="${modelVendas.prod3_cred}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_cred_valor" name="prod3_cred_valor">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">PIX</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_pix" name="prod3_pix" required value="${modelVendas.prod3_pix}">
                                                                                                    </div>
                                                                                                    <div class="col-6">
                                                                                                        <label style="color: fuchsia">VALOR</label>
                                                                                                        <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_pix_valor" name="prod3_pix_valor">
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <!-- Campo para SOBRAS -->
                                                                                            <div class="col-2">
                                                                                                <label>SOBRAS</label>
                                                                                                <input type="number" class="form-control" id="sobras" name="sobras" placeholder="" value="${modelVendas.sobras}">
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

                                                                                        <br>

                                                                                        <div>
                                                                                            <button class="btn btn-outline-success waves-effect waves-light">Salvar</button>
                                                                                            <button type="button" class="btn btn-outline-danger waves-effect waves-light" onclick="limparFormVendas();">Limpar</button>
                                                                                            <button type="button" class="btn btn-outline-danger waves-effect waves-light" onclick="deletaVenda();">Excluir</button>
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
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">

                                            <!--INSERIR BOTÃO 2 AQUI-->
                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-behance" data-bs-toggle="modal" data-bs-target="#modalBusca">
                                                <h4>Consultar</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalBusca" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" >Pesquisa de Funcionário     </h5>

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



                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

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
                                                <h4>Excluir</h4>
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

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body" >
                                <span style="color: #f2a654" id="msg">${msg}</span>
                                <div class="table-responsive"style="overflow-x: hidden">
                                    <table class="table" >
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                        <form action="<%= request.getContextPath() %>/ServletUsuarioController" method="post" id="formUser2" name="formUser2" >
                                            <input type="hidden" name="acao" acao value="">
                                            <div class="row">

                                                <div class="col">
                                                    <input type="hidden" name="acao" value="">
                                                    <div class="row">
                                                        <label class="float-label">VENDA ID:</label>
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <span class="form-bar"></span>
                                                        <input type="text" class="form-control" id="venda_id2" name="venda_id" placeholder="" style="background-color: black" readonly value="${modelVendas.venda_id}" disabled>
                                                    </div>
                                                    <div class="col-6">
                                                        <div class="col-auto">
                                                            <span style="color:#1ad76b">${msg}</span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-3">
                                                            <label for="dataVenda">Data da Venda</label>
                                                            <input type="date" class="form-control" id="dataVenda2" name="dataVenda">
                                                        </div>

                                                        <div class="col-sm-1">
                                                            <label class="float-label">ID:</label>
                                                            <span class="form-bar"></span>
                                                            <input type="text" class="form-control" id="vendedor_id2" name="vendedor_id" placeholder="" style="background-color: black" readonly value="${modelVendas.vendedor_id}">
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="float-label">FUNCIONÁRIO:</label>
                                                            <span class="form-bar"></span>
                                                            <input type="text" class="form-control" id="vendedor" name="nome" placeholder="" style="background-color: black" readonly value="${modelVendas.nome}">
                                                        </div>

                                                        <div class="col-2">
                                                            <label class="float-label">TOTAL DE FOTOS:</label>
                                                            <span class="form-bar"></span>
                                                            <input type="text" class="form-control" id="totalFotos2" name="nome" placeholder="" style="background-color: white; color: black" disabled>
                                                        </div>
                                                    </div>

                                                    <!-- Seções para FOTOS, ENCARTE e DIGITAIS em linha -->
                                                    <div class="row mt-3">
                                                        <div class="col-4 text-center">
                                                            <h5  style="color: #f2a654">FOTOS</h5>
                                                        </div>
                                                        <div class="col-4 text-center">
                                                            <h5 STYLE="color: #00d25b">ENCARTES</h5>
                                                        </div>
                                                        <div class="col-4 text-center">
                                                            <h5 style="color: fuchsia">DIGITAIS</h5>
                                                        </div>
                                                    </div>
                                                    <!-- Inputs para FOTOS -->
                                                    <div class="col-4">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">DINHEIRO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_din2" name="prod1_din" required value="${modelVendas.prod1_din}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_din_valor2" name="prod1_din_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">DÉBITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_deb2" name="prod1_deb" required value="${modelVendas.prod1_deb}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_deb_valor2" name="prod1_deb_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">CREDITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_cred2" name="prod1_cred" required value="${modelVendas.prod1_cred}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_cred_valor2" name="prod1_cred_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">PIX</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="prod1_pix2" name="prod1_pix" required value="${modelVendas.prod1_pix}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="prod1_pix_valor2" name="prod1_pix_valor">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Inputs para ENCARTE -->
                                                    <div class="col-4">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">DINHEIRO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #73b307; color: black; font-weight: bold" id="prod2_din2" name="prod2_din" required value="${modelVendas.prod2_din}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_din_valor2" name="prod2_din_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">DÉBITO</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="prod2_deb2" name="prod2_deb" required value="${modelVendas.prod2_deb}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_deb_valor2" name="prod2_deb_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">CREDITO</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="prod2_cred2" name="prod2_cred" required value="${modelVendas.prod2_cred}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_cred_valor2" name="prod2_cred_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">PIX</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="prod2_pix2" name="prod2_pix" required value="${modelVendas.prod2_pix}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="prod2_pix_valor2" name="prod2_pix_valor">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Inputs para DIGITAIS -->
                                                    <div class="col-4">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">DINHEIRO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_din2" name="prod3_din" required value="${modelVendas.prod3_din}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_din_valor2" name="prod3_din_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">DÉBITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_deb2" name="prod3_deb" required value="${modelVendas.prod3_deb}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_deb_valor2" name="prod3_deb_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">CREDITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_cred2" name="prod3_cred" required value="${modelVendas.prod3_cred}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_cred_valor2" name="prod3_cred_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">PIX</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="prod3_pix2" name="prod3_pix" required value="${modelVendas.prod3_pix}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="prod3_pix_valor2" name="prod3_pix_valor">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Campo para SOBRAS -->
                                                    <div class="col-2">
                                                        <label>SOBRAS</label>
                                                        <input type="number" class="form-control" id="sobras2" name="sobras" placeholder="" value="${modelVendas.sobras}">
                                                    </div>

                                                    <div class="col-2">
                                                        <label>RIBBON</label>
                                                        <select class="form-select" id="ribbon2" name="ribbon">
                                                            <option disabled="disabled">Tamanho do Papel</option>
                                                            <option style="color: #00d25b" value="10x15"  <%
                                                                modelVendas = (ModelVendas) request.getAttribute("modelVendas");
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


                                                <br>

                                                <div>
                                                    <button class="btn btn-outline-success waves-effect waves-light">Atualizar</button>
                                                    <button type="button" class="btn btn-outline-danger waves-effect waves-light" onclick="limparFormVendas();">Limpar</button>
                                                    <button type="button" class="btn btn-outline-danger waves-effect waves-light" onclick="deletaVenda();">Excluir</button>
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






                                            <div style="overflow-x: hidden">
                                                <div style="height: 300px; overflow-y: auto ">


                                                </div>
                                                <nav aria-label="Page navigation example">
                                                    <ul class="pagination">
                                                        <%
                                                            int totalPagina = (int) request.getAttribute("totalPagina");
                                                            for (int p=0; p<totalPagina; p++) {
                                                                String url = request.getContextPath()+"/ServletUsuarioController?acao=paginar&pagina=" + (p * 6);

                                                                out.print("<li class=\"page-item\"><a class=\"page-link\" href=\""+url+"\">"+(p + 1)+"</a></li>");
                                                            }
                                                        %>




                                                    </ul>
                                                </nav>
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

        <script type="text/javascript">
            function deletaVenda() {
                const vendaId = document.getElementById('venda_id').value; // Obtém o ID da venda
                if (confirm("Tem certeza que deseja excluir esta venda?")) {
                    $.ajax({
                        method: 'POST',
                        url: '<%= request.getContextPath() %>/ServletVendas',
                        data: { acao: 'deletar', venda_id: vendaId },
                        success: function(response) {
                            alert("Venda excluída com sucesso!");
                            location.reload(); // Atualiza a página
                        },
                        error: function(xhr, status, errorThrown) {
                            alert('Erro ao excluir a venda: ' + xhr.responseText);
                        }
                    });
                }
            }

            function limparbuscaForm() {
                var elementos = document.getElementById("formBuscaUser").elements;
                for (var p = 0; p < elementos.length; p++) {
                    if (elementos[p].type !== "button") {
                        elementos[p].value = ''; // Limpa apenas os campos de entrada
                    }
                }
                document.getElementById('totalResultados').textContent = ''; // Limpa o total de resultados
                $('#tabelabuscafuncionario > tbody').empty(); // Limpa a tabela de resultados
            }

            function buscarFunc() {
                var nomeFunc = document.getElementById('nomeBusca').value.trim();

                if (nomeFunc) {
                    var urlAction = document.getElementById('formBuscaFuncionario').action;

                    $.ajax({
                        method: 'GET',
                        url: urlAction,
                        data: { nome: nomeFunc, acao: 'buscaruserajax' },
                        dataType: 'json',
                        success: function(json) {
                            console.log(json); // Adicione isso para ver o que está sendo retornado
                            $('#tabelabuscafuncionario > tbody').empty(); // Limpa a tabela antes de adicionar novos resultados

                            if (json.length > 0) { // Verifica se há resultados
                                for (var p = 0; p < json.length; p++) {
                                    $('#tabelabuscafuncionario > tbody').append(
                                        '<tr> <td>' + json[p].id + '</td> <td>' + json[p].nome +
                                        '</td> <td> <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="verEditar(' + json[p].id + ', \'' + json[p].nome + '\')">Selecionar</button></td></tr>'
                                    );
                                }
                                document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
                            } else {
                                $('#tabelabuscafuncionario > tbody').append('<tr><td colspan="3">Nenhum resultado encontrado</td></tr>');
                                document.getElementById('totalResultados').textContent = 'Resultados: 0';
                            }
                        },
                        error: function(xhr, status, errorThrown) {
                            console.error('Erro:', status, errorThrown); // Log de erro detalhado
                            alert('Erro ao Pesquisar o Funcionário: ' + xhr.responseText);
                        }
                    });
                } else {
                    alert('Por favor, insira um nome para pesquisa.');
                }
            }


            function verEditar(id, nome) {
                document.getElementById('vendedor_id').value = id;
                document.getElementById('vendedor').value = nome;
                $('#modalBuscaFuncionario').modal('hide'); // Fecha o modal
            }

            function salvarVenda() {
                var formData = $('#formVenda').serialize(); // Coleta os dados do formulário
                var urlAction = document.getElementById('formVenda').action;

                $.ajax({
                    method: 'POST',
                    url: urlAction,
                    data: formData,
                    success: function(response) {
                        $('#msg').html(response); // Atualiza a tag ${msg} com a resposta
                        limparFormVendas(); // Limpa o formulário
                    },
                    error: function(xhr, status, errorThrown) {
                        alert('Erro ao salvar a venda: ' + xhr.responseText);
                    }
                });
            }

            function limparFormVendas() {
                $('#formVenda')[0].reset(); // Limpa os campos do formulário

            }
        </script>


</body>
</html>
