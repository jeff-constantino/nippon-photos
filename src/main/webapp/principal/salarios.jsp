
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
                                                                                   style="background-color: white; color: black"
                                                                                   id="nomeResultado" readonly tabindex="-1">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE FOTOS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="ft_totalResultado" name="ft_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE DIGITAIS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="dig_totalResultado" name="dig_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">TOTAL DE SOBRAS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="sobrasResultado" name="sobras">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">APROVEITAMENTO</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="aproveitamentoResultado" name="aproveitamento">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">FUNCIONÁRIO ID</label>
                                                                            <input type="text" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
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
                                                                                   style="background-color: white; color: black"
                                                                                   id="advertenciasResultado" name="advertencias">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">FALTAS</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="faltasResultado" name="faltas">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">DIAS DE SUSPENSÃO</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="suspensoesResultado" name="suspensoes">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">DSR</label>
                                                                            <input type="number" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
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
                                                                                   style="background-color: white; color: black"
                                                                                   id="inputFaltasResultado" name="inputFaltas">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">VALOR DAS SUSPENSÕES + DSR</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
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
                                                                                   style="background-color: white; color: black"
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
                                                                                   style="background-color: white; color: black"
                                                                                   id="venda_totalResultado" name="venda_total">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">VALES</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="vales_mesResultado" name="vales_mes">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">INSS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="inssResultado" name="inss">
                                                                        </div>
                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">PARCELA A DEDUZIR</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="parcelaResultado" name="parcela">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">FGTS</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
                                                                                   id="fgtsResultado" name="fgts">
                                                                        </div>

                                                                        <div class="col-auto">
                                                                            <label style="color: #f2a654">DESCONTOS DISCIPLINARES</label>
                                                                            <input type="number" step="0.01" class="form-control text-center fw-bold"
                                                                                   style="background-color: white; color: black"
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
                                                                                   style="background-color: white; color: black"
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
                                                                                   style="background-color: white; color: black"
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
                                                   style="background-color: white; color: black"
                                                   name="nome" value="${mv.nome}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE FOTOS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: white; color: black"
                                                   id="ft_total" name="ft_total"
                                                   value="${mv.ft_total}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE ENCARTES</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: white; color: black"
                                                   id="enc_total" name="enc_total"
                                                   value="${mv.enc_total}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE DIGITAIS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: white; color: black"
                                                   id="dig_total" name="dig_total"
                                                   value="${mv.dig_total}" readonly tabindex="-1">
                                        </div>

                                        <div class="col-auto">
                                            <label style="color: #f2a654">TOTAL DE SOBRAS</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: white; color: black"
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
                                                   style="background-color: white; color: black"
                                                   value="<fmt:formatNumber value='${aproveitamento}' maxFractionDigits='2'/>%"
                                                   readonly tabindex="-1">

                                            <!-- input real para enviar no POST -->
                                            <input type="hidden" name="aproveitamento" value="${aproveitamento}" />
                                        </div>



                                        <div class="col-auto">
                                            <label style="color: #f2a654">FUNCIONÁRIO ID</label>
                                            <input type="text" class="form-control text-center fw-bold"
                                                   style="background-color: white; color: black"
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
                                               style="background-color: white; color: black"
                                               name="advertencias"
                                               value="${resumoConduta.totalAdvertencias}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">FALTAS</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: white; color: black"
                                               name="faltas"
                                               value="${resumoConduta.totalFaltas}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">DIAS DE SUSPENSÃO</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: white; color: black"
                                               name="suspensoes"
                                               value="${resumoConduta.totalDiasSuspensao}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">DSR</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: white; color: black"
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
                                               style="background-color: white; color: black"
                                               id="inputFaltas" name="inputFaltas"
                                               value="R$ 0,00"
                                               data-faltas="${resumoConduta.totalFaltas}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">VALOR DAS SUSPENSÕES + DSR</label>
                                        <input type="text" class="form-control text-center fw-bold"
                                               style="background-color: white; color: black"
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
                                               style="background-color: white; color: black"
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
                                               style="background-color: white; color: black"
                                               id="venda_total" name="venda_total" value="${venda_total}" tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">VALES</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: white; color: black"
                                               id="vales_mes" name="vales_mes" value="${vales_mes}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">INSS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: white; color: black"
                                               id="inss" name="inss" value="${inss}" readonly tabindex="-1">
                                    </div>
                                    <div class="col-auto">
                                        <label style="color: #f2a654">PARCELA A DEDUZIR</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: white; color: black"
                                               id="parcela" name="parcela" value="${parcela}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">FGTS</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: white; color: black"
                                               id="fgts" name="fgts" value="${fgts}" readonly tabindex="-1">
                                    </div>

                                    <div class="col-auto">
                                        <label style="color: #f2a654">DESCONTOS DISCIPLINARES</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: white; color: black"
                                               id="descontos_mes" name="descontos_mes" value="${descontos_mes}" readonly tabindex="-1">
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
                                               style="background-color: white; color: black"
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
                                               style="background-color: white; color: black"
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


    window.onload = function() {
        fetch('ServletRelVenda')
            .then(response => response.text())
            .then(data => {
                document.getElementById('resultado').innerHTML = data;
            })
            .catch(error => console.error('Erro:', error));
    }
    // Inicializa o tooltip com um delay reduzido para aparecer mais rápido
    $(document).ready(function(){
        $('#tooltipButton').tooltip({
            delay: { "show": 100, "hide": 100 } // O tooltip vai aparecer em 100ms
        });
    });


    function setData() {
        // Obtém o valor do campo dataInicial
        var dataInicial = document.getElementById("dataInicial").value;

        if (dataInicial) {
            // Divide a data inicial em dia, mês e ano
            var partesData = dataInicial.split('-'); // Assume que o formato é yyyy-mm-dd
            var ano = parseInt(partesData[0], 10);
            var mes = parseInt(partesData[1], 10) - 1; // Mês é 0-based no JavaScript
            var dia = parseInt(partesData[2], 10);

            // Cria um objeto Date com os valores extraídos
            var data = new Date(ano, mes, dia);

            // Verifica se a data é válida
            if (!isNaN(data.getTime())) {
                // Calcula o último dia do mês da data inicial
                var ultimoDia = new Date(ano, mes + 1, 0);

                // Formata a data final no padrão yyyy-mm-dd
                var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
                var mesFinal = String(mes + 1).padStart(2, '0'); // Ajusta o mês para exibição (1-12)
                var dataFinal = ano + '-' + mesFinal + '-' + diaFinal;

                // Define o valor do campo dataFinal
                document.getElementById("dataFinal").value = dataFinal;
            } else {
                console.error("Data inicial inválida.");
                document.getElementById("dataFinal").value = ""; // Limpa o campo se a data for inválida
            }
        } else {
            console.error("Data inicial não selecionada.");
            document.getElementById("dataFinal").value = ""; // Limpa o campo se a data inicial estiver vazia
        }
    }

    // Função para inicializar os campos de data ao abrir o modal
    function initializeDates() {
        // Obtém a data atual
        var today = new Date();

        // Formata a data inicial no padrão yyyy-mm-dd
        var diaInicial = String(today.getDate()).padStart(2, '0');
        var mesInicial = String(today.getMonth() + 1).padStart(2, '0');
        var anoInicial = today.getFullYear();
        var dataInicial = anoInicial + '-' + mesInicial + '-' + diaInicial;

        // Calcula o último dia do mês atual
        var ultimoDia = new Date(anoInicial, today.getMonth() + 1, 0);

        // Formata a data final no padrão yyyy-mm-dd
        var diaFinal = String(ultimoDia.getDate()).padStart(2, '0');
        var mesFinal = String(today.getMonth() + 1).padStart(2, '0'); // Usa o mês da data inicial
        var anoFinal = today.getFullYear();
        var dataFinal = anoFinal + '-' + mesFinal + '-' + diaFinal;

        // Define os valores dos campos
        document.getElementById("dataInicial").value = dataInicial;
        document.getElementById("dataFinal").value = dataFinal;
    }

    // Inicializa os campos de data quando o modal é aberto
    document.addEventListener('DOMContentLoaded', function () {
        const modal = document.getElementById('modalData'); // Substitua 'meuModal' pelo ID do seu modal
        if (modal) {
            modal.addEventListener('shown.bs.modal', function () {
                // Verifica se os campos já foram inicializados
                if (!document.getElementById("dataInicial").value) {
                    initializeDates();
                }
            });
        }

        // Adiciona o evento onchange ao campo dataInicial
        document.getElementById("dataInicial").addEventListener('change', setData);
    });

    function atualizarFuncionarioSelecionado(formId) {
        const select = document.getElementById("funcionarioId");
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

    // *******************************************************************
    // === CONFIGURAÇÕES DO BACKEND ===
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

    // === ELEMENTOS DO FORMULÁRIO ===
    const vendaTotalInput = document.getElementById('venda_total');
    const inssInput = document.getElementById('inss');
    const parcelaInput = document.getElementById('parcela')
    const fgtsInput = document.getElementById('fgts');
    const comissaoInput = document.getElementById('comissao');
    const comissao2Input = document.getElementById('comissao2');
    const salarioTotal1Input = document.getElementById('salario_total');
    const salarioTotal2Input = document.getElementById('salario_total2');
    const salarioLiquido1Input = document.getElementById('salario_liquido');
    const salarioLiquido2Input = document.getElementById('salario_liquido2');
    const valesInput = document.getElementById('vales_mes');
    const descontosInput = document.getElementById('descontos_mes');
    const atrasosInput = document.getElementById('atrasos_horas');

    // === Função para converter HH:MM em horas decimais ===
    function converterHorasParaDecimal(horasMinutos) {
        if (!horasMinutos) return 0;
        const partes = horasMinutos.split(':');
        const horas = parseInt(partes[0], 10) || 0;
        const minutos = parseInt(partes[1], 10) || 0;
        return horas + (minutos / 60);
    }

    // === Função para remover máscara e tratar valores numéricos ===
    function removerMascara(valor) {
        if (!valor || typeof valor !== 'string') return '0';
        return valor.replace(/\./g, '').replace(',', '.').replace('R$ ', '').trim();
    }

    // === Calcular descontos disciplinares ===
    function calcularDescontosDisciplinares() {
        const inputFaltas = document.getElementById('inputFaltas');
        const inputSuspensoes = document.getElementById('inputSuspensoes');
        const descontosMesInput = document.getElementById('descontos_mes');

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

        // Valores sem formatação monetária
        if (inputFaltas) inputFaltas.value = valorFaltas.toFixed(2);
        if (inputSuspensoes) inputSuspensoes.value = valorSuspensoes.toFixed(2);

        if (descontosMesInput) {
            descontosMesInput.value = valorTotal.toFixed(2);
        }


    }

    // === Calcular salário bruto com base nos totais e valores configurados ===
    function calcularVendaTotal() {
        const ftTotal = parseFloat(document.getElementById('ft_total')?.value || 0);
        const encTotal = parseFloat(document.getElementById('enc_total')?.value || 0);
        const digTotal = parseFloat(document.getElementById('dig_total')?.value || 0);

        const vendaTotal = (ftTotal * conf1_valor) + (encTotal * conf2_valor) + (digTotal * conf3_valor);
        vendaTotalInput.value = vendaTotal.toFixed(2);

        // Dispara evento input para recalcular INSS, FGTS e salários líquidos
        vendaTotalInput.dispatchEvent(new Event('input'));
    }

    // === Cálculo do INSS, FGTS e atualização dos salários líquidos ===
    vendaTotalInput.addEventListener('input', function () {
        let vendaTotal = parseFloat(this.value);

        if (isNaN(vendaTotal)) {
            vendaTotal = parseFloat(removerMascara(this.value)) || 0;
        }

        if (isNaN(vendaTotal) || vendaTotal <= 0) {
            inssInput.value = '0.00';
            parcelaInput.value = '0.00'
            fgtsInput.value = '0.00';
            calcularSalariosLiquidos();
            return;
        }

        // Base para cálculo INSS e FGTS = salário_bruto * comissão
        const baseCalculo = vendaTotal * (comissao / 100);

        // Cálculo do INSS baseado nas faixas
        let aliquotaInss = 0;
        let parcelaDeduzir = 0;

        for (let faixa of faixasInss) {
            if (baseCalculo >= faixa.min && baseCalculo <= faixa.max) {
                aliquotaInss = faixa.aliquota / 100;
                parcelaDeduzir = faixa.parcela || 0;
                break;
            }
        }

// Caso ultrapasse todas as faixas, usa última faixa como padrão
        if (aliquotaInss === 0 && baseCalculo > faixasInss[faixasInss.length - 1].max) {
            const ultimaFaixa = faixasInss[faixasInss.length - 1];
            aliquotaInss = ultimaFaixa.aliquota / 100;
            parcelaDeduzir = ultimaFaixa.parcela || 0;
        }

        const valorInss = (baseCalculo * aliquotaInss) - parcelaDeduzir;
        inssInput.value = valorInss.toFixed(2);
        parcelaInput.value = parcelaDeduzir.toFixed(2);


         // Cálculo do FGTS
        const valorFgts = baseCalculo * (fgtsAliquota / 100);
        fgtsInput.value = valorFgts.toFixed(2);

        // Recalcula os descontos disciplinares quando o salário muda
        calcularDescontosDisciplinares();

        // Atualiza os salários líquidos
        calcularSalariosLiquidos();
    });

    function calcularSalariosLiquidos() {
        let vendaTotal = parseFloat(vendaTotalInput.value || 0);
        let inss = parseFloat(inssInput.value || 0);
        let parcela = parseFloat(parcelaInput.value || 0);
        let fgts = parseFloat(fgtsInput.value || 0);
        let vales = parseFloat(valesInput?.value || 0);

        let descontos = 0;
        if (descontosInput && descontosInput.value) {
            descontos = parseFloat(descontosInput.value) || 0;
        }

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

        salarioTotal1Input.value = salarioTotal1.toFixed(2);
        salarioTotal2Input.value = salarioTotal2.toFixed(2);

        const descontos_1 = inss + vales + descontos + descontoAtraso;
        const descontos_2 = inss + fgts + vales + descontos + descontoAtraso;

        // Atualiza os campos descontos_1 e descontos_2 sem formatação
        const descontos1Input = document.getElementById('descontos_1');
        if (descontos1Input) {
            descontos1Input.value = descontos_1.toFixed(2);
        }
        const descontos2Input = document.getElementById('descontos_2');
        if (descontos2Input) {
            descontos2Input.value = descontos_2.toFixed(2);
        }

        const salarioLiquido1 = salarioTotal1 - descontos_1;
        const salarioLiquido2 = salarioTotal2 - descontos_2;

        salarioLiquido1Input.value = salarioLiquido1.toLocaleString('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        });
        salarioLiquido2Input.value = salarioLiquido2.toLocaleString('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        });
    }


    // === Eventos para recalcular salários líquidos ao alterar vales, descontos ou atrasos ===
    valesInput?.addEventListener('input', function() {
        calcularSalariosLiquidos();
    });

    descontosInput?.addEventListener('input', function() {
        calcularSalariosLiquidos();
    });

    atrasosInput?.addEventListener('input', function() {
        calcularSalariosLiquidos();
    });

    // === Inicialização ===
    window.addEventListener('DOMContentLoaded', () => {
        calcularVendaTotal();
        comissaoInput.value = comissao.toFixed(2);
        comissao2Input.value = comissao2.toFixed(2);
        calcularDescontosDisciplinares();
    });
    // Formatação de dinheiro simples (R$ 0,00)
    function formatMoney(valor) {
        if (valor == null) return 'R$ 0,00';
        let num = Number(valor);
        if (isNaN(num)) return 'R$ 0,00';
        return num.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    }

    document.addEventListener('DOMContentLoaded', function() {
        const btnBuscar = document.getElementById('btnBuscar');
        const btnSalvar = document.getElementById('btnSalvar');
        const resultadoBusca = document.getElementById('resultadoBusca');
        const formEdicao = document.getElementById('formEdicao');

        // Evento para buscar
        if (btnBuscar) {
            btnBuscar.addEventListener('click', function() {
                realizarBusca();
            });
        }

        // Evento para salvar edição - USANDO SUBMIT TRADICIONAL
        if (btnSalvar) {
            btnSalvar.addEventListener('click', function() {
                if (confirm('Deseja realmente salvar as alterações?')) {
                    salvarEdicaoViaSubmit();
                }
            });
        }

        function realizarBusca() {
            const mes = document.getElementById('mes').value;
            const ano = document.getElementById('ano').value;
            const funcionarioId = document.getElementById('funcionarioIdBusca').value;

            // Validação dos campos
            if (!mes || !ano || !funcionarioId) {
                alert('Por favor, preencha todos os campos (Mês, Ano e Funcionário).');
                return;
            }

            // Mostrar loading
            btnBuscar.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Buscando...';
            btnBuscar.disabled = true;

            // Ocultar resultados anteriores
            resultadoBusca.style.display = 'none';

            // Ocultar botão salvar
            if (btnSalvar) {
                btnSalvar.style.display = 'none';
            }

            // Fazer requisição AJAX
            const params = new URLSearchParams({
                acao: 'buscaSalario',
                mes: mes,
                ano: ano,
                funcionarioId: funcionarioId
            });

            // CORRIGIDO: Removido o JSP scriptlet que não funciona no JavaScript
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
                        resultadoBusca.style.display = 'block';

                        // Mostrar botão salvar
                        if (btnSalvar) {
                            btnSalvar.style.display = 'inline-block';
                        }
                    } else {
                        alert('Nenhum salário encontrado para os critérios informados.');
                    }
                })
                .catch(error => {
                    console.error('Erro na busca:', error);
                    if (error.erro) {
                        alert('Erro: ' + error.erro);
                    } else {
                        alert('Erro ao buscar salário. Verifique os dados e tente novamente.');
                    }
                })
                .finally(() => {
                    // Restaurar botão
                    btnBuscar.innerHTML = 'Exibir Resultados';
                    btnBuscar.disabled = false;
                });
        }

        // Função modificada para preencher os campos para edição
        function preencherResultadosParaEdicao(salario) {
            const meses = ['', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
                'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
            const mesAnoTexto = meses[salario.mes] + ' ' + salario.ano;

            setText('mesAnoResultado', mesAnoTexto.toUpperCase());

            // Preencher campos ocultos para edição
            setValue('idSalario', salario.idSalario);
            setValue('mesEdicao', salario.mes);
            setValue('anoEdicao', salario.ano);
            setValue('funcionarioIdEdicao', salario.funcionarioId);
            setValue('nomeEdicao', salario.nomeFuncionario);
            setValue('mesAnoHidden', mesAnoTexto);

            // Informações Gerais
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

            // Descontos - valores para input (sem formatação)
            setValue('inputFaltasResultado', formatarNumeroParaInput(salario.valorFaltas));
            setValue('inputSuspensoesResultado', formatarNumeroParaInput(salario.valorSuspensoes));
            setValue('atrasos_horasResultado', formatarHoras(salario.atrasos));
            setValue('valor_desconto_atrasosResultado', formatarNumeroParaInput(salario.valorAtrasos));

            // Salários e Benefícios - valores para input (sem formatação)
            setValue('venda_totalResultado', formatarNumeroParaInput(salario.venda_total));
            setValue('vales_mesResultado', formatarNumeroParaInput(salario.vales));
            setValue('inssResultado', formatarNumeroParaInput(salario.inss));
            setValue('parcelaResultado', formatarNumeroParaInput(salario.parcela));
            setValue('fgtsResultado', formatarNumeroParaInput(salario.fgts));
            setValue('descontos_mesResultado', formatarNumeroParaInput(salario.descontos_mes));

            // Salário 1ª linha - valores para input (sem formatação)
            setValue('comissaoResultado', formatarNumeroParaInput(salario.comissao));
            setValue('salario_totalResultadoField', formatarNumeroParaInput(salario.salario_total));
            setValue('descontos_1Resultado', formatarNumeroParaInput(salario.descontos_1));
            setValue('salario_liquidoResultado', formatarNumeroParaInput(salario.salario_liquido1));

            // Salário 2ª linha - valores para input (sem formatação)
            setValue('comissao2Resultado', formatarNumeroParaInput(salario.comissao2));
            setValue('salario_total2Resultado', formatarNumeroParaInput(salario.salario_total2));
            setValue('descontos_2Resultado', formatarNumeroParaInput(salario.descontos_2));
            setValue('salario_liquido2Resultado', formatarNumeroParaInput(salario.salario_liquido2));
        }

        // NOVA FUNÇÃO: Salvar usando fetch (com correções baseadas no submit que funciona)
        function salvarEdicaoViaForm() {
            console.log('=== SALVANDO VIA FORM ===');

            // Verificar se o form existe
            if (!formEdicao) {
                console.error('Formulário de edição não encontrado!');
                alert('Erro: Formulário não encontrado.');
                return;
            }

            // Verificar se os campos obrigatórios existem
            const idSalario = document.getElementById('idSalario');
            if (!idSalario || !idSalario.value || idSalario.value === '0') {
                console.error('ID do salário não encontrado ou é 0');
                alert('Erro: ID do salário não encontrado. Realize uma nova busca.');
                return;
            }

            console.log('ID do salário:', idSalario.value);

            // Mostrar loading no botão
            const textoOriginal = btnSalvar.innerHTML;
            btnSalvar.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Salvando...';
            btnSalvar.disabled = true;

            // Criar FormData a partir do formulário
            const formData = new FormData(formEdicao);

            // DEBUG: Verificar os dados que serão enviados
            console.log('=== DADOS DO FORMULÁRIO ===');
            for (let pair of formData.entries()) {
                console.log(pair[0] + ': ' + pair[1]);
            }

            // CORREÇÃO: Usar a mesma URL do action do form
            const url = formEdicao.action || (window.location.origin + window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/')) + '/ServletSalarios');
            console.log('URL do servlet:', url);

            // Enviar dados via fetch - SEM HEADERS DESNECESSÁRIOS
            fetch(url, {
                method: 'POST',
                body: formData
                // Removido headers - deixar o browser definir automaticamente
            })
                .then(response => {
                    console.log('=== RESPOSTA RECEBIDA ===');
                    console.log('Status:', response.status);
                    console.log('OK:', response.ok);

                    if (response.ok) {
                        console.log('Resposta OK - operação bem-sucedida');
                        alert('Salário atualizado com sucesso!');

                        // Opcional: fechar o modal
                        const modalElement = document.getElementById('modalBusca');
                        if (modalElement && typeof bootstrap !== 'undefined') {
                            const modal = bootstrap.Modal.getInstance(modalElement);
                            if (modal) {
                                modal.hide();
                                console.log('Modal fechado');
                            }
                        }
                    } else {
                        console.error('Resposta não OK:', response.status, response.statusText);
                        // Tentar ler a resposta como texto para obter mais detalhes do erro
                        return response.text().then(text => {
                            console.error('Resposta do servidor:', text);
                            throw new Error(`Erro ${response.status}: ${response.statusText}`);
                        });
                    }
                })
                .catch(error => {
                    console.error('=== ERRO NO FETCH ===');
                    console.error('Tipo do erro:', error.name);
                    console.error('Mensagem:', error.message);
                    console.error('Stack:', error.stack);
                    alert('Erro ao salvar as alterações: ' + error.message);
                })
                .finally(() => {
                    console.log('=== FINALIZANDO ===');
                    // Restaurar botão
                    btnSalvar.innerHTML = textoOriginal;
                    btnSalvar.disabled = false;
                    console.log('Botão restaurado');
                });
        }

        // FUNÇÃO PRINCIPAL: Salvar usando submit tradicional do form
        function salvarEdicaoViaSubmit() {
            console.log('=== SALVANDO VIA SUBMIT ===');

            if (!formEdicao) {
                console.error('Formulário de edição não encontrado!');
                alert('Erro: Formulário não encontrado.');
                return;
            }

            const idSalario = document.getElementById('idSalario');
            if (!idSalario || !idSalario.value || idSalario.value === '0') {
                console.error('ID do salário não encontrado ou é 0');
                alert('Erro: ID do salário não encontrado. Realize uma nova busca.');
                return;
            }

            // Mostrar loading no botão
            const textoOriginal = btnSalvar.innerHTML;
            btnSalvar.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Salvando...';
            btnSalvar.disabled = true;

            // Usar submit tradicional
            console.log('Submetendo formulário...');
            formEdicao.submit();

            // Nota: O loading será restaurado quando a página recarregar/redirecionar
        }

        // Função para formatar número para input (sem formatação visual)
        function formatarNumeroParaInput(valor) {
            if (!valor && valor !== 0) return '';
            const numero = typeof valor === 'string' ? parseFloat(valor) : valor;
            if (isNaN(numero)) return '';
            return numero.toFixed(2);
        }

        // Auxiliares seguros
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

        function formatarMoeda(valor) {
            if (!valor && valor !== 0) return 'R$ 0,00';

            const numero = typeof valor === 'string' ? parseFloat(valor) : valor;
            if (isNaN(numero)) return 'R$ 0,00';

            return 'R$ ' + numero.toLocaleString('pt-BR', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });
        }

        function formatarPercentual(valor) {
            if (!valor && valor !== 0) return '0%';

            const numero = typeof valor === 'string' ? parseFloat(valor) : valor;
            if (isNaN(numero)) return '0%';

            return numero.toLocaleString('pt-BR', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }) + '%';
        }

        function formatarAproveitamento(valor) {
            if (!valor && valor !== 0) return '0,00%';

            const numero = typeof valor === 'string' ? parseFloat(valor) : valor;
            if (isNaN(numero)) return '0,00%';

            return numero.toLocaleString('pt-BR', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            }) + '%';
        }

        function formatarHoras(valor) {
            if (!valor && valor !== 0) return '00:00';

            // Assumindo que o valor está em horas decimais (ex: 1.5 = 1h30min)
            const horas = Math.floor(valor);
            const minutos = Math.round((valor - horas) * 60);

            return String(horas).padStart(2, '0') + ':' + String(minutos).padStart(2, '0');
        }

        // EXPOSIÇÃO GLOBAL para debug (opcional)
        window.debugSalarios = {
            salvarViaForm: salvarEdicaoViaForm,
            salvarViaSubmit: salvarEdicaoViaSubmit,
            formEdicao: formEdicao
        };
    });








</script>
</body>
</html>
