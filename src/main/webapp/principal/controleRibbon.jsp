<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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



                        <div>
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <div class="modal fade" id="modalPesquisaControle" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl" style="height: 100vh; width: auto; max-width: none;"> <!-- Altura total da viewport e largura ajustável -->
                                            <div class="modal-content" style="height: 100%; margin: 0;"> <!-- Altura total do modal -->
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticRanking">Controle de Ribbon</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body" style="height: calc(100% - 56px); overflow: hidden;"> <!-- Ajusta altura do corpo do modal e remove rolagem -->
                                                    <div class="container-fluid h-100"> <!-- Altura total do container -->

                                                        <form id="formRelatorio" action="ServletControleRibbon" method="get">
                                                            <input type="hidden" name="acao" value="imprimirRelatorioControle">
                                                            <div class="row align-items-end g-2"> <!-- Alinha os itens ao final -->
                                                                <div class="col-auto">
                                                                    <label for="dataInicial" class="form-label">Data Inicial</label>
                                                                    <input type="date" class="form-control" id="dataInicial" name="dataInicial" value="${dataInicial}" required>
                                                                </div>
                                                                <div class="col-auto">
                                                                    <label for="dataFinal" class="form-label">Data Final</label>
                                                                    <input type="date" class="form-control" id="dataFinal" name="dataFinal" value="${dataFinal}" required>
                                                                </div>
                                                                <div class="col-auto">
                                                                    <button type="button" class="btn btn-outline-success" id="buscar">IMPRIMIR RELATÓRIO</button>
                                                                </div>
                                                            </div>
                                                        </form>




                                                        <form id="modalRibbons" action="ServletControleRibbons" method="get">
                                                            <input type="hidden" name="pagina" id="pagina" value="1"> <!-- ID para manipulação via JavaScript -->
                                                            <div class="row h-100"> <!-- Altura total para a linha -->
                                                                <div class="col-lg-12 grid-margin stretch-card h-100"> <!-- Altura total para a coluna -->
                                                                    <div class="table-responsive h-100"> <!-- Altura total para a tabela -->
                                                                        <table class="table table-striped table-bordered" id="tabelaContas">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>Opções</th>
                                                                                <th>Data</th>
                                                                                <th>Ribbon 1 Atual</th>
                                                                                <th>Ribbon 2 Atual</th>
                                                                                <th>Ribbon 3 Atual</th>
                                                                                <th>Ribbon 4 Atual</th>
                                                                                <th>Ribbon 5 Atual</th>
                                                                                <th>Ribbon 6 Atual</th>
                                                                                <th>ID</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody id="tabelaRibbonBody">

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>

                                                    </div>
                                                </div>

                                                <!-- Paginação -->
                                                <div class="pagination">

                                                    <c:forEach var="i" begin="1" end="${totalPaginas}">
                                                        <a href="#" class="btn btn-outline-primary page-link" data-pagina="${i}">${i}</a>
                                                    </c:forEach>

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
                        <div class="col-sm-4 grid-margin">


                            <div class="row">
                                <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                    <div class="d-flex d-sm-block d-md-flex align-items-center">
                                        <!--INSERIR BOTÃO 3 AQUI-->
                                        <!-- Button trigger modal -->


                                        <!-- Modal -->
                                        <div class="modal fade" id="modalTrocaRibbon" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-xl mt-5">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Troca de Ribbon</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="<%= request.getContextPath() %>/ServletControleRibbon" method="post" id="formTrocaRibbon">

                                                            <div class="row g-3 align-items-center">
                                                                <!-- Select Ribbon -->
                                                                <div class="col-md-4">
                                                                    <label style="color: #f2a654">Impressora</label>
                                                                    <select class="form-control" name="ribbon_selecionado" aria-label="Ribbon Select">
                                                                        <option value="" selected>Selecione o Ribbon</option>
                                                                        <option value="ribbon1">Ribbon 1</option>
                                                                        <option value="ribbon2">Ribbon 2</option>
                                                                        <option value="ribbon3">Ribbon 3</option>
                                                                        <option value="ribbon4">Ribbon 4</option>
                                                                        <option value="ribbon5">Ribbon 5</option>
                                                                        <option value="ribbon6">Ribbon 6</option>
                                                                    </select>

                                                                </div>

                                                                <!-- Input Ribbon Final -->
                                                                <div class="col-md-4">
                                                                    <label style="color: #f2a654">Ribbon Final</label>
                                                                    <input type="number" class="form-control" placeholder=""
                                                                           style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                                            id="fim_ribbon" name="fim_ribbon" value="${controle.fim_ribbon}">
                                                                </div>

                                                                <!-- Input Ribbon Troca -->
                                                                <div class="col-md-4">
                                                                    <label style="color: #f2a654">Ribbon Troca</label>
                                                                    <input type="number" class="form-control" placeholder=""
                                                                           style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                                            id="troca_ribbon" name="troca_ribbon" value="${controle.troca_ribbon}">
                                                                </div>
                                                            </div>

                                                            <div class="row mt-3">
                                                                <div class="col-4">
                                                                    <button type="submit" class="btn btn-outline-success">GRAVAR TROCA</button>

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

                                    </div>

                                </div>


                            </div>
                        </div>

                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">

                                <div class="card-body">
                                    <div class="table-responsive" style="overflow-y: hidden ;overflow-x: hidden">
                                        <table class="table">


                                            <div class="d-flex justify-content-between">

                                    <button type="button" class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#modalTrocaRibbon">
                                        <h4>Troca de Ribbon</h4>
                                    </button>
                                    <button type="button" class="btn btn-outline-danger"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalPesquisaControle">
                                        <h4>Pesquisar Controle</h4>
                                    </button>
                                            </div>
                                        </table>


                                    <%--PAGINA PRINCIPAL                  --%>

                                    <form action="<%= request.getContextPath() %>/ServletControleRibbon"
                                          method="post" id="formEditarcontrole">

                                        <div class="col-sm-1">
                                            <label class="float-label">ID:</label>
                                            <span class="form-bar"></span>
                                            <input type="text" class="form-control" id="idControle"
                                                   name="idControle" placeholder=""
                                                   style="text-align: center; background-color: black" readonly
                                                   value="${ultimoControle.idControle}">
                                        </div>
                                        <div class="col-6">
                                            <div class="col-auto">
                                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-3">
                                                <label >Data do
                                                    Controle:</label>
                                                <input type="date" class="form-control"
                                                       id="data_ribbon"
                                                       name="data_ribbon" required
                                                       value="${ultimoControle.data_ribbon}">
                                            </div>

                                            <div class="col-6">
                                                <label class="float-label">Observações:</label>
                                                <span class="form-bar"></span>
                                                <input type="text" class="form-control"
                                                       id="observacao_ribbon" name="observacao_ribbon"
                                                       placeholder=""
                                                       style="text-align: center; background-color: white; color: black"
                                                       value="${ultimoControle.observacao_ribbon}">
                                            </div>


                                        </div>

                                        <div class="row">

 <%--  Ribbons--%>

                                            <div class="row mt-3">


                                            </div>
                                            <div class="col-4">
                                                <div class="row">


                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 1 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_1_atual" name="ribbon_1_atual"
                                                               value="${ultimoControle.ribbon_1_atual}">

                                                        <label style="color: #f2a654">Revelado</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               tabindex="-1" id="rev_ribbon_1" name="rev_ribbon_1"value="${ultimoControle.rev_ribbon_1}">


                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 2 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_2_atual" name="ribbon_2_atual"
                                                               value="${ultimoControle.ribbon_2_atual}">

                                                        <label style="color: #f2a654">Revelado</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               tabindex="-1" id="rev_ribbon_2" name="rev_ribbon_2"value="${ultimoControle.rev_ribbon_2}">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="row">

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 3 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_3_atual" name="ribbon_3_atual"
                                                               value="${ultimoControle.ribbon_3_atual}">

                                                        <label style="color: #f2a654">Revelado</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               tabindex="-1" id="rev_ribbon_3" name="rev_ribbon_3"value="${ultimoControle.rev_ribbon_3}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 4 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_4_atual" name="ribbon_4_atual"
                                                               value="${ultimoControle.ribbon_4_atual}">

                                                        <label style="color: white">Revelado</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               tabindex="-1" id="rev_ribbon_4" name="rev_ribbon_4"value="${ultimoControle.rev_ribbon_4}">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-4">
                                                <div class="row">

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 5 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_5_atual" name="ribbon_5_atual"
                                                               value="${ultimoControle.ribbon_5_atual}">

                                                        <label style="color: #f2a654">Revelado</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               tabindex="-1" id="rev_ribbon_5" name="rev_ribbon_5"value="${ultimoControle.rev_ribbon_5}">
                                                    </div>

                                                    <div class="col-6">
                                                        <label style="color: #f2a654">Ribbon 6 Atual</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               id="ribbon_6_atual" name="ribbon_6_atual"
                                                               value="${ultimoControle.ribbon_6_atual}">

                                                        <label style="color: #f2a654">Revelado</label>
                                                        <input type="number" class="form-control" placeholder=""
                                                               style="text-align: center; background-color: white; color: black; font-weight: bold"
                                                               tabindex="-1" id="rev_ribbon_6" name="rev_ribbon_6"value="${ultimoControle.rev_ribbon_6}">
                                                    </div>
                                                </div>
                                            </div>
     <div class="col-4">
         <div class="row">
             <div class="col-6">
                 <label style="color: #f2a654">Ribbon 1 Anterior</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="old_ribbon_1" name="old_ribbon_1"
                        value="${ultimoControle.old_ribbon_1}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Ribbon 2 Anterior</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="old_ribbon_2" name="old_ribbon_2"
                        value="${ultimoControle.old_ribbon_2}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Diferença</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="dif_ribbon_1" name="dif_ribbon_1"
                        value="${ultimoControle.dif_ribbon_1}">

                 <label style="color: #f2a654">Ribbon 1 Final</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="fim_ribbon_1" name="fim_ribbon_1"
                        value="${ultimoControle.fim_ribbon_1}">

                 <label style="color: #f2a654">Ribbon 1 Troca</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="troca_ribbon_1" name="troca_ribbon_1" value="${ultimoControle.troca_ribbon_1}">


             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Diferença</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="dif_ribbon_2" name="dif_ribbon_2"
                        value="${ultimoControle.dif_ribbon_2}">

                 <label style="color: #f2a654">Ribbon 2 Final</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="fim_ribbon_2" name="fim_ribbon_2"
                        value="${ultimoControle.fim_ribbon_2}">

                 <label style="color: #f2a654">Troca Ribbon 2</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="troca_ribbon_2" name="troca_ribbon_2" value="${ultimoControle.troca_ribbon_2}">
             </div>
         </div>
     </div>

     <div class="col-4">
         <div class="row">
             <div class="col-6">
                 <label style="color: #f2a654">Ribbon 3 Anterior</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="old_ribbon_3" name="old_ribbon_3"
                        value="${ultimoControle.old_ribbon_3}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Ribbon 4 Anterior</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="old_ribbon_4" name="old_ribbon_4"
                        value="${ultimoControle.old_ribbon_4}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Diferença</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="dif_ribbon_3" name="dif_ribbon_3"
                        value="${ultimoControle.dif_ribbon_3}">

                 <label style="color: #f2a654">Ribbon 3 Final</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="fim_ribbon_3" name="fim_ribbon_3"
                        value="${ultimoControle.fim_ribbon_3}">

                 <label style="color: #f2a654">Trova Ribbon 3</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="troca_ribbon_3" name="troca_ribbon_3" value="${ultimoControle.troca_ribbon_3}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Diferença</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="dif_ribbon_4" name="dif_ribbon_4"
                        value="${ultimoControle.dif_ribbon_4}">

                 <label style="color: #f2a654">Ribbon 4 Final</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="fim_ribbon_4" name="fim_ribbon_4"
                        value="${ultimoControle.fim_ribbon_4}">

                 <label style="color: #f2a654">Troca Ribbon 4</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="troca_ribbon_4" name="troca_ribbon_4" value="${ultimoControle.troca_ribbon_4}">
             </div>
         </div>
     </div>

     <div class="col-4">
         <div class="row">
             <div class="col-6">
                 <label style="color: #f2a654">Ribbon 5 Anterior</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="old_ribbon_5" name="old_ribbon_5"
                        value="${ultimoControle.old_ribbon_5}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Ribbon 6 Anterior</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="old_ribbon_6" name="old_ribbon_6"
                        value="${ultimoControle.old_ribbon_6}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Diferença</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="dif_ribbon_5" name="dif_ribbon_5"
                        value="${ultimoControle.dif_ribbon_5}">

                 <label style="color: #f2a654">Ribbon 5 Final</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="fim_ribbon_5" name="fim_ribbon_5"
                        value="${ultimoControle.fim_ribbon_5}">

                 <label style="color: #f2a654">Troca Ribbon 5</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="troca_ribbon_5" name="troca_ribbon_5" value="${ultimoControle.troca_ribbon_5}">
             </div>

             <div class="col-6">
                 <label style="color: #f2a654">Diferença</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="dif_ribbon_6" name="dif_ribbon_6"
                        value="${ultimoControle.dif_ribbon_6}">

                 <label style="color: #f2a654">Ribbon 6 Final</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        id="fim_ribbon_6" name="fim_ribbon_6"
                        value="${ultimoControle.fim_ribbon_6}">

                 <label style="color: #f2a654">Troca Ribbon 6</label>
                 <input type="number" class="form-control" placeholder=""
                        style="text-align: center; background-color: white; color: black; font-weight: bold"
                        tabindex="-1" id="troca_ribbon_6" name="troca_ribbon_6" value="${ultimoControle.troca_ribbon_6}">
             </div>
         </div>
     </div>

                                        </div>


                                        <div class="row mt-3">
                                            <div class="col-4">

                                                <button type="button" class="btn btn-outline-success"
                                                        onclick="enviarAtualizar()">ATUALIZAR CONTROLE
                                                </button>
                                            </div>
                                        </div>


                                    </form>
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



        function enviarAtualizar() {
            var form = document.getElementById('formEditarcontrole');
            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'acao';
            input.value = 'atualizarcontrole';
            form.appendChild(input);
            form.submit();
        }


        function preencherFormularioRibbon(idControle, data_ribbon, ribbon_1_atual, ribbon_2_atual, ribbon_3_atual, ribbon_4_atual, ribbon_5_atual, ribbon_6_atual, rev_ribbon_1, rev_ribbon_2, rev_ribbon_3, rev_ribbon_4, rev_ribbon_5, rev_ribbon_6, dif_ribbon_1, dif_ribbon_2, dif_ribbon_3, dif_ribbon_4, dif_ribbon_5, dif_ribbon_6, troca_ribbon_1, troca_ribbon_2, troca_ribbon_3, troca_ribbon_4, troca_ribbon_5, troca_ribbon_6, fim_ribbon_1, fim_ribbon_2, fim_ribbon_3, fim_ribbon_4, fim_ribbon_5, fim_ribbon_6, old_ribbon_1, old_ribbon_2, old_ribbon_3, old_ribbon_4, old_ribbon_5, old_ribbon_6, observacao_ribbon) {


            // Certifique-se de que a data está no formato esperado (yyyy-MM-dd)
            if (data_ribbon && /^(\d{4})-(\d{2})-(\d{2})$/.test(data_ribbon)) {
                // Preenche o campo no formulário
                document.getElementById('data_ribbon').value = data_ribbon;
            } else {
                console.log("Data inválida ou mal formatada");
                // Exibir mensagem de erro ou alertar o usuário de forma mais clara
            }

            // Preenche todos os campos do formulário externo com os valores passados como parâmetros
            document.getElementById('idControle').value = idControle;
            document.getElementById('ribbon_1_atual').value = ribbon_1_atual;
            document.getElementById('ribbon_2_atual').value = ribbon_2_atual;
            document.getElementById('ribbon_3_atual').value = ribbon_3_atual;
            document.getElementById('ribbon_4_atual').value = ribbon_4_atual;
            document.getElementById('ribbon_5_atual').value = ribbon_5_atual;
            document.getElementById('ribbon_6_atual').value = ribbon_6_atual;

            document.getElementById('rev_ribbon_1').value = rev_ribbon_1;
            document.getElementById('rev_ribbon_2').value = rev_ribbon_2;
            document.getElementById('rev_ribbon_3').value = rev_ribbon_3;
            document.getElementById('rev_ribbon_4').value = rev_ribbon_4;
            document.getElementById('rev_ribbon_5').value = rev_ribbon_5;
            document.getElementById('rev_ribbon_6').value = rev_ribbon_6;

            document.getElementById('dif_ribbon_1').value = dif_ribbon_1;
            document.getElementById('dif_ribbon_2').value = dif_ribbon_2;
            document.getElementById('dif_ribbon_3').value = dif_ribbon_3;
            document.getElementById('dif_ribbon_4').value = dif_ribbon_4;
            document.getElementById('dif_ribbon_5').value = dif_ribbon_5;
            document.getElementById('dif_ribbon_6').value = dif_ribbon_6;

            document.getElementById('troca_ribbon_1').value = troca_ribbon_1;
            document.getElementById('troca_ribbon_2').value = troca_ribbon_2;
            document.getElementById('troca_ribbon_3').value = troca_ribbon_3;
            document.getElementById('troca_ribbon_4').value = troca_ribbon_4;
            document.getElementById('troca_ribbon_5').value = troca_ribbon_5;
            document.getElementById('troca_ribbon_6').value = troca_ribbon_6;

            document.getElementById('fim_ribbon_1').value = fim_ribbon_1;
            document.getElementById('fim_ribbon_2').value = fim_ribbon_2;
            document.getElementById('fim_ribbon_3').value = fim_ribbon_3;
            document.getElementById('fim_ribbon_4').value = fim_ribbon_4;
            document.getElementById('fim_ribbon_5').value = fim_ribbon_5;
            document.getElementById('fim_ribbon_6').value = fim_ribbon_6;

            document.getElementById('old_ribbon_1').value = old_ribbon_1;
            document.getElementById('old_ribbon_2').value = old_ribbon_2;
            document.getElementById('old_ribbon_3').value = old_ribbon_3;
            document.getElementById('old_ribbon_4').value = old_ribbon_4;
            document.getElementById('old_ribbon_5').value = old_ribbon_5;
            document.getElementById('old_ribbon_6').value = old_ribbon_6;

            document.getElementById('observacao_ribbon').value = observacao_ribbon;
            $('#modalPesquisaControle').modal('hide');
        }




        function carregarControle(pagina = 1) {
            $.ajax({
                url: 'ServletControleRibbon',
                method: 'GET',
                data: {
                    acao: 'imprimirRelatorioControle',
                    pagina: pagina
                },
                success: function(data) {
                    $('#tabelaRibbonBody').html(data); // Atualiza o tbody com os dados retornados
                    $('#pagina').val(pagina); // Atualiza o valor da página no formulário oculto
                },
                error: function() {
                    console.error('Erro ao carregar controle.');
                }
            });
        }

        $('#buscar').click(function() {
            carregarControle();
        });




        // Lógica para a paginação
        $(document).on('click', '.pagination a', function(event) {
            event.preventDefault(); // Impede o comportamento padrão do link
            const pagina = $(this).data('pagina'); // Obtém o número da página
            carregarControle(pagina); // Carrega as contas da nova página
        });

        // Evento para abrir o modal
        // $('#modalPesquisaControle').on('shown.bs.modal', function() {
        //     carregarControle(); // Carrega as contas ao abrir o modal
        // });
        // // Carregar as contas ao iniciar a página
        // $(document).ready(function() {
        //     carregarControle();
        // });




    </SCRIPT>
</body>
</html>