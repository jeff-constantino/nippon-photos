<%@ page import="model.ModelLogin" %><%--
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
                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalCad">
                                                <h4>Cadastrar</h4>
                                            </button>

                                            <!-- Modal -->

                                            <div class="modal fade" id="modalCad" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl modal-fullscreen-lg-down mt-lg-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Cadastro de Funcionário</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                                                <div class="row">
                                                                    <div class="page-body">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">

                                                                                    <form class="form-material" enctype="multipart/form-data"
                                                                                          action="<%= request.getContextPath() %>/ServletUsuarioController"
                                                                                          method="post" id="formUser">

                                                                                        <div class="row">
                                                                                            <!-- ID e Foto -->
                                                                                            <div class="col-6 col-sm-3 col-md-2 col-lg-1 mb-3">
                                                                                                <label class="float-label">ID:</label>
                                                                                                <input type="text" class="form-control" id="id2" name="id"
                                                                                                       placeholder="" readonly value="${modelLogin.id}">
                                                                                            </div>

                                                                                            <div class="col-12 col-md-6 col-lg-4 mb-3">
                                                                                                <label class="d-block mb-2">Foto:</label>
                                                                                                <div class="input-group">
                                                                                                    <div class="input-group-prepend me-2">
                                                                                                        <img src="" id="fotoembase64"
                                                                                                             class="img-thumbnail"
                                                                                                             style="max-width: 150px; height: auto;">
                                                                                                    </div>
                                                                                                    <input type="file" id="filefoto" name="filefoto"
                                                                                                           onchange="visualizarImg('fotoembase64','filefoto')"
                                                                                                           class="form-control">
                                                                                                </div>
                                                                                            </div>

                                                                                            <!-- Dados Pessoais -->
                                                                                            <div class="col-12 col-sm-6 col-lg-4 mb-3">
                                                                                                <label class="float-label">NOME:</label>
                                                                                                <input type="text" class="form-control" id="nome2" name="nome"
                                                                                                       placeholder="" style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.nome}" autofocus>
                                                                                            </div>
                                                                                            <div class="col-12 col-sm-6 col-lg-4 mb-3">
                                                                                                <label class="float-label">APELIDO:</label>
                                                                                                <input type="text" class="form-control" id="apelido2" name="apelido"
                                                                                                       placeholder="" style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.apelido}" autofocus>
                                                                                            </div>

                                                                                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-3">
                                                                                                <label class="float-label">RG:</label>
                                                                                                <input type="text" class="form-control" id="rg2" name="rg"
                                                                                                       maxlength="12" placeholder=""
                                                                                                       style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.rg}">
                                                                                            </div>

                                                                                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-3">
                                                                                                <label class="float-label">CPF:</label>
                                                                                                <input type="text" class="form-control" id="cpf2" name="cpf"
                                                                                                       maxlength="14" placeholder=""
                                                                                                       style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.cpf}">
                                                                                            </div>

                                                                                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-3">
                                                                                                <label class="float-label">PIS:</label>
                                                                                                <input type="text" class="form-control" id="pis2" name="pis"
                                                                                                       maxlength="14" placeholder=""
                                                                                                       style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.pis}">
                                                                                            </div>

                                                                                            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-3">
                                                                                                <label class="float-label">TELEFONE:</label>
                                                                                                <input type="text" class="form-control" id="telefone2"
                                                                                                       name="telefone" maxlength="15" placeholder=""
                                                                                                       style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.telefone}">
                                                                                            </div>

                                                                                            <div class="col-12 mb-3">
                                                                                                <label class="float-label">ENDEREÇO:</label>
                                                                                                <input type="text" class="form-control" id="endereco2"
                                                                                                       name="endereco" placeholder=""
                                                                                                       style="background-color: black"
                                                                                                       REQUIRED value="${modelLogin.endereco}">
                                                                                            </div>

                                                                                            <!-- Status e Comissão -->
                                                                                            <div class="col-12 col-sm-6 col-md-4 mb-3">
                                                                                                <label>STATUS</label>
                                                                                                <select class="form-select" id="status1" name="status" required>
                                                                                                    <option disabled="disabled">Selecione o Status</option>
                                                                                                    <option style="color: #00d25b" value="Ativo" <%
                                                                                                        ModelLogin modelLogin = (ModelLogin)request.getAttribute("modelLogin");
                                                                                                        if (modelLogin != null && modelLogin.getStatus().equalsIgnoreCase("Ativo")){
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }%>>Ativo
                                                                                                    </option>
                                                                                                    <option style="color: #bf3322" value="Inativo" <%
                                                                                                        modelLogin = (ModelLogin) request.getAttribute("modelLogin");
                                                                                                        if (modelLogin != null && modelLogin.getStatus().equalsIgnoreCase("Inativo")){
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }%>>Inativo
                                                                                                    </option>
                                                                                                </select>
                                                                                            </div>

                                                                                            <div class="col-12 col-sm-6 col-md-4 mb-3">
                                                                                                <label>COMISSÃO</label>
                                                                                                <select class="form-select" id="comissao" name="comissao" required>
                                                                                                    <option disabled="disabled">Selecione a Comissão</option>
                                                                                                    <option value="Comissão 1" <%
                                                                                                        if (modelLogin != null && "Comissão 1".equalsIgnoreCase(modelLogin.getComissao())) {
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }
                                                                                                    %>>Comissão 1
                                                                                                    </option>
                                                                                                    <option value="Comissão 2" <%
                                                                                                        if (modelLogin != null && "Comissão 2".equalsIgnoreCase(modelLogin.getComissao())) {
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }
                                                                                                    %>>Comissão 2
                                                                                                    </option>
                                                                                                </select>
                                                                                            </div>

                                                                                            <!-- Botões -->
                                                                                            <div class="col-12">
                                                                                                <div class="row">
                                                                                                    <div class="col-6 col-sm-4 col-md-3 mb-2">
                                                                                                        <button type="button"
                                                                                                                class="btn btn-outline-primary waves-effect waves-light w-100"
                                                                                                                onclick="limparForm();">
                                                                                                            Novo
                                                                                                        </button>
                                                                                                    </div>
                                                                                                    <div class="col-6 col-sm-4 col-md-3 mb-2">
                                                                                                        <button class="btn btn-outline-success waves-effect waves-light w-100">
                                                                                                            Cadastrar
                                                                                                        </button>
                                                                                                    </div>
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
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-multiple-plus text-success ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalCad" ></i>
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
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" >Pesquisa de Funcionário     </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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

                                                        <div class="modal-body" >
                                                            <div class="container-fluid">
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">

                                                                                    <form class="form-material"  id="formBuscaUser" method="get" action="<%= request.getContextPath() %>/ServletUsuarioController">

                                                                                        <div class="row">




                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label" >ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="idBusca" name="id" placeholder="" readonly value="${modelLogin.id}">
                                                                                            </div>
                                                                                            <div class="col-4">
                                                                                                <label class="float-label">NOME:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="nomeBusca" name="nome" placeholder=""  style="background-color: black" REQUIRED value="${modelLogin.nome}" autofocus>

                                                                                            </div>


                                                                                            <div>
                                                                                                <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparbuscaForm();" >Novo</button>
                                                                                                <button  type="button" class="btn btn-outline-success waves-effect waves-light" onclick="buscarUsuario();">Pesquisar</button>
                                                                                                <%--  BOTOES MODAL busca--%>
                                                                                            </div>
                                                                                            <div style="overflow-x: hidden">
                                                                                                <div style="height: 300px; overflow-y: auto ">
                                                                                                    <table class="table" id="tabelaresultados">
                                                                                                        <thead>
                                                                                                        <tr>
                                                                                                            <th scope="col">ID</th>
                                                                                                            <th scope="col">NOME</th>

                                                                                                            <th scope="col">GERENCIAR</th>

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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR</button>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-question text-behance ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalbusca" ></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                   
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">FUNCIONÁRIOS</h4>
                                <span style="color:#1ad76b; text-align: center">${msg}</span>

                                <div class="table-responsive" style="overflow-x: hidden">
                                    <form action="<%= request.getContextPath() %>/ServletUsuarioController"
                                          method="post" id="formUser2" name="formUser2" enctype="multipart/form-data">

                                        <input type="hidden" name="acao" value="">

                                        <div class="row">

                                            <!-- ID -->
                                            <div class="col-sm-1 mb-3">
                                                <label>ID:</label>
                                                <input type="text" class="form-control" id="id" name="id"
                                                       style="background-color: black" readonly
                                                       value="${modelLogin.id}">
                                            </div>

                                            <!-- Nome -->
                                            <div class="col-sm-4 mb-3">
                                                <label>NOME:</label>
                                                <input type="text" class="form-control" id="nome" name="nome"
                                                       style="background-color: black" required
                                                       value="${modelLogin.nome}">
                                            </div>
                                            <div class="col-12 col-sm-6 col-lg-4 mb-3">
                                                <label class="float-label">APELIDO:</label>
                                                <input type="text" class="form-control" id="apelido" name="apelido"
                                                       placeholder="" style="background-color: black"
                                                       REQUIRED value="${modelLogin.apelido}" autofocus>
                                            </div>
                                            <div class="col-3 input-group mb-4">
                                                <div class="input-group-prepend">
                                                    <c:if test="${modelLogin.fotouser != '' && modelLogin.fotouser != null}">
                                                        <img id="fotoembase642" src="${modelLogin.fotouser}" width="200px">
                                                    </c:if>
                                                    <c:if test="${modelLogin.fotouser == '' || modelLogin.fotouser == null}">
                                                        <img id="fotoembase642" src="assets/images/user.png" width="200px">
                                                    </c:if>
                                                </div>
                                                <input type="file" id="filefoto2" name="filefoto" onchange="visualizarImg('fotoembase642','filefoto2')" class="form-control-file">
                                            </div>

                                            <!-- RG -->
                                            <div class="col-sm-2 mb-3">
                                                <label>RG:</label>
                                                <input type="text" class="form-control" id="rg" name="rg" maxlength="12"
                                                       style="background-color: black" required
                                                       value="${modelLogin.rg}">
                                            </div>

                                            <!-- CPF -->
                                            <div class="col-sm-2 mb-3">
                                                <label>CPF:</label>
                                                <input type="text" class="form-control" id="cpf" name="cpf" maxlength="14"
                                                       style="background-color: black" required
                                                       value="${modelLogin.cpf}">
                                            </div>

                                            <!-- PIS -->
                                            <div class="col-sm-2 mb-3">
                                                <label>PIS:</label>
                                                <input type="text" class="form-control" id="pis" name="pis" maxlength="14"
                                                       style="background-color: black" required
                                                       value="${modelLogin.pis}">
                                            </div>

                                            <!-- Telefone -->
                                            <div class="col-sm-2 mb-3">
                                                <label>TELEFONE:</label>
                                                <input type="text" class="form-control" id="telefone" name="telefone" maxlength="15"
                                                       style="background-color: black" required
                                                       value="${modelLogin.telefone}">
                                            </div>

                                            <!-- Endereço (linha inteira) -->
                                            <div class="col-8 mb-3">
                                                <label>ENDEREÇO:</label>
                                                <input type="text" class="form-control" id="endereco" name="endereco"
                                                       style="background-color: black" required
                                                       value="${modelLogin.endereco}">
                                            </div>

                                            <!-- STATUS -->
                                            <div class="col-sm-3 mb-3">
                                                <label>STATUS</label>
                                                <select class="form-select" id="status2" name="status" required>
                                                    <option disabled>Selecione o Status</option>

                                                    <option value="Ativo"
                                                            <%
                                                                modelLogin = (ModelLogin) request.getAttribute("modelLogin");
                                                                if (modelLogin != null && modelLogin.getStatus().equalsIgnoreCase("Ativo")) {
                                                                    out.print("selected=\"selected\"");
                                                                }
                                                            %>>
                                                        Ativo
                                                    </option>

                                                    <option value="Inativo"
                                                            <%
                                                                if (modelLogin != null && modelLogin.getStatus().equalsIgnoreCase("Inativo")) {
                                                                    out.print("selected=\"selected\"");
                                                                }
                                                            %>>
                                                        Inativo
                                                    </option>
                                                </select>
                                            </div>

                                            <!-- Comissão -->
                                            <div class="col-sm-3 mb-3">
                                                <label>COMISSÃO</label>
                                                <select class="form-select" id="comissao2" name="comissao" required>
                                                    <option disabled>Selecione a Comissão</option>

                                                    <option value="Comissão 1"
                                                            <%
                                                                if (modelLogin != null && "Comissão 1".equalsIgnoreCase(modelLogin.getComissao())) {
                                                                    out.print("selected=\"selected\"");
                                                                }
                                                            %>>
                                                        Comissão 1
                                                    </option>

                                                    <option value="Comissão 2"
                                                            <%
                                                                if (modelLogin != null && "Comissão 2".equalsIgnoreCase(modelLogin.getComissao())) {
                                                                    out.print("selected=\"selected\"");
                                                                }
                                                            %>>
                                                        Comissão 2
                                                    </option>
                                                </select>
                                            </div>

                                            <!-- Botões -->
                                            <div class="col-12 mt-2">
                                                <button class="btn btn-outline-success">Atualizar</button>
                                                <button type="button"
                                                        class="btn btn-outline-danger"
                                                        onclick="criarDeleteComAjax();">
                                                    Excluir
                                                </button>
                                            </div>

                                        </div>
                                    </form>

                                    <h5>Funcionários Ativos:</h5>

                                    <!-- Tabela -->
                                    <div style="overflow-x: hidden; overflow-y: hidden">
                                        <table class="table" id="tabelaresultadosview">
                                            <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>NOME</th>
                                                <th>STATUS</th>
                                                <th>GERENCIAR</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${modelLogins}" var="mL">
                                                <tr>
                                                    <td>${mL.id}</td>
                                                    <td>${mL.nome}</td>
                                                    <td>${mL.status}</td>
                                                    <td>
                                                        <a class="btn btn-outline-success"
                                                           href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${mL.id}">
                                                            Gerenciar
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
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




    function verEditar(id){
        var urlAction = document.getElementById('formBuscaUser').action;

        window.location.href = urlAction + '?acao=buscarEditar&id='+id;
    }


    function criarCadastro(){
        document.getElementById("acao").value = 'cadastrar';
        document.getElementById("formUser").submit();



    }

    function buscarUsuario(){
        var nomeBusca = document.getElementById('nomeBusca').value;
        //valida que precisa ter valor para continuar BUSCANDO
        if (nomeBusca != null && nomeBusca !='' && nomeBusca.trim() != ''){
            var urlAction = document.getElementById('formBuscaUser').action;
            $.ajax({
                method: 'GET',
                url : urlAction,
                data : "nomeBusca=" + nomeBusca + '&acao=buscaruserajax',
                success : function (response){
                    const json = JSON.parse(response);


                    $('#tabelaresultados > tbody > tr').remove();
                    for (var p = 0; p < json.length; p++){
                        $('#tabelaresultados > tbody').append('<tr> <td>' + json[p].id + '</td> <td>' +json[p].nome+ '</td> <td> <button  type="button" class="btn btn-outline-success waves-effect waves-light" onclick="verEditar('+json[p].id+')">Editar</button></td></tr>');

                    }
                    document.getElementById('totalResultados').textContent = 'Resultados: '+json.length;



                }

            }).fail(function (xhr, status, errorThrown){
                alert('Erro ao Pesquisar o Funcionário :'+xhr.responseText);
            });

        }

    }


    function criarDeleteComAjax(){
        if (confirm('Deseja realmente excluir o Funcionário?')){
            var urlAction = document.getElementById('formUser2').action;
            var idUser = document.getElementById('id').value;

            $.ajax({
                method : "get",
                url : urlAction,
                data : "id=" + idUser + '&acao=deletarajax',
                success : function (response){
                    limparForm2();
                    document.getElementById('msg').textContent = response;
                }

            }).fail(function (xhr, status, errorThrown){
                alert('Erro ao Excluir o Funcionário :'+xhr.responseText);
            });
        }
    }

    function criarDelete() {
        if (confirm('Deseja realmente excluir o Funcionário?')) {

            document.getElementById("formUser2").method = 'get';
            document.getElementById("acao").value = 'deletar';
            document.getElementById("formUser2").submit();

        }
    }




    function limparForm(){
        var elementos =document.getElementById("formUser").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }
    function limparForm2(){
        var elementos =document.getElementById("formUser2").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }
    function  limparbuscaForm(){
        var elementos =document.getElementById("formBuscaUser").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }
    function  limpaFormCad(){
        var elementos = document.getElementById("formUser").elements;
        for (var p = 0; p < elementos.length; p++){
            elementos[p].value = '';
        }
    }

    // Evento para limpar o formulário ao fechar o modal
    $('#modalCad').on('hidden.bs.modal', function () {
        limpaFormCad(); // Limpa o formulário
    })



   // ============================ MÁSCARAS ===============================

   // Mascara CPF
   function mascaraCPF(value) {
       return value
           .replace(/\D/g, "")
           .replace(/(\d{3})(\d)/, "$1.$2")
           .replace(/(\d{3})(\d)/, "$1.$2")
           .replace(/(\d{3})(\d{1,2})$/, "$1-$2");
   }

   // Mascara PIS
   function mascaraPIS(value) {
       return value
           .replace(/\D/g, "")
           .replace(/(\d{3})(\d)/, "$1.$2")
           .replace(/(\d{5})(\d)/, "$1.$2")
           .replace(/(\d{5}\.\d{2})(\d{1,2})$/, "$1-$2");
   }

   // Mascara Telefone
   function mascaraTelefone(value) {
       return value
           .replace(/\D/g, "")
           .replace(/(\d{2})(\d)/, "($1) $2")
           .replace(/(\d{5})(\d)/, "$1-$2");
   }

   // ============================ APLICAÇÃO DAS MÁSCARAS ===============================

   document.getElementById("cpf2").addEventListener("input", function () {
       this.value = mascaraCPF(this.value);
   });

   document.getElementById("pis2").addEventListener("input", function () {
       this.value = mascaraPIS(this.value);
   });

   document.getElementById("telefone2").addEventListener("input", function () {
       this.value = mascaraTelefone(this.value);
   });

   document.getElementById("cpf").addEventListener("input", function () {
       this.value = mascaraCPF(this.value);
   });

   document.getElementById("pis").addEventListener("input", function () {
       this.value = mascaraPIS(this.value);
   });

   document.getElementById("telefone").addEventListener("input", function () {
       this.value = mascaraTelefone(this.value);
   });


   // ============================ BLOQUEAR LETRAS NOS CAMPOS NUMÉRICOS ===============================

   ["cpf2", "pis2", "telefone2", "rg2" ,"cpf", "pis", "telefone", "rg"  ].forEach(id => {
       document.getElementById(id).addEventListener("keypress", function (e) {
           if (!/[0-9]/.test(e.key)) {
               e.preventDefault();
           }
       });
   });


   // ============================ LIMITES DE TAMANHO ===============================

   document.getElementById("cpf2").maxLength = 14; // 000.000.000-00
   document.getElementById("pis2").maxLength = 14; // 000.00000.00-0
   document.getElementById("telefone2").maxLength = 15; // (00) 00000-0000
   document.getElementById("rg2").maxLength = 15;
   document.getElementById("cpf").maxLength = 14; // 000.000.000-00
   document.getElementById("pis").maxLength = 14; // 000.00000.00-0
   document.getElementById("telefone").maxLength = 15; // (00) 00000-0000
   document.getElementById("rg").maxLength = 15;

   // ============================ VALIDAÇÃO DE CPF REAL ===============================

   function validarCPF(cpf) {
       cpf = cpf.replace(/\D/g, "");

       if (cpf.length !== 11) return false;
       if (/^(.)\1+$/.test(cpf)) return false;

       let soma = 0, resto;

       for (let i = 1; i <= 9; i++)
           soma += parseInt(cpf.substring(i - 1, i)) * (11 - i);

       resto = (soma * 10) % 11;
       if (resto === 10 || resto === 11) resto = 0;
       if (resto !== parseInt(cpf.substring(9, 10))) return false;

       soma = 0;
       for (let i = 1; i <= 10; i++)
           soma += parseInt(cpf.substring(i - 1, i)) * (12 - i);

       resto = (soma * 10) % 11;
       if (resto === 10 || resto === 11) resto = 0;
       return resto === parseInt(cpf.substring(10, 11));
   }

   // ============================ VALIDAÇÃO DE PIS REAL ===============================

   function validarPIS(pis) {
       pis = pis.replace(/\D/g, "");

       if (pis.length !== 11) return false;

       const pesos = [3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
       let soma = 0;

       for (let i = 0; i < 10; i++) {
           soma += parseInt(pis.charAt(i)) * pesos[i];
       }

       const resto = soma % 11;
       const digito = resto < 2 ? 0 : 11 - resto;

       return digito === parseInt(pis.charAt(10));
   }


   // ============================ BLOQUEAR SUBMIT ===============================

   document.getElementById("formUser").addEventListener("submit", function (e) {

       let cpf  = document.getElementById("cpf")  ? document.getElementById("cpf").value  : "";
       let cpf2 = document.getElementById("cpf2") ? document.getElementById("cpf2").value : "";

       let pis  = document.getElementById("pis")  ? document.getElementById("pis").value  : "";
       let pis2 = document.getElementById("pis2") ? document.getElementById("pis2").value : "";

       // ================= CPF =================
       if (cpf !== "" && !validarCPF(cpf)) {
           alert("CPF inválido. Corrija antes de enviar.");
           e.preventDefault();
           return;
       }

       if (cpf2 !== "" && !validarCPF(cpf2)) {
           alert("CPF inválido. Corrija antes de enviar.");
           e.preventDefault();
           return;
       }

       // ================= PIS =================
       if (pis !== "" && !validarPIS(pis)) {
           alert("PIS inválido. Corrija antes de enviar.");
           e.preventDefault();
           return;
       }

       if (pis2 !== "" && !validarPIS(pis2)) {
           alert("PIS inválido. Corrija antes de enviar.");
           e.preventDefault();
           return;
       }

   });
function visualizarImg(fotoembase64 , filefoto){
    var preview = document.getElementById(fotoembase64);
    var fileUser = document.getElementById(filefoto).files[0];
    var reader = new FileReader();

    reader.onloadend = function (){
        preview.src = reader.result;
    }
    if (fileUser){
        reader.readAsDataURL(fileUser);
    }else {
        preview.src = "";
    }

}

</SCRIPT>
</body>
</html>