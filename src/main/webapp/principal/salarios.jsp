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
            <div class="content-wrapper" style="min-height: calc(98vh - 100px);">
                <div class="row">

                </div>
                <div class="row">
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
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">

                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <c:if test="${not empty msg}">
                                    <div>
                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                    </div>
                                </c:if>


                                <div class="row align-items-center mb-3">

                                    <div class="row align-items-center mb-3">

                                        <div class="col text-center">
                                            <h2 style="text-transform: uppercase; color: #d39e00">${mesAno}</h2>
                                        </div>
                                    </div>
                                </div>


                                <h4 class="card-title" style="text-align: center">VENDAS TOTAIS DO FUNCIONÁRIO</h4>

                                <div style="overflow-x: hidden; overflow-y: hidden;">

                                    <table class="table" id="tabelarelvendas">
                                        <thead>
                                        <tr>
                                            <th scope="col">NOME</th>
                                            <th scope="col">TOTAL DE FOTOS</th>
                                            <th scope="col">TOTAL DE ENCARTES</th>
                                            <th scope="col">TOTAL DE DIGITAIS</th>
                                            <th scope="col">TOTAL DE SOBRAS</th>
                                            <th scope="col">APROVEITAMENTO</th>
                                            <th scope="col">ID</th>


                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasFuncionarioList}" var="mv">
                                            <tr>
                                                <td><c:out value="${mv.nome}"></c:out></td>
                                                <td id="ft_total"><c:out value="${mv.ft_total}"/></td>
                                                <td id="enc_total"><c:out value="${mv.enc_total}"/></td>
                                                <td id="dig_total"><c:out value="${mv.dig_total}"/></td>
                                                <td><c:out value="${mv.sobras}"></c:out></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${mv.sobras + mv.ft_total > 0}">
                                                            <fmt:formatNumber value="${(mv.ft_total * 100) / (mv.sobras + mv.ft_total)}" maxFractionDigits="2" />%
                                                        </c:when>
                                                        <c:otherwise>
                                                            0%
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><c:out value="${funcionarioId}"></c:out></td>



                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>

                                    <!-- Controles de paginação -->
                                    <div class="pagination">
                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                            <a href="ServletSalarios?acao=imprimirRelatorioVendas&pagina=${i}"
                                               class="page-link ${i == paginaAtual ? 'active' : ''}">${i}</a>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            <%--parte 2--%>

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">


                                <h4 class="card-title" STYLE="text-align: center">HISTÓRICO DE CONDUTA</h4>

                                <div  style="overflow-x: hidden; overflow-y: hidden;">
                                    <table class="table" id="tabelafuncconduta">
                                        <thead>
                                        <tr>
                                            <th>ADVERTÊNCIAS</th>
                                            <th>FALTAS</th>
                                            <th>DIAS DE SUSPENSÃO</th>
                                            <th>DSR</th>
                                        </tr>
                                        </thead>

                                        <tbody>
                                        <c:if test="${not empty resumoConduta}">
                                            <tr>
                                                <td>${resumoConduta.totalAdvertencias}</td>
                                                <td>${resumoConduta.totalFaltas}</td>
                                                <td>${resumoConduta.totalDiasSuspensao}</td>
                                                <td>${resumoConduta.totalDsrSuspensao}</td>
                                            </tr>
                                        </c:if>
                                        </tbody>



                                    </table>
                                    <!-- Controles de paginação -->
                                    <div class="pagination">

                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                            <a href="ServletSalarios?acao=imprimirRelatorioVendas&pagina=${i}" class="page-link ${i == paginaAtual ? 'active' : ''}">${i}</a>
                                        </c:forEach>

                                    </div>

                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                    </table>
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
                                               id="salario_bruto" name="salario_bruto" value="${salario_bruto}" tabindex="-1">
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

                                    <div class="col-auto ms-3">
                                        <label style="color: #f2a654">SALÁRIO LÍQUIDO 2</label>
                                        <input type="text" class="form-control money text-center fw-bold"
                                               style="background-color: #f2a654; color: black"
                                               readonly tabindex="-1" id="salario_liquido2" name="salario_liquido2" value="${salario_liquido2}">
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
           aliquota: parseFloat('${configInss.inss_1}')
       },
       {
           min: parseFloat('${configInss.min_inss_2}'),
           max: parseFloat('${configInss.max_inss_2}'),
           aliquota: parseFloat('${configInss.inss_2}')
       },
       {
           min: parseFloat('${configInss.min_inss_3}'),
           max: parseFloat('${configInss.max_inss_3}'),
           aliquota: parseFloat('${configInss.inss_3}')
       },
       {
           min: parseFloat('${configInss.min_inss_4}'),
           max: parseFloat('${configInss.max_inss_4}'),
           aliquota: parseFloat('${configInss.inss_4}')
       }
   ];

   // === ELEMENTOS DO FORMULÁRIO ===
   const salarioInput = document.getElementById('salario_bruto');
   const inssInput = document.getElementById('inss');
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

       // Salário bruto e comissão
       let salarioBruto = parseFloat(salarioInput.value || 0);
       if (isNaN(salarioBruto)) salarioBruto = parseFloat(removerMascara(salarioInput.value)) || 0;

       const baseCalculo = salarioBruto * (comissao / 100);
       const valorDia = baseCalculo / 30;

       // Dados do backend
       const totalFaltas = parseInt(inputFaltas?.getAttribute('data-faltas')) || 0;
       const totalSuspensoes = parseInt(inputSuspensoes?.getAttribute('data-suspensoes')) || 0;
       const totalDsr = parseInt(inputSuspensoes?.getAttribute('data-dsr')) || 0;

       const valorFaltas = totalFaltas * valorDia;
       const valorSuspensoes = (totalSuspensoes + totalDsr) * valorDia;
       const valorTotal = valorFaltas + valorSuspensoes;

       if (inputFaltas) inputFaltas.value = valorFaltas.toFixed(2);
       if (inputSuspensoes) inputSuspensoes.value = valorSuspensoes.toFixed(2);

       if (descontosMesInput) {
           descontosMesInput.value = valorTotal.toFixed(2);
       }

       console.log('Descontos disciplinares calculados:', {
           salarioBruto,
           baseCalculo,
           valorDia,
           totalFaltas,
           totalSuspensoes,
           totalDsr,
           valorFaltas,
           valorSuspensoes,
           valorTotal
       });
   }

   // === Calcular salário bruto com base nos totais e valores configurados ===
   function calcularSalarioBruto() {
       const ftTotal = parseFloat(document.getElementById('ft_total')?.innerText || 0);
       const encTotal = parseFloat(document.getElementById('enc_total')?.innerText || 0);
       const digTotal = parseFloat(document.getElementById('dig_total')?.innerText || 0);

       const salarioBruto = (ftTotal * conf1_valor) + (encTotal * conf2_valor) + (digTotal * conf3_valor);
       salarioInput.value = salarioBruto.toFixed(2);

       // Dispara evento input para recalcular INSS, FGTS e salários líquidos
       salarioInput.dispatchEvent(new Event('input'));
   }

   // === Cálculo do INSS, FGTS e atualização dos salários líquidos ===
   salarioInput.addEventListener('input', function () {
       let salarioBruto = parseFloat(this.value);

       if (isNaN(salarioBruto)) {
           salarioBruto = parseFloat(removerMascara(this.value)) || 0;
       }

       if (isNaN(salarioBruto) || salarioBruto <= 0) {
           inssInput.value = '0.00';
           fgtsInput.value = '0.00';
           calcularSalariosLiquidos();
           return;
       }

       // Base para cálculo INSS e FGTS = salário_bruto * comissão
       const baseCalculo = salarioBruto * (comissao / 100);

       // Cálculo do INSS baseado nas faixas
       let aliquotaInss = 0;
       for (let faixa of faixasInss) {
           if (baseCalculo >= faixa.min && baseCalculo <= faixa.max) {
               aliquotaInss = faixa.aliquota / 100;
               break;
           }
       }
       if (aliquotaInss === 0 && baseCalculo > faixasInss[faixasInss.length - 1].max) {
           aliquotaInss = faixasInss[faixasInss.length - 1].aliquota / 100;
       }

       const valorInss = baseCalculo * aliquotaInss;
       inssInput.value = valorInss.toFixed(2);

       // Cálculo do FGTS
       const valorFgts = baseCalculo * (fgtsAliquota / 100);
       fgtsInput.value = valorFgts.toFixed(2);

       // Recalcula os descontos disciplinares quando o salário muda
       calcularDescontosDisciplinares();

       // Atualiza os salários líquidos
       calcularSalariosLiquidos();
   });

   // === Calcular salários líquidos considerando atrasos, vales, descontos e encargos ===
   function calcularSalariosLiquidos() {
       let salarioBruto = parseFloat(salarioInput.value || 0);
       let inss = parseFloat(inssInput.value || 0);
       let fgts = parseFloat(fgtsInput.value || 0);
       let vales = parseFloat(valesInput?.value || 0);

       // Tratamento dos descontos - agora mais simples já que vem do backend sem formatação
       let descontos = 0;
       if (descontosInput && descontosInput.value) {
           descontos = parseFloat(descontosInput.value) || 0;
       }

       // Cálculo do desconto por atraso (em horas)
       const horasAtraso = converterHorasParaDecimal(atrasosInput?.value || '0:00');
       const salarioBaseComissao = salarioBruto * (comissao / 100);
       const salarioHora = salarioBaseComissao / 220;
       const descontoAtraso = horasAtraso * salarioHora;

       // Atualiza campo visual com valor do desconto por atrasos
       const valorDescontoAtrasosInput = document.getElementById('valor_desconto_atrasos');
       if (valorDescontoAtrasosInput) {
           valorDescontoAtrasosInput.value = descontoAtraso.toLocaleString('pt-BR', {
               style: 'currency',
               currency: 'BRL'
           });
       }

       // Cálculo dos salários totais (bruto * comissão)
       const salarioTotal1 = salarioBruto * (comissao / 100);
       const salarioTotal2 = salarioBruto * (comissao2 / 100);

       // Atualiza os campos de salário total
       salarioTotal1Input.value = (salarioTotal1 || 0).toLocaleString('pt-BR', {
           style: 'currency',
           currency: 'BRL'
       });
       salarioTotal2Input.value = (salarioTotal2 || 0).toLocaleString('pt-BR', {
           style: 'currency',
           currency: 'BRL'
       });

       // Debug dos valores antes do cálculo
       console.log('Valores para cálculo:', {
           salarioBruto,
           comissao,
           comissao2,
           salarioTotal1,
           salarioTotal2,
           inss,
           fgts,
           vales,
           descontos,
           descontoAtraso
       });

       // Cálculo dos salários líquidos
       const salarioLiquido1 = salarioTotal1 - inss - vales - descontos - descontoAtraso;
       const salarioLiquido2 = salarioTotal2 - inss - fgts - vales - descontos - descontoAtraso;

       console.log('Salários líquidos calculados:', {
           salarioLiquido1,
           salarioLiquido2
       });

       salarioLiquido1Input.value = (salarioLiquido1 || 0).toLocaleString('pt-BR', {
           style: 'currency',
           currency: 'BRL'
       });
       salarioLiquido2Input.value = (salarioLiquido2 || 0).toLocaleString('pt-BR', {
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
       calcularSalarioBruto();
       comissaoInput.value = comissao.toFixed(2);
       comissao2Input.value = comissao2.toFixed(2);
       calcularDescontosDisciplinares();
   });


</script>
</body>
</html>
