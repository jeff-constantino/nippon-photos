
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
<%
    // Gera o ano atual e define como atributo
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int anoAtual = cal.get(java.util.Calendar.YEAR);
    request.setAttribute("anoAtual", anoAtual);
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
            <div class="content-wrapper" style="min-height: calc(98vh - 100px);">
                <div class="row">

                </div>

                <div class="row">
                    <div class="col-sm-4 grid-margin">
                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!-- Modal Buscar Salarios -->
                                    <div class="modal fade" id="modalBusca" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5" style="max-width: 80%; width: 80%">
                                            <div class="modal-content">
                                                <div class="modal-body">

                                                    <form id="formBusca" name="formBusca">
                                                        <input type="hidden" name="acao" value="buscaSalario">
                                                        <div class="form-row align-items-center">

                                                            <!-- Select de Mês -->
                                                            <div class="col-auto">
                                                                <label for="mes">Mês</label>
                                                                <select class="form-control" id="mes" name="mes" required>
                                                                    <option value="">Selecione o mês</option>
                                                                    <c:forEach var="i" begin="1" end="12">
                                                                        <c:set var="mesNome">
                                                                            <c:choose>
                                                                                <c:when test="${i == 1}">Janeiro</c:when>
                                                                                <c:when test="${i == 2}">Fevereiro</c:when>
                                                                                <c:when test="${i == 3}">Março</c:when>
                                                                                <c:when test="${i == 4}">Abril</c:when>
                                                                                <c:when test="${i == 5}">Maio</c:when>
                                                                                <c:when test="${i == 6}">Junho</c:when>
                                                                                <c:when test="${i == 7}">Julho</c:when>
                                                                                <c:when test="${i == 8}">Agosto</c:when>
                                                                                <c:when test="${i == 9}">Setembro</c:when>
                                                                                <c:when test="${i == 10}">Outubro</c:when>
                                                                                <c:when test="${i == 11}">Novembro</c:when>
                                                                                <c:when test="${i == 12}">Dezembro</c:when>
                                                                            </c:choose>
                                                                        </c:set>
                                                                        <option value="${i}" <c:if test="${i == mes}">selected</c:if>>${mesNome}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>

                                                            <!-- Select de Ano -->
                                                            <div class="col-auto">
                                                                <label for="ano">Ano</label>
                                                                <select class="form-control" id="ano" name="ano" required>
                                                                    <option value="">Selecione o ano</option>
                                                                    <c:forEach var="a" begin="${anoAtual - 10}" end="${anoAtual + 10}">
                                                                        <option value="${a}" <c:if test="${a == ano}">selected</c:if>>${a}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>

                                                            <!-- Select de Funcionário -->
                                                            <div class="col-auto">
                                                                <label>Funcionário</label>
                                                                <select class="form-control" id="funcionarioIdBusca" name="funcionarioId" required>
                                                                    <option value="">Selecione um Funcionário</option>

                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                        <c:if test="${funcionario.status == 'ATIVO'}">
                                                                            <option value="${funcionario.id}" class="text-success"
                                                                                    <c:if test="${param.funcionarioId != null && param.funcionarioId == funcionario.id}">
                                                                                        selected
                                                                                    </c:if>>
                                                                                    ${funcionario.nome}
                                                                            </option>
                                                                        </c:if>
                                                                    </c:forEach>

                                                                    <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                        <c:if test="${funcionario.status != 'ATIVO'}">
                                                                            <option value="${funcionario.id}" class="text-danger"
                                                                                    <c:if test="${param.funcionarioId != null && param.funcionarioId == funcionario.id}">
                                                                                        selected
                                                                                    </c:if>>
                                                                                    ${funcionario.nome}
                                                                            </option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>

                                                            <!-- Botão de Submissão -->
                                                            <div class="col-auto">
                                                                <button id="btnBuscar" type="button" class="btn btn-primary">Exibir Resultados</button>
                                                            </div>

                                                        </div>
                                                    </form>


                                                    <!-- ÁREA DE RESULTADOS DA BUSCA -->
                                                    <div id="resultadoBusca" style="display: none;">
                                                        <hr class="my-4">

                                                        <!-- Form para edição -->
                                                        <form id="formEdicao" name="formEdicao" method="post" action="${pageContext.request.contextPath}/ServletSalarios">
                                                            <input type="hidden" name="acao" value="editarSalario">
                                                            <input type="hidden" id="idSalario" name="idSalario" value="">
                                                            <input type="hidden" id="mesEdicao" name="mes" value="">
                                                            <input type="hidden" id="anoEdicao" name="ano" value="">
                                                            <input type="hidden" id="funcionarioIdEdicao" name="funcionarioId" value="">
                                                            <input type="hidden" id="nomeEdicao" name="nome" value="">
                                                            <input type="hidden" id="mesAnoHidden" name="mesAno" value="">

                                                            <!-- Título com mês/ano -->
                                                            <div class="row align-items-center mb-3">
                                                                <div class="col text-center">
                                                                    <h2 style="text-transform: uppercase; color: #d39e00" id="mesAnoResultado">${mesAno}</h2>
                                                                </div>
                                                            </div>

                                                            <!-- VENDAS TOTAIS DO FUNCIONÁRIO -->
                                                            <div class="card mb-3">
                                                                <div class="card-body">
                                                                    <h4 class="card-title" style="text-align: center">VENDAS TOTAIS DO FUNCIONÁRIO</h4>

                                                                    <div class="row align-items-center mb-3">
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">NOME</label>
                                                                            <input type="text" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="nomeResultado" readonly tabindex="-1">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE FOTOS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="ft_totalResultado" name="ft_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE DIGITAIS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="dig_totalResultado" name="dig_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE SOBRAS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="sobrasResultado" name="sobras">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">APROVEITAMENTO</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="aproveitamentoResultado" name="aproveitamento">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">FUNCIONÁRIO ID</label>
                                                                            <input type="text" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="funcionarioIdResultado" readonly tabindex="-1">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- HISTÓRICO DE CONDUTA -->
                                                            <div class="card mb-3">
                                                                <div class="card-body">
                                                                    <h4 class="card-title" style="text-align: center">HISTÓRICO DE CONDUTA</h4>

                                                                    <div class="row align-items-center mb-3">
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">ADVERTÊNCIAS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="advertenciasResultado" name="advertencias">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">FALTAS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="faltasResultado" name="faltas">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">DIAS DE SUSPENSÃO</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="suspensoesResultado" name="suspensoes">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">DSR</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="dsrResultado" name="dsr">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- DESCONTOS DISCIPLINARES -->
                                                            <div class="card mb-3">
                                                                <div class="card-body">
                                                                    <h4 class="card-title" style="text-align: center">VALOR DE DESCONTOS DISCIPLINARES</h4>

                                                                    <div class="row align-items-center mb-3">
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">VALOR DAS FALTAS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="inputFaltasResultado" name="inputFaltas">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">VALOR DAS SUSPENSÕES + DSR</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="inputSuspensoesResultado" name="inputSuspensoes">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">ATRASOS (HH:MM)</label>
                                                                            <input type="text" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="atrasos_horasResultado" name="atrasos_horas"
                                                                                   pattern="^([0-9]{1,2}):([0-5][0-9])$"
                                                                                   placeholder="00:00">
                                                                        </div>

                                                                        <div class="col-auto ms-3">
                                                                            <label style="color: #f2a654">VALOR DESCONTO ATRASOS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="valor_desconto_atrasosResultado" name="valor_desconto_atrasos">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- SALÁRIOS E COMISSÕES -->
                                                            <div class="card mb-3">
                                                                <div class="card-body">
                                                                    <!-- Primeira linha -->
                                                                    <div class="row align-items-center mb-3">
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">VENDA TOTAL</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="venda_totalResultado" name="venda_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">VALES</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="vales_mesResultado" name="vales_mes">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">INSS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="inssResultado" name="inss">
                                                                        </div>
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">PARCELA A DEDUZIR</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="parcelaResultado" name="parcela">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">FGTS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="fgtsResultado" name="fgts">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">DESCONTOS DISCIPLINARES</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="descontos_mesResultado" name="descontos_mes">
                                                                        </div>
                                                                    </div>

                                                                    <!-- Segunda linha -->
                                                                    <div class="row align-items-center mb-3">
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">COMISSÃO %</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #f2a654; color: black"
                                                                                   id="comissaoResultado" name="comissao">
                                                                        </div>

                                                                        <div class="col-auto ms-3">
                                                                            <label style="color: #f2a654">SALÁRIO TOTAL</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #f2a654; color: black"
                                                                                   id="salario_totalResultadoField" name="salario_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE DESCONTOS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="descontos_1Resultado" name="descontos_1">
                                                                        </div>

                                                                        <div class="col-auto ms-3">
                                                                            <label style="color: #f2a654">SALÁRIO LÍQUIDO</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #f2a654; color: black"
                                                                                   id="salario_liquidoResultado" name="salario_liquido">
                                                                        </div>
                                                                    </div>

                                                                    <!-- Terceira linha -->
                                                                    <div class="row align-items-center">
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">COMISSÃO %</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #f2a654; color: black"
                                                                                   id="comissao2Resultado" name="comissao2">
                                                                        </div>

                                                                        <div class="col-auto ms-3">
                                                                            <label style="color: #f2a654">SALÁRIO TOTAL</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #f2a654; color: black"
                                                                                   id="salario_total2Resultado" name="salario_total2">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE DESCONTOS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #2c2c2c; color: white"
                                                                                   id="descontos_2Resultado" name="descontos_2">
                                                                        </div>

                                                                        <div class="col-auto ms-3">
                                                                            <label style="color: #f2a654">SALÁRIO LÍQUIDO 2</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: #f2a654; color: black"
                                                                                   id="salario_liquido2Resultado" name="salario_liquido2">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-success" id="btnSalvar" style="display: none;">SALVAR ALTERAÇÕES</button>
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
                                    <!-- Modal -->
                                    <div class="modal fade" id="modalData" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-body">

                                                    <form action="<%= request.getContextPath() %>/ServletSalarios" method="get" id="formVendaTotal" name="formVendaTotal">
                                                        <input type="hidden" name="acao" value="imprimirVendasFuncionario">
                                                        <div class="form-row align-items-center">
                                                            <div class="col-auto">
                                                                <label for="dataInicial">Data Inicial</label>
                                                                <input type="date" class="form-control" id="dataInicial" name="dataInicial" value="${dataInicial}">
                                                            </div>
                                                            <div class="col-auto">
                                                                <label for="dataFinal">Data Final</label>
                                                                <input type="date" class="form-control" id="dataFinal" name="dataFinal" value="${dataFinal}">
                                                            </div>
                                                            <div class="col-auto">
                                                                <label>Funcionário</label>
                                                                <select class="form-control" id="funcionarioId" name="funcionarioId" required>
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
                                                            <div class="col-auto">
                                                                <button type="submit" class="btn btn-primary">Imprimir Relatório</button>
                                                            </div>
                                                        </div>
                                                    </form>

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
                <form action="<%= request.getContextPath() %>/ServletSalarios" method="post" id="formGravarVenda" name="formGravarVenda">
                    <input type="hidden" name="acao" value="gravarVenda">
                    <input type="hidden" name="mesAno" value="${mesAno}">

                    <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <!-- Botão Gerar Relatório -->
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>GERAR RELATÓRIO</h4>
                                </button>
                                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalBusca">
                                    <h4>BUSCAR SALÁRIO</h4>
                                </button>

                                

                                <!-- Título com mês/ano -->
                                <div class="row align-items-center mb-3">
                                    <div class="col text-center">
                                        <h2 style="text-transform: uppercase; color: #d39e00">${mesAno}</h2>
                                    </div>
                                </div>

                                <!-- Título principal -->
                                <h4 class="card-title" style="text-align: center">VENDAS TOTAIS DO FUNCIONÁRIO</h4>

                                <!-- Bloco de inputs com forEach -->
                                <c:forEach var="mv" items="${vendasFuncionarioList}">
                                    <div class="row align-items-center mb-3">

                                        <div class="col-auto">
                                            <label style="color: #f2a654">NOME</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   name="nome" value="${mv.nome}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE FOTOS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   id="ft_total" name="ft_total"
                                                   value="${mv.ft_total}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE ENCARTES</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   id="enc_total" name="enc_total"
                                                   value="${mv.enc_total}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE DIGITAIS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   id="dig_total" name="dig_total"
                                                   value="${mv.dig_total}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE SOBRAS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   name="sobras" value="${mv.sobras}" readonly tabindex="-1">
                                        </div>

                                            <%-- Lógica JSP para calcular aproveitamento --%>
                                        <c:set var="aproveitamento" value="0" />
                                        <c:if test="${mv.sobras + mv.ft_total > 0}">
                                            <c:set var="aproveitamento" value="${(mv.ft_total * 100) / (mv.sobras + mv.ft_total)}" />
                                        </c:if>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">APROVEITAMENTO</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   value="<fmt:formatNumber value='${aproveitamento}' maxFractionDigits='2'/>%"
                                                   readonly tabindex="-1">

                                            <!-- input real para enviar no POST -->
                                            <input type="hidden" name="aproveitamento" value="${aproveitamento}" />
                                        </div>



                                        <div class="col-auto">
                                            <label style="color: #f2a654">FUNCIONÁRIO ID</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   name="funcionarioId"
                                                   value="${funcionarioId}" readonly tabindex="-1">
                                        </div>

                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                </div>



            <%--parte 2--%>

                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <!-- Título -->
                                <h4 class="card-title" style="text-align: center">HISTÓRICO DE CONDUTA</h4>

                                <!-- Bloco de inputs com mesmo layout -->
                                <div class="row align-items-center mb-3">

                                    <div class="col-auto">
                                        <label style="color: #f2a654">ADVERTÊNCIAS</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               name="advertencias"
                                               value="${resumoConduta.totalAdvertencias}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">FALTAS</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               name="faltas"
                                               value="${resumoConduta.totalFaltas}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">DIAS DE SUSPENSÃO</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               name="suspensoes"
                                               value="${resumoConduta.totalDiasSuspensao}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">DSR</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               name="dsr"
                                               value="${resumoConduta.totalDsrSuspensao}" readonly tabindex="-1">
                                    </div>

                                </div>

                              </div>
                        </div>
                    </div>
                </div>

            <%-- 3 PARTE--%>
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row align-items-center mb-3">
                                    <h4 class="card-title" STYLE="text-align: center">VALOR DE DESCONTOS DISCIPLINARES</h4>
                                    <div class="col-auto">
                                        <label style="color: #f2a654">VALOR DAS FALTAS</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="inputFaltas" name="inputFaltas"
                                               value="R$ 0,00"
                                               data-faltas="${resumoConduta.totalFaltas}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">VALOR DAS SUSPENSÕES + DSR</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="inputSuspensoes" name="inputSuspensoes"
                                               value="R$ 0,00"
                                               data-suspensoes="${resumoConduta.totalDiasSuspensao}"
                                               data-dsr="${resumoConduta.totalDsrSuspensao}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">ATRASOS (HH:MM)</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: white; color: black"
                                               id="atrasos_horas" name="atrasos_horas" placeholder="00:00">
                                    </div>
                                    <div class="col-auto ms-3">
                                        <label style="color: #f2a654">VALOR DESCONTO ATRASOS</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="valor_desconto_atrasos" name="valor_desconto_atrasos" value="R$ 0,00" readonly tabindex="-1">
                                    </div>
                                </div>



                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <!-- Primeira linha: Vendas, vales, inss, fgts, descontos -->
                                <div class="row align-items-center mb-3">
                                    <div class="col-auto">
                                        <label style="color: #f2a654">VENDA TOTAL</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="venda_total" name="venda_total" value="${venda_total}" tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">VALES</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="vales_mes" name="vales_mes" value="${vales_mes}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">INSS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="inss" name="inss" value="${inss}" readonly tabindex="-1">
                                    </div>
                                    <div class="col-auto">
                                        <label style="color: #f2a654">PARCELA A DEDUZIR</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="parcela" name="parcela" value="${parcela}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">FGTS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="fgts" name="fgts" value="${fgts}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">DESCONTOS DISCIPLINARES</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="descontos_mes" name="descontos_mes" value="${descontos_mes}" readonly tabindex="-1">
                                    </div>

                                    <c:forEach var="mv" items="${vendasFuncionarioList}">
                                        <div class="col-auto">
                                            <label style="color: #f2a654">DIFERENÇA DE FOTOS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: #2c2c2c; color: white"
                                                   id="dif_fotos" name="dif_fotos"
                                                   value="${mv.ribbon_descontar}" readonly tabindex="-1">
                                        </div>
                                    </c:forEach>
                                    <div class="col-auto">
                                        <label style="color: #f2a654">DESCONTOS DE FOTOS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="desconto_fotos" name="desconto_fotos" value="${desconto_fotos}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">IMPOSTO DE RENDA</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="descontos_ir" name="descontos_ir" value="${descontos_ir}" readonly tabindex="-1">
                                    </div>


                                </div>

                                <!-- Segunda linha: Comissão 1 e Salário Líquido 1 -->
                                <div class="row align-items-center mb-3">
                                    <div class="col-auto">
                                        <label style="color: #f2a654">COMISSÃO %</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="comissao" name="comissao" value="${comissao}%" >
                                    </div>
                                    <div class="col-auto ms-3">
                                        <label style="color: #f2a654">SALÁRIO TOTAL</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="salario_total" name="salario_total" value="${salario_total}">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">TOTAL DE DESCONTOS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="descontos_1" name="descontos_1" value="${descontos_1}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto ms-3">
                                        <label style="color: #f2a654">SALÁRIO LÍQUIDO</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="salario_liquido" name="salario_liquido" value="${salario_liquido}">
                                    </div>

                                </div>

                                <!-- Terceira linha: Comissão 2 e Salário Líquido 2 -->
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <label style="color: #f2a654">COMISSÃO %</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="comissao2" name="comissao2" value="${comissao2}%" >

                                    </div>
                                    <div class="col-auto ms-3">
                                        <label style="color: #f2a654">SALÁRIO TOTAL</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="salario_total2" name="salario_total2" value="${salario_total2}">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">TOTAL DE DESCONTOS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #2c2c2c; color: white"
                                               id="descontos_2" name="descontos_2" value="${descontos_2}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto ms-3">
                                        <label style="color: #f2a654">SALÁRIO LÍQUIDO 2</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="salario_liquido2" name="salario_liquido2" value="${salario_liquido2}">
                                    </div>
                                </div>
                                <input type="hidden" name="id_salario" id="id_salario" value="">


                            </div>



                        </div>
                    </div>
                </div>
                    <div class="row">
                        <div class="col-12 grid-margin">
                            <div class="card">
                                <div class="card-body">
                                    <button type="submit" class="btn btn-outline-success">
                                        <H4>Gravar</H4>
                                    </button>

                                </div>



                            </div>
                        </div>
                    </div>
                </form>


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
    // === DEBUG: VERIFICAR CONFIGURAÇÕES ===
    console.log('=== CONFIGURAÇÕES CARREGADAS ===');
    console.log('conf1_valor:', '${listaConfigs[0].conf1_valor}');
    console.log('conf2_valor:', '${listaConfigs[0].conf2_valor}');
    console.log('conf3_valor:', '${listaConfigs[0].conf3_valor}');
    console.log('comissao:', '${configSalario.comissao}');
    console.log('comissao2:', '${configSalario.comissao2}');
    console.log('fgts:', '${configSalario.fgts}');
    // ===================================================================
    // CORREÇÃO: Consolidar todos os window.onload em DOMContentLoaded
    // ===================================================================

    $(document).ready(function () {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show');
            $.post("${pageContext.request.contextPath}/ServletVendas", { acao: "limparMsg" });
        }

        // Inicializa tooltips
        $('#tooltipButton').tooltip({
            delay: { "show": 100, "hide": 100 }
        });
    });

    // ===================================================================
    // NAVEGAÇÃO POR SETAS
    // ===================================================================
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

    // Bloqueia alteração de valor com setas em inputs number
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                event.preventDefault();
            }
        });
    });

    document.addEventListener('keydown', navigateFocusableElements);

    // ===================================================================
    // CONFIGURAÇÕES DO BACKEND
    // ===================================================================
    const conf1_valor = parseFloat('${listaConfigs[0].conf1_valor}');
    const conf2_valor = parseFloat('${listaConfigs[0].conf2_valor}');
    const conf3_valor = parseFloat('${listaConfigs[0].conf3_valor}');

    const comissao = parseFloat('${configSalario.comissao}');
    const comissao2 = parseFloat('${configSalario.comissao2}');
    const fgtsAliquota = parseFloat('${configSalario.fgts}');

    const faixasInss = [
        {
            min: parseFloat('${configInss.min_inss_1}'),
            max: parseFloat('${configInss.max_inss_1}'),
            aliquota: parseFloat('${configInss.inss_1}'),
            parcela: parseFloat('${configInss.parcela_1}')
        },
        {
            min: parseFloat('${configInss.min_inss_2}'),
            max: parseFloat('${configInss.max_inss_2}'),
            aliquota: parseFloat('${configInss.inss_2}'),
            parcela: parseFloat('${configInss.parcela_2}')
        },
        {
            min: parseFloat('${configInss.min_inss_3}'),
            max: parseFloat('${configInss.max_inss_3}'),
            aliquota: parseFloat('${configInss.inss_3}'),
            parcela: parseFloat('${configInss.parcela_3}')
        },
        {
            min: parseFloat('${configInss.min_inss_4}'),
            max: parseFloat('${configInss.max_inss_4}'),
            aliquota: parseFloat('${configInss.inss_4}'),
            parcela: parseFloat('${configInss.parcela_4}')
        }
    ];

    // ===================================================================
    // FUNÇÕES AUXILIARES
    // ===================================================================
    function converterHorasParaDecimal(horasMinutos) {
        if (!horasMinutos) return 0;
        const partes = horasMinutos.split(':');
        const horas = parseInt(partes[0], 10) || 0;
        const minutos = parseInt(partes[1], 10) || 0;
        return horas + (minutos / 60);
    }

    function removerMascara(valor) {
        if (!valor || typeof valor !== 'string') return '0';
        return valor.replace(/\./g, '').replace(',', '.').replace('R$ ', '').trim();
    }

    function formatMoney(valor) {
        if (valor == null) return 'R$ 0,00';
        let num = Number(valor);
        if (isNaN(num)) return 'R$ 0,00';
        return num.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    }

    // ===================================================================
    // FUNÇÃO CORRIGIDA: atualizarFuncionarioSelecionado
    // ===================================================================
    function atualizarFuncionarioSelecionado(formId) {
        const select = document.getElementById("funcionarioId");
        const form = document.getElementById(formId);

        // CORREÇÃO: Verifica se os elementos existem antes de acessar
        if (!select || !form) {
            console.warn(`Elementos não encontrados - select: ${!!select}, form: ${!!form}`);
            return;
        }

        const funcionarioId = select.value;
        const nomeFuncionario = select.options[select.selectedIndex].text.trim();

        const inputFuncId = form.querySelector('input[name="funcionarioId"]');
        const inputNomeFuncionario = form.querySelector('input[name="nomeFuncionario"]');

        if (inputFuncId) inputFuncId.value = funcionarioId;
        if (inputNomeFuncionario) inputNomeFuncionario.value = nomeFuncionario;
    }

    // ===================================================================
    // CÁLCULOS DE SALÁRIO
    // ===================================================================
    function calcularDescontosDisciplinares() {
        const vendaTotalInput = document.getElementById('venda_total');
        const inputFaltas = document.getElementById('inputFaltas');
        const inputSuspensoes = document.getElementById('inputSuspensoes');
        const descontosMesInput = document.getElementById('descontos_mes');

        if (!vendaTotalInput) return;

        let vendaTotal = parseFloat(vendaTotalInput.value || 0);
        if (isNaN(vendaTotal)) vendaTotal = parseFloat(removerMascara(vendaTotalInput.value)) || 0;

        const baseCalculo = vendaTotal * (comissao / 100);
        const valorDia = baseCalculo / 30;

        const totalFaltas = parseInt(inputFaltas?.getAttribute('data-faltas')) || 0;
        const totalSuspensoes = parseInt(inputSuspensoes?.getAttribute('data-suspensoes')) || 0;
        const totalDsr = parseInt(inputSuspensoes?.getAttribute('data-dsr')) || 0;

        const valorFaltas = totalFaltas * valorDia;
        const valorSuspensoes = (totalSuspensoes + totalDsr) * valorDia;
        const valorTotal = valorFaltas + valorSuspensoes;

        if (inputFaltas) inputFaltas.value = valorFaltas.toFixed(2);
        if (inputSuspensoes) inputSuspensoes.value = valorSuspensoes.toFixed(2);
        if (descontosMesInput) descontosMesInput.value = valorTotal.toFixed(2);
    }

    function calcularVendaTotal() {
        const ftTotal = parseFloat(document.getElementById('ft_total')?.value || 0);
        const encTotal = parseFloat(document.getElementById('enc_total')?.value || 0);
        const digTotal = parseFloat(document.getElementById('dig_total')?.value || 0);
        const vendaTotalInput = document.getElementById('venda_total');

        if (!vendaTotalInput) return;

        const vendaTotal = (ftTotal * conf1_valor) + (encTotal * conf2_valor) + (digTotal * conf3_valor);
        vendaTotalInput.value = vendaTotal.toFixed(2);
        vendaTotalInput.dispatchEvent(new Event('input'));
    }

    function calcularCustoFoto() {
        const difFotos = document.getElementById('dif_fotos');
        const descontoFotos = document.getElementById('desconto_fotos');

        if (!difFotos || !descontoFotos) return;

        const faltaFoto = parseFloat(difFotos.value || 0);
        const custoFoto = faltaFoto * conf1_valor;
        descontoFotos.value = custoFoto.toFixed(2);
        calcularSalariosLiquidos();
    }

    function calcularSalariosLiquidos() {
        const vendaTotalInput = document.getElementById('venda_total');
        const inssInput = document.getElementById('inss');
        const fgtsInput = document.getElementById('fgts');
        const valesInput = document.getElementById('vales_mes');
        const descontosInput = document.getElementById('descontos_mes');
        const atrasosInput = document.getElementById('atrasos_horas');
        const descontoFotos = document.getElementById('desconto_fotos');
        const salarioTotal1Input = document.getElementById('salario_total');
        const salarioTotal2Input = document.getElementById('salario_total2');
        const salarioLiquido1Input = document.getElementById('salario_liquido');
        const salarioLiquido2Input = document.getElementById('salario_liquido2');

        if (!vendaTotalInput) return;

        let vendaTotal = parseFloat(vendaTotalInput.value || 0);
        let inss = parseFloat(inssInput?.value || 0);
        let fgts = parseFloat(fgtsInput?.value || 0);
        let vales = parseFloat(valesInput?.value || 0);
        let descontos = parseFloat(descontosInput?.value || 0);
        let valorRibbon = parseFloat(descontoFotos?.value || 0);

        const horasAtraso = converterHorasParaDecimal(atrasosInput?.value || '0:00');
        const salarioBaseComissao = vendaTotal * (comissao / 100);
        const salarioHora = salarioBaseComissao / 220;
        const descontoAtraso = horasAtraso * salarioHora;

        const valorDescontoAtrasosInput = document.getElementById('valor_desconto_atrasos');
        if (valorDescontoAtrasosInput) {
            valorDescontoAtrasosInput.value = descontoAtraso.toFixed(2);
        }

        const salarioTotal1 = vendaTotal * (comissao / 100);
        const salarioTotal2 = vendaTotal * (comissao2 / 100);

        if (salarioTotal1Input) salarioTotal1Input.value = salarioTotal1.toFixed(2);
        if (salarioTotal2Input) salarioTotal2Input.value = salarioTotal2.toFixed(2);

        const descontos_1 = inss + vales + descontos + descontoAtraso + valorRibbon;
        const descontos_2 = inss + fgts + vales + descontos + descontoAtraso + valorRibbon;

        const descontos1Input = document.getElementById('descontos_1');
        const descontos2Input = document.getElementById('descontos_2');

        if (descontos1Input) descontos1Input.value = descontos_1.toFixed(2);
        if (descontos2Input) descontos2Input.value = descontos_2.toFixed(2);

        const salarioLiquido1 = salarioTotal1 - descontos_1;
        const salarioLiquido2 = salarioTotal2 - descontos_2;

        if (salarioLiquido1Input) {
            salarioLiquido1Input.value = salarioLiquido1.toLocaleString('pt-BR', {
                style: 'currency',
                currency: 'BRL'
            });
        }
        if (salarioLiquido2Input) {
            salarioLiquido2Input.value = salarioLiquido2.toLocaleString('pt-BR', {
                style: 'currency',
                currency: 'BRL'
            });
        }
    }

    // ===================================================================
    // EVENT LISTENERS
    // ===================================================================
    document.addEventListener('DOMContentLoaded', function() {
        // CORREÇÃO: Inicializar carregamento do relatório
        fetch('ServletRelVenda')
            .then(response => response.text())
            .then(data => {
                const resultadoEl = document.getElementById('resultado');
                if (resultadoEl) resultadoEl.innerHTML = data;
            })
            .catch(error => console.error('Erro:', error));

        // CORREÇÃO: Tentar atualizar funcionário se o formulário existir
        if (document.getElementById('formAdvertencia')) {
            atualizarFuncionarioSelecionado('formAdvertencia');
        }

        // Inicializar datas no modal
        const modal = document.getElementById('modalData');
        if (modal) {
            modal.addEventListener('shown.bs.modal', function () {
                if (!document.getElementById("dataInicial")?.value) {
                    initializeDates();
                }
            });
        }

        const dataInicialInput = document.getElementById("dataInicial");
        if (dataInicialInput) {
            dataInicialInput.addEventListener('change', setData);
        }

        // Event listeners para cálculos
        const vendaTotalInput = document.getElementById('venda_total');
        if (vendaTotalInput) {
            vendaTotalInput.addEventListener('input', function () {
                let vendaTotal = parseFloat(this.value);
                if (isNaN(vendaTotal)) {
                    vendaTotal = parseFloat(removerMascara(this.value)) || 0;
                }

                const inssInput = document.getElementById('inss');
                const parcelaInput = document.getElementById('parcela');
                const fgtsInput = document.getElementById('fgts');

                if (isNaN(vendaTotal) || vendaTotal <= 0) {
                    if (inssInput) inssInput.value = '0.00';
                    if (parcelaInput) parcelaInput.value = '0.00';
                    if (fgtsInput) fgtsInput.value = '0.00';
                    calcularSalariosLiquidos();
                    return;
                }

                const baseCalculo = vendaTotal * (comissao / 100);

                // Cálculo do INSS
                let aliquotaInss = 0;
                let parcelaDeduzir = 0;

                for (let faixa of faixasInss) {
                    if (baseCalculo >= faixa.min && baseCalculo <= faixa.max) {
                        aliquotaInss = faixa.aliquota / 100;
                        parcelaDeduzir = faixa.parcela || 0;
                        break;
                    }
                }

                if (aliquotaInss === 0 && baseCalculo > faixasInss[faixasInss.length - 1].max) {
                    const ultimaFaixa = faixasInss[faixasInss.length - 1];
                    aliquotaInss = ultimaFaixa.aliquota / 100;
                    parcelaDeduzir = ultimaFaixa.parcela || 0;
                }

                const valorInss = (baseCalculo * aliquotaInss) - parcelaDeduzir;
                if (inssInput) inssInput.value = valorInss.toFixed(2);
                if (parcelaInput) parcelaInput.value = parcelaDeduzir.toFixed(2);

                // Cálculo do FGTS
                const valorFgts = baseCalculo * (fgtsAliquota / 100);
                if (fgtsInput) fgtsInput.value = valorFgts.toFixed(2);

                calcularDescontosDisciplinares();
                calcularSalariosLiquidos();
            });
        }

        const valesInput = document.getElementById('vales_mes');
        const descontosInput = document.getElementById('descontos_mes');
        const atrasosInput = document.getElementById('atrasos_horas');
        const difFotos = document.getElementById('dif_fotos');

        if (valesInput) valesInput.addEventListener('input', calcularSalariosLiquidos);
        if (descontosInput) descontosInput.addEventListener('input', calcularSalariosLiquidos);
        if (atrasosInput) atrasosInput.addEventListener('input', calcularSalariosLiquidos);
        if (difFotos) difFotos.addEventListener('input', calcularCustoFoto);

        // Inicialização final
        calcularVendaTotal();

        const comissaoInput = document.getElementById('comissao');
        const comissao2Input = document.getElementById('comissao2');
        if (comissaoInput) comissaoInput.value = comissao.toFixed(2);
        if (comissao2Input) comissao2Input.value = comissao2.toFixed(2);

        calcularDescontosDisciplinares();
        calcularCustoFoto();

        // ===================================================================
        // BUSCA E EDIÇÃO DE SALÁRIOS
        // ===================================================================
        const btnBuscar = document.getElementById('btnBuscar');
        const btnSalvar = document.getElementById('btnSalvar');

        if (btnBuscar) {
            btnBuscar.addEventListener('click', realizarBusca);
        }

        if (btnSalvar) {
            btnSalvar.addEventListener('click', function() {
                if (confirm('Deseja realmente salvar as alterações?')) {
                    salvarEdicaoViaSubmit();
                }
            });
        }
    });

    // ===================================================================
    // FUNÇÕES DE DATA
    // ===================================================================
    function setData() {
        var dataInicial = document.getElementById("dataInicial")?.value;
        if (!dataInicial) return;

        var partesData = dataInicial.split('-');
        var ano = parseInt(partesData[0], 10);
        var mes = parseInt(partesData[1], 10) - 1;
        var dia = parseInt(partesData[2], 10);

        var data = new Date(ano, mes, dia);

        if (!isNaN(data.getTime())) {
            var ultimoDia = new Date(ano, mes + 1, 0);
            var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
            var mesFinal = String(mes + 1).padStart(2, '0');
            var dataFinal = ano + '-' + mesFinal + '-' + diaFinal;

            const dataFinalInput = document.getElementById("dataFinal");
            if (dataFinalInput) dataFinalInput.value = dataFinal;
        }
    }

    function initializeDates() {
        var today = new Date();
        var diaInicial = String(today.getDate()).padStart(2, '0');
        var mesInicial = String(today.getMonth() + 1).padStart(2, '0');
        var anoInicial = today.getFullYear();
        var dataInicial = anoInicial + '-' + mesInicial + '-' + diaInicial;

        var ultimoDia = new Date(anoInicial, today.getMonth() + 1, 0);
        var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
        var mesFinal = String(today.getMonth() + 1).padStart(2, '0');
        var dataFinal = anoInicial + '-' + mesFinal + '-' + diaFinal;

        const dataInicialInput = document.getElementById("dataInicial");
        const dataFinalInput = document.getElementById("dataFinal");

        if (dataInicialInput) dataInicialInput.value = dataInicial;
        if (dataFinalInput) dataFinalInput.value = dataFinal;
    }

    // ===================================================================
    // BUSCA DE SALÁRIOS
    // ===================================================================
    function realizarBusca() {
        const mes = document.getElementById('mes')?.value;
        const ano = document.getElementById('ano')?.value;
        const funcionarioId = document.getElementById('funcionarioIdBusca')?.value;
        const btnBuscar = document.getElementById('btnBuscar');
        const resultadoBusca = document.getElementById('resultadoBusca');
        const btnSalvar = document.getElementById('btnSalvar');

        if (!mes || !ano || !funcionarioId) {
            alert('Por favor, preencha todos os campos (Mês, Ano e Funcionário).');
            return;
        }

        if (btnBuscar) {
            btnBuscar.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Buscando...';
            btnBuscar.disabled = true;
        }

        if (resultadoBusca) resultadoBusca.style.display = 'none';
        if (btnSalvar) btnSalvar.style.display = 'none';

        const params = new URLSearchParams({
            acao: 'buscaSalario',
            mes: mes,
            ano: ano,
            funcionarioId: funcionarioId
        });

        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 2));

        fetch(contextPath + '/ServletSalarios?' + params.toString(), {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => Promise.reject(err));
                }
                return response.json();
            })
            .then(data => {
                if (Array.isArray(data) && data.length > 0) {
                    preencherResultadosParaEdicao(data[0]);
                    if (resultadoBusca) resultadoBusca.style.display = 'block';
                    if (btnSalvar) btnSalvar.style.display = 'inline-block';
                } else {
                    alert('Nenhum salário encontrado para os critérios informados.');
                }
            })
            .catch(error => {
                console.error('Erro na busca:', error);
                alert(error.erro || 'Erro ao buscar salário. Verifique os dados e tente novamente.');
            })
            .finally(() => {
                if (btnBuscar) {
                    btnBuscar.innerHTML = 'Exibir Resultados';
                    btnBuscar.disabled = false;
                }
            });
    }

    // ===================================================================
    // PREENCHER RESULTADOS PARA EDIÇÃO
    // ===================================================================
    function preencherResultadosParaEdicao(salario) {
        const meses = ['', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
            'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
        const mesAnoTexto = meses[salario.mes] + ' ' + salario.ano;

        setText('mesAnoResultado', mesAnoTexto.toUpperCase());

        // Campos ocultos
        setValue('idSalario', salario.idSalario);
        setValue('mesEdicao', salario.mes);
        setValue('anoEdicao', salario.ano);
        setValue('funcionarioIdEdicao', salario.funcionarioId);
        setValue('nomeEdicao', salario.nomeFuncionario);
        setValue('mesAnoHidden', mesAnoTexto);

        // Informações gerais
        setValue('nomeResultado', salario.nomeFuncionario);
        setValue('ft_totalResultado', salario.qtdFotos, true);
        setValue('dig_totalResultado', salario.qtdArquivos, true);
        setValue('sobrasResultado', salario.qtdSobras, true);
        setValue('aproveitamentoResultado', formatarNumeroParaInput(salario.aproveitamento));
        setValue('funcionarioIdResultado', salario.funcionarioId);

        // Conduta
        setValue('advertenciasResultado', salario.advertencias, true);
        setValue('faltasResultado', salario.faltas, true);
        setValue('suspensoesResultado', salario.suspensoes, true);
        setValue('dsrResultado', salario.dsr, true);

        // Descontos
        setValue('inputFaltasResultado', formatarNumeroParaInput(salario.valorFaltas));
        setValue('inputSuspensoesResultado', formatarNumeroParaInput(salario.valorSuspensoes));
        setValue('atrasos_horasResultado', formatarHoras(salario.atrasos));
        setValue('valor_desconto_atrasosResultado', formatarNumeroParaInput(salario.valorAtrasos));

        // Salários
        setValue('venda_totalResultado', formatarNumeroParaInput(salario.venda_total));
        setValue('vales_mesResultado', formatarNumeroParaInput(salario.vales));
        setValue('inssResultado', formatarNumeroParaInput(salario.inss));
        setValue('parcelaResultado', formatarNumeroParaInput(salario.parcela));
        setValue('fgtsResultado', formatarNumeroParaInput(salario.fgts));
        setValue('descontos_mesResultado', formatarNumeroParaInput(salario.descontos_mes));

        // Salário 1ª linha
        setValue('comissaoResultado', formatarNumeroParaInput(salario.comissao));
        setValue('salario_totalResultadoField', formatarNumeroParaInput(salario.salario_total));
        setValue('descontos_1Resultado', formatarNumeroParaInput(salario.descontos_1));
        setValue('salario_liquidoResultado', formatarNumeroParaInput(salario.salario_liquido1));

        // Salário 2ª linha
        setValue('comissao2Resultado', formatarNumeroParaInput(salario.comissao2));
        setValue('salario_total2Resultado', formatarNumeroParaInput(salario.salario_total2));
        setValue('descontos_2Resultado', formatarNumeroParaInput(salario.descontos_2));
        setValue('salario_liquido2Resultado', formatarNumeroParaInput(salario.salario_liquido2));
    }

    // ===================================================================
    // SALVAR EDIÇÃO
    // ===================================================================
    function salvarEdicaoViaSubmit() {
        const formEdicao = document.getElementById('formEdicao');

        if (!formEdicao) {
            alert('Erro: Formulário não encontrado.');
            return;
        }

        const idSalario = document.getElementById('idSalario');
        if (!idSalario || !idSalario.value || idSalario.value === '0') {
            alert('Erro: ID do salário não encontrado. Realize uma nova busca.');
            return;
        }

        const btnSalvar = document.getElementById('btnSalvar');
        if (btnSalvar) {
            btnSalvar.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Salvando...';
            btnSalvar.disabled = true;
        }

        formEdicao.submit();
    }

    // ===================================================================
    // FUNÇÕES AUXILIARES
    // ===================================================================
    function formatarNumeroParaInput(valor) {
        if (!valor && valor !== 0) return '';
        const numero = typeof valor === 'string' ? parseFloat(valor) : valor;
        if (isNaN(numero)) return '';
        return numero.toFixed(2);
    }

    function formatarHoras(valor) {
        if (!valor && valor !== 0) return '00:00';
        const horas = Math.floor(valor);
        const minutos = Math.round((valor - horas) * 60);
        return String(horas).padStart(2, '0') + ':' + String(minutos).padStart(2, '0');
    }

    function setValue(id, valor, zeroPorPadrao = false) {
        const el = document.getElementById(id);
        if (el) {
            el.value = valor !== undefined && valor !== null ? valor : (zeroPorPadrao ? '0' : '');
        }
    }

    function setText(id, texto) {
        const el = document.getElementById(id);
        if (el) {
            el.textContent = texto || '';
        }
    }
</script>
</body>
</html>
