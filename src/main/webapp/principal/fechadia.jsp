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
            <div class="content-wrapper" style="min-height: calc(100vh - 70px);">
                <div class="row">
                    <div class="col-xl-12">



                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">

                                <div class="card-body" >



 <%--PAGINA PRINCIPAL                  --%>

                                    <div class="modal fade" id="modalBuscaFechamento" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Pesquisa de Fechamentos</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="<%= request.getContextPath() %>/ServletFechaDia" method="get" id="formBuscaFechamento">
                                                        <input type="hidden" name="acao" value="gerenciarFechadia" />
                                                        <div class="col-3">
                                                            <label for="fecha_id" class="form-label">ID:</label>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="fecha_id" name="fecha_id" required placeholder="" />
                                                                <button type="submit" class="btn btn-outline-success">Buscar</button>
                                                            </div>

                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Sair</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="modalLancaFechamento" data-bs-backdrop="static" data-bs-keyboard="false"
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
                                                                            <form action="<%= request.getContextPath() %>/ServletFechaDia" method="get" id="formFechaTotal" name="formFechaTotal">
                                                                                <input type="hidden" name="acao" value="buscaData" />
                                                                                <div class="form-row align-items-center">
                                                                                    <div class="col-auto d-flex align-items-end">
                                                                                        <div class="mr-2">
                                                                                            <label for="data_fechamento">Data Fechamento</label>
                                                                                            <input type="date" class="form-control" id="data_fechamento" name="data_fechamento" value="${data_fechamento}">
                                                                                        </div>
                                                                                        <div>
                                                                                            <button type="submit" class="btn btn-outline-success">Gerar Fechamento</button>
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
                                                    <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR
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



                                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal"
                                                            data-bs-target="#modalLancaFechamento">
                                                        <h4>Finalizar Dia</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                                            data-bs-target="#modalBuscaFechamento">
                                                        <h4>Buscar Fechamento</h4>
                                                    </button>
                                                    <div class="table-responsive" style="overflow-x: hidden">
                                                        <table class="table">
 <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                                            <form action="<%= request.getContextPath() %>/ServletFechaDia" method="post" id="formBuscarFechamento" name="formBuscarFechamento">
                                                                <input type="hidden" name="acao" value="">
                                                                <div class="col-sm-1">
                                                                    <label class="float-label">ID:</label>
                                                                    <span class="form-bar"></span>
                                                                    <input type="text" class="form-control" id="FechaId" name="id" placeholder=""
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
                                                                        <label for="dataFechamento">Data do Fechamento:</label>
                                                                        <input type="date" class="form-control" id="dataFechamento" name="data_fechamento" required
                                                                                value="${fechamento != null ? fechamento.data_fechamento : ''}">
                                                                    </div>

                                                                    <div class="col-6">
                                                                        <label class="float-label">Observações:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control" id="observacao" name="observacao" placeholder=""
                                                                               style="background-color: black" readonly
                                                                                value="${fechamento != null ? fechamento.observacao : ''}">
                                                                    </div>

                                                                    <div class="col-2">
                                                                        <label class="float-label">TOTAL DE FOTOS:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control" id="total_total" name="total_total" placeholder=""
                                                                               style="background-color: white; color: black" disabled>
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
                                                                                <label style="color: #f2a654">Fotos Dinheiro</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled id="total_ft_din" name="total_ft_din"
                                                                                       value="${fechamento != null ? fechamento.total_ft_din : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">Fotos Débito</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled id="total_ft_deb" name="total_ft_deb"
                                                                                        value="${fechamento != null ? fechamento.total_ft_deb : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">Fotos Crédito</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled id="total_ft_cred" name="total_ft_cred"
                                                                                        value="${fechamento != null ? fechamento.total_ft_cred : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">Fotos Pix</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                       disabled id="total_ft_pix" name="total_ft_pix"
                                                                                        value="${fechamento != null ? fechamento.total_ft_pix : ''}">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Inputs para ENCARTE -->
                                                                    <div class="col-4">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <label style="color: #00d25b">Encartes Dinheiro</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled id="total_enc_din" name="total_enc_din"
                                                                                        value="${fechamento != null ? fechamento.total_enc_din : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: #00d25b">Encartes Débito</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled id="total_enc_deb" name="total_enc_deb"
                                                                                        value="${fechamento != null ? fechamento.total_enc_deb : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: #00d25b">Encartes Crédito</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled id="total_enc_cred" name="total_enc_cred"
                                                                                        value="${fechamento != null ? fechamento.total_enc_cred : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: #00d25b">Encartes Pix</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: #73b307; color: black; font-weight: bold"
                                                                                       disabled id="total_enc_pix" name="total_enc_pix"
                                                                                        value="${fechamento != null ? fechamento.total_enc_pix : ''}">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Inputs para DIGITAIS -->
                                                                    <div class="col-4">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">Digitais Dinheiro</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled id="total_dig_din" name="total_dig_din"
                                                                                        value="${fechamento != null ? fechamento.total_dig_din : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">Digitais Débito</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled id="total_dig_deb" name="total_dig_deb"
                                                                                        value="${fechamento != null ? fechamento.total_dig_deb : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">Digitais Crédito</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled id="total_dig_cred" name="total_dig_cred"
                                                                                        value="${fechamento != null ? fechamento.total_dig_cred : ''}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">Digitais Pix</label>
                                                                                <input type="number" class="form-control" placeholder=""
                                                                                       style="background-color: fuchsia; color: black; font-weight: bold"
                                                                                       disabled id="total_dig_pix" name="total_dig_pix"
                                                                                        value="${fechamento != null ? fechamento.total_dig_pix : ''}">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="row mt-3">
                                                                    <div class="col-4">
                                                                        <input type="submit" class="btn btn-primary" value="Atualizar Fechamento">
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
                            </div>
                        </div>
                    </div>
                    <%--BLOCO 2--%>


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

                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">Fechamentos</h4>
                                    <div class="table-responsive">
