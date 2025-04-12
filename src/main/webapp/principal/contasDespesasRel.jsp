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
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table">


                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                                <h4>Gerar Relatório</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modal2">
                                                <h4>Configurações de Materiais</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">
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
                                    <div class="modal fade" id="modalData" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">

                                                            <form action="<%= request.getContextPath() %>/ServletContasDespesasRel" method="get" id="formBuscaMes" name="formBuscaMes">
                                                                <input type="hidden" name="acao" value="gerarRelatorioMensal">
                                                                <div class="form-row align-items-center">
                                                                    <div class="col-auto">
                                                                        <label for="dataInicial">Data Inicial</label>
                                                                        <input type="date" class="form-control" id="dataInicial" name="dataInicial" required onchange="setData()" value="${dataInicial}">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <label for="dataFinal">Data Final</label>
                                                                        <input type="date" class="form-control" id="dataFinal" name="dataFinal" required value="${dataFinal}">
                                                                    </div>
                                                                    <div class="col-auto">
                                                                        <button type="submit" class="btn btn-primary">Imprimir Relatório</button>
                                                                    </div>
                                                                </div>
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
                                    <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticRanking">RANKING</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <div class="col-lg-6 grid-margin stretch-card">
                                                                <H5>CORPO DO RANKING</H5>
                                                            </div>




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
                                    <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticFinalizar">FINALIZAR</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <div class="col-lg-6 grid-margin stretch-card">
                                                                <H5>CORPO DA FINALIZAÇÃO</H5>
                                                            </div>




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

                <%--BLOCO 1                --%>
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
                               <div class="table-responsive">
                                    <div class="row">
                                        <div class="col-md-12 grid-margin">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h4 class="card-title" style="text-align: center">DESPESAS DO MÊS</h4>
                                                    <div style="height: 300px; overflow-y: auto;">

                                                        <table class="table" id="tabelareldespesas">
                                                            <thead>
                                                            <tr>
                                                                <th scope="col">Id</th>
                                                                <th scope="col">Nome Despesa</th>
                                                                <th scope="col">Descrição</th>
                                                                <th scope="col">Valor</th>
                                                                <th scope="col">Data</th>
                                                                <th scope="col">Forma de Pagamento</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach items="${despesasMes}" var="despesa">
                                                                <tr>
                                                                    <td><c:out value="${despesa.id_despesa}"/></td>
                                                                    <td><c:out value="${despesa.nome_despesa}"/></td>
                                                                    <td><c:out value="${despesa.descricao_despesa}"/></td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${despesa.valor_despesa}" type="currency" currencySymbol="R$" />
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatDate value="${despesa.data_despesa}" pattern="dd/MM/yyyy"/>
                                                                    </td>
                                                                    <td><c:out value="${despesa.pagamento_despesa}"/></td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>

                                                            <!-- Exibir o valor total das despesas -->
                                                            <tr>
                                                                <td colspan="6" style="font-weight: bold; color: #DAA520; font-size: 1.2rem; text-align: center;">
                                                                    Valor Total das Despesas:
                                                                    <fmt:formatNumber value="${valorTotalDespesas}" type="currency" currencySymbol="R$" />
                                                                </td>
                                                            </tr>

                                                        </table>



                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <%--PARTE 4--%>
                                    <div class="row">
                                        <div class="col-md-12 grid-margin">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h4 class="card-title" style="text-align: center">CONTAS DO MÊS</h4>
                                                    <table class="table">
                                                        <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Nº Pedido</th>
                                                            <th>Empresa</th>
                                                            <th>Itens</th>
                                                            <th>Valor</th>
                                                            <th>Pedido</th>
                                                            <th>Pagamento</th>
                                                            <th>Status</th>
                                                            <th>Pagamento</th>



                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="contas" items="${contasMes}">
                                                            <tr>

                                                                <td><c:out value="${contas.conta_id}"/></td>
                                                                <td><c:out
                                                                        value="${contas.numero_pedido}"/></td>
                                                                <td><c:out value="${contas.empresa}"/></td>
                                                                <td><c:out value="${contas.itens}"/></td>
                                                                <td><fmt:formatNumber value="${contas.valor}"
                                                                                      type="currency"
                                                                                      currencySymbol="R$"/></td>
                                                                <td><fmt:formatDate
                                                                        value="${contas.data_de_pedido}"
                                                                        pattern="dd/MM/yyyy"/></td>
                                                                <td><fmt:formatDate
                                                                        value="${contas.data_de_pagamento}"
                                                                        pattern="dd/MM/yyyy"/></td>
                                                                <td><c:out value="${contas.status}"/></td>
                                                                <td><c:out value="${contas.pagamento}"/></td>

                                                            </tr>
                                                        </c:forEach>
                                                        <tr>
                                                            <td colspan="9" style="font-weight: bold; color: #DAA520; font-size: 1.2rem; text-align: center;">
                                                                Valor Total das Contas:
                                                                <fmt:formatNumber value="${valorTotalContas}" type="currency" currencySymbol="R$" />
                                                            </td>
                                                        </tr>

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


                <%--BLOCO 2--%>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">MATERIAL</h4>
                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--BLOCO 3--%>

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">GERAIS</h4>
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



</SCRIPT>


</body>
</html>
