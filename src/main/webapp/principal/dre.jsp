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
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalDRE">
                                                <h4>Gerar DRE</h4>
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
                                    <div class="modal fade" id="modalDRE" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticBackdropLabel">Vendas do dia</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="<%= request.getContextPath() %>/ServletDre" method="get" id="formDre" name="formDre">
                                                        <input type="hidden" name="acao" value="relatorioMes">
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
<%--CONTEUDO PAGINA--%>
                <div class="row">
                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RECEITAS OPERACIONAIS</h4>
                                <!-- Table Content -->
                                <div style="overflow-x: hidden; overflow-y: hidden"  class="table-responsive">
                                    <table class="table table-bordered" id="tabelaReceita" >
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col" style="font-size: 1.2rem">TIPO</th>
                                            <th scope="col" style="font-size: 1.2rem">VALOR</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="receitaDinheiro" value="0" />
                                        <c:set var="receitaDebito" value="0" />
                                        <c:set var="receitaCredito" value="0" />
                                        <c:set var="receitaPix" value="0" />
                                        <c:set var="impostos" value="0" />
                                        <c:set var="receitaBruta" value="0" />

                                        <c:forEach items="${vendasMesList}" var="vl">
                                            <tr>
                                                <td style="font-size: 1.2rem">Dinheiro</td>
                                                <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_din_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 1.2rem">Débito</td>
                                                <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_deb_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 1.2rem">Crédito</td>
                                                <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_cred_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 1.2rem">Pix</td>
                                                <td style="font-size: 1.2rem"><fmt:formatNumber value="${vl.valor_pix_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <c:set var="receitaDinheiro" value="${receitaDinheiro+ vl.valor_din_mes}" />
                                            <c:set var="receitaDebito" value="${receitaDebito + vl.valor_deb_mes}" />
                                            <c:set var="receitaCredito" value="${receitaCredito + vl.valor_cred_mes}" />
                                            <c:set var="receitaPix" value="${receitaPix + vl.valor_pix_mes}" />
                                            <tr>
                                                <td style="font-size: 1.2rem">Receita Bruta</td>
                                                <td style="font-size: 1.2rem"><fmt:formatNumber value="${receitaDinheiro + receitaDebito + receitaCredito + receitaPix}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">DESPESAS OPERACIONAIS</h4>
                                <!-- Table Content -->
                                <div style="overflow-x: hidden; overflow-y: hidden"  class="table-responsive">
                                    <table class="table table-bordered" id="tabelaDespesas">
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col" style="font-size: 1.2rem">TIPO</th>
                                            <th scope="col" style="font-size: 1.2rem">VALOR</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="ribbons" value="0" />
                                        <c:set var="encartes" value="0" />
                                        <c:set var="jurosCartoes" value="0" />
                                        <c:set var="despesasOperacionais" value="0" />
                                        <c:set var="lucroBruto" value="0" />

                                        <c:forEach items="${vendasMesList}" var="vl">

                                            <tr>
                                                <td style="font-size: 1.2rem">Ribbons</td>
                                                <td style="font-size: 1.2rem">
                                                    <fmt:formatNumber value="${vl.total_ribbons}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="font-size: 1.2rem">Encartes</td>
                                                <td style="font-size: 1.2rem">
                                                    <fmt:formatNumber value="${vl.valor_enc}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="font-size: 1.2rem">Juros dos Cartões</td>
                                                <td style="font-size: 1.2rem">
                                                    <fmt:formatNumber value="${vl.juros_cartoes}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="font-size: 1.2rem">Despesas Operacionais</td>
                                                <td style="font-size: 1.2rem">
                                                    <fmt:formatNumber value="${vl.total_ribbons + vl.valor_enc + vl.juros_cartoes}" type="currency" currencySymbol="R$" />
                                                </td>
                                            </tr>

                                        </c:forEach>

                                        </tbody>
                                        <tfoot>

                                        </tfoot>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <form method="post" action="<%=request.getContextPath()%>/ServletFechaMes">
                                    <h4 class="card-title" style="text-align: center">DESPESAS ADMINISTRATIVAS</h4>
                                    <!-- Table Content -->
                                    <div style="overflow-x: hidden; overflow-y: hidden">
                                        <table class="table table-bordered" id="tabelavalorescontames">
                                            <div class="row">

                                                <div class="col-6 mb-3">
                                                    <label for="icms" style="font-size: 0.8rem;">ICMS</label>
                                                    <input type="text" class="form-control money" id="icms" name="icms" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="pis" style="font-size: 0.8rem;">PIS</label>
                                                    <input type="text" class="form-control money" id="pis" name="pis" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="cofins" style="font-size: 0.8rem;">COFINS</label>
                                                    <input type="text" class="form-control money" id="cofins" name="cofins" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="inss" style="font-size: 0.8rem;">INSS</label>
                                                    <input type="text" class="form-control money" id="inss" name="inss" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="irpj" style="font-size: 0.8rem;">IRPJ</label>
                                                    <input type="text" class="form-control money" id="irpj" name="irpj" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="csll" style="font-size: 0.8rem;">CSLL</label>
                                                    <input type="text" class="form-control money" id="csll" name="csll" style="font-size: 0.8rem;">
                                                </div>

                                                <div class="col-6 mb-3">
                                                    <label for="aluguel" style="font-size: 0.8rem;">Aluguel</label>
                                                    <input type="text" class="form-control money" id="aluguel" name="aluguel" style="font-size: 0.8rem;">

                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="salarios" style="font-size: 0.8rem;">Salários</label>
                                                    <input type="text" class="form-control money" id="salarios" name="salarios" style="font-size: 0.8rem;">
                                                </div>

                                                <div class="col-6 mb-3">
                                                    <label for="contas" style="font-size: 0.8rem;">Contas</label>
                                                    <input type="text" class="form-control money" id="contas" name="contas" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="despesasGerais" style="font-size: 0.8rem;">Depesas Gerais</label>
                                                    <input type="text" class="form-control money" id="despesasGerais" name="despesasGerais" style="font-size: 0.8rem;">
                                                </div>

                                                <div class="col-6 mb-3">
                                                    <label for="bonificacoes" style="font-size: 0.8rem;">Bonificações</label>
                                                    <input type="text" class="form-control money" id="bonificacoes" name="bonificacoes" style="font-size: 0.8rem;">
                                                </div>
                                                <div class="col-6 mb-3">
                                                    <label for="prestacoes" style="font-size: 0.8rem;">Prestações de Equipamentos</label>
                                                    <input type="text" class="form-control money" id="prestacoes" name="prestacoes" style="font-size: 0.8rem;">
                                                </div>

                                                <div class="col-6 mb-3">
                                                    <label for="debitoVm" style="font-size: 0.8rem;">Outras Despesas</label>
                                                    <input type="text" class="form-control money" id="debitoVm" name="debitoVm"  style="font-size: 0.8rem;">
                                                </div>

                                            </div>


                                        </table>
                                        <div style="align-items: center">

                                            <button type="submit" class="btn btn-outline-success" STYLE="font-size: large">
                                                Gravar Fechamento do Mês
                                            </button>
                                        </div>
                                    </div>
                                </form>
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
       const modal = document.getElementById('modalDRE'); // Substitua 'meuModal' pelo ID do seu modal
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
