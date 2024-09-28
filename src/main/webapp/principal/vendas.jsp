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

                <!-- Modal -->
                <div class="modal fade" id="modalBuscaVenda" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" >Pesquisa de Vendas </h5>

                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="container-fluid">
                                <div class="page-body">

                                    <div class="row">
                                        <div class="col-auto">
                                            <span id="msg" style="color:#f2a654">${msg}</span>
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
                                                        <form class="form-material" id="formBuscaVenda" method="get" action="<%= request.getContextPath() %>/ServletVendas">
                                                            <div class="row">
                                                                <div class="col-sm-1">
                                                                    <label class="float-label">ID:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="idVenda" name="venda_id" placeholder="">
                                                                </div>
                                                                <div>
                                                                    <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="buscarVenda();">Pesquisar</button>
                                                                </div>
                                                                <div style="overflow-x: hidden">
                                                                    <div style="height: 300px; overflow-y: auto">
                                                                        <table class="table" id="tabelabuscavenda">
                                                                            <thead>
                                                                            <tr>
                                                                                <th scope="col">ID</th>
                                                                                <th scope="col">OPÇÕES</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <!-- Aqui você pode preencher os dados da tabela -->
                                                                            </tbody>
                                                                        </table>
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
                                <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                <%--FIM MODAL BUSCA--%>
                            </div>
                        </div>
                    </div>


                    <%--                   TIRAR AQUI--%>


                </div>

                <!-- Modal -->
                <div class="modal fade" id="modalBuscaFuncionario" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" >Lançamento de vendas </h5>

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

                                                        <form class="form-material" id="formBuscaFuncionario" method="get" action="<%= request.getContextPath() %>/ServletVendas">

                                                            <div class="row">

                                                                <div class="col-4">
                                                                    <label class="float-label">FUNCIONÁRIO:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="nomeBusca" name="nome" placeholder=""  style="background-color: black" REQUIRED  autofocus>

                                                                </div>

                                                                <div>


                                                                    <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparbuscaFuncionario();" >Novo</button>
                                                                    <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="buscarFunc();">Pesquisar</button>



                                                                    <%--  BOTOES MODAL busca--%>
                                                                </div>
                                                                <div style="overflow-x: hidden">
                                                                    <div style="height: 300px; overflow-y: auto ">
                                                                        <table class="table" id="tabelabuscafuncionario">
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
                                                                <span id="totalResultados"></span>

                                                            </div>

                                                        </form>
                                                        <!-- Adicione o formulário da venda aqui -->
                                                        <form action="<%= request.getContextPath() %>/ServletVendas" method="post" id="formBuscarVenda" name="formBuscarVenda">
                                                            <input type="hidden" name="acao" value="">
                                                            <div class="col-sm-1">
                                                                <label class="float-label">VENDA ID:</label>
                                                                <span class="form-bar"></span>
                                                                <input type="text" class="form-control" id="venda_id" name="venda_id" placeholder="" style="background-color: black" readonly value="${modelVendas.venda_id}">
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
                                                                    <input type="text" class="form-control" id="vendedor_id" name="vendedor_id" placeholder="" style="background-color: black" readonly value="${modelVendas.id}">
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="float-label">FUNCIONÁRIO:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="vendedor" name="nome" placeholder="" style="background-color: black" readonly value="${modelVendas.nome}">
                                                                </div>
                                                                <div class="col-2">
                                                                    <label class="float-label">TOTAL DE FOTOS:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="nome" name="nome" placeholder="" style="background-color: white; color: black" readonly>
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
                                                                            <option z="disabled">Tamanho do Papel</option>
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
                                                                    <button type="button" class="btn btn-outline-warning waves-effect waves-light" onclick="limparFormVendas();">Limpar</button>

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

                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalBuscaFuncionario">
                                        <h4>Lançamentos</h4>
                                    </button>
                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalBuscaVenda">
                                        <h4>Buscar Venda</h4>
                                    </button>
                                    <div class="table-responsive"style="overflow-x: hidden">
                                        <table class="table" >
                                            <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                            <form action="<%= request.getContextPath() %>/ServletVendas" method="post" id="formVendido" name="formBuscarVenda">
                                                <input type="hidden" name="acao" value="">
                                                <div class="col-sm-1">
                                                    <label class="float-label">VENDA ID:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control" id="outer_venda_id" name="venda_id" placeholder="" style="background-color: black" readonly value="${modelVendasConsulta.venda_id}">
                                                </div>
                                                <div class="col-6">
                                                    <div class="col-auto">
                                                        <span style="color:#1ad76b">${msg}</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">
                                                        <label for="outer_dataVenda">Data da Venda</label>
                                                        <input type="date" class="form-control" id="outer_dataVenda" name="dataVenda">
                                                    </div>

                                                    <div class="col-sm-1">
                                                        <label class="float-label">ID:</label>
                                                        <span class="form-bar"></span>
                                                        <input type="text" class="form-control" id="outer_vendedor_id" name="vendedor_id" placeholder="" style="background-color: black" readonly  value="${modelVendasConsulta.vendedor_id}">
                                                    </div>
                                                    <div class="col-6">
                                                        <label class="float-label">FUNCIONÁRIO:</label>
                                                        <span class="form-bar"></span>
                                                        <input type="text" class="form-control" id="outer_vendedor" name="nome" placeholder="" style="background-color: black" readonly  value="${modelVendasConsulta.nome}">
                                                    </div>

                                                    <div class="col-2">
                                                        <label class="float-label">TOTAL DE FOTOS:</label>
                                                        <span class="form-bar"></span>
                                                        <input type="text" class="form-control" id="outer_nome" name="nome" placeholder="" style="background-color: white; color: black" disabled>
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
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="outer_prod1_din" name="prod1_din" required  value="${modelVendasConsulta.prod1_din}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="outer_prod1_din_valor" name="prod1_din_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">DÉBITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="outer_prod1_deb" name="prod1_deb" required  value="${modelVendasConsulta.prod1_deb}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="outer_prod1_deb_valor" name="prod1_deb_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">CREDITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="outer_prod1_cred" name="prod1_cred" required  value="${modelVendasConsulta.prod1_cred}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="outer_prod1_cred_valor" name="prod1_cred_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">PIX</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" id="outer_prod1_pix" name="prod1_pix" required  value="${modelVendasConsulta.prod1_pix}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: #f2a654">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #f2a654; color: black; font-weight: bold" disabled id="outer_prod1_pix_valor" name="prod1_pix_valor">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Inputs para ENCARTE -->
                                                    <div class="col-4">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">DINHEIRO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #73b307; color: black; font-weight: bold" id="outer_prod2_din" name="prod2_din" required  value="${modelVendasConsulta.prod2_din}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="outer_prod2_din_valor" name="prod2_din_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">DÉBITO</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="outer_prod2_deb" name="prod2_deb" required  value="${modelVendasConsulta.prod2_deb}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="outer_prod2_deb_valor" name="prod2_deb_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">CREDITO</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="outer_prod2_cred" name="prod2_cred" required  value="${modelVendasConsulta.prod2_cred}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="outer_prod2_cred_valor" name="prod2_cred_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">PIX</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" id="outer_prod2_pix" name="prod2_pix" required  value="${modelVendasConsulta.prod2_pix}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" STYLE="background-color: #73b307; color: black; font-weight: bold" disabled id="outer_prod2_pix_valor" name="prod2_pix_valor">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Inputs para DIGITAIS -->
                                                    <div class="col-4">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">DINHEIRO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="outer_prod3_din" name="prod3_din" required  value="${modelVendasConsulta.prod3_din}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="outer_prod3_din_valor" name="prod3_din_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">DÉBITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="outer_prod3_deb" name="prod3_deb" required  value="${modelVendasConsulta.prod3_deb}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="outer_prod3_deb_valor" name="prod3_deb_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">CREDITO</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="outer_prod3_cred" name="prod3_cred" required  value="${modelVendasConsulta.prod3_cred}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="outer_prod3_cred_valor" name="prod3_cred_valor">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">PIX</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" id="outer_prod3_pix" name="prod3_pix" required  value="${modelVendasConsulta.prod3_pix}">
                                                            </div>
                                                            <div class="col-6">
                                                                <label style="color: fuchsia">VALOR</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: fuchsia; color: black; font-weight: bold" disabled id="outer_prod3_pix_valor" name="prod3_pix_valor">
                                                            </div>
                                                        </div>

                                                        </div>
                                                    <div class="col-4">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <label style="color: #777777">SOBRAS</label>
                                                                <input type="number" class="form-control" placeholder="" style="background-color: #777777; color: black; font-weight: bold" id="outer_sobras" name="sobras" required  value="${modelVendasConsulta.sobras}">
                                                            </div>
                                                            <div class="col-6">
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


                                                    </div>
                                                </div>


                                                <div>

                                                    <div>
                                                        <button class="btn btn-outline-success waves-effect waves-light">Atualizar</button>

                                                        <button type="button" class="btn btn-outline-warning waves-effect waves-light"  onclick="limparFormVendido();">Limpar</button>

                                                        <button type="button" class="btn btn-outline-danger waves-effect waves-light"  onclick="deletaVenda();">Excluir Venda</button>
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

        function limparbuscaFuncionario() {
            var elementos = document.getElementById("formBuscaFuncionario").elements;
            for (var p = 0; p < elementos.length; p++) {
                elementos[p].value = '';
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
                    success: function(json) {
                        $('#tabelabuscafuncionario > tbody > tr').remove();
                        for (var p = 0; p < json.length; p++) {
                            $('#tabelabuscafuncionario > tbody').append(
                                '<tr> <td>' + json[p].id + '</td> <td>' + json[p].nome +
                                '</td> <td> <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="verEditar(' + json[p].id + ', \'' + json[p].nome + '\')">Selecionar</button></td></tr>'
                            );
                        }
                        document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
                    },
                    error: function(xhr, status, errorThrown) {
                        alert('Erro ao Pesquisar o Funcionário: ' + xhr.responseText);
                    }
                });
            }
        }

        function verEditar(id, nome) {
            document.getElementById('vendedor_id').value = id;
            document.getElementById('vendedor').value = nome;

            // Rola até o fim do modal
            var modal = $('#modalBuscaFuncionario'); // Substitua pelo ID do seu modal
            modal.animate({ scrollTop: modal[0].scrollHeight }, 1000); // Rola suavemente para o fim em 1 segundo
        }




        function limparFormVendas() {
            // Limpa os campos do formulário
            $('#formBuscarVenda')[0].reset();
        }

        function limparFormVendido() {
            // Limpa os campos do formulário
            $('#formVendido')[0].reset();
        }






    </SCRIPT>




</body>
</html>