<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

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
            <div class="content-wrapper" style="min-height: calc(92vh - 70px);">
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
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalADV">
                                                <h4>ADVERTÊNCIAS</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalADV" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Advertências </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
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
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">

                                                                                    <form class="form-material" id="formBuscaFuncionario1" method="get" action="<%= request.getContextPath() %>/ServletMedidasDisciplinares">
                                                                                        <div class="row">
                                                                                            <div class="col-auto">
                                                                                                <label>Funcionário</label>
                                                                                                <select class="form-control" id="funcionarioIdADV" name="funcionarioIdADV" onchange="atualizarFuncionarioSelecionado('formAdvertencia', this.value)" required>
                                                                                                    <option value="">Selecione um Funcionário</option>
                                                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                                        <c:if test="${funcionario.status == 'ATIVO'}">
                                                                                                            <option value="${funcionario.id}" class="text-success"
                                                                                                                    <c:if test="${funcionario.id == funcionarioIdADV}">selected</c:if>>
                                                                                                                    ${funcionario.nome}
                                                                                                            </option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                                        <c:if test="${funcionario.status != 'ATIVO'}">
                                                                                                            <option value="${funcionario.id}" class="text-danger"
                                                                                                                    <c:if test="${funcionario.id == funcionarioIdADV}">selected</c:if>>
                                                                                                                    ${funcionario.nome}
                                                                                                            </option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </select>

                                                                                            </div>
                                                                                        </div>
                                                                                    </form>

                                                                                    <form action="<%= request.getContextPath() %>/ServletMedidasDisciplinares" method="post" id="formAdvertencia" name="formAdvertencia">
                                                                                        <input type="hidden" name="acao" value="gravarAdvertencia">
                                                                                        <input type="hidden" name="funcionarioId" id="funcionarioIdAdvertencia">
                                                                                        <input type="hidden" name="nomeFuncionario" id="nomeFuncionario" />


                                                                                        <div class="col-6">
                                                                                            <span style="color:#1ad76b">${msg}</span>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label>Data da Advertência</label>
                                                                                                <input type="date" class="form-control" id="data_advertencia" name="data_advertencia" required
                                                                                                       value="">
                                                                                            </div>

                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col">
                                                                                                <label style="color: #f2a654">Motivo</label>
                                                                                                <textarea class="form-control"
                                                                                                          style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase"
                                                                                                          id="adv_motivo" name="adv_motivo" required
                                                                                                          oninput="this.value = this.value.toUpperCase();"></textarea>

                                                                                            </div>
                                                                                        </div>
                                                                                        <br>
                                                                                        <div>
                                                                                            <button class="btn btn-outline-success waves-effect waves-light">Salvar</button>
                                                                                            <button type="button" class="btn btn-outline-warning waves-effect waves-light" onclick="limparForm('formAdvertencia')">Limpar</button>
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi  mdi mdi-alert text-warning ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalADV" ></i>
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
                                            <button type="button" class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#modalFalta">
                                                <h4>FALTAS</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalFalta" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Faltas </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
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
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">

                                                                                    <form class="form-material" id="formBuscaFuncionario2"
                                                                                          method="get"
                                                                                          action="<%= request.getContextPath() %>/ServletMedidasDisciplinares">

                                                                                        <div class="row">
                                                                                            <div class="col-auto">
                                                                                                <label>Funcionário</label>
                                                                                                <select class="form-control" id="funcionarioFalta" name="funcionarioIdFalta" onchange="atualizarFuncionarioFalta()" required>
                                                                                                    <option value="">Selecione um Funcionário</option>
                                                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                                        <c:if test="${funcionario.status == 'ATIVO'}">
                                                                                                            <option value="${funcionario.id}"
                                                                                                                    class="text-success"
                                                                                                                    <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                                                    ${funcionario.nome}
                                                                                                            </option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                                        <c:if test="${funcionario.status != 'ATIVO'}">
                                                                                                            <option value="${funcionario.id}"
                                                                                                                    class="text-danger"
                                                                                                                    <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                                                    ${funcionario.nome}
                                                                                                            </option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </select>

                                                                                            </div>
                                                                                        </div>

                                                                                    </form>

                                                                                    <form action="<%= request.getContextPath() %>/ServletMedidasDisciplinares"
                                                                                          method="post" id="formFaltas" name="formFaltas">
                                                                                        <input type="hidden" name="acao" value="gravarFaltas">
                                                                                        <input type="hidden" name="acao" value="gravarAdvertencia">
                                                                                        <input type="hidden" name="funcionarioId" id="funcionarioIdFalta" />
                                                                                        <input type="hidden" name="nomeFuncionario" id="nomeFuncionarioFalta" />


                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="row">

                                                                                            <div class="col-3">
                                                                                                <label>Data da Falta</label>
                                                                                                <input type="date" class="form-control"
                                                                                                       id="data_falta" name="data_falta"
                                                                                                       required
                                                                                                       value="">
                                                                                            </div>



                                                                                        </div>




                                                                                        <div class="row">

                                                                                            <div class="col">
                                                                                                <div class="row">
                                                                                                    <div class="mb-3">
                                                                                                        <label style="color: #f2a654">OBSERVAÇÕES</label>
                                                                                                        <textarea class="form-control"
                                                                                                                  style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase"
                                                                                                                  id="falta_obs" name="falta_obs"
                                                                                                                  required
                                                                                                                  oninput="this.value = this.value.toUpperCase();"></textarea>



                                                                                                    </div>

                                                                                                </div>
                                                                                            </div>









                                                                                        </div>

                                                                                        <br>

                                                                                        <div>
                                                                                            <button class="btn btn-outline-success waves-effect waves-light">
                                                                                                Salvar
                                                                                            </button>
                                                                                            <button type="button"
                                                                                                    class="btn btn-outline-warning waves-effect waves-light"
                                                                                                    onclick="limparFormVendas();">Limpar
                                                                                            </button>

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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi  mdi-snapchat text-light ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalFalta" ></i>
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
                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalSuspensao">
                                                <h4>SUSPENSÃO</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalSuspensao" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Lançamento de Suspensão </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                    aria-label="Close"></button>
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
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">

                                                                                    <form class="form-material" id="formBuscaFuncionario3"
                                                                                          method="get"
                                                                                          action="<%= request.getContextPath() %>/ServletMedidasDisciplinares">

                                                                                        <div class="row">

                                                                                            <div class="col-auto">
                                                                                                <label>Funcionário</label>
                                                                                                <select class="form-control" id="funcionarioIdSusp" name="funcionarioIdSusp" required>
                                                                                                    <option value="">Selecione um Funcionário</option>
                                                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                                        <c:if test="${funcionario.status == 'ATIVO'}">
                                                                                                            <option value="${funcionario.id}"
                                                                                                                    class="text-success"
                                                                                                                    <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                                                    ${funcionario.nome}
                                                                                                            </option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                                        <c:if test="${funcionario.status != 'ATIVO'}">
                                                                                                            <option value="${funcionario.id}"
                                                                                                                    class="text-danger"
                                                                                                                    <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                                                    ${funcionario.nome}
                                                                                                            </option>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                </select>

                                                                                            </div>

                                                                                        </div>

                                                                                    </form>

                                                                                    <form action="<%= request.getContextPath() %>/ServletMedidasDisciplinares"
                                                                                          method="post" id="formSuspensao" name="formSuspensao">
                                                                                        <input type="hidden" name="acao" value="">

                                                                                        <div class="col-6">
                                                                                            <div class="col-auto">
                                                                                                <span style="color:#1ad76b">${msg}</span>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="row">
                                                                                            <div class="col-3">
                                                                                                <label for="data_suspensao">Data da Suspensão</label>
                                                                                                <input type="date" class="form-control"
                                                                                                       id="data_suspensao" name="data_suspensao"
                                                                                                       required
                                                                                                       value="">
                                                                                            </div>
                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label">ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="id_suspensao" name="id"
                                                                                                       placeholder=""
                                                                                                       style="background-color: black" readonly
                                                                                                       value="${funcionario.id}">
                                                                                            </div>

                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label">DIAS:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control"
                                                                                                       id="dias_suspensao" name="susp_dias" placeholder=""
                                                                                                       style="background-color: white; color: black; font-weight: bold"
                                                                                                       value="${modelVendas.nome}" >
                                                                                            </div>

                                                                                        </div>




                                                                                        <div class="row">

                                                                                            <div class="col">
                                                                                                <div class="row">
                                                                                                    <div class="mb-3">
                                                                                                        <label style="color: #f2a654">MOTIVO:</label>
                                                                                                        <textarea class="form-control"
                                                                                                                  style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase"
                                                                                                                  id="susp_motivo" name="susp_motivo"
                                                                                                                  required
                                                                                                                  oninput="this.value = this.value.toUpperCase();"></textarea>


                                                                                                    </div>

                                                                                                </div>
                                                                                            </div>









                                                                                        </div>

                                                                                        <br>

                                                                                        <div>
                                                                                            <button class="btn btn-outline-success waves-effect waves-light">
                                                                                                Salvar
                                                                                            </button>
                                                                                            <button type="button"
                                                                                                    class="btn btn-outline-warning waves-effect waves-light"
                                                                                                    onclick="limparFormVendas();">Limpar
                                                                                            </button>

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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR
                                                            </button>
                                                            <%--FIM MODAL BUSCA--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-block-helper text-danger ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalSuspensao" ></i>
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
                                <h4 class="card-title">Histórico Disciplinar</h4>
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
<!-- container-scroller -->
<!-- plugins:js -->
<jsp:include page="pluginsJS.jsp"></jsp:include>
<!-- End custom js for this page -->
<script>
    $(document).ready(function () {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem

            // Remove a mensagem da sessão após exibi-la
            $.post("${pageContext.request.contextPath}/ServletMedidasDisciplinares", { acao: "limparMsg" });
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



    function buscarFuncAdv() {
        var nomeBusca = document.getElementById('nomeBusca').value;

        if (nomeBusca != null && nomeBusca.trim() != '') {
            var urlAction = document.getElementById('formBuscaFuncionario1').action;

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
                            '</td> <td> <button type="button" class="btn btn-outline-success waves-effect waves-light" onclick="verEditarAdv(' + json[p].id + ', \'' + json[p].nome + '\')">Selecionar</button></td></tr>'
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
    function verEditarAdv(id, nome) {
        document.getElementById('id_advertencia').value = id;
        document.getElementById('nome_advertencia').value = nome;


    }

    function atualizarFuncionarioSelecionado(formId) {
        const select = document.getElementById("funcionarioIdADV");
        const funcionarioId = select.value;
        const nomeFuncionario = select.options[select.selectedIndex].text.trim();

        const form = document.getElementById(formId);
        form.querySelector('input[name="funcionarioId"]').value = funcionarioId;
        // form.querySelector('input[name="id_advertencia"]').value = funcionarioId;
        form.querySelector('input[name="nomeFuncionario"]').value = nomeFuncionario;
    }

    window.onload = function () {
        atualizarFuncionarioSelecionado('formAdvertencia');
    };
    function atualizarFuncionarioFalta() {
        const select = document.getElementById("funcionarioFalta");
        const funcionarioId = select.value;
        const nomeFuncionario = select.options[select.selectedIndex].text.trim();

        const form = document.getElementById("formFaltas");
        form.querySelector('input[name="funcionarioId"]').value = funcionarioId;
        form.querySelector('input[name="nomeFuncionario"]').value = nomeFuncionario;
    }
    window.onload = atualizarFuncionarioFalta;

    function limparForm(formId) {
        document.getElementById(formId).reset();
        document.getElementById(formId).querySelector('input[name="funcionarioId"]').value = '';
        document.getElementById(formId).querySelector('input[name="id_advertencia"]').value = '';
    }



</SCRIPT>
</body>
</html>