<%--Inserir Ribbons --%>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--BLOCO 3--%>

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

                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title" style="text-align: center">MATERIAIS</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered minha-tabela">
                                            <thead class="thead-light">

                                            <c:if test="${not empty fechaDia}">
                                            <table class="table table-bordered">

                                                <tr>

                                                    <th>ID</th>
                                                    <th>Data</th>
                                                    <th>Fts Din.</th>
                                                    <th>Fts Déb.</th>
                                                    <th>Fts Cred.</th>
                                                    <th>Fts Pix</th>

                                                    <th>Enc. Din.</th>
                                                    <th>Enc. Déb.</th>
                                                    <th>Enc. Cred.</th>
                                                    <th>Enc. Pix</th>

                                                    <th>Dig. Din.</th>
                                                    <th>Dig. Déb.</th>
                                                    <th>Dig. Cred.</th>
                                                    <th>Dig. Pix</th>
                                                    <th>Sobras</th>
                                                    <th>Ribbon 1</th>
                                                    <th>Ribbon 2</th>
                                                    <th>Ribbon 3</th>
                                                    <th>Ribbon 4</th>
                                                    <th>Ribbon 5</th>
                                                    <th>Ribbon 6</th>




                                                </tr>

                                                <!-- Bloco 2 -->
                                                <tbody>
                                                <c:forEach items="${fechaDia}" var="modelFechaDia">
                                                    <c:if test="${modelFechaDia.idConf == 2}">
                                                        <tr>
                                                            <td>

                                                            </td>
                                                            <td><c:out value="${modelFechaDia.id}"/></td>
                                                            <td><c:out value="${modelFechaDia.data_fechamento}"/></td>

                                                            <td><c:out value="${modelFechaDia.total_ft_din}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ft_deb}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ft_cred}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ft_pix}"/></td>

                                                            <td><c:out value="${modelFechaDia.total_enc_din}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_enc_deb}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_enc_cred}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_enc_pix}"/></td>

                                                            <td><c:out value="${modelFechaDia.total_dig_din}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_dig_deb}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_dig_cred}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_dig_pix}"/></td>

                                                            <td><c:out value="${modelFechaDia.sobras}"/></td>

                                                            <td><fmt:formatNumber value="${modelFechaDia.desconto}" type="number" maxFractionDigits="2" minFractionDigits="2"/></td>
                                                            <td hidden="hidden"><c:out value="${modelFechaDia.observacao}"/></td>

                                                            <td><c:out value="${modelFechaDia.total_ribbon_1}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ribbon_2}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ribbon_3}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ribbon_4}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ribbon_5}"/></td>
                                                            <td><c:out value="${modelFechaDia.total_ribbon_6}"/></td>


                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                                </tbody>


                                                </c:if>
                                                <c:if test="${empty fechadia}">
                                                <p>Nenhuma configuração encontrada.</p>
                                                </c:if>
                                            </thead>
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



    <SCRIPT type="text/javascript">

        $(document).ready(function() {
            var msg = "${msg}";
            if (msg) {
                $('#msgModal').modal('show'); // Exibe o modal com a mensagem
            }
        });


        function deletaVenda() {
            const fechaId = document.getElementById('id').value; // Obtém o ID da venda
            if (confirm("Tem certeza que deseja excluir esta venda?")) {
                $.ajax({
                    method: 'POST',
                    url: '<%= request.getContextPath() %>/ServletVendas',
                    data: {acao: 'deletar', id: fechaId},
                    success: function (response) {
                        alert("Venda excluída com sucesso!");
                        location.reload(); // Atualiza a página
                    },
                    error: function (xhr, status, errorThrown) {
                        alert('Erro ao excluir o Fechamento: ' + xhr.responseText);
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

                xhr.onload = function() {
                    if (xhr.status === 200) {
                        // Preenche o array de produtos com os valores retornados
                        produtos = JSON.parse(xhr.responseText);
                        console.log('Produtos carregados:', produtos); // Log dos produtos carregados
                        calcularValor(quantidade, produtoId); // Calcular valor após receber os produtos
                    } else {
                        console.error('Erro ao buscar valores:', xhr.statusText);
                    }
                };
                xhr.send();
            } else {
                calcularValor(quantidade, produtoId); // Se os produtos já foram carregados, calcular o valor imediatamente
            }
        }

        function calcularValor(quantidade, produtoId) {
            console.log('Recalculando valor para a quantidade:', quantidade, 'do produto:', produtoId); // Log da recalculação

            const prod = produtos[0]; // Considerando que você só tem um produto na lista

            if (prod) {
                let valorProduto;

                switch (produtoId) {
                    case 'total_conf1_din':
                    case 'total_conf1_deb':
                    case 'total_conf1_cred':
                    case 'total_conf1_pix':
                        valorProduto = parseFloat(prod.conf1_valor);
                        break;
                    case 'total_conf2_din':
                    case 'total_conf2_deb':
                    case 'total_conf2_cred':
                    case 'total_conf2_pix':
                        valorProduto = parseFloat(prod.conf2_valor);
                        break;
                    case 'total_conf3_din':
                    case 'total_conf3_deb':
                    case 'total_conf3_cred':
                    case 'total_conf3_pix':
                        valorProduto = parseFloat(prod.conf3_valor);
                        break;
                    default:
                        console.log('Produto não encontrado');
                        return;
                }

                const valorTotal = quantidade * valorProduto; // Calcula o valor total
                document.getElementById(produtoId + '_valor').value = valorTotal.toFixed(2); // Mostrando duas casas decimais
                console.log('Valor total calculado:', valorTotal.toFixed(2)); // Log do valor total

                atualizarTotal(); // Atualiza o total geral
            } else {
                console.log('Produto não encontrado');
            }
        }

        function atualizarTotal() {
            let total = 0;
            // Soma as quantidades digitadas apenas dos campos do prod1
            ['total_conf1_din', 'total_conf1_deb', 'total_conf1_cred', 'total_conf1_pix'].forEach(id => {
                const quantidade = parseFloat(document.getElementById(id).value) || 0; // Pega o valor ou 0 se estiver vazio
                total += quantidade;
            });
            document.getElementById('total_total').value = total; // Atualiza o valor total no campo
            console.log('Total atualizado:', total); // Log do total
        }

        // Funções para o modal
        function buscarValorModal(produtoId) {
            const quantidade = document.getElementById(produtoId).value;

            if (produtos.length === 0) {
                const xhr = new XMLHttpRequest();
                xhr.open('GET', `ServletVendas?acao=buscarValoresProdutos`, true);

                xhr.onload = function() {
                    if (xhr.status === 200) {
                        produtos = JSON.parse(xhr.responseText);
                        console.log('Produtos carregados:', produtos);
                        calcularValorModal(quantidade, produtoId);
                    } else {
                        console.error('Erro ao buscar valores:', xhr.statusText);
                    }
                };
                xhr.send();
            } else {
                calcularValorModal(quantidade, produtoId);
            }
        }

        function calcularValorModal(quantidade, produtoId) {

            const prod = produtos[0];

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
                        console.log('Produto não encontrado');
                        return;
                }

                const valorTotal = quantidade * valorProduto;
                document.getElementById(produtoId + '_valor').value = valorTotal.toFixed(2);
                console.log('Valor total calculado:', valorTotal.toFixed(2));

                atualizarTotalModal(); // Atualiza o total geral do modal
            } else {
                console.log('Produto não encontrado');
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
            console.log('Total atualizado no modal:', total); // Log do total
        }


        function toggleInputs(selectId, fieldsToDisable) {
            var ribbonSelect = document.getElementById(selectId);

            if (ribbonSelect.value === "15x20") {
                // Desabilitar todos os campos e alterar a cor de fundo para cinza
                fieldsToDisable.forEach(function(field) {
                    field.disabled = true;
                    field.style.backgroundColor = "black"; // Cor de fundo cinza
                });
            } else if (ribbonSelect.value === "10x15") {
                // Habilitar todos os campos e restaurar a cor de fundo original
                fieldsToDisable.forEach(function(field) {
                    field.disabled = false;
                    field.style.backgroundColor = "#00d25b"; // Restaura a cor de fundo padrão
                });
            }
        }

        function setupToggle() {
            // Inicializa os campos no carregamento da página com base no valor inicial
            toggleInputs("ribbon", [
                document.getElementById("prod2_din"),
                document.getElementById("prod2_deb"),
                document.getElementById("prod2_cred"),
                document.getElementById("prod2_pix")
            ]);

            toggleInputs("ribbon2", [
                document.getElementById("total_conf2_din"),
                document.getElementById("total_conf2_deb"),
                document.getElementById("total_conf2_cred"),
                document.getElementById("total_conf2_pix")
            ]);
        }

        // Executa a função ao carregar a página
        window.onload = function() {
            setupToggle();
        };

        // Adiciona o event listener para o select "ribbon"
        document.getElementById("ribbon").addEventListener("change", function() {
            toggleInputs("ribbon", [
                document.getElementById("prod2_din"),
                document.getElementById("prod2_deb"),
                document.getElementById("prod2_cred"),
                document.getElementById("prod2_pix")
            ]);
        });

        // Adiciona o event listener para o select "ribbon2"
        document.getElementById("ribbon2").addEventListener("change", function() {
            toggleInputs("ribbon2", [
                document.getElementById("total_conf2_din"),
                document.getElementById("total_conf2_deb"),
                document.getElementById("total_conf2_cred"),
                document.getElementById("total_conf2_pix")
            ]);
        });
            }






    </SCRIPT>


</div>
</body>
</html>