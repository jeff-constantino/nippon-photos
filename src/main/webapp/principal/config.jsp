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
                                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalProd">
                                                    <h4>Configurações de Produtos</h4>
                                                </button>

                                                <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalMat">
                                                    <h4>Configurações de Materiais</h4>
                                                </button>

                                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalGeral">
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
                                            <div class="modal fade" id="modalProd" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Configuração de Produtos</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">

                                                                    <%--body modal 1--%>
                                                                    <form id="configForm" method="post"
                                                                          action="<%= request.getContextPath() %>/ServletConfig">

                                                                        <div class="row">
                                                                            <div class="col-auto">
                                                                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row mb-3">
                                                                            <div class="col-sm-1">
                                                                                <label class="float-label">ID:</label>
                                                                                <span class="form-bar"></span>
                                                                                <input type="text" class="form-control" style="background-color: black" id="idConf"
                                                                                       name="idConf" placeholder=""
                                                                                       value="${modelConfig.idConf}" readonly>
                                                                            </div>


                                                                            <div class="col-4">
                                                                                <label for="conf1_nome">Configuração</label>
                                                                                <input type="text" class="form-control" id="conf_name"
                                                                                       name="conf_name" required
                                                                                       value="${modelConfig.conf_name}" style="color: black" readonly>
                                                                            </div>


                                                                        </div>

                                                                        <div class="row mb-3">


                                                                            <div class="col-4">
                                                                                <label for="conf1_nome">Produto 1 Nome</label>
                                                                                <input type="text" class="form-control" id="conf1_nome"
                                                                                       name="conf1_nome" required
                                                                                       value="${modelConfig.conf1_nome}">
                                                                            </div>

                                                                            <div class="col-4">
                                                                                <div class="row">
                                                                                    <div class="col-6">
                                                                                        <label for="conf1_valor">Valor</label>
                                                                                        <input type="text" class="form-control"
                                                                                               id="conf1_valor" name="conf1_valor"
                                                                                               required
                                                                                               value="${modelConfig.conf1_valor}">
                                                                                    </div>

                                                                                    <div class="col-6">
                                                                                        <label for="conf1_valor2">Valor
                                                                                            2</label>
                                                                                        <input type="text" class="form-control"
                                                                                               id="conf1_valor2" name="conf1_valor2"
                                                                                               required
                                                                                               value="${modelConfig.conf1_valor2}">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-3">
                                                                            <div class="col-4">
                                                                                <label for="conf2_nome">Produto 2 Nome</label>
                                                                                <input type="text" class="form-control" id="conf2_nome"
                                                                                       name="conf2_nome" required
                                                                                       value="${modelConfig.conf2_nome}">
                                                                            </div>
                                                                            <div class="col-4">
                                                                                <label for="conf2_valor">Valor</label>
                                                                                <input type="text" class="form-control" id="conf2_valor"
                                                                                       name="conf2_valor" required
                                                                                       value="${modelConfig.conf2_valor}">
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-3">
                                                                            <div class="col-4">
                                                                                <label for="conf3_nome">Produto 3 Nome</label>
                                                                                <input type="text" class="form-control" id="conf3_nome"
                                                                                       name="conf3_nome" required
                                                                                       value="${modelConfig.conf3_nome}">
                                                                            </div>
                                                                            <div class="col-4">
                                                                                <label for="conf3_valor">Valor</label>
                                                                                <input type="text" class="form-control" id="conf3_valor"
                                                                                       name="conf3_valor" required
                                                                                       value="${modelConfig.conf3_valor}">
                                                                            </div>
                                                                        </div>
                                                                        <button type="submit" class="btn btn-outline-success">Salvar
                                                                        </button>

                                                                    </form>


                                                                </div>

                                                                <div class="row">
                                                                    <div class="col">
                                                                        <DIV></DIV>

                                                                    </div>
                                                                    <div class="col">

                                                                    </div>

                                                                </div>
                                                                <div class="row">

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
                                            <!--INSERIR BOTÃO 2 AQUI-->
                                            <!-- Button trigger modal -->


                                            <!-- Modal -->
                                            <div class="modal fade" id="modalMat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticRanking">Configurações de Materiais</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">


                                                                    <form id="configFormMat" method="post" action="<%= request.getContextPath() %>/ServletConfig">

                                                                        <div class="row">
                                                                            <div class="col-auto">
                                                                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row mb-3">
                                                                            <div class="col-sm-1">
                                                                                <label class="float-label">ID:</label>
                                                                                <span class="form-bar"></span>
                                                                                <input type="text" class="form-control" style="background-color: black" id="idConf_mat"
                                                                                       name="idConf" placeholder="" value="${modelConfig.idConf}" readonly>
                                                                            </div>

                                                                            <div class="col-4">
                                                                                <label for="conf_name_mat">Configuração</label>
                                                                                <input type="text" class="form-control" id="conf_name_mat"
                                                                                       name="conf_name" required value="${modelConfig.conf_name}" style="color: black" readonly>
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-3">
                                                                                <label for="conf1_nome_mat">Produto 1</label>
                                                                                <input type="text" class="form-control" id="conf1_nome_mat" name="conf1_nome" required value="${modelConfig.conf1_nome}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_valor_mat">Valor</label>
                                                                                <input type="text" class="form-control" id="conf1_valor_mat" name="conf1_valor" required value="${modelConfig.conf1_valor}"  oninput="calcularCustoUnitario('conf1')" >
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_qtd_mat">Quantidade</label>
                                                                                <input type="text" class="form-control" id="conf1_qtd_mat" name="conf1_qtd" required value="${modelConfig.conf1_qtd}"  oninput="calcularCustoUnitario('conf1')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_custo_mat">Custo Unitário</label>
                                                                                <input type="text" class="form-control" id="conf1_custo_mat" name="conf1_custo" required value="${modelConfig.conf1_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-3">
                                                                                <label for="conf2_nome_mat">Produto 2</label>
                                                                                <input type="text" class="form-control" id="conf2_nome_mat" name="conf2_nome" required value="${modelConfig.conf2_nome}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_valor_mat">Valor</label>
                                                                                <input type="text" class="form-control" id="conf2_valor_mat" name="conf2_valor" required value="${modelConfig.conf2_valor}"  oninput="calcularCustoUnitario('conf2')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_qtd_mat">Quantidade</label>
                                                                                <input type="text" class="form-control" id="conf2_qtd_mat" name="conf2_qtd" required value="${modelConfig.conf2_qtd}"  oninput="calcularCustoUnitario('conf2')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_custo_mat">Custo Unitário</label>
                                                                                <input type="text" class="form-control" id="conf2_custo_mat" name="conf2_custo" required value="${modelConfig.conf2_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-3">
                                                                                <label for="conf3_nome_mat">Produto 3</label>
                                                                                <input type="text" class="form-control" id="conf3_nome_mat" name="conf3_nome" required value="${modelConfig.conf3_nome}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_valor_mat">Valor</label>
                                                                                <input type="text" class="form-control" id="conf3_valor_mat" name="conf3_valor" required value="${modelConfig.conf3_valor}"  oninput="calcularCustoUnitario('conf3')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_qtd_mat">Quantidade</label>
                                                                                <input type="text" class="form-control" id="conf3_qtd_mat" name="conf3_qtd" required value="${modelConfig.conf3_qtd}"  oninput="calcularCustoUnitario('conf3')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_custo_mat">Custo Unitário</label>
                                                                                <input type="text" class="form-control" id="conf3_custo_mat" name="conf3_custo" required value="${modelConfig.conf3_custo}" >
                                                                            </div>
                                                                        </div>

                                                                        <button type="submit" class="btn btn-outline-success">Salvar</button>

                                                                    </form>





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
                                            <div class="modal fade" id="modalGeral" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticFinalizar">Configurações Gerais</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <form id="configFormGeral" method="post" action="<%= request.getContextPath() %>/ServletConfig">

                                                                        <div class="row">
                                                                            <div class="col-auto">
                                                                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-3">
                                                                            <div class="col-sm-1">
                                                                                <label class="float-label">ID:</label>
                                                                                <span class="form-bar"></span>
                                                                                <input type="text" class="form-control" style="background-color: black" id="idConf_geral"
                                                                                       name="idConf" placeholder=""
                                                                                       value="${modelConfig.idConf}" readonly>
                                                                            </div>

                                                                            <div class="col-4">
                                                                                <label for="conf_name_geral">Configuração</label>
                                                                                <input type="text" class="form-control" id="conf_name_geral"
                                                                                       name="conf_name" required
                                                                                       value="${modelConfig.conf_name}" style="color: black" readonly>
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-3">
                                                                                <label for="conf1_nome">Produto 1</label>
                                                                                <input type="text" class="form-control" id="conf1_nome_geral" name="conf1_nome" required value="${modelConfig.conf1_nome}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_valor">Valor</label>
                                                                                <input type="text" class="form-control" id="conf1_valor_geral" name="conf1_valor" required value="${modelConfig.conf1_valor}" oninput="calcularCustoUnitario('conf1')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_qtd_geral">Quantidade</label>
                                                                                <input type="text" class="form-control" id="conf1_qtd_geral" name="conf1_qtd" required value="${modelConfig.conf1_qtd}" oninput="calcularCustoUnitario('conf1')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_custo_geral">Custo Unitário</label>
                                                                                <input type="text" class="form-control" id="conf1_custo_geral" name="conf1_custo" required value="${modelConfig.conf1_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-3">
                                                                                <label for="conf2_nome">Produto 2</label>
                                                                                <input type="text" class="form-control" id="conf2_nome_geral" name="conf2_nome" required value="${modelConfig.conf2_nome}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_valor">Valor</label>
                                                                                <input type="text" class="form-control" id="conf2_valor_geral" name="conf2_valor" required value="${modelConfig.conf2_valor}" oninput="calcularCustoUnitario('conf2')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_qtd_geral">Quantidade</label>
                                                                                <input type="text" class="form-control" id="conf2_qtd_geral" name="conf2_qtd" required value="${modelConfig.conf2_qtd}" oninput="calcularCustoUnitario('conf2')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_custo_geral">Custo Unitário</label>
                                                                                <input type="text" class="form-control" id="conf2_custo_geral" name="conf2_custo" required value="${modelConfig.conf2_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-3">
                                                                                <label for="conf3_nome">Produto 3</label>
                                                                                <input type="text" class="form-control" id="conf3_nome_geral" name="conf3_nome" required value="${modelConfig.conf3_nome}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_valor">Valor</label>
                                                                                <input type="text" class="form-control" id="conf3_valor_geral" name="conf3_valor" required value="${modelConfig.conf3_valor}" oninput="calcularCustoUnitario('conf3')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_qtd_geral">Quantidade</label>
                                                                                <input type="text" class="form-control" id="conf3_qtd_geral" name="conf3_qtd" required value="${modelConfig.conf3_qtd}" oninput="calcularCustoUnitario('conf3')">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_custo_geral">Custo Unitário</label>
                                                                                <input type="text" class="form-control" id="conf3_custo_geral" name="conf3_custo" required value="${modelConfig.conf3_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <button type="submit" class="btn btn-outline-success">Salvar</button>

                                                                    </form>




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
                                <h4 class="card-title" style="text-align: center">PRODUTOS</h4>
                                <div class="table-responsive">
                                     <table class="table table-bordered minha-tabela">
                                         <thead class="thead-light">

                                         <c:if test="${not empty configs}">
                                         <table class="table table-bordered">

                                             <tr>
                                                 <th>Ações</th>
                                                 <th>ID</th>
                                                 <th>Produto 1</th>
                                                 <th>Valor 1</th>
                                                 <th>Valor 2</th>
                                                 <th>Produto 2</th>
                                                 <th>Valor</th>
                                                 <th>Produto 3</th>
                                                 <th>Valor</th>


                                             </tr>

                                             <!-- Bloco 1 -->
                                             <tbody>
                                             <c:forEach items="${configs}" var="modelConf">
                                                 <c:if test="${modelConf.idConf == 1}">
                                                     <tr>
                                                         <td>
                                                             <a class="btn btn-outline-success waves-effect waves-light"
                                                                href="javascript:void(0);"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalProd"
                                                                onclick="gerenciarConfig(
                                                                    ${modelConf.idConf},
                                                                        '${modelConf.conf_name}',
                                                                        '${modelConf.conf1_nome}',
                                                                        '${modelConf.conf1_valor}',
                                                                        '${modelConf.conf1_valor2}',
                                                                        '${modelConf.conf2_nome}',
                                                                        '${modelConf.conf2_valor}',
                                                                        '${modelConf.conf3_nome}',
                                                                        '${modelConf.conf3_valor}')">
                                                                 Editar
                                                             </a>
                                                         </td>
                                                         <td><c:out value="${modelConf.idConf}"/></td>
                                                         <td hidden="hidden"><c:out value="${modelConf.conf_name}"/></td>
                                                         <td><c:out value="${modelConf.conf1_nome}"/></td>
                                                         <td><c:out value="${modelConf.conf1_valor}"/></td>
                                                         <td><c:out value="${modelConf.conf1_valor2}"/></td>
                                                         <td><c:out value="${modelConf.conf2_nome}"/></td>
                                                         <td><c:out value="${modelConf.conf2_valor}"/></td>
                                                         <td><c:out value="${modelConf.conf3_nome}"/></td>
                                                         <td><c:out value="${modelConf.conf3_valor}"/></td>
                                                     </tr>
                                                 </c:if>
                                             </c:forEach>
                                             </tbody>


                                             </c:if>
                                             <c:if test="${empty configs}">
                                                 <p>Nenhuma configuração encontrada.</p>
                                             </c:if>
                                         </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



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

                                        <c:if test="${not empty configs}">
                                        <table class="table table-bordered">

                                            <tr>
                                                <th>Ações</th>
                                                <th>ID</th>
                                                <th hidden="hidden">Nome</th>
                                                <th>Produto 1</th>
                                                <th>Valor</th>
                                                <th>Quantidade</th>
                                                <th>Custo Unitário</th>

                                                <th>Produto 2</th>
                                                <th>Valor</th>
                                                <th>Quantidade</th>
                                                <th>Custo Unitário</th>

                                                <th>Produto 3</th>
                                                <th>Valor</th>
                                                <th>Quantidade</th>
                                                <th>Custo Unitário</th>


                                            </tr>

                                            <!-- Bloco 2 -->
                                            <tbody>
                                            <c:forEach items="${configs}" var="modelConf">
                                                <c:if test="${modelConf.idConf == 2}">
                                                    <tr>
                                                        <td>
                                                            <a class="btn btn-outline-success waves-effect waves-light"
                                                               href="javascript:void(0);"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#modalMat"
                                                               onclick="gerenciarMat(
                                                                   ${modelConf.idConf},
                                                                       '${modelConf.conf_name}',
                                                                       '${modelConf.conf1_nome}',
                                                                       '${modelConf.conf1_valor}',
                                                                       '${modelConf.conf1_qtd}',
                                                                       '${modelConf.conf1_custo}',
                                                                       '${modelConf.conf2_nome}',
                                                                       '${modelConf.conf2_valor}',
                                                                       '${modelConf.conf2_qtd}',
                                                                       '${modelConf.conf2_custo}',
                                                                       '${modelConf.conf3_nome}',
                                                                       '${modelConf.conf3_valor}',
                                                                       '${modelConf.conf3_qtd}',
                                                                       '${modelConf.conf3_custo}')">
                                                            Editar
                                                            </a>
                                                        </td>
                                                        <td><c:out value="${modelConf.idConf}"/></td>
                                                        <td><c:out value="${modelConf.conf1_nome}"/></td>
                                                        <td><c:out value="${modelConf.conf1_valor}"/></td>
                                                        <td><c:out value="${modelConf.conf1_qtd}"/></td>
                                                        <td><c:out value="${modelConf.conf1_custo}"/></td>

                                                        <td><c:out value="${modelConf.conf2_nome}"/></td>
                                                        <td><c:out value="${modelConf.conf2_valor}"/></td>
                                                        <td><c:out value="${modelConf.conf2_qtd}"/></td>
                                                        <td><c:out value="${modelConf.conf2_custo}"/></td>

                                                        <td><c:out value="${modelConf.conf3_nome}"/></td>
                                                        <td><c:out value="${modelConf.conf3_valor}"/></td>
                                                        <td><c:out value="${modelConf.conf3_qtd}"/></td>
                                                        <td><c:out value="${modelConf.conf3_custo}"/></td>

                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>


                                            </c:if>
                                            <c:if test="${empty configs}">
                                            <p>Nenhuma configuração encontrada.</p>
                                            </c:if>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



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
                                <h4 class="card-title" style="text-align: center">GERAL</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered minha-tabela">
                                        <thead class="thead-light">

                                        <c:if test="${not empty configs}">
                                        <table class="table table-bordered">

                                            <tr>
                                                <th>Ações</th>
                                                <th>ID</th>
                                                <th>Produto 1</th>
                                                <th>Valor 1</th>
                                                <th>Valor 2</th>
                                                <th>Produto 2</th>
                                                <th>Valor</th>
                                                <th>Produto 3</th>
                                                <th>Valor</th>


                                            </tr>

                                            <!-- Bloco 3 -->
                                            <tbody>
                                            <c:forEach items="${configs}" var="modelConf">
                                                <c:if test="${modelConf.idConf == 3}">
                                                    <tr>
                                                        <td>
                                                            <a class="btn btn-outline-success waves-effect waves-light"
                                                               href="javascript:void(0);"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#modalGeral"
                                                               onclick="gerenciarGeral(
                                                                   ${modelConf.idConf},
                                                                       '${modelConf.conf_name}',
                                                                       '${modelConf.conf1_nome}',
                                                                       '${modelConf.conf1_valor}',
                                                                       '${modelConf.conf1_qtd}',
                                                                       '${modelConf.conf1_custo}',
                                                                       '${modelConf.conf2_nome}',
                                                                       '${modelConf.conf2_valor}',
                                                                       '${modelConf.conf2_qtd}',
                                                                       '${modelConf.conf2_custo}',
                                                                       '${modelConf.conf3_nome}',
                                                                       '${modelConf.conf3_valor}',
                                                                       '${modelConf.conf3_qtd}',
                                                                       '${modelConf.conf3_custo}')">
                                                                Editar
                                                            </a>
                                                        </td>
                                                        <td><c:out value="${modelConf.idConf}"/></td>
                                                        <td><c:out value="${modelConf.conf1_nome}"/></td>
                                                        <td><c:out value="${modelConf.conf1_valor}"/></td>
                                                        <td><c:out value="${modelConf.conf1_valor2}"/></td>
                                                        <td><c:out value="${modelConf.conf2_nome}"/></td>
                                                        <td><c:out value="${modelConf.conf2_valor}"/></td>
                                                        <td><c:out value="${modelConf.conf3_nome}"/></td>
                                                        <td><c:out value="${modelConf.conf3_valor}"/></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>


                                            </c:if>
                                            <c:if test="${empty configs}">
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
<script>
    $(document).ready(function() {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem
        }
    });




    function gerenciarConfig(idConf, conf_name, conf1_nome, conf1_valor, conf1_valor2, conf2_nome, conf2_valor, conf3_nome, conf3_valor) {
        // Preencher o campo idConf
        document.getElementById('idConf').value = idConf; // Campo que irá receber o idConf
        document.getElementById('conf_name').value = conf_name; // Campo para conf_name

        console.log("Valores recebidos na função gerenciarConfig:");
        console.log("idConf:", idConf);
        console.log("conf1_nome:", conf1_nome);
        console.log("conf1_valor:", conf1_valor);
        console.log("conf1_valor2:", conf1_valor2);

        // Preencher os campos para idConf === 1
        document.getElementById('conf1_nome').value = conf1_nome;
        document.getElementById('conf1_valor').value = conf1_valor;
        document.getElementById('conf1_valor2').value = conf1_valor2;

        // Preencher os campos para conf2 e conf3
        document.getElementById('conf2_nome').value = conf2_nome;
        document.getElementById('conf2_valor').value = conf2_valor;
        document.getElementById('conf3_nome').value = conf3_nome;
        document.getElementById('conf3_valor').value = conf3_valor;
    }

    function gerenciarMat(idConf,conf_name, conf1_nome, conf1_valor, conf1_qtd, conf1_custo, conf2_nome, conf2_valor, conf2_qtd, conf2_custo, conf3_nome, conf3_valor, conf3_qtd, conf3_custo) {

        document.getElementById('idConf_mat').value = idConf; // Campo que irá receber o idConf
        document.getElementById('conf_name_mat').value =conf_name;

        document.getElementById('conf1_nome_mat').value = conf1_nome;
        document.getElementById('conf1_valor_mat').value = conf1_valor;
        document.getElementById('conf1_qtd_mat').value = conf1_qtd; // Verifique se o ID está correto
        document.getElementById('conf1_custo_mat').value = conf1_custo; // Campo para custo do conf1

        document.getElementById('conf2_nome_mat').value = conf2_nome;
        document.getElementById('conf2_valor_mat').value = conf2_valor;
        document.getElementById('conf2_qtd_mat').value = conf2_qtd; // Verifique se o ID está correto
        document.getElementById('conf2_custo_mat').value = conf2_custo; // Campo para custo do conf2

        document.getElementById('conf3_nome_mat').value = conf3_nome;
        document.getElementById('conf3_valor_mat').value = conf3_valor;
        document.getElementById('conf3_qtd_mat').value = conf3_qtd; // Verifique se o ID está correto
        document.getElementById('conf3_custo_mat').value = conf3_custo; // Campo para custo do conf3
    }

    function gerenciarGeral(idConf, conf_name, conf1_nome, conf1_valor, conf1_qtd, conf1_custo, conf2_nome, conf2_valor, conf2_qtd, conf2_custo, conf3_nome, conf3_valor, conf3_qtd, conf3_custo) {
        // Preencher o campo idConf
        document.getElementById('idConf_geral').value = idConf; // Campo que irá receber o idConf
        document.getElementById('conf_name_geral').value = conf_name; // Campo para conf_name

        console.log("Valores recebidos na função gerenciarGeral:");
        console.log("idConf:", idConf);
        console.log("conf1_nome:", conf1_nome);
        console.log("conf1_valor:", conf1_valor);
        console.log("conf1_qtd:", conf1_qtd); // Este deve ser o correto
        console.log("conf1_custo:", conf1_custo); // Este deve ser o custo

        // Preencher os campos para idConf === 3
        document.getElementById('conf1_nome_geral').value = conf1_nome;
        document.getElementById('conf1_valor_geral').value = conf1_valor;
        document.getElementById('conf1_qtd_geral').value = conf1_qtd; // Verifique se o ID está correto
        document.getElementById('conf1_custo_geral').value = conf1_custo; // Campo para custo do conf1

        document.getElementById('conf2_nome_geral').value = conf2_nome;
        document.getElementById('conf2_valor_geral').value = conf2_valor;
        document.getElementById('conf2_qtd_geral').value = conf2_qtd; // Verifique se o ID está correto
        document.getElementById('conf2_custo_geral').value = conf2_custo; // Campo para custo do conf2

        document.getElementById('conf3_nome_geral').value = conf3_nome;
        document.getElementById('conf3_valor_geral').value = conf3_valor;
        document.getElementById('conf3_qtd_geral').value = conf3_qtd; // Verifique se o ID está correto
        document.getElementById('conf3_custo_geral').value = conf3_custo; // Campo para custo do conf3
    }

    function calcularCustoUnitario(conf) {
        const valor = parseFloat(document.getElementById(`${conf}_valor`).value) || 0; // Obtém o valor ou 0 se vazio
        const quantidade = parseFloat(document.getElementById(`${conf}_qtd`).value) || 1; // Evita divisão por zero

        const custoUnitario = (quantidade > 0) ? (valor / quantidade) : 0; // Divide o valor pela quantidade

        document.getElementById(`${conf}_custo`).value = custoUnitario.toFixed(2); // Atualiza o campo de custo unitário
    }


    function formatarValor(input) {
        let valor = parseFloat(input.value.replace('.', '').replace(',', '.'));
        if (!isNaN(valor)) {
            input.value = valor.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            document.getElementById(input.id + '_hidden').value = valor; // Atualiza o campo oculto com o valor original
        } else {
            input.value = ''; // Limpa o campo se o valor não for válido
            document.getElementById(input.id + '_hidden').value = ''; // Limpa o campo oculto
        }
    }

    // Adiciona um evento de submissão ao formulário
    document.getElementById('formConfig').addEventListener('submit', function() {
        // Aqui você pode adicionar qualquer lógica extra se necessário
    });

</SCRIPT>


</body>
</html>
