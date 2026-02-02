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

<style>
    /* ===== ESTILOS DE RESPONSIVIDADE ===== */

    /* Botões principais responsivos */
    .btn-container {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .btn-container .btn {
        flex: 1;
        min-width: 200px;
        margin-bottom: 10px;
    }

    /* Tabelas responsivas */
    .table-responsive {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    .minha-tabela {
        border-collapse: collapse;
        width: 100%;
        min-width: 800px; /* Garante largura mínima para scroll horizontal */
    }

    .minha-tabela td, .minha-tabela th {
        padding: 8px;
        vertical-align: middle;
        font-size: 14px;
        white-space: nowrap;
    }

    /* Formulários responsivos */
    .form-row-responsive {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-bottom: 15px;
    }

    .form-col-responsive {
        flex: 1;
        min-width: 200px;
    }

    /* Modal responsivo */
    .modal-responsive {
        padding: 0 15px;
    }

    /* Paginação responsiva */
    .pagination {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 5px;
        padding: 10px;
    }

    .pagination .btn {
        min-width: 40px;
        margin: 2px;
    }

    /* ===== MEDIA QUERIES ===== */

    /* Tablets e dispositivos médios */
    @media (max-width: 992px) {
        .btn-container .btn {
            min-width: 150px;
        }

        .modal-dialog {
            margin: 10px;
        }

        .modal-xl {
            max-width: calc(100% - 20px);
        }

        .minha-tabela td, .minha-tabela th {
            font-size: 12px;
            padding: 6px;
        }
    }

    /* Smartphones e dispositivos pequenos */
    @media (max-width: 768px) {
        .btn-container {
            flex-direction: column;
        }

        .btn-container .btn {
            width: 100%;
            min-width: 100%;
        }

        .btn-container .btn h4 {
            font-size: 1.1rem;
        }

        .form-col-responsive {
            min-width: 100%;
        }

        .modal-dialog {
            margin: 5px;
        }

        .modal-body {
            padding: 10px;
        }

        .modal-xl {
            max-width: 100%;
            margin: 0;
        }

        .modal-content {
            border-radius: 0;
        }

        .table-responsive {
            margin: 0 -15px;
        }

        .card-body {
            padding: 15px;
        }

        /* Ajusta colunas do formulário para mobile */
        .row .col-2,
        .row .col-3,
        .row .col-4,
        .row .col-6 {
            width: 100%;
            flex: 0 0 100%;
            max-width: 100%;
            margin-bottom: 10px;
        }

        /* Botões de ação em mobile */
        .btn-group-mobile {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .btn-group-mobile .btn {
            width: 100%;
        }

        /* Paginação em mobile */
        .pagination .btn {
            min-width: 35px;
            font-size: 0.875rem;
            padding: 5px 8px;
        }
    }

    /* Dispositivos muito pequenos */
    @media (max-width: 480px) {
        .modal-header h5 {
            font-size: 1rem;
        }

        .btn h4 {
            font-size: 0.9rem;
        }

        .minha-tabela td, .minha-tabela th {
            font-size: 10px;
            padding: 4px;
        }

        .form-control,
        .form-select {
            font-size: 14px;
        }

        label {
            font-size: 0.875rem;
        }
    }

    /* Landscape em smartphones */
    @media (max-width: 768px) and (orientation: landscape) {
        .modal-dialog {
            max-height: 90vh;
        }

        .modal-body {
            max-height: calc(90vh - 120px);
            overflow-y: auto;
        }
    }

    /* Estilo adicional para melhor UX */
    .btn-responsive {
        white-space: normal;
        word-wrap: break-word;
    }

    .input-group {
        flex-wrap: nowrap;
    }

    /* Garante que textareas sejam responsivos */
    textarea {
        resize: vertical;
        min-height: 80px;
    }
</style>

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
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <!-- BOTÕES PRINCIPAIS - AGORA RESPONSIVOS -->
                                    <div class="btn-container">
                                        <button type="button" class="btn btn-outline-warning btn-responsive" data-bs-toggle="modal" data-bs-target="#modalProd">
                                            <h4>Lançar Contas</h4>
                                        </button>

                                        <button type="button" class="btn btn-outline-success btn-responsive" data-bs-toggle="modal" data-bs-target="#modalMat">
                                            <h4>Todas as Contas</h4>
                                        </button>

                                        <button type="button" class="btn btn-outline-danger btn-responsive" data-bs-toggle="modal" data-bs-target="#modalGeral">
                                            <h4>Baixar Conta</h4>
                                        </button>
                                    </div>
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
                                    <!-- Modal LANÇAR CONTAS -->
                                    <div class="modal fade" id="modalProd" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl modal-responsive">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Lançamento de Contas</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>

                                                <div class="container-fluid">
                                                    <div class="page-body">
                                                        <div class="row">
                                                            <div class="col-auto">
                                                                <span style="color:#f2a654">${msg}</span>
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
                                                                            <form action="<%= request.getContextPath() %>/ServletFinanContas" method="post" id="lançarConta" name="lançarConta">
                                                                                <input type="hidden" name="acao" value="">
                                                                                <input type="hidden" id="valorOriginal" name="valorOriginal">

                                                                                <div class="col-12 mb-3">
                                                                                    <span style="color:#1ad76b">${msg}</span>
                                                                                </div>

                                                                                <!-- LINHA 1 - RESPONSIVA -->
                                                                                <div class="row mb-3">
                                                                                    <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                                                        <label for="data_de_pedido">Data da Compra</label>
                                                                                        <input type="date" class="form-control" id="data_de_pedido" name="data_de_pedido" required value="${formattedDataCompra != null ? formattedDataCompra : ''}">
                                                                                    </div>
                                                                                    <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                                                        <label for="data_de_pagamento">Data de Pagamento</label>
                                                                                        <input type="date" class="form-control" id="data_de_pagamento" name="data_de_pagamento" value="${formattedDataPagamento != null ? formattedDataPagamento : ''}">
                                                                                    </div>
                                                                                    <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                                                        <label class="float-label">Nº PEDIDO:</label>
                                                                                        <input type="text" class="form-control" id="pedido" name="numero_pedido" placeholder="" style="background-color: black" value="${contas.numero_pedido}">
                                                                                    </div>
                                                                                    <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                                                        <label class="float-label">EMPRESA:</label>
                                                                                        <input type="text" class="form-control" id="empresa" name="empresa" placeholder="" style="background-color: black; text-transform: uppercase;" value="${contas.empresa}">
                                                                                    </div>
                                                                                </div>

                                                                                <!-- TEXTAREAS -->
                                                                                <div class="row mb-3">
                                                                                    <div class="col-12 mb-3">
                                                                                        <label style="color: #f2a654">ITENS DO PEDIDO</label>
                                                                                        <textarea class="form-control" style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;" id="itens" name="itens" required>${contas.itens}</textarea>
                                                                                    </div>
                                                                                    <div class="col-12 mb-3">
                                                                                        <label style="color: #f2a654">CÓDIGO DE BARRAS</label>
                                                                                        <textarea class="form-control" style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;" id="codigo" name="codigo" required>${modelContas.codigo}</textarea>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- LINHA DE VALORES -->
                                                                                <div class="row mb-3">
                                                                                    <div class="col-md-4 col-sm-6 col-12 mb-2">
                                                                                        <label style="color: #f2a654">VALOR</label>
                                                                                        <div class="input-group">
                                                                                            <span class="input-group-text" style="color: #f2a654; font-weight: bold">R$</span>
                                                                                            <input type="text" class="form-control" id="conf1_valor" name="conf1_valor" required value="${contas.valor}">
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-4 col-sm-6 col-12 mb-2">
                                                                                        <label>STATUS</label>
                                                                                        <select class="form-select" id="status" name="status" required>
                                                                                            <option style="color: #00d25b" value="Pago" ${contas.status == 'Pago' ? 'selected' : ''}>Pago</option>
                                                                                            <option style="color: #bf3322" value="A Pagar" ${contas.status == 'A Pagar' ? 'selected' : ''}>A Pagar</option>
                                                                                        </select>
                                                                                    </div>
                                                                                    <div class="col-md-4 col-sm-6 col-12 mb-2">
                                                                                        <label>FORMA DE PAGAMENTO</label>
                                                                                        <select class="form-select" id="pagamento" name="pagamento" required>
                                                                                            <option value="---------">---------</option>
                                                                                            <option value="DINHEIRO" ${contas.pagamento == 'DINHEIRO' ? 'selected' : ''}>DINHEIRO</option>
                                                                                            <option value="BOLETO" ${contas.pagamento == 'BOLETO' ? 'selected' : ''}>BOLETO</option>
                                                                                            <option value="CARTAO" ${contas.pagamento == 'CARTAO' ? 'selected' : ''}>CARTÃO</option>
                                                                                            <option value="PIX" ${contas.pagamento == 'PIX' ? 'selected' : ''}>PIX</option>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- BOTÕES DE AÇÃO -->
                                                                                <div class="btn-group-mobile">
                                                                                    <button class="btn btn-outline-success waves-effect waves-light">Salvar</button>
                                                                                    <button type="button" class="btn btn-outline-warning waves-effect waves-light" onclick="limparFormLancar();">Limpar</button>
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

                    <div class="col-sm-4 grid-margin">
                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!-- Modal TODAS AS CONTAS -->
                                    <div class="modal fade" id="modalMat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl modal-responsive">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticRanking">TODAS AS CONTAS</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body" style="max-height: 70vh; overflow-y: auto;">
                                                    <div class="container-fluid">
                                                        <form id="modalContas" action="ServletFinanContas" method="get">
                                                            <input type="hidden" name="acao" value="imprimirRelatorioContas">
                                                            <input type="hidden" name="pagina" id="pagina" value="1">
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <div class="table-responsive">
                                                                        <table class="table table-striped table-bordered" id="tabelaContas">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>Conta ID</th>
                                                                                <th>Número do Pedido</th>
                                                                                <th>Empresa</th>
                                                                                <th>Itens</th>
                                                                                <th>Valor</th>
                                                                                <th>Data de Pedido</th>
                                                                                <th>Data de Pagamento</th>
                                                                                <th>Status</th>
                                                                                <th>Pagamento</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody id="tabelaContasBody">
                                                                            <!-- As linhas da tabela serão inseridas aqui via AJAX -->
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
                    </div>

                    <div class="col-sm-4 grid-margin">
                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!-- Modal BAIXAR CONTA -->
                                    <div class="modal fade" id="modalGeral" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg modal-responsive">
                                            <div class="modal-content">
                                                <div class="modal-header bg-dark text-white">
                                                    <h5 class="modal-title">Baixar Conta</h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>

                                                <div class="modal-body">
                                                    <form action="<%= request.getContextPath() %>/ServletFinanContas" method="post" id="formBaixarVenda" class="p-3">
                                                        <input type="hidden" name="acao" value="baixar"/>

                                                        <div class="row mb-3">
                                                            <div class="col-md-6 col-12 mb-2">
                                                                <label for="numero_pedido" class="form-label fw-bold">Número do Pedido</label>
                                                                <input type="text" class="form-control form-control-lg" id="numero_pedido" name="numero_pedido" required placeholder="Digite o Nº do pedido">
                                                            </div>

                                                            <div class="col-md-6 col-12 mb-2">
                                                                <label for="formaPgto" class="form-label fw-bold">Forma de Pagamento</label>
                                                                <select class="form-select form-select-lg" id="formaPgto" name="formaPgto" required>
                                                                    <option value="">Selecione...</option>
                                                                    <option value="DINHEIRO">DINHEIRO</option>
                                                                    <option value="BOLETO">BOLETO</option>
                                                                    <option value="CARTAO">CARTÃO</option>
                                                                    <option value="PIX">PIX</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="d-grid">
                                                            <button type="submit" class="btn btn-outline-success btn-lg">
                                                                <h4 class="mb-0">BAIXAR CONTA</h4>
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Fechar</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- FORMULÁRIO DE EDIÇÃO -->
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <span style="color:#1ad76b; text-align: center">${msg}</span>

                                <div class="table-responsive">
                                    <form action="<%= request.getContextPath() %>/ServletFinanContas" method="post" id="formContas">
                                        <!-- LINHA 1 -->
                                        <div class="row mb-3">
                                            <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                <label for="data_de_pedido2">Data da Compra</label>
                                                <input type="date" class="form-control" id="data_de_pedido2" name="data_de_pedido" required value="${formattedDataCompra != null ? formattedDataCompra : ''}">
                                            </div>
                                            <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                <label for="data_de_pagamento2">Data de Pagamento</label>
                                                <input type="date" class="form-control" id="data_de_pagamento2" name="data_de_pagamento" value="${formattedDataPagamento != null ? formattedDataPagamento : ''}">
                                            </div>
                                            <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                <label class="float-label">Nº PEDIDO:</label>
                                                <input type="text" class="form-control" id="pedido2" name="numero_pedido" style="background-color: black" value="${contas.numero_pedido}">
                                            </div>
                                            <div class="col-md-3 col-sm-6 col-12 mb-2">
                                                <label class="float-label">ID:</label>
                                                <input type="text" class="form-control" id="idPedido" name="idPedido" style="background-color: black; text-transform: uppercase;" value="${contas.conta_id}">
                                            </div>
                                        </div>

                                        <!-- LINHA 2 -->
                                        <div class="row mb-3">
                                            <div class="col-12 mb-3">
                                                <label class="float-label">EMPRESA:</label>
                                                <input type="text" class="form-control" id="empresa2" name="empresa2" style="background-color: black; text-transform: uppercase;" value="${contas.empresa}">
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label>ITENS DO PEDIDO</label>
                                                <textarea class="form-control" style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;" id="itens2" name="itens" required>${modelContas.itens}</textarea>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label style="color: #f2a654">CÓDIGO DE BARRAS</label>
                                                <textarea class="form-control" style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;" id="codigo2" name="codigo" required>${modelContas.codigo}</textarea>
                                            </div>
                                        </div>

                                        <!-- LINHA 3 -->
                                        <div class="row mb-3">
                                            <div class="col-md-4 col-sm-6 col-12 mb-2">
                                                <label>VALOR</label>
                                                <div class="input-group">
                                                    <span class="input-group-text" style="color: #f2a654; font-weight: bold">R$</span>
                                                    <input type="text" class="form-control" id="conf1_valor2" name="conf1_valor2" required value="${contas.valor}">
                                                </div>
                                            </div>

                                            <div class="col-md-4 col-sm-6 col-12 mb-2">
                                                <label>STATUS</label>
                                                <select class="form-select" id="status2" name="status" required>
                                                    <option style="color: #00d25b" value="PAGO" ${contas.status == 'PAGO' ? 'selected' : ''}>PAGO</option>
                                                    <option style="color: #bf3322" value="A PAGAR" ${contas.status == 'A PAGAR' ? 'selected' : ''}>A PAGAR</option>
                                                </select>
                                            </div>

                                            <div class="col-md-4 col-sm-6 col-12 mb-2">
                                                <label>FORMA DE PAGAMENTO</label>
                                                <select class="form-select" id="pagamento2" name="pagamento" required>
                                                    <option value="---------">---------</option>
                                                    <option value="DINHEIRO" ${contas.pagamento == 'DINHEIRO' ? 'selected' : ''}>DINHEIRO</option>
                                                    <option value="BOLETO" ${contas.pagamento == 'BOLETO' ? 'selected' : ''}>BOLETO</option>
                                                    <option value="CARTAO" ${contas.pagamento == 'CARTAO' ? 'selected' : ''}>CARTÃO</option>
                                                    <option value="PIX" ${contas.pagamento == 'PIX' ? 'selected' : ''}>PIX</option>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- BOTÕES DE AÇÃO -->
                                        <div class="btn-group-mobile">
                                            <input type="hidden" name="acao" value="atualizar">
                                            <button type="submit" class="btn btn-outline-success">Atualizar</button>
                                            <button type="button" class="btn btn-outline-warning waves-effect waves-light" onclick="limparFormContas();">Limpar</button>
                                            <button type="button" class="btn btn-outline-danger waves-effect waves-light" onclick="deletaConta();">Excluir Conta</button>
                                        </div>
                                    </form>
                                </div>

                                <!-- TABELA DE CONTAS RECENTES -->
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-body">
                                                <h2 style="text-align: center" class="mb-3">CONTAS DOS ÚLTIMOS 60 DIAS</h2>
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-bordered minha-tabela">
                                                        <thead>
                                                        <tr>
                                                            <th>Opções</th>
                                                            <th>Status</th>
                                                            <th>Nº Pedido</th>
                                                            <th>Empresa</th>
                                                            <th>Itens</th>
                                                            <th>Valor</th>
                                                            <th>Pedido</th>
                                                            <th>Pagamento</th>
                                                            <th>Forma</th>
                                                            <th>ID</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:choose>
                                                            <c:when test="${not empty contasRecentes}">
                                                                <c:forEach var="contas" items="${contasRecentes}">
                                                                    <tr>
                                                                        <td>
                                                                            <c:set var="valorFormatado">
                                                                                <fmt:formatNumber value="${contas.valor}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                                            </c:set>
                                                                            <button class="btn btn-outline-primary btn-sm" onclick="editarConta(this, '${contas.data_de_pedido}', '${contas.data_de_pagamento}', '${contas.numero_pedido}', '${contas.conta_id}', '${contas.empresa}', '${contas.itens}', '${contas.codigo}', '${valorFormatado}', '${contas.status}', '${contas.pagamento}')">
                                                                                Editar
                                                                            </button>
                                                                        </td>
                                                                        <td>
                                                                            <span class="<c:choose>
                                                                                <c:when test='${contas.status eq "PAGO"}'>text-success fw-bold</c:when>
                                                                                <c:when test='${contas.status eq "A PAGAR"}'>text-warning fw-bold</c:when>
                                                                                <c:when test='${contas.status eq "ATRASADO"}'>text-danger fw-bold</c:when>
                                                                                <c:otherwise>text-secondary</c:otherwise>
                                                                            </c:choose>">
                                                                                <c:out value="${contas.status}"/>
                                                                            </span>
                                                                        </td>
                                                                        <td><c:out value="${contas.numero_pedido}"/></td>
                                                                        <td><c:out value="${contas.empresa}"/></td>
                                                                        <td><c:out value="${contas.itens}"/></td>
                                                                        <td><fmt:formatNumber value="${contas.valor}" type="currency" currencySymbol="R$"/></td>
                                                                        <td><fmt:formatDate value="${contas.data_de_pedido}" pattern="dd/MM/yyyy"/></td>
                                                                        <td><fmt:formatDate value="${contas.data_de_pagamento}" pattern="dd/MM/yyyy"/></td>
                                                                        <td><c:out value="${contas.pagamento}"/></td>
                                                                        <td><c:out value="${contas.conta_id}"/></td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <tr>
                                                                    <td colspan="10">Nenhuma conta encontrada.</td>
                                                                </tr>
                                                            </c:otherwise>
                                                        </c:choose>
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
                </div>
            </div>
            <!-- content-wrapper ends -->
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->

<jsp:include page="pluginsJS.jsp"></jsp:include>

<!-- Modal HTML -->
<div class="modal" id="msgModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-responsive" role="document">
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;">
            <div class="modal-header" style="border-bottom: none;"></div>
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
            $('#msgModal').modal('show');
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
                event.preventDefault();
            }
        });
    });

    document.addEventListener('keydown', navigateFocusableElements);

    $("#conf1_valor").maskMoney({showSymbol: true, symbol: "R$ ", decimal: ",", thousands: "."});
    $("#conf1_valor2").maskMoney({showSymbol: true, symbol: "R$ ", decimal: ",", thousands: "."});

    function removerMascara(valor) {
        return valor.replace(/\./g, '').replace(',', '.').replace('R$ ', '');
    }

    $("#formContas").on("submit", function (e) {
        e.preventDefault();
        var valorAtual = $("#conf1_valor2").val();
        var valorLimpo = valorAtual.toString()
            .replace('R$', '')
            .trim()
            .replace(/\./g, '')
            .replace(',', '.');
        $("#conf1_valor2").val(valorLimpo);
        document.getElementById('formContas').submit();
    });

    $("#lançarConta").on("submit", function (e) {
        var valor1 = removerMascara($("#conf1_valor").val());
        $("#conf1_valor").val(valor1);
    });

    function deletaConta() {
        const contaID = document.getElementById('idPedido').value;
        if (confirm("Tem certeza que deseja excluir a conta " + contaID + "?")) {
            $.ajax({
                method: 'GET',
                url: '<%= request.getContextPath() %>/ServletFinanContas',
                data: {acao: 'deletar', conta_id: contaID},
                success: function (response) {
                    alert("Conta excluída com sucesso!");
                    location.reload();
                },
                error: function (xhr, status, errorThrown) {
                    alert('Erro ao excluir a conta: ' + xhr.responseText);
                }
            });
        }
    }

    function formatarData(data) {
        var partes = data.split('/');
        if (partes.length === 3) {
            return `${partes[2]}-${partes[1]}-${partes[0]}`;
        }
        return data;
    }

    function editarConta(button, dataPedido, dataPagamento, numeroPedido, conta_id, empresa, itens, codigo, valor, status, pagamento) {
        document.getElementById('data_de_pedido2').value = formatarData(dataPedido);
        document.getElementById('data_de_pagamento2').value = formatarData(dataPagamento);
        document.getElementById('pedido2').value = numeroPedido;
        document.getElementById('idPedido').value = conta_id;
        document.getElementById('empresa2').value = empresa;
        document.getElementById('itens2').value = itens;
        document.getElementById('codigo2').value = codigo;

        $("#conf1_valor2").val('');
        setTimeout(function() {
            $("#conf1_valor2").val(valor);
        }, 50);

        document.getElementById('status2').value = status;
        document.getElementById('pagamento2').value = pagamento;

        // Scroll suave para o formulário de edição em mobile
        if (window.innerWidth <= 768) {
            document.getElementById('formContas').scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    }

    function carregarContas(pagina = 1) {
        $.ajax({
            url: 'ServletFinanContas',
            method: 'GET',
            data: {
                acao: 'imprimirRelatorioContas',
                pagina: pagina
            },
            success: function(data) {
                $('#tabelaContasBody').html(data);
                $('#pagina').val(pagina);
            },
            error: function() {
                console.error('Erro ao carregar contas.');
            }
        });
    }

    $(document).ready(function() {
        carregarContas();
    });

    $(document).on('click', '.pagination a', function(event) {
        event.preventDefault();
        const pagina = $(this).data('pagina');
        carregarContas(pagina);
    });

    $('#modalMat').on('shown.bs.modal', function() {
        carregarContas();
    });
</script>

</body>
</html>
