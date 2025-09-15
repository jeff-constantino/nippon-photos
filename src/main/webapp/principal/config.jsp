<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
 <%--PARTE 1--%>
                <div class="row justify-content-center">
                    <div class="col-md-4 grid-margin">
                        <div class="card text-center">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalProd">
                                    <h4>Configurações de Produtos</h4>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 grid-margin">
                        <div class="card text-center">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalMat">
                                    <h4>Configurações de Materiais</h4>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 grid-margin">
                        <div class="card text-center">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#modalSalarios">
                                    <h4>Salários e IRRF</h4>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <%--PARTE 2--%>
                <div class="row justify-content-center">
                    <div class="col-md-4 grid-margin">
                        <div class="card text-center">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalCartao">
                                    <h4>Juros Cartões</h4>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 grid-margin">
                        <div class="card text-center">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalFinanceiro">
                                    <h4>Configurações Financeiras</h4>
                                </button>
                                <!-- Table Content -->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 grid-margin">
                        <div class="card text-center">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalINSS">
                                    <h4>Configurações INSS</h4>
                                </button>
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
                                                                                       value="${modelConfig.conf_name}" style="color: black">
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
                                                                        <input type="hidden" name="tipo_config" value="materiais">

                                                                        <div class="row">
                                                                            <div class="col-auto">
                                                                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Material 1 -->
                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-12">
                                                                                <h6 class="text-primary">Material 1</h6>
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_nome_mat">Nome do Material *</label>
                                                                                <input type="text" class="form-control" id="conf1_nome_mat"
                                                                                       name="conf1_nome" value="${material1.conf_name}" required>
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_valor_mat">Valor (R$) *</label>
                                                                                <input type="text" class="form-control" id="conf1_valor_mat"
                                                                                       name="conf1_valor" value="${material1.conf1_valor}" required>
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_qtd_mat">Quantidade *</label>
                                                                                <input type="number" class="form-control" id="conf1_qtd_mat"
                                                                                       name="conf1_qtd" value="${material1.conf1_qtd}" required>
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf1_custo_mat">Custo Unitário (R$) *</label>
                                                                                <input type="text" class="form-control" id="conf1_custo_mat"
                                                                                       name="conf1_custo" value="${material1.conf1_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <!-- Material 2 -->
                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-12">
                                                                                <h6 class="text-primary">Material 2</h6>
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_nome_mat">Nome do Material</label>
                                                                                <input type="text" class="form-control" id="conf2_nome_mat"
                                                                                       name="conf2_nome" value="${material2.conf_name}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_valor_mat">Valor (R$)</label>
                                                                                <input type="text" class="form-control" id="conf2_valor_mat"
                                                                                       name="conf2_valor" value="${material2.conf1_valor}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_qtd_mat">Quantidade</label>
                                                                                <input type="number" class="form-control" id="conf2_qtd_mat"
                                                                                       name="conf2_qtd" value="${material2.conf1_qtd}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf2_custo_mat">Custo Unitário (R$)</label>
                                                                                <input type="text" class="form-control" id="conf2_custo_mat"
                                                                                       name="conf2_custo" value="${material2.conf1_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <!-- Material 3 -->
                                                                        <div class="row mb-4 d-flex">
                                                                            <div class="col-12">
                                                                                <h6 class="text-primary">Material 3</h6>
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_nome_mat">Nome do Material</label>
                                                                                <input type="text" class="form-control" id="conf3_nome_mat"
                                                                                       name="conf3_nome" value="${material3.conf_name}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_valor_mat">Valor (R$)</label>
                                                                                <input type="text" class="form-control" id="conf3_valor_mat"
                                                                                       name="conf3_valor" value="${material3.conf1_valor}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_qtd_mat">Quantidade</label>
                                                                                <input type="number" class="form-control" id="conf3_qtd_mat"
                                                                                       name="conf3_qtd" value="${material3.conf1_qtd}">
                                                                            </div>
                                                                            <div class="col-3">
                                                                                <label for="conf3_custo_mat">Custo Unitário (R$)</label>
                                                                                <input type="text" class="form-control" id="conf3_custo_mat"
                                                                                       name="conf3_custo" value="${material3.conf1_custo}">
                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-3">
                                                                            <div class="col-12">

                                                                            </div>
                                                                        </div>

                                                                        <button type="submit" class="btn btn-outline-success">Salvar Materiais</button>
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
                                            <div class="modal fade" id="modalINSS" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticFinalizar">Configurações INSS</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <form action="${pageContext.request.contextPath}/ServletConfiguracao" method="post" id="formINSS">
                                                                        <input type="hidden" name="acao" value="inss" />

                                                                        <div class="modal-body container-fluid">
                                                                            <div class="row">
                                                                                <!-- Faixa 1 -->
                                                                                <div class="col-12 mb-3 border rounded p-3">
                                                                                    <h6>Faixa 1</h6>
                                                                                    <input type="hidden" name="id_inss_1" value="${configInss.id_inss_1}" />

                                                                                    <label>INSS (%)</label>
                                                                                    <input type="number" name="inss_1" step="0.01" min="0" max="100" class="form-control" value="${configInss.inss_1}" required />

                                                                                    <label>PARCELA A DEDUZIR</label>
                                                                                    <input type="number" name="parcela_1" step="0.01" min="0"  class="form-control" value="${configInss.parcela_1}" required />

                                                                                    <label>Salário Mínimo</label>
                                                                                    <input type="number" name="min_inss_1" step="0.01" min="0" class="form-control" value="${configInss.min_inss_1}" required />

                                                                                    <label>Salário Máximo</label>
                                                                                    <input type="number" name="max_inss_1" step="0.01" min="0" class="form-control" value="${configInss.max_inss_1}" required />
                                                                                </div>

                                                                                <!-- Faixa 2 -->
                                                                                <div class="col-12 mb-3 border rounded p-3">
                                                                                    <h6>Faixa 2</h6>
                                                                                    <input type="hidden" name="id_inss_2" value="${configInss.id_inss_2}" />
                                                                                    <label>INSS (%)</label>
                                                                                    <input type="number" name="inss_2" step="0.01" min="0" max="100" class="form-control" value="${configInss.inss_2}" required />
                                                                                    <label>PARCELA A DEDUZIR</label>
                                                                                    <input type="number" name="parcela_2" step="0.01" min="0"  class="form-control" value="${configInss.parcela_2}" required />
                                                                                    <label>Salário Mínimo</label>
                                                                                    <input type="number" name="min_inss_2" step="0.01" min="0" class="form-control" value="${configInss.min_inss_2}" required />
                                                                                    <label>Salário Máximo</label>
                                                                                    <input type="number" name="max_inss_2" step="0.01" min="0" class="form-control" value="${configInss.max_inss_2}" required />
                                                                                </div>

                                                                                <!-- Faixa 3 -->
                                                                                <div class="col-12 mb-3 border rounded p-3">
                                                                                    <h6>Faixa 3</h6>
                                                                                    <input type="hidden" name="id_inss_3" value="${configInss.id_inss_3}" />
                                                                                    <label>INSS (%)</label>
                                                                                    <input type="number" name="inss_3" step="0.01" min="0" max="100" class="form-control" value="${configInss.inss_3}" required />
                                                                                    <label>PARCELA A DEDUZIR</label>
                                                                                    <input type="number" name="parcela_3" step="0.01" min="0"  class="form-control" value="${configInss.parcela_3}" required />
                                                                                    <label>Salário Mínimo</label>
                                                                                    <input type="number" name="min_inss_3" step="0.01" min="0" class="form-control" value="${configInss.min_inss_3}" required />
                                                                                    <label>Salário Máximo</label>
                                                                                    <input type="number" name="max_inss_3" step="0.01" min="0" class="form-control" value="${configInss.max_inss_3}" required />
                                                                                </div>

                                                                                <!-- Faixa 4 -->
                                                                                <div class="col-12 mb-3 border rounded p-3">
                                                                                    <h6>Faixa 4</h6>
                                                                                    <input type="hidden" name="id_inss_4" value="${configInss.id_inss_4}" />
                                                                                    <label>INSS (%)</label>
                                                                                    <input type="number" name="inss_4" step="0.01" min="0" max="100" class="form-control" value="${configInss.inss_4}" required />
                                                                                    <label>PARCELA A DEDUZIR</label>
                                                                                    <input type="number" name="parcela_4" step="0.01" min="0"  class="form-control" value="${configInss.parcela_4}" required />
                                                                                    <label>Salário Mínimo</label>
                                                                                    <input type="number" name="min_inss_4" step="0.01" min="0" class="form-control" value="${configInss.min_inss_4}" required />
                                                                                    <label>Salário Máximo</label>
                                                                                    <input type="number" name="max_inss_4" step="0.01" min="0" class="form-control" value="${configInss.max_inss_4}" required />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="submit" class="btn btn-primary">Salvar</button>
                                                                        </div>
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
                                    <div class="modal fade" id="modalFinanceiro" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="financeiro">Configurações Dinanceiro</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <form id="configFinanceiro" method="post" action="<%= request.getContextPath() %>/ServletConfiguracao">
                                                                <input type="hidden" name="acao" value="financeiro">



                                                                <div class="row mb-3">
                                                                    <div class="col-sm-1">
                                                                        <label class="float-label">ID:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control" style="background-color: black" id="idConf_financeiro"
                                                                               name="idConf" placeholder=""
                                                                               value="" readonly>
                                                                    </div>


                                                                </div>

                                                                <div class="row mb-4 d-flex">
                                                                    <div class="col-3">
                                                                        <label for="conf1_nome">Impostos sobre Vendas</label>
                                                                        <input type="text" class="form-control" id="juros_sobre_vendas" name="deb_visa_master" required value="">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label for="conf1_valor">ICMS</label>
                                                                        <input type="text" class="form-control" id="etc" name="cred_visa_master" required value="">
                                                                    </div>

                                                                </div>

                                                                <div class="row mb-4 d-flex">
                                                                    <div class="col-3">
                                                                        <label for="conf2_nome">PIS</label>
                                                                        <input type="text" class="form-control" id="etc2" name="deb_outros" required value="">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label for="conf2_valor">COFINS</label>
                                                                        <input type="text" class="form-control" id="etc3" name="cred_outros" required value="">
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
                                    <div class="modal fade" id="modalCartao" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="pagamento">Cartões</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <form id="configPagamento" method="post" action="<%= request.getContextPath() %>/ServletConfiguracao">
                                                                <input type="hidden" name="acao" value="cartao">



                                                                <div class="row mb-3">
                                                                    <div class="col-sm-1">
                                                                        <label class="float-label">ID:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control" style="background-color: black" id="idConf_juros"
                                                                               name="idConf" placeholder=""
                                                                               value="" readonly>
                                                                    </div>


                                                                </div>

                                                                <div class="row mb-4 d-flex">
                                                                    <div class="col-3">
                                                                        <label for="conf1_nome">Débito Visa/Master</label>
                                                                        <input type="text" class="form-control" id="deb_visa_master" name="deb_visa_master" required value="">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label for="conf1_valor">Crédito Visa/Master</label>
                                                                        <input type="text" class="form-control" id="cred_visa_master" name="cred_visa_master" required value="">
                                                                    </div>

                                                                </div>

                                                                <div class="row mb-4 d-flex">
                                                                    <div class="col-3">
                                                                        <label for="conf2_nome">Débito Outros</label>
                                                                        <input type="text" class="form-control" id="deb_outros" name="deb_outros" required value="">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label for="conf2_valor">Crédito Outros</label>
                                                                        <input type="text" class="form-control" id="cred_outros" name="cred_outros" required value="">
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
                                    <div class="modal fade" id="modalSalarios" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="modal_salario">Salários e Comissões</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <form id="configFormSalarios" method="post" action="<%= request.getContextPath() %>/ServletConfiguracao">
                                                                <input type="hidden" name="acao" value="salario">

                                                              <div class="row mb-3">
                                                                    <div class="col-sm-1">
                                                                        <label class="float-label">ID:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control" style="background-color: black" id="idConf_salario"
                                                                               name="idConf" placeholder=""
                                                                               value="${configsSalarios[0].idConf}" readonly>
                                                                    </div>


                                                                </div>

                                                                <div class="row mb-4 d-flex">
                                                                    <div class="col-3">
                                                                        <label for="conf1_nome">Salário</label>
                                                                        <input type="text" class="form-control" id="salario" name="salario" value="${configsSalarios[0].salario}">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label for="conf2_nome">Comissão 1</label>
                                                                        <input type="text" class="form-control" id="comissao" name="comissao" value="${configsSalarios[0].comissao}">
                                                                    </div>

                                                                </div>

                                                                <div class="row mb-4 d-flex">
                                                                    <div class="col-3">
                                                                        <label for="conf2_valor">COMISSÃO 2</label>
                                                                        <input type="text" class="form-control" id="comissao2" name="comissao2" value="${configsSalarios[0].comissao2}">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label for="conf2_nome">FGTS</label>
                                                                        <input type="text" class="form-control" id="fgts" name="fgts" required value="${configsSalarios[0].fgts}">
                                                                    </div>


                                                                </div>
                                                                <h5>CONFIGURAÇÕES IRRF</h5>
                                                                <div class="row">
                                                                    <div class="col-12 mb-3 border rounded p-3">
                                                                        <h6>Faixa 1</h6>
                                                                        <input type="hidden" name="id_irrf_1" value="${configIrrf.id_irrf_1}" />
                                                                        <label>IRRF (%)</label>
                                                                        <input type="number" name="irrf_1" step="0.01" min="0" max="100" class="form-control" value="${configIrrf.irrf_1}" required />
                                                                        <label>PARCELA A DEDUZIR</label>
                                                                        <input type="number" name="parcela_irrf_1" step="0.01" min="0" class="form-control" value="${configIrrf.parcela_irrf_1}" required />
                                                                        <label>Salário Mínimo</label>
                                                                        <input type="number" name="min_irrf_1" step="0.01" min="0" class="form-control" value="${configIrrf.min_irrf_1}" required />
                                                                        <label>Salário Máximo</label>
                                                                        <input type="number" name="max_irrf_1" step="0.01" min="0" class="form-control" value="${configIrrf.max_irrf_1}" required />
                                                                    </div>

                                                                    <div class="col-12 mb-3 border rounded p-3">
                                                                        <h6>Faixa 2</h6>
                                                                        <input type="hidden" name="id_irrf_2" value="${configIrrf.id_irrf_2}" />
                                                                        <label>IRRF (%)</label>
                                                                        <input type="number" name="irrf_2" step="0.01" min="0" max="100" class="form-control" value="${configIrrf.irrf_2}" required />
                                                                        <label>PARCELA A DEDUZIR</label>
                                                                        <input type="number" name="parcela_irrf_2" step="0.01" min="0" class="form-control" value="${configIrrf.parcela_irrf_2}" required />
                                                                        <label>Salário Mínimo</label>
                                                                        <input type="number" name="min_irrf_2" step="0.01" min="0" class="form-control" value="${configIrrf.min_irrf_2}" required />
                                                                        <label>Salário Máximo</label>
                                                                        <input type="number" name="max_irrf_2" step="0.01" min="0" class="form-control" value="${configIrrf.max_irrf_2}" required />
                                                                    </div>

                                                                    <div class="col-12 mb-3 border rounded p-3">
                                                                        <h6>Faixa 3</h6>
                                                                        <input type="hidden" name="id_irrf_3" value="${configIrrf.id_irrf_3}" />
                                                                        <label>IRRF (%)</label>
                                                                        <input type="number" name="irrf_3" step="0.01" min="0" max="100" class="form-control" value="${configIrrf.irrf_3}" required />
                                                                        <label>PARCELA A DEDUZIR</label>
                                                                        <input type="number" name="parcela_irrf_3" step="0.01" min="0" class="form-control" value="${configIrrf.parcela_irrf_3}" required />
                                                                        <label>Salário Mínimo</label>
                                                                        <input type="number" name="min_irrf_3" step="0.01" min="0" class="form-control" value="${configIrrf.min_irrf_3}" required />
                                                                        <label>Salário Máximo</label>
                                                                        <input type="number" name="max_irrf_3" step="0.01" min="0" class="form-control" value="${configIrrf.max_irrf_3}" required />
                                                                    </div>

                                                                    <div class="col-12 mb-3 border rounded p-3">
                                                                        <h6>Faixa 4</h6>
                                                                        <input type="hidden" name="id_irrf_4" value="${configIrrf.id_irrf_4}" />
                                                                        <label>IRRF (%)</label>
                                                                        <input type="number" name="irrf_4" step="0.01" min="0" max="100" class="form-control" value="${configIrrf.irrf_4}" required />
                                                                        <label>PARCELA A DEDUZIR</label>
                                                                        <input type="number" name="parcela_irrf_4" step="0.01" min="0" class="form-control" value="${configIrrf.parcela_irrf_4}" required />
                                                                        <label>Salário Mínimo</label>
                                                                        <input type="number" name="min_irrf_4" step="0.01" min="0" class="form-control" value="${configIrrf.min_irrf_4}" required />
                                                                        <label>Salário Máximo</label>
                                                                        <input type="number" name="max_irrf_4" step="0.01" min="0" class="form-control" value="${configIrrf.max_irrf_4}" required />
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
<%--FIM DOS MODAIS--%>
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

                                                         <!-- Formatação do valor com JSTL -->
                                                         <td><fmt:formatNumber value="${modelConf.conf1_valor}" type="currency" currencySymbol="R$" /></td>

                                                         <td><c:out value="${modelConf.conf2_nome}"/></td>
                                                         <td><fmt:formatNumber value="${modelConf.conf2_valor}" type="currency" currencySymbol="R$" /></td>
                                                         <td><c:out value="${modelConf.conf3_nome}"/></td>
                                                         <td><fmt:formatNumber value="${modelConf.conf3_valor}" type="currency" currencySymbol="R$" /></td>

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
                                                <th>Qtd</th>
                                                <th>Custo Und</th>

                                                <th>Produto 2</th>
                                                <th>Valor</th>
                                                <th>Qtd</th>
                                                <th>Custo Und</th>

                                                <th>Produto 3</th>
                                                <th>Valor</th>
                                                <th>Qtd</th>
                                                <th>Custo Und</th>


                                            </tr>

                                            <!-- Bloco 2 -->
                                            <tbody>
                                            <!-- Tabela para exibir os 3 materiais fixos -->
                                            <c:if test="${not empty material1.conf_name or not empty material2.conf_name or not empty material3.conf_name}">
                                                <tr>
                                                    <td>
                                                        <a class="btn btn-outline-success waves-effect waves-light"
                                                           href="javascript:void(0);"
                                                           data-bs-toggle="modal"
                                                           data-bs-target="#modalMat"
                                                           onclick="gerenciarMat(
                                                                   '${material1.conf_name}', '${material1.conf1_valor}', '${material1.conf1_qtd}', '${material1.conf1_custo}',
                                                                   '${material2.conf_name}', '${material2.conf1_valor}', '${material2.conf1_qtd}', '${material2.conf1_custo}',
                                                                   '${material3.conf_name}', '${material3.conf1_valor}', '${material3.conf1_qtd}', '${material3.conf1_custo}'
                                                                   )">
                                                            Editar
                                                        </a>
                                                    </td>
                                                    <td>Materiais</td>

                                                    <!-- Material 1 -->
                                                    <td><c:out value="${material1.conf_name}"/></td>
                                                    <td><fmt:formatNumber value="${material1.conf1_valor}" type="currency" currencySymbol="R$" /></td>
                                                    <td><c:out value="${material1.conf1_qtd}"/></td>
                                                    <td><fmt:formatNumber value="${material1.conf1_custo}" type="currency" currencySymbol="R$" /></td>

                                                    <!-- Material 2 -->
                                                    <td><c:out value="${material2.conf_name}"/></td>
                                                    <td><fmt:formatNumber value="${material2.conf1_valor}" type="currency" currencySymbol="R$" /></td>
                                                    <td><c:out value="${material2.conf1_qtd}"/></td>
                                                    <td><fmt:formatNumber value="${material2.conf1_custo}" type="currency" currencySymbol="R$" /></td>

                                                    <!-- Material 3 -->
                                                    <td><c:out value="${material3.conf_name}"/></td>
                                                    <td><fmt:formatNumber value="${material3.conf1_valor}" type="currency" currencySymbol="R$" /></td>
                                                    <td><c:out value="${material3.conf1_qtd}"/></td>
                                                    <td><fmt:formatNumber value="${material3.conf1_custo}" type="currency" currencySymbol="R$" /></td>
                                                </tr>
                                            </c:if>

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
                                <h4 class="card-title" style="text-align: center">SALÁRIOS E COMISSÕES</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered minha-tabela">
                                        <thead class="thead-light">

                                        <c:if test="${not empty configs}">
                                        <table class="table table-bordered">

                                            <tr>
                                                <th>Ações</th>
                                                <th>ID</th>
                                                <th>Salário</th>
                                                <th>Comissão 1</th>
                                                <th>Comissão 2</th>
                                                <th>FGTS</th>

                                            </tr>

                                            <!-- Bloco 1 -->
                                            <tbody>
                                            <c:forEach items="${configsSalarios}" var="modelConfiguracao">

                                                    <tr>
                                                        <td>
                                                            <a class="btn btn-outline-success waves-effect waves-light"
                                                               href="javascript:void(0);"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#modalSalarios"
                                                               onclick="gerenciarSalario(
                                                                   ${modelConfiguracao.idConf},
                                                                       '${modelConfiguracao.salario}',
                                                                       '${modelConfiguracao.comissao}',
                                                                       '${modelConfiguracao.comissao2}',
                                                                       '${modelConfiguracao.fgts}'
                                                                       )">
                                                                Editar
                                                            </a>
                                                        </td>
                                                        <td><c:out value="${modelConfiguracao.idConf}"/></td>

                                                        <!-- Formatação do valor com JSTL -->
                                                        <td><fmt:formatNumber value="${modelConfiguracao.salario}" type="currency" currencySymbol="R$" /></td>
                                                        <td><fmt:formatNumber value="${modelConfiguracao.comissao / 100}" type="percent" maxFractionDigits="2" minFractionDigits="2"/></td>
                                                        <td><fmt:formatNumber value="${modelConfiguracao.comissao2 / 100}" type="percent" maxFractionDigits="2" minFractionDigits="2"/></td>
                                                        <td><fmt:formatNumber value="${modelConfiguracao.fgts / 100}" type="percent" maxFractionDigits="2" minFractionDigits="2"/></td>



                                                    </tr>

                                            </c:forEach>
                                            </tbody>


                                            </c:if>
                                            <c:if test="${empty configsSalarios}">
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
                                <h4 class="card-title" style="text-align: center">JUROS DE CARTÕES</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered minha-tabela">
                                        <thead class="thead-light">

                                        <c:if test="${not empty configs}">
                                        <table class="table table-bordered">

                                            <tr>
                                                <th>Ações</th>
                                                <th>ID</th>
                                                <th>Débito V/M</th>
                                                <th>Crédito V/M</th>
                                                <th>Débito Outos</th>
                                                <th>Crédit Outros</th>

                                            </tr>

                                            <!-- Bloco 1 -->
                                            <tbody>
                                            <c:forEach items="${configsJuros}" var="modelConfiguracao">

                                                <tr>
                                                    <td>
                                                        <a class="btn btn-outline-success waves-effect waves-light"
                                                           href="javascript:void(0);"
                                                           data-bs-toggle="modal"
                                                           data-bs-target="#modalCartao"
                                                           onclick="gerenciarCartao(
                                                               ${modelConfiguracao.idConf},
                                                                   '${modelConfiguracao.deb_visa_master}',
                                                                   '${modelConfiguracao.cred_visa_master}',
                                                                   '${modelConfiguracao.deb_outros}',
                                                                   '${modelConfiguracao.cred_outros}'
                                                                   )">
                                                            Editar
                                                        </a>
                                                    </td>
                                                    <td><c:out value="${modelConfiguracao.idConf}"/></td>

                                                    <!-- Formatação do valor com JSTL -->
                                                    <fmt:setLocale value="pt_BR" />
                                                    <td>
                                                        <fmt:formatNumber value="${modelConfiguracao.deb_visa_master}" pattern="0.00%" />
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${modelConfiguracao.cred_visa_master}" pattern="0.00%" />
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${modelConfiguracao.deb_outros}" pattern="0.00%" />
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${modelConfiguracao.cred_outros}" pattern="0.00%" />
                                                    </td>




                                                </tr>


                                            </c:forEach>
                                            </tbody>


                                            </c:if>
                                            <c:if test="${empty configsSalarios}">
                                            <p>Nenhuma configuração encontrada.</p>
                                            </c:if>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">TABELA DE INSS</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>Faixa</th>
                                            <th>INSS (%)</th>
                                            <th>Salário Mínimo</th>
                                            <th>Salário Máximo</th>
                                            <th>ID</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td><fmt:formatNumber value="${configInss.inss_1}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configInss.min_inss_1}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configInss.max_inss_1}" type="currency"/></td>
                                            <td>${configInss.id_inss_1}</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>${configInss.id_inss_2}</td>
                                            <td><fmt:formatNumber value="${configInss.inss_2}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configInss.min_inss_2}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configInss.max_inss_2}" type="currency"/></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>${configInss.id_inss_3}</td>
                                            <td><fmt:formatNumber value="${configInss.inss_3}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configInss.min_inss_3}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configInss.max_inss_3}" type="currency"/></td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>${configInss.id_inss_4}</td>
                                            <td><fmt:formatNumber value="${configInss.inss_4}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configInss.min_inss_4}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configInss.max_inss_4}" type="currency"/></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">TABELA DE IRRF</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>Faixa</th>
                                            <th>ID</th>
                                            <th>IRRF (%)</th>
                                            <th>Salário Mínimo</th>
                                            <th>Salário Máximo</th>
                                            <th>Parcela a Deduzir</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>${configIrrf.id_irrf_1}</td>
                                            <td><fmt:formatNumber value="${configIrrf.irrf_1}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.min_irrf_1}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.max_irrf_1}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.parcela_irrf_1}" type="currency"/></td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>${configIrrf.id_irrf_2}</td>
                                            <td><fmt:formatNumber value="${configIrrf.irrf_2}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.min_irrf_2}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.max_irrf_2}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.parcela_irrf_2}" type="currency"/></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>${configIrrf.id_irrf_3}</td>
                                            <td><fmt:formatNumber value="${configIrrf.irrf_3}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.min_irrf_3}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.max_irrf_3}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.parcela_irrf_3}" type="currency"/></td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>${configIrrf.id_irrf_4}</td>
                                            <td><fmt:formatNumber value="${configIrrf.irrf_4}" pattern="0.00"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.min_irrf_4}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.max_irrf_4}" type="currency"/></td>
                                            <td><fmt:formatNumber value="${configIrrf.parcela_irrf_4}" type="currency"/></td>
                                        </tr>
                                        </tbody>
                                    </table>
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
       $(document).ready(function () {
       var msg = "${msg}";
       if (msg) {
       $('#msgModal').modal('show'); // Exibe o modal com a mensagem

       // Remove a mensagem da sessão após exibi-la
       $.post("${pageContext.request.contextPath}/ServletConfig", { acao: "limparMsg" });
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



       function gerenciarConfig(idConf, conf_name, conf1_nome, conf1_valor, conf2_nome, conf2_valor, conf3_nome, conf3_valor) {
       // Preencher o campo idConf
       document.getElementById('idConf').value = idConf; // Campo que irá receber o idConf
       document.getElementById('conf_name').value = conf_name; // Campo para conf_name


       // Preencher os campos para idConf === 1
       document.getElementById('conf1_nome').value = conf1_nome;
       document.getElementById('conf1_valor').value = conf1_valor;


       // Preencher os campos para conf2 e conf3
       document.getElementById('conf2_nome').value = conf2_nome;
       document.getElementById('conf2_valor').value = conf2_valor;
       document.getElementById('conf3_nome').value = conf3_nome;
       document.getElementById('conf3_valor').value = conf3_valor;
   }

       function gerenciarSalario(idConf, salario, comissao, comissao2, fgts) {
       // Preencher o campo idConf
       document.getElementById('idConf_salario').value = idConf;
       document.getElementById('salario').value = salario;
       document.getElementById('comissao').value = comissao;
       document.getElementById('comissao2').value = comissao2;
       document.getElementById('fgts').value = fgts;

   }

       function gerenciarCartao(idConf, deb_visa_master, cred_visa_master, deb_outros, cred_outros) {
       // Preencher o campo idConf
       document.getElementById('idConf_juros').value = idConf;
       document.getElementById('deb_visa_master').value = deb_visa_master;
       document.getElementById('cred_visa_master').value = cred_visa_master;
       document.getElementById('deb_outros').value = deb_outros;
       document.getElementById('cred_outros').value = cred_outros;

   }

       function gerenciarMat(nome1, valor1, qtd1, custo1, nome2, valor2, qtd2, custo2, nome3, valor3, qtd3, custo3) {
       // Limpa os campos primeiro
       document.getElementById('conf1_nome_mat').value = '';
       document.getElementById('conf1_valor_mat').value = '';
       document.getElementById('conf1_qtd_mat').value = '';
       document.getElementById('conf1_custo_mat').value = '';

       document.getElementById('conf2_nome_mat').value = '';
       document.getElementById('conf2_valor_mat').value = '';
       document.getElementById('conf2_qtd_mat').value = '';
       document.getElementById('conf2_custo_mat').value = '';

       document.getElementById('conf3_nome_mat').value = '';
       document.getElementById('conf3_valor_mat').value = '';
       document.getElementById('conf3_qtd_mat').value = '';
       document.getElementById('conf3_custo_mat').value = '';

       // Preenche Material 1 se existir
       if (nome1 && nome1 !== 'null' && nome1.trim() !== '') {
       document.getElementById('conf1_nome_mat').value = nome1;
       document.getElementById('conf1_valor_mat').value = valor1 || '';
       document.getElementById('conf1_qtd_mat').value = qtd1 || '';
       document.getElementById('conf1_custo_mat').value = custo1 || '';
   }

       // Preenche Material 2 se existir
       if (nome2 && nome2 !== 'null' && nome2.trim() !== '') {
       document.getElementById('conf2_nome_mat').value = nome2;
       document.getElementById('conf2_valor_mat').value = valor2 || '';
       document.getElementById('conf2_qtd_mat').value = qtd2 || '';
       document.getElementById('conf2_custo_mat').value = custo2 || '';
   }

       // Preenche Material 3 se existir
       if (nome3 && nome3 !== 'null' && nome3.trim() !== '') {
       document.getElementById('conf3_nome_mat').value = nome3;
       document.getElementById('conf3_valor_mat').value = valor3 || '';
       document.getElementById('conf3_qtd_mat').value = qtd3 || '';
       document.getElementById('conf3_custo_mat').value = custo3 || '';
   }
   }

       function gerenciarGeral(idConf, conf_name, conf1_nome, conf1_valor, conf1_qtd, conf1_custo, conf2_nome, conf2_valor, conf2_qtd, conf2_custo, conf3_nome, conf3_valor, conf3_qtd, conf3_custo) {
       // Preencher o campo idConf
       document.getElementById('idConf_geral').value = idConf; // Campo que irá receber o idConf
       document.getElementById('conf_name_geral').value = conf_name; // Campo para conf_name



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



    $("#configForm").on("submit", function(e) {

        $("#conf1_valor").val(removerMascara($("#conf1_valor").val()));

        $("#conf2_valor").val(removerMascara($("#conf2_valor").val()));
        $("#conf3_valor").val(removerMascara($("#conf3_valor").val()));



    });



   // Aplica máscara apenas nos campos de entrada digitável
   $('#conf1_valor_mat, #conf2_valor_mat, #conf3_valor_mat').maskMoney({
       prefix: 'R$ ',
       allowNegative: false,
       thousands: '.',
       decimal: ',',
       affixesStay: true
   });
       $("#configProd").on("submit", function(e) {

           $("#conf1_valor").val(removerMascara($("#conf1_valor").val()));

           $("#conf2_valor").val(removerMascara($("#conf2_valor").val()));
           $("#conf3_valor").val(removerMascara($("#conf3_valor").val()));



       });



       // Aplica máscara apenas nos campos de entrada digitável
       $('#conf1_valor, #conf2_valor, #conf3_valor').maskMoney({
           prefix: 'R$ ',
           allowNegative: false,
           thousands: '.',
           decimal: ',',
           affixesStay: true
       });

   // Função única para remover a máscara e converter para número
       function removerMascara(valor) {
           if (!valor) return 0;

           valor = valor.replace('R$ ', '').trim();

           // Só remove os pontos de milhar se houver vírgula (formato BR)
           if (valor.includes(',')) {
               valor = valor.replace(/\./g, '');
               valor = valor.replace(',', '.');
           }

           return parseFloat(valor);
       }



       // Função para formatar como moeda brasileira
       function formatarMoeda(valor) {
           return 'R$ ' + Number(valor).toFixed(8).replace('.', ',');
       }


       // Função para calcular custo unitário
   function calcularCusto(valorSelector, qtdSelector, custoSelector) {
       const $valor = $(valorSelector);
       const $qtd = $(qtdSelector);
       const $custo = $(custoSelector);

       function atualizar() {
           const valorNum = removerMascara($valor.val());
           const qtdNum = parseFloat($qtd.val());

           if (!isNaN(valorNum) && !isNaN(qtdNum) && qtdNum > 0) {
               const custo = valorNum / qtdNum;
               $custo.val(formatarMoeda(custo));
           } else {
               $custo.val('');
           }
       }

       $valor.on('input', atualizar);
       $qtd.on('input', atualizar);
   }

   // Aplica para cada material
   $(document).ready(function () {
       calcularCusto('#conf1_valor_mat', '#conf1_qtd_mat', '#conf1_custo_mat');
       calcularCusto('#conf2_valor_mat', '#conf2_qtd_mat', '#conf2_custo_mat');
       calcularCusto('#conf3_valor_mat', '#conf3_qtd_mat', '#conf3_custo_mat');
   });

   // Remove máscara antes de enviar o formulário
   $('#configFormMat').on('submit', function () {
       // $('#conf1_valor_mat').val(removerMascara($('#conf1_valor_mat').val()));
        $('#conf2_valor_mat').val(removerMascara($('#conf2_valor_mat').val()));
       // $('#conf3_valor_mat').val(removerMascara($('#conf3_valor_mat').val()));
       $('#conf1_custo_mat').val(removerMascara($('#conf1_custo_mat').val()));
       $('#conf2_custo_mat').val(removerMascara($('#conf2_custo_mat').val()));
       $('#conf3_custo_mat').val(removerMascara($('#conf3_custo_mat').val()));
   });

</SCRIPT>


</body>
</html>
