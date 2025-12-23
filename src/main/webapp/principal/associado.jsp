<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelAssociado" %>
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

                                        <!-- Modal -->
                                        <div class="modal fade" id="modalCustos" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
                                            <div class="modal-dialog modal-xl mt-5">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Configurações de Custos</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="container-fluid">
                                                            <div class="row">
                                                                <form id="formCustos" method="post" action="<%= request.getContextPath() %>/ServletAssociado">
                                                                    <input type="hidden" name="tipo_config" value="materiais">

                                                                    <div class="row">
                                                                        <div class="col-auto">
                                                                            <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                        </div>
                                                                    </div>

                                                                    <!-- CONFIGURAÇÕES FINANCEIRAS -->
                                                                    <div class="row mb-4 d-flex">
                                                                        <div class="col-12">
                                                                            <h6 class="text-warning">CONFIGURAÇÕES FINANCEIRAS</h6>
                                                                        </div>
                                                                        <div class="col-4">
                                                                            <label for="limite_config">Limite de Fotos/Encartes *</label>
                                                                            <input type="number" class="form-control" id="limite_config"
                                                                                   name="limite" value="${modelConfig.limite}" required>
                                                                            <small class="text-muted">Excedendo este limite, contará como extras</small>
                                                                        </div>
                                                                        <div class="col-4">
                                                                            <label for="percentual_extras">Percentual de Extras (%) *</label>
                                                                            <input type="text" class="form-control" id="percentual_extras"
                                                                                   name="percentual_extras" value="${modelConfig.percentual_extras}" required>
                                                                            <small class="text-muted">Ex: 50 para 50%</small>
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
                                                                                   name="conf1_nome" value="${material1.mat1_nome}" required>
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf1_valor_mat">Valor (R$) *</label>
                                                                            <input type="text" class="form-control" id="conf1_valor_mat"
                                                                                   name="conf1_valor" value="${material1.mat1_valor}" required>
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf1_qtd_mat">Quantidade *</label>
                                                                            <input type="number" class="form-control" id="conf1_qtd_mat"
                                                                                   name="conf1_qtd" value="${material1.mat1_qtd}" required>
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf1_custo_mat">Custo Unitário (R$) *</label>
                                                                            <input type="text" class="form-control" id="conf1_custo_mat"
                                                                                   name="conf1_custo" value="${material1.mat1_custo}">
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
                                                                                   name="conf2_nome" value="${material2.mat2_nome}">
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf2_valor_mat">Valor (R$)</label>
                                                                            <input type="text" class="form-control" id="conf2_valor_mat"
                                                                                   name="conf2_valor" value="${material2.mat2_valor}">
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf2_qtd_mat">Quantidade</label>
                                                                            <input type="number" class="form-control" id="conf2_qtd_mat"
                                                                                   name="conf2_qtd" value="${material2.mat2_qtd}">
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf2_custo_mat">Custo Unitário (R$)</label>
                                                                            <input type="text" class="form-control" id="conf2_custo_mat"
                                                                                   name="conf2_custo" value="${material2.mat2_custo}">
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
                                                                                   name="conf3_nome" value="${material3.mat3_nome}">
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf3_valor_mat">Valor (R$)</label>
                                                                            <input type="text" class="form-control" id="conf3_valor_mat"
                                                                                   name="conf3_valor" value="${material3.mat3_valor}">
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf3_qtd_mat">Quantidade</label>
                                                                            <input type="number" class="form-control" id="conf3_qtd_mat"
                                                                                   name="conf3_qtd" value="${material3.mat3_qtd}">
                                                                        </div>
                                                                        <div class="col-3">
                                                                            <label for="conf3_custo_mat">Custo Unitário (R$)</label>
                                                                            <input type="text" class="form-control" id="conf3_custo_mat"
                                                                                   name="conf3_custo" value="${material3.mat3_custo}">
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
                                       <div class="modal fade" id="modalRelatorio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-xl mt-5">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="staticRanking">Relatórios Gerenciais</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="container-fluid">
                                                                            <div class="row">
                                                                                <form id="formRelatorio" method="post" action="<%= request.getContextPath() %>/ServletAssociado">
                                                                                    <input type="hidden" name="tipo_config" value="materiais">



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
                                        <!-- Modal -->
                                <div class="modal fade" id="modalFinanceiro" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
                                    <div class="modal-dialog modal-xl mt-5">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Financeiro</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <form id="formFinanceiro" method="post" action="<%= request.getContextPath() %>/ServletAssociado">
                                                            <input type="hidden" name="financeiro" value="financeiro">

                                                            <div class="row">
                                                                <div class="col-auto">
                                                                    <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                </div>
                                                            </div>

                                                            <!-- PERÍODO DE CONSULTA -->
                                                            <div class="row mb-4 d-flex">
                                                                <div class="col-12">
                                                                    <h6 class="text-warning">PERÍODO</h6>
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="data_inicial_fin">Data Inicial *</label>
                                                                    <input type="date" class="form-control" id="data_inicial_fin"
                                                                           name="data_inicial" required>
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="data_final_fin">Data Final *</label>
                                                                    <input type="date" class="form-control" id="data_final_fin"
                                                                           name="data_final" required>
                                                                </div>
                                                                <div class="col-3 d-flex align-items-end">
                                                                    <button type="button" class="btn btn-outline-primary" onclick="calcularFinanceiro()">
                                                                        Calcular
                                                                    </button>
                                                                </div>
                                                            </div>

                                                            <!-- FOTOS VENDIDAS -->
                                                            <div class="row mb-4 d-flex">
                                                                <div class="col-12">
                                                                    <h6 class="text-primary">FOTOS VENDIDAS</h6>
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_fotos">Total de Fotos</label>
                                                                    <input type="text" class="form-control" id="total_fotos"
                                                                           name="total_fotos" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_sobras">Total de Sobras</label>
                                                                    <input type="text" class="form-control" id="total_sobras"
                                                                           name="total_sobras" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_encartes">Total de Encartes</label>
                                                                    <input type="text" class="form-control" id="total_encartes"
                                                                           name="total_encartes" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="dig_total">Total de Digitais</label>
                                                                    <input type="text" class="form-control" id="dig_total"
                                                                           name="dig_total" readonly style="background-color: black;">
                                                                </div>
                                                            </div>

                                                            <!-- EXTRAS -->
                                                            <div class="row mb-4 d-flex">
                                                                <div class="col-12">
                                                                    <h6 class="text-info">EXTRAS</h6>
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_extras">Fotos Extras</label>
                                                                    <input type="text" class="form-control" id="total_extras"
                                                                           name="total_extras" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_enc_extras">Encartes Extras</label>
                                                                    <input type="text" class="form-control" id="total_enc_extras"
                                                                           name="total_enc_extras" readonly style="background-color: black;">
                                                                </div>
                                                            </div>

                                                            <!-- CUSTOS -->
                                                            <div class="row mb-4 d-flex">
                                                                <div class="col-12">
                                                                    <h6 class="text-danger">CUSTOS</h6>
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="custo_fotos_sobras">Fotos+Sobras (R$)</label>
                                                                    <input type="text" class="form-control" id="custo_fotos_sobras"
                                                                           name="custo_fotos_sobras" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="custo_encartes">Encartes (R$)</label>
                                                                    <input type="text" class="form-control" id="custo_encartes"
                                                                           name="custo_encartes" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-2">
                                                                    <label for="fgts_valor">FGTS (R$)</label>
                                                                    <input type="text" class="form-control" id="fgts_valor"
                                                                           name="fgts_valor">
                                                                </div>
                                                                <div class="col-2">
                                                                    <label for="inss_valor">INSS (R$)</label>
                                                                    <input type="text" class="form-control" id="inss_valor"
                                                                           name="inss_valor">
                                                                </div>

                                                            </div>

                                                            <!-- FINANCEIRO -->
                                                            <div class="row mb-4 d-flex">
                                                                <div class="col-12">
                                                                    <h6 class="text-success">FINANCEIRO</h6>
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_bruto">Total Bruto (R$)</label>
                                                                    <input type="text" class="form-control" id="total_bruto"
                                                                           name="total_bruto" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="total_bruto">Total Vendas (R$)</label>
                                                                    <input type="text" class="form-control" id="total_vendas"
                                                                           name="total_vendas" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="valor_extras">Valor Extras (R$)</label>
                                                                    <input type="text" class="form-control" id="valor_extras"
                                                                           name="valor_extras" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="custos_totais">Custos de Fotos (R$)</label>
                                                                    <input type="text" class="form-control" id="custos_totais"
                                                                           name="custos_totais" readonly style="background-color: black;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="restituir">Restituir (R$)</label>
                                                                    <input type="text" class="form-control" id="restituir"
                                                                           name="restituir" readonly style="background-color: #AF2018; color: black; font-weight: bold; font-size: 1.2rem;">
                                                                </div>
                                                                <div class="col-3">
                                                                    <label for="saldo_liquido">Saldo Líquido (R$)</label>
                                                                    <input type="text" class="form-control" id="saldo_liquido"
                                                                           name="saldo_liquido" readonly
                                                                           style="background-color: #00d25b; color: black; font-weight: bold; font-size: 1.2rem;">
                                                                </div>
                                                            </div>

                                                            <button type="submit" class="btn btn-outline-success btn-lg">GRAVAR MÊS</button>
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
                                                                                      action="<%= request.getContextPath() %>/ServletAssociado">

                                                                                    <div class="row">
                                                                                        <div class="col-auto">
                                                                                            <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row mb-3">
                                                                                        <div class="col-sm-1">
                                                                                            <label class="float-label">ID:</label>
                                                                                            <span class="form-bar"></span>
                                                                                            <input type="text" class="form-control" style="background-color: black;color: #FFFFFF" id="idconf"
                                                                                                   name="idconf" placeholder=""
                                                                                                   value="${modelConfig.idconf}" readonly>
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
                                                    <form action="<%= request.getContextPath() %>/ServletAssociado"
                                                          method="get" id="formBuscaVenda">
                                                        <input type="hidden" name="acao" value="gerenciarVenda"/>
                                                        <div class="col-3">
                                                            <label for="venda_id" class="form-label">ID da
                                                                Venda:</label>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="id_venda_id"
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
                                                                                  action="<%= request.getContextPath() %>/ServletAssociado">

                                                                                <div class="row">

                                                                                    <div class="col-4">


                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               id="nomeBusca"
                                                                                               name="nome"
                                                                                               placeholder=""
                                                                                               style="background-color: black"
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
                                                                            <form action="<%= request.getContextPath() %>/ServletAssociado"
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
                                                                                           value="${modelAssociado.venda_id}">
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
                                                                                               value="${modelAssociado.id}">
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
                                                                                               value="${modelAssociado.nome}">
                                                                                    </div>
                                                                                    <div class="col-2">
                                                                                        <label class="float-label">TOTAL
                                                                                            DE FOTOS:</label>
                                                                                        <span class="form-bar"></span>
                                                                                        <input type="number"
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
                                                                                                       value="${modelAssociado.prod1_din}"
                                                                                                       oninput="buscarValorModal('prod1_din')"/>
                                                                                                <!-- Passando 1 como argumento -->
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod1_deb}"
                                                                                                       oninput="buscarValorModal('prod1_deb')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod1_cred}"
                                                                                                       oninput="buscarValorModal('prod1_cred')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod1_pix}"
                                                                                                       oninput="buscarValorModal('prod1_pix')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod2_din}"
                                                                                                       oninput="buscarValorModal('prod2_din')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod2_deb}"
                                                                                                       oninput="buscarValorModal('prod2_deb')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod2_cred}"
                                                                                                       oninput="buscarValorModal('prod2_cred')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod2_pix}"
                                                                                                       oninput="buscarValorModal('prod2_pix')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod3_din}"
                                                                                                       oninput="buscarValorModal('prod3_din')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod3_deb}"
                                                                                                       oninput="buscarValorModal('prod3_deb')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod3_cred}"
                                                                                                       oninput="buscarValorModal('prod3_cred')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="text"
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
                                                                                                       value="${modelAssociado.prod3_pix}"
                                                                                                       oninput="buscarValorModal('prod3_pix')">
                                                                                            </div>
                                                                                            <div class="col-6">
                                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                                <input type="text"
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
                                                                                               id="sobras_input"
                                                                                               value="${modelAssociado.sobras}" required
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
                                                                                                tabindex="-1">
                                                                                    </div>


                                                                                    <div class="col-2">
                                                                                        <label>RIBBON</label>
                                                                                        <select class="form-select"
                                                                                                id="ribbon"
                                                                                                name="ribbon" required
                                                                                                value="${modelAssociado.ribbon}">
                                                                                            <option disabled>Diferença de fotos
                                                                                            </option>
                                                                                            <option style="color: #00d25b"
                                                                                                    value="AUTORIZADO"
                                                                                                    <%
                                                                                                        ModelAssociado modelAssociado = (ModelAssociado) request.getAttribute("modelAssociado");
                                                                                                        if (modelAssociado != null && modelAssociado.getRibbon() != null && modelAssociado.getRibbon().equalsIgnoreCase("AUTORIZADO")) {
                                                                                                            out.print("selected=\"selected\"");
                                                                                                        }
                                                                                                    %>>AUTORIZADO
                                                                                            </option>
                                                                                            <option style="color: #bf3322"
                                                                                                    value="DESCONTAR"
                                                                                                    <%
                                                                                                        modelAssociado = (ModelAssociado) request.getAttribute("modelAssociado");
                                                                                                        if (modelAssociado != null && modelAssociado.getRibbon() != null && modelAssociado.getRibbon().equalsIgnoreCase("DESCONTAR")) {
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
                                                                                    <div class="col-2">
                                                                                        <label>Total Vendas</label>
                                                                                        <input type="text"
                                                                                               class="form-control"
                                                                                               placeholder=""
                                                                                               style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                               id="total_vendido"
                                                                                               name="total_vendido"
                                                                                               required
                                                                                               value=""
                                                                                               readonly tabindex="-1">

                                                                                    </div>
                                                                                    <div class="col-2">
                                                                                        <label>&nbsp;</label>
                                                                                        <div class="form-check">
                                                                                            <input type="checkbox" id="sobras_sem_custo" class="form-check-input">
                                                                                            <label for="sobras_sem_custo" class="form-check-label">
                                                                                                SOBRAS EXTRAS
                                                                                            </label>
                                                                                        </div>
                                                                                    </div>


                                                                                </div>


                                                                                <br>


                                                                                <div>
                                                                                    <button class="btn btn-outline-success waves-effect waves-light"
                                                                                            style="font-size: 1.4rem; font-weight: bold; padding: 12px 20px; text-align: center;">
                                                                                        GRAVAR VENDA
                                                                                    </button>

                                                                                    <button type="button"
                                                                                            class="btn btn-outline-warning waves-effect waves-light"
                                                                                            onclick="limparFormVendas();"
                                                                                            style="font-size: 1.4rem; font-weight: bold; padding: 12px 20px; text-align: center;">
                                                                                        LIMPAR
                                                                                    </button>
                                                                                </div>


                                                                            </form>


                                                                        </div>
                                                                        <div class="row">
                                                                            <H4 style="color: #d39e00">CONFERÊNCIA DE TOTAIS</H4>
                                                                        <div class="col-2">
                                                                            <label>DINHEIRO INF</label>
                                                                            <input type="text"
                                                                                   class="form-control"
                                                                                   placeholder=""
                                                                                   style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                   id="conf_din_inf"
                                                                                   name="conf_din_inf"
                                                                                   required
                                                                                   value=""
                                                                                   readonly tabindex="-1">

                                                                        </div>
                                                                            <div class="col-2">
                                                                                <label>CRÉDITO INF</label>
                                                                                <input type="text"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                       id="conf_credito_inf"
                                                                                       name="conf_credito_inf"
                                                                                       required
                                                                                       value=""
                                                                                       readonly tabindex="-1">

                                                                            </div>

                                                                            <div class="col-2">
                                                                                <label>DÉBITO INF</label>
                                                                                <input type="text"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                       id="conf_debito_inf"
                                                                                       name="conf_debito_inf"
                                                                                       required
                                                                                       value=""
                                                                                       readonly tabindex="-1">

                                                                            </div>

                                                                            <div class="col-2">
                                                                                <label>PIX INF</label>
                                                                                <input type="text"
                                                                                       class="form-control"
                                                                                       placeholder=""
                                                                                       style="background-color: black; color:#DAA520; font-weight: bold"
                                                                                       id="conf_pix_inf"
                                                                                       name="conf_pix_inf"
                                                                                       required
                                                                                       value=""
                                                                                       readonly tabindex="-1">

                                                                            </div>


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


                                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal"
                                                            data-bs-target="#modalLancaVenda">
                                                        <h4>Lançamentos</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"                                                           data-bs-target="#modalBuscaVenda">
                                                        <h4>Buscar Venda</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#modalProd">
                                                        <h4>Configurações de Produtos</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalCustos">
                                                        <h4>Configurações de Custos</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalFinanceiro">
                                                        <h4>Financeiro</h4>
                                                    </button>
                                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalRelatorio">
                                                        <h4>Relatórios</h4>
                                                    </button>


                                                    <div class="table-responsive" style="overflow-x: hidden">
                                                        <table class="table">
                                                            <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                                            <form action="<%= request.getContextPath() %>/ServletAssociado"
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
                                                                           value="${modelAssociadoConsulta.venda_id}">
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
                                                                               value="${modelAssociadoConsulta.vendedor_id}">
                                                                    </div>
                                                                    <div class="col-6">
                                                                        <label class="float-label">FUNCIONÁRIO:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control"
                                                                               id="outer_vendedor"
                                                                               name="nome" placeholder=""
                                                                               style="background-color: black" readonly
                                                                               value="${modelAssociadoConsulta.nome}">
                                                                    </div>

                                                                    <div class="col-2">
                                                                        <label class="float-label">TOTAL DE
                                                                            FOTOS:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="number" class="form-control"
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
                                                                                       value="${modelAssociadoConsulta.prod1_din}"
                                                                                       oninput="buscarValor('outer_prod1_din')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod1_deb}"
                                                                                       oninput="buscarValor('outer_prod1_deb')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod1_cred}"
                                                                                       oninput="buscarValor('outer_prod1_cred')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod1_pix}"
                                                                                       oninput="buscarValor('outer_prod1_pix')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: #f2a654">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod2_din}"
                                                                                       oninput="buscarValor('outer_prod2_din')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod2_deb}"
                                                                                       oninput="buscarValor('outer_prod2_deb')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod2_cred}"
                                                                                       oninput="buscarValor('outer_prod2_cred')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod2_pix}"
                                                                                       oninput="buscarValor('outer_prod2_pix')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label STYLE="color: #00d25b">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod3_din}"
                                                                                       oninput="buscarValor('outer_prod3_din')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod3_deb}"
                                                                                       oninput="buscarValor('outer_prod3_deb')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod3_cred}"
                                                                                       oninput="buscarValor('outer_prod3_cred')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.prod3_pix}"
                                                                                       oninput="buscarValor('outer_prod3_pix')">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label style="color: fuchsia">VALOR</label>
                                                                                <input type="text"
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
                                                                                       value="${modelAssociadoConsulta.sobras}">
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <label>RIBBON</label>
                                                                                <select class="form-select" id="ribbon2"
                                                                                        name="ribbon"
                                                                                        required
                                                                                        value="${modelAssociado.ribbon}">
                                                                                    <option disabled>Tamanho do Papel
                                                                                    </option>
                                                                                    <option style="color: #00d25b"
                                                                                            value="AUTORIZADO"
                                                                                            <%
                                                                                                modelAssociado = (ModelAssociado) request.getAttribute("modelAssociado");
                                                                                                if (modelAssociado != null && modelAssociado.getRibbon() != null && modelAssociado.getRibbon().equalsIgnoreCase("AUTORIZADO")) {
                                                                                                    out.print("selected=\"selected\"");
                                                                                                }
                                                                                            %>>AUTORIZADO
                                                                                    </option>
                                                                                    <option style="color: #bf3322"
                                                                                            value="DESCONTAR"
                                                                                            <%
                                                                                                modelAssociado = (ModelAssociado) request.getAttribute("modelAssociado");
                                                                                                if (modelAssociado != null && modelAssociado.getRibbon() != null && modelAssociado.getRibbon().equalsIgnoreCase("DESCONTAR")) {
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
                                                                                           href="<%= request.getContextPath() %>/ServletAssociado?acao=gerenciarVenda&venda_id=${vd.venda_id}">Gerenciar</a>
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
                $.post("${pageContext.request.contextPath}/ServletAssociado", { acao: "limparMsg" });
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
                    url: '<%= request.getContextPath() %>/ServletAssociado',
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

                    if (nomeBusca.trim() === '') {
                        document.getElementById('totalResultados').textContent = 'Todos os associados: ' + json.length;
                    } else {
                        document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
                    }
                },
                error: function (xhr, status, errorThrown) {
                    alert('Erro ao Pesquisar o Funcionário: ' + xhr.responseText);
                }
            });
        }


        // function verEditar(id, nome) {
        //     document.getElementById('vendedor_id').value = id;
        //     document.getElementById('vendedor').value = nome;
        //
        //     // Rola até o fim do modal
        //     var modal = $('#modalLancaVenda'); // Substitua pelo ID do seu modal
        //     modal.animate({scrollTop: modal[0].scrollHeight}, 1000); // Rola suavemente para o fim em 1 segundo
        // }
        function verEditar(id, nome) {
            document.getElementById('vendedor_id').value = id;
            document.getElementById('vendedor').value = nome;

            var modal = $('#modalLancaVenda');
            var campoData = $('#outer_dataVenda'); // elemento alvo

            modal.animate({
                scrollTop: campoData.offset().top - modal.offset().top + modal.scrollTop()
            }, 700); // 700ms = rolagem suave
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
                xhr.open('GET', `ServletAssociado?acao=buscarValoresProdutos`, true);

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
                xhr.open('GET', `ServletAssociado?acao=buscarValoresProdutos`, true);

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

                        return;
                }

                const valorTotal = quantidade * valorProduto;
                document.getElementById(produtoId + '_valor').value = valorTotal.toFixed(2);

                atualizarTotalModal();     // mantém seu total geral
                atualizarConferencia();    // agora atualiza seus totais INF

            } else {

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
            xhr.open('GET', 'ServletAssociado?acao=buscarValoresProdutos', true);

            xhr.onload = function() {
                if (xhr.status === 200) {
                    const data = JSON.parse(xhr.responseText);

                    controles = data.controles || []; // Preenche a variável controles com os dados recebidos


                    // Adiciona o event listener para o select após carregar os valores
                    document.getElementById('ribbon_selecionado').addEventListener('change', function() {
                        const ribbonSelecionado = this.value;
                        const ribbonIndex = parseInt(ribbonSelecionado.replace("ribbon", "")) - 1;



                        if (controles.length > 0 && ribbonIndex >= 0 && ribbonIndex < 6) {
                            const valorRibbon = controles[ribbonIndex];
                            const valorTroca = controles[ribbonIndex + 6] || 0; // Garantir que valorTroca tenha um default
                            const valorFim = controles[ribbonIndex + 12] || 0; // Garantir que valorFim tenha um default
                            const valorTotal = valorRibbon + valorTroca - valorFim;

                            document.getElementById('ribbon_atual').value = valorTotal; // Atualiza o campo "ribbon_atual" com o valor retornado


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

        // Atualizar outras funções que usam getElementById('sobras')
        function calcularDiferenca() {
            var ribbonAtual = parseFloat(document.getElementById("ribbon_atual").value) || 0;
            var ribbonInf = parseFloat(document.getElementById("ribbon_inf").value) || 0;
            var ribbonSobras = parseFloat(document.getElementById("sobras_input").value) || 0;  // ← MUDOU
            var ribbonTotal = parseFloat(document.getElementById("total").value) || 0;
            var ribbonDif = document.getElementById("ribbon_dif");

            ribbonDif.value = (ribbonInf + ribbonSobras + ribbonTotal) - ribbonAtual;
        }

        function calcularAproveitamento() {
            var vendas = parseFloat(document.getElementById('total').value) || 0;
            var sobras = parseFloat(document.getElementById('sobras_input').value) || 0;  // ← MUDOU
            var producao = vendas + sobras;

            var aproveitamento = producao > 0 ? (vendas / producao) * 100 : 0;
            document.getElementById('aproveitamento').value = aproveitamento.toFixed(2) + " %";
        }
        function atualizarConferencia() {

            function n(id) {
                return parseFloat(document.getElementById(id).value) || 0;
            }

            // DINHEIRO
            const totalDin =
                n('prod1_din_valor') +
                n('prod2_din_valor') +
                n('prod3_din_valor');

            // DÉBITO
            const totalDeb =
                n('prod1_deb_valor') +
                n('prod2_deb_valor') +
                n('prod3_deb_valor');

            // CRÉDITO
            const totalCred =
                n('prod1_cred_valor') +
                n('prod2_cred_valor') +
                n('prod3_cred_valor');

            // PIX
            const totalPix =
                n('prod1_pix_valor') +
                n('prod2_pix_valor') +
                n('prod3_pix_valor');

            // Atualiza os campos
            document.getElementById("conf_din_inf").value = totalDin.toFixed(2);
            document.getElementById("conf_debito_inf").value = totalDeb.toFixed(2);
            document.getElementById("conf_credito_inf").value = totalCred.toFixed(2);
            document.getElementById("conf_pix_inf").value = totalPix.toFixed(2);
        }

        // ========== FUNÇÕES DE MÁSCARA ==========

        /**
         * Formata valor monetário: R$ 1.000,00
         */
        function formatarMoeda(input) {
            let valor = input.value.replace(/\D/g, ''); // Remove tudo que não é dígito

            if (valor === '') {
                input.value = '';
                return;
            }

            // Converte para centavos
            valor = (parseInt(valor) / 100).toFixed(2);

            // Formata com separadores
            valor = valor.replace('.', ',');
            valor = valor.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');

            input.value = 'R$ ' + valor;
        }

        /**
         * Remove formatação de moeda para enviar ao servidor
         */
        function removerFormatacaoMoeda(valor) {
            if (!valor) return '';
            return valor.replace(/[^\d,]/g, '').replace(',', '.');
        }

        /**
         * Formata quantidade: 1.000
         */
        function formatarQuantidade(input) {
            let valor = input.value.replace(/\D/g, ''); // Remove tudo que não é dígito

            if (valor === '') {
                input.value = '';
                return;
            }

            // Adiciona separadores de milhares
            valor = parseInt(valor).toString();
            valor = valor.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');

            input.value = valor;
        }

        /**
         * Remove formatação de quantidade para enviar ao servidor
         */
        function removerFormatacaoQuantidade(valor) {
            if (!valor) return '';
            return valor.replace(/\./g, '');
        }

        // ========== APLICAR MÁSCARAS NOS CAMPOS ==========

        document.addEventListener('DOMContentLoaded', function() {

            // CAMPOS DE VALORES MONETÁRIOS (Produtos)
            const camposMoeda = [
                'conf1_valor', 'conf2_valor', 'conf3_valor', // Modal Produtos
                'conf1_valor_mat', 'conf2_valor_mat', 'conf3_valor_mat', // Modal Materiais - Valores
                'conf1_custo_mat', 'conf2_custo_mat', 'conf3_custo_mat'  // Modal Materiais - Custos
            ];

            camposMoeda.forEach(id => {
                const campo = document.getElementById(id);
                if (campo) {
                    // Formata ao carregar (se já tiver valor)
                    if (campo.value) {
                        campo.value = 'R$ ' + parseFloat(campo.value).toFixed(2).replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
                    }

                    // Formata ao digitar
                    campo.addEventListener('blur', function() {
                        formatarMoeda(this);
                    });

                    // Remove formatação antes de enviar
                    campo.closest('form').addEventListener('submit', function() {
                        campo.value = removerFormatacaoMoeda(campo.value);
                    });
                }
            });

            // CAMPOS DE QUANTIDADE (Materiais)
            const camposQuantidade = [
                'conf1_qtd_mat', 'conf2_qtd_mat', 'conf3_qtd_mat'
            ];

            camposQuantidade.forEach(id => {
                const campo = document.getElementById(id);
                if (campo) {
                    // Formata ao carregar (se já tiver valor)
                    if (campo.value && campo.value !== '0') {
                        campo.value = parseInt(campo.value).toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
                    }

                    // Formata ao digitar
                    campo.addEventListener('blur', function() {
                        formatarQuantidade(this);
                    });

                    // Remove formatação antes de enviar
                    campo.closest('form').addEventListener('submit', function() {
                        campo.value = removerFormatacaoQuantidade(campo.value);
                    });
                }
            });
        });


        // ========== CHECKBOX SOBRAS EXTRAS (CORRIGIDO) ==========
        document.addEventListener('DOMContentLoaded', function() {
            var checkbox = document.getElementById('sobras_sem_custo');
            if (checkbox) {
                checkbox.addEventListener('change', function() {
                    var sobrasInput = document.getElementById('sobras_input');
                    var valorSobras = parseInt(sobrasInput.value) || 0;

                    console.log('📦 Checkbox mudou! Checked:', this.checked, 'Valor:', valorSobras);

                    // Remove campos hidden anteriores se existirem
                    var hiddenAntigos = document.querySelectorAll('input[name="sobras"], input[name="sobras_extras"]');
                    hiddenAntigos.forEach(function(campo) {
                        if (campo.type === 'hidden') {
                            campo.remove();
                        }
                    });

                    // Cria novos campos hidden
                    var formVenda = document.getElementById('formBuscarVenda');

                    var sobrasHidden = document.createElement('input');
                    sobrasHidden.type = 'hidden';
                    sobrasHidden.name = 'sobras';

                    var sobrasExtrasHidden = document.createElement('input');
                    sobrasExtrasHidden.type = 'hidden';
                    sobrasExtrasHidden.name = 'sobras_extras';

                    if (this.checked) {
                        // Marcado = SOBRAS EXTRAS (sem custo)
                        sobrasHidden.value = 0;
                        sobrasExtrasHidden.value = valorSobras;
                        console.log('✅ Sobras EXTRAS:', valorSobras);
                    } else {
                        // Desmarcado = SOBRAS NORMAIS (com custo)
                        sobrasHidden.value = valorSobras;
                        sobrasExtrasHidden.value = 0;
                        console.log('✅ Sobras NORMAIS:', valorSobras);
                    }

                    formVenda.appendChild(sobrasHidden);
                    formVenda.appendChild(sobrasExtrasHidden);

                    console.log('📤 Campos criados - sobras:', sobrasHidden.value, 'sobras_extras:', sobrasExtrasHidden.value);
                });
            }
        });

        // ========== BUSCAR TOTAL VENDIDO NO MÊS (SEM ALERT DUPLICADO) ==========

        // Variável para controlar se já mostrou o alert
        var alertJaMostrado = false;

        function buscarTotalVendidoMes(vendedorId, mostrarAlert) {
            console.log('🔍 buscarTotalVendidoMes chamado com vendedorId:', vendedorId);

            if (!vendedorId || vendedorId === '' || vendedorId === 'undefined') {
                console.log('❌ vendedor_id vazio ou inválido:', vendedorId);
                return;
            }

            // Converte para string
            vendedorId = String(vendedorId);

            // Usa mês/ano atual SEMPRE (já que vendas são só do mês atual)
            var hoje = new Date();
            var mes = String(hoje.getMonth() + 1);
            if (mes.length === 1) mes = '0' + mes;
            var ano = String(hoje.getFullYear());
            console.log('📅 Usando mês atual:', mes, '/', ano);

            // Usa concatenação ao invés de template literals
            var url = 'ServletAssociado?acao=buscarTotalVendidoMes&vendedor_id=' + vendedorId + '&mes=' + mes + '&ano=' + ano;
            console.log('🔍 URL montada:', url);

            fetch(url)
                .then(function(response) {
                    console.log('📥 Resposta status:', response.status);
                    return response.text();
                })
                .then(function(text) {
                    console.log('📄 Resposta TEXTO:', text);

                    try {
                        var data = JSON.parse(text);
                        console.log('✅ JSON parseado:', data);

                        if (data.error) {
                            console.error('❌ Erro do servidor:', data.error);
                            document.getElementById('total_vendido').value = 'ERRO';
                            return;
                        }

                        var totalVendido = data.total_fotos || 0;
                        document.getElementById('total_vendido').value = totalVendido;
                        console.log('✅ Total vendido atualizado:', totalVendido);

                        // Se já passou do limite E deve mostrar alert E ainda não mostrou
                        var limite = 240;
                        if (totalVendido >= limite) {
                            document.getElementById('total_vendido').style.color = '#ff0000';

                            // Só mostra alert se for solicitado E não mostrou ainda
                            if (mostrarAlert && !alertJaMostrado) {
                                alertJaMostrado = true;
                                alert('⚠️ Atenção! ' + totalVendido + ' fotos já vendidas no mês.\nLimite de ' + limite + ' atingido!\n\nMarque "SOBRAS EXTRAS" para sobras sem custo.');
                            }
                        } else {
                            document.getElementById('total_vendido').style.color = '#DAA520';
                        }
                    } catch (parseError) {
                        console.error('❌ Erro ao fazer parse do JSON:', parseError);
                        console.error('❌ Texto recebido:', text);
                        document.getElementById('total_vendido').value = 'ERRO JSON';
                    }
                })
                .catch(function(error) {
                    console.error('❌ Erro ao buscar total vendido:', error);
                    document.getElementById('total_vendido').value = 'ERRO REDE';
                });
        }

        // ========== FUNÇÃO verEditar ==========
        function verEditar(id, nome) {
            console.log('👤 verEditar chamado - ID:', id, 'Nome:', nome);

            // Reseta o controle de alert
            alertJaMostrado = false;

            // Converte para string
            id = String(id);

            // Primeiro preenche os campos
            document.getElementById('vendedor_id').value = id;
            document.getElementById('vendedor').value = nome;

            // IMPORTANTE: Espera um pouco para o campo ser preenchido
            setTimeout(function() {
                console.log('⏱️ Verificando campo vendedor_id:', document.getElementById('vendedor_id').value);
                // Passa true para MOSTRAR alert
                buscarTotalVendidoMes(id, true);
            }, 100);

            var modal = $('#modalLancaVenda');
            var campoData = $('#outer_dataVenda');

            modal.animate({
                scrollTop: campoData.offset().top - modal.offset().top + modal.scrollTop()
            }, 700);
        }

        // Atualizar total vendido quando mudar a data (SEM ALERT)
        document.addEventListener('DOMContentLoaded', function() {
            var campoData = document.getElementById('outer_dataVenda');
            if (campoData) {
                campoData.addEventListener('change', function() {
                    var vendedorId = document.getElementById('vendedor_id').value;
                    console.log('📅 Data mudou, vendedor_id do campo:', vendedorId);
                    if (vendedorId && vendedorId !== '' && vendedorId !== 'undefined') {
                        // Passa false para NÃO mostrar alert
                        buscarTotalVendidoMes(vendedorId, false);
                    } else {
                        console.log('❌ Campo vendedor_id está vazio!');
                    }
                });
            }
        });

        // ========== CÁLCULO FINANCEIRO (VERSÃO FINAL COM TOTAL VENDAS) ==========
        function calcularFinanceiro() {
            const dataInicial = document.getElementById('data_inicial_fin').value;
            const dataFinal = document.getElementById('data_final_fin').value;

            if (!dataInicial || !dataFinal) {
                alert('Por favor, informe as datas inicial e final!');
                return;
            }

            fetch('ServletAssociado?acao=consultarFinanceiro&data_inicial=' + dataInicial + '&data_final=' + dataFinal)
                .then(response => response.json())
                .then(data => {
                    console.log('===== DADOS RECEBIDOS DO SERVIDOR =====');
                    console.log('Dados completos:', data);

                    // Preenche os totais
                    document.getElementById('total_fotos').value = data.ft_total || 0;
                    document.getElementById('total_sobras').value = data.sobras || 0;
                    document.getElementById('total_encartes').value = data.enc_total || 0;
                    document.getElementById('dig_total').value = data.dig_total || 0;

                    // Calcula extras
                    const limite = data.limite || 0;
                    const ft_total = data.ft_total || 0;
                    const enc_total = data.enc_total || 0;
                    const dig_total = data.dig_total || 0;
                    const sobras = data.sobras || 0;

                    const total_extras = Math.max(0, ft_total - limite);
                    const total_enc_extras = Math.max(0, enc_total - limite);

                    console.log('===== CÁLCULO DE EXTRAS =====');
                    console.log('total_extras (fotos):', total_extras);
                    console.log('total_enc_extras (encartes):', total_enc_extras);

                    document.getElementById('total_extras').value = total_extras;
                    document.getElementById('total_enc_extras').value = total_enc_extras;

                    // Calcula custos
                    const mat1_custo = parseFloat(data.mat1_custo) || 0;
                    const mat2_custo = parseFloat(data.mat2_custo) || 0;

                    console.log('===== CÁLCULO DE CUSTOS =====');
                    console.log('mat1_custo:', mat1_custo);
                    console.log('mat2_custo:', mat2_custo);
                    console.log('ft_total:', ft_total);
                    console.log('sobras:', sobras);
                    console.log('limite:', limite);

                    // Custo Fotos: ATÉ o limite
                    const qtd_fotos_custo = Math.min(ft_total, limite);
                    console.log('Quantidade FOTOS com custo (até limite):', qtd_fotos_custo);

                    // Custo Sobras: SEMPRE todas (sem limite!)
                    const qtd_sobras_custo = sobras;
                    console.log('Quantidade SOBRAS com custo (TODAS):', qtd_sobras_custo);

                    const custo_fotos_sobras = (qtd_fotos_custo + qtd_sobras_custo) * mat1_custo;
                    console.log('Total fotos+sobras com custo:', qtd_fotos_custo + qtd_sobras_custo);
                    console.log('Custo fotos+sobras:', custo_fotos_sobras);

                    document.getElementById('custo_fotos_sobras').value = formatarMoedaValor(custo_fotos_sobras);

                    // Custo Encartes: ATÉ o limite
                    const qtd_encartes_custo = Math.min(enc_total, limite);
                    const custo_encartes = qtd_encartes_custo * mat2_custo;

                    console.log('Quantidade encartes com custo:', qtd_encartes_custo);
                    console.log('Custo encartes:', custo_encartes);

                    document.getElementById('custo_encartes').value = formatarMoedaValor(custo_encartes);

                    // Calcula totais financeiros
                    const conf1_valor = parseFloat(data.conf1_valor) || 0;
                    const conf2_valor = parseFloat(data.conf2_valor) || 0;
                    const conf3_valor = parseFloat(data.conf3_valor) || 0;
                    const percentual_extras = parseFloat(data.percentual_extras) || 0;

                    console.log('===== CÁLCULO FINANCEIRO =====');
                    console.log('conf1_valor:', conf1_valor);
                    console.log('conf2_valor:', conf2_valor);
                    console.log('conf3_valor:', conf3_valor);
                    console.log('percentual_extras (original):', percentual_extras);

                    // ========== TOTAL BRUTO = TUDO QUE VENDEU (SÓ VISUALIZAÇÃO) ==========
                    const total_bruto = (ft_total * conf1_valor) +
                        (enc_total * conf2_valor) +
                        (dig_total * conf3_valor);

                    console.log('Cálculo Total Bruto (visualização):');
                    console.log('  Fotos:', ft_total, '×', conf1_valor, '=', ft_total * conf1_valor);
                    console.log('  Encartes:', enc_total, '×', conf2_valor, '=', enc_total * conf2_valor);
                    console.log('  Digitais:', dig_total, '×', conf3_valor, '=', dig_total * conf3_valor);
                    console.log('  = Total bruto:', total_bruto);

                    document.getElementById('total_bruto').value = formatarMoedaValor(total_bruto);

                    // ========== TOTAL VENDAS (RECEBIDO) = SÓ ATÉ O LIMITE ==========
                    const fotos_ate_limite = Math.min(ft_total, limite);
                    const enc_ate_limite = Math.min(enc_total, limite);
                    const dig_ate_limite = Math.min(dig_total, limite);

                    const total_vendas = (fotos_ate_limite * conf1_valor) +
                        (enc_ate_limite * conf2_valor) +
                        (dig_ate_limite * conf3_valor);

                    console.log('Cálculo Total Vendas (recebido):');
                    console.log('  Fotos até limite:', fotos_ate_limite, '×', conf1_valor, '=', fotos_ate_limite * conf1_valor);
                    console.log('  Encartes até limite:', enc_ate_limite, '×', conf2_valor, '=', enc_ate_limite * conf2_valor);
                    console.log('  Digitais até limite:', dig_ate_limite, '×', conf3_valor, '=', dig_ate_limite * conf3_valor);
                    console.log('  = Total vendas:', total_vendas);

                    document.getElementById('total_vendas').value = formatarMoedaValor(total_vendas);

                    // ========== VALOR EXTRAS (COMISSÃO) = SÓ FOTOS E ENCARTES EXTRAS ==========
                    let percentual_divisor = percentual_extras;
                    if (percentual_extras < 1) {
                        percentual_divisor = percentual_extras;
                        console.log('Percentual já em decimal:', percentual_divisor);
                    } else {
                        percentual_divisor = percentual_extras / 100;
                        console.log('Percentual convertido para decimal:', percentual_divisor);
                    }

                    const valor_extras = ((total_extras * conf1_valor) +
                        (total_enc_extras * conf2_valor)) * percentual_divisor;

                    console.log('Cálculo Valor Extras (Comissão):');
                    console.log('  Fotos extras:', total_extras, '×', conf1_valor, '=', total_extras * conf1_valor);
                    console.log('  Encartes extras:', total_enc_extras, '×', conf2_valor, '=', total_enc_extras * conf2_valor);
                    console.log('  Soma extras:', (total_extras * conf1_valor) + (total_enc_extras * conf2_valor));
                    console.log('  × percentual:', percentual_divisor);
                    console.log('  = Valor extras (Comissão):', valor_extras);

                    document.getElementById('valor_extras').value = formatarMoedaValor(valor_extras);

                    atualizarFinanceiro();

                    console.log('===== CÁLCULO FINALIZADO =====');
                })
                .catch(error => {
                    console.error('Erro ao buscar dados financeiros:', error);
                    alert('Erro ao consultar dados financeiros!');
                });
        }
        // ========== ATUALIZAR FINANCEIRO (COM TOTAL VENDAS) ==========
        function atualizarFinanceiro() {
            console.log('===== ATUALIZANDO FINANCEIRO =====');

            // Pega valores dos inputs
            const custo_fotos_sobras_str = document.getElementById('custo_fotos_sobras').value;
            const custo_encartes_str = document.getElementById('custo_encartes').value;

            console.log('custo_fotos_sobras string:', custo_fotos_sobras_str);
            console.log('custo_encartes string:', custo_encartes_str);

            const custo_fotos_sobras_qtd = parseFloat(removerFormatacaoMoeda(custo_fotos_sobras_str)) || 0;
            const custo_encartes_qtd = parseFloat(removerFormatacaoMoeda(custo_encartes_str)) || 0;

            console.log('custo_fotos_sobras parseado:', custo_fotos_sobras_qtd);
            console.log('custo_encartes parseado:', custo_encartes_qtd);

            const fgts = parseFloat(removerFormatacaoMoeda(document.getElementById('fgts_valor').value)) || 0;
            const inss = parseFloat(removerFormatacaoMoeda(document.getElementById('inss_valor').value)) || 0;


            console.log('FGTS:', fgts);
            console.log('INSS:', inss);


            // Custos de Fotos: simplesmente somar os custos (já calculados em R$)
            const custos_totais = custo_fotos_sobras_qtd + custo_encartes_qtd;

            console.log('Custos totais:', custos_totais);
            document.getElementById('custos_totais').value = formatarMoedaValor(custos_totais);

            // Restituir: custos_totais + inss + fgts
            const restituir = custos_totais + inss + fgts;

            console.log('Restituir:', restituir);
            document.getElementById('restituir').value = formatarMoedaValor(restituir);

            // ========== SALDO LÍQUIDO: TOTAL VENDAS + COMISSÃO - CUSTOS - INSS - FGTS ==========
            const total_vendas = parseFloat(removerFormatacaoMoeda(document.getElementById('total_vendas').value)) || 0;
            const valor_extras = parseFloat(removerFormatacaoMoeda(document.getElementById('valor_extras').value)) || 0;

            const saldo_liquido = total_vendas + valor_extras - restituir;

            console.log('Total vendas:', total_vendas);
            console.log('Valor extras (Comissão):', valor_extras);
            console.log('Restituir:', restituir);
            console.log('Saldo líquido:', saldo_liquido);

            document.getElementById('saldo_liquido').value = formatarMoedaValor(saldo_liquido);
        }
        // ========== FUNÇÕES AUXILIARES FINANCEIRAS ==========

        function formatarMoedaValor(valor) {
            return 'R$ ' + valor.toFixed(2).replace('.', ',').replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
        }



        // Adicionar eventos para atualizar cálculos quando FGTS/INSS mudarem
        document.addEventListener('DOMContentLoaded', function() {
            ['fgts_valor', 'inss_valor'].forEach(id => {
                const campo = document.getElementById(id);
                if (campo) {
                    campo.addEventListener('input', atualizarFinanceiro);
                    campo.addEventListener('blur', function() {
                        if (this.value) {
                            this.value = formatarMoedaValor(parseFloat(removerFormatacaoMoeda(this.value)) || 0);
                        }
                    });
                }
            });
        });
        // Adicionar antes do submit
        document.getElementById('formBuscarVenda').addEventListener('submit', function(e) {
            // Se não tiver checkbox marcado, criar campos com valores padrão
            var checkbox = document.getElementById('sobras_sem_custo');
            var sobrasInput = document.getElementById('sobras_input');
            var valorSobras = parseInt(sobrasInput.value) || 0;

            // Remove campos hidden anteriores
            var hiddenAntigos = this.querySelectorAll('input[name="sobras"], input[name="sobras_extras"]');
            hiddenAntigos.forEach(function(campo) {
                if (campo.type === 'hidden') {
                    campo.remove();
                }
            });

            // Cria novos campos
            var sobrasHidden = document.createElement('input');
            sobrasHidden.type = 'hidden';
            sobrasHidden.name = 'sobras';

            var sobrasExtrasHidden = document.createElement('input');
            sobrasExtrasHidden.type = 'hidden';
            sobrasExtrasHidden.name = 'sobras_extras';

            if (checkbox && checkbox.checked) {
                sobrasHidden.value = 0;
                sobrasExtrasHidden.value = valorSobras;
            } else {
                sobrasHidden.value = valorSobras;
                sobrasExtrasHidden.value = 0;
            }

            this.appendChild(sobrasHidden);
            this.appendChild(sobrasExtrasHidden);

            console.log('📤 SUBMIT - sobras:', sobrasHidden.value, 'sobras_extras:', sobrasExtrasHidden.value);
        });
    </SCRIPT>


</body>
</html>