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
                                            <!-- Modal para INSERIR VALE -->
                                            <div class="modal fade" id="modalVales" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                        <div class="modal-body">

                                                            <c:if test="${not empty msg}">
                                                                <div>
                                                                    <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                </div>
                                                            </c:if>

                                                            <form action="<%= request.getContextPath() %>/ServletVales" method="post" id="formInserirVale">
                                                                <input type="hidden" name="acao" value="inserirVale">


                                                                <div class="row">
                                                                   <div class="col-4">
                                                                        <label for="data">Data</label>
                                                                        <input type="date" class="form-control" id="data" name="data" value="${data}">
                                                                    </div>

                                                                    <div class="col-4">
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
                                                                        <!-- CAMPO HIDDEN PARA O NOME -->
                                                                        <input type="hidden" name="nome_funcionario" id="nome_funcionario">
                                                                    </div>
                                                                </div>

                                                                <div class="row mt-3">
                                                                    <div class="col-4">
                                                                        <label>Observação:</label>
                                                                        <input type="text" class="form-control" name="observacao" id="observacao"
                                                                               style="background-color: white; color: black; text-transform: uppercase;"
                                                                               value="${observacao}">
                                                                    </div>

                                                                    <div class="col-4">
                                                                        <label>Forma de Pagamento</label>
                                                                        <select class="form-control" name="forma_pagamento" id="forma_pagamento">
                                                                            <option value="DINHEIRO">DINHEIRO</option>
                                                                            <option value="PIX">PIX</option>
                                                                        </select>
                                                                    </div>

                                                                    <div class="col-4">
                                                                        <label>Valor:</label>
                                                                        <input type="number" class="form-control" name="valor" id="valor"
                                                                               style="background-color: black; color: #DAA520" value="${valor}">
                                                                    </div>
                                                                </div>

                                                                <div class="row mt-3">
                                                                    <div class="col-auto">
                                                                        <button type="submit" class="btn btn-outline-success">LANÇAR VALE</button>
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




                    <div class="col-sm-4 grid-margin">



                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!-- Modal -->
                                    <!-- Modal Vales -->
                                    <!-- Modal para CONSULTAR VALES -->
                                    <div class="modal fade" id="modalData" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-body">

                                                    <form action="<%= request.getContextPath() %>/ServletVales" method="get" id="formBuscaVales">
                                                        <input type="hidden" name="acao" value="buscarValesPorData">

                                                        <div class="row mb-3">
                                                            <div class="col-md-4">
                                                                <label for="dataInicial">Data Inicial</label>
                                                                <input type="date" class="form-control" name="dataInicial" id="dataInicial" value="${param.dataInicial != null ? param.dataInicial : ''}" required>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label for="dataFinal">Data Final</label>
                                                                <input type="date" class="form-control" name="dataFinal" id="dataFinal" value="${param.dataFinal != null ? param.dataFinal : ''}"  required>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label for="funcionarioId">Funcionário</label>
                                                                <select class="form-control" id="funcionarioIdbusca" name="funcionarioId" required>
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
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-auto">
                                                                <button type="submit" class="btn btn-outline-info">Buscar Vales</button>
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
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalVales">
                                    <h4>Lançar Vale</h4>
                                </button>
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Buscar Vales</h4>
                                </button>
                                <h4 class="card-title" STYLE="text-align: center">RESULTADO DA BUSCA</h4>

                                <div  style="overflow-x: auto; overflow-y: hidden;">




                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tabelafuncconduta">
                                            <thead>
                                            <tr>
                                                <th scope="col">NOME</th>
                                                <th scope="col">DATA</th>
                                                <th scope="col">VALOR</th>
                                                <th scope="col">DESCRIÇÃO</th>
                                                <th scope="col">TIPO PGTO</th>
                                                <th scope="col">Id Vale</th>
                                                <th scope="col">OPÇÕES</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="vale" items="${valesFiltrados}">
                                                <tr>
                                                    <td>${vale.nome_funcionario}</td>
                                                    <td><fmt:formatDate value="${vale.dataFormatadaParaFmt}" pattern="dd/MM/yyyy" /></td>
                                                    <td><fmt:formatNumber value="${vale.valor}" type="currency" currencySymbol="R$" /></td>
                                                    <td>${vale.observacao}</td>
                                                    <td>${vale.forma_pagamento}</td>
                                                    <td>${vale.id_vale}</td>
                                                    <td>
                                                        <!-- Link para excluir o vale -->
                                                        <a href="<%= request.getContextPath() %>/ServletVales?acao=excluirVale&idVale=${vale.id_vale}"
                                                           class="btn btn-danger" onclick="return confirm('Tem certeza que deseja excluir este vale?')">Excluir</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>

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

                                <h4 class="card-title" STYLE="text-align: center">RELATÓRIO DE VALES NOS ULTIMOS 30 DIAS</h4>

                                <div  style="overflow-x: auto; overflow-y: hidden;">



                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th scope="col">NOME</th>
                                            <th scope="col">DATA</th>
                                            <th scope="col">VALOR</th>
                                            <th scope="col">DESCRIÇÃO</th>
                                            <th scope="col">TIPO PGTO</th>
                                            <th scope="col">Id Vale</th>
                                            <th scope="col">OPÇÕES</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="vale" items="${vales}">
                                            <tr>
                                                <td>${vale.nome_funcionario}</td>
                                                <td><fmt:formatDate value="${vale.dataFormatadaParaFmt}" pattern="dd/MM/yyyy" /></td>
                                                <td><fmt:formatNumber value="${vale.valor}" type="currency" currencySymbol="R$" /></td>
                                                <td>${vale.observacao}</td>
                                                <td>${vale.forma_pagamento}</td>
                                                <td>${vale.id_vale}</td>
                                                <td>
                                                    <!-- Link para excluir o vale -->
                                                    <a href="<%= request.getContextPath() %>/ServletVales?acao=excluirVale&idVale=${vale.id_vale}"
                                                       class="btn btn-danger" onclick="return confirm('Tem certeza que deseja excluir este vale?')">Excluir</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
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


    function atualizarIdFuncionario() {
        const selectElement = document.getElementById("nome_funcionario");
        const selectedOption = selectElement.options[selectElement.selectedIndex];
        const funcionarioId = selectedOption.getAttribute("data-id");
        document.getElementById("id_funcionario").value = funcionarioId || '';
    }

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

   $(document).ready(function () {
       var abrirModal = ${modalDataAbrir != null && modalDataAbrir == true ? "true" : "false"};

       if (abrirModal === "true") {
           $('#modalData').modal('show');
       }
   });
   document.getElementById('funcionarioId').addEventListener('change', function () {
       const selectedOption = this.options[this.selectedIndex];
       document.getElementById('nome_funcionario').value = selectedOption.textContent.trim();
   });

   // Preenche no carregamento, caso já tenha selecionado anteriormente
   window.addEventListener('DOMContentLoaded', function () {
       const select = document.getElementById('funcionarioId');
       const selectedOption = select.options[select.selectedIndex];
       if (selectedOption) {
           document.getElementById('nome_funcionario').value = selectedOption.textContent.trim();
       }
   });


</script>
</body>
</html>
