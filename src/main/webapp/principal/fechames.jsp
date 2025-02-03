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

                                                            <form action="<%= request.getContextPath() %>/ServletFechaMes" method="get" id="formBuscaMes" name="formBuscaMes">
                                                                <input type="hidden" name="acao" value="relatorioMes">
                                                                <div class="form-row align-items-center">
                                                                    <div class="col-auto">
                                                                        <label for="dataInicial">Data Inicial</label>
                                                                        <input type="date" class="form-control" id="dataInicial" name="dataInicial" required value="${dataInicial}">
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


                </div>
                <div class="row">
                    <div class="col-lg-3 grid-margin">
                        <div class="card" >
                            <div class="card-body" style="text-align: center">
                                <!-- Card 1 -->
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <c:if test="${not empty msg}">
                                    <div>
                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <h4 class="card-title" style="text-align: center">RESUMO DO MÊS</h4>

                                <div style="overflow-x: hidden; overflow-y: hidden">
                                    <table class="table table-bordered" id="tabelavendasmes">
                                        <thead class="thead-light">
                                        <tr>

                                            <th scope="col">TOTAL DE FOTOS</th>
                                            <th scope="col">TOTAL DE ENCARTES</th>
                                            <th scope="col">TOTAL DE DIGITAIS</th>
                                            <th scope="col">TOTAL DE SOBRAS</th>
                                            <th scope="col">TOTAL DE RIBBONS</th>



                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasMesList}" var="vl">
                                            <tr>
                                                <td><c:out value="${vl.total_ft}"></c:out></td>
                                                <td><c:out value="${vl.total_enc}"></c:out></td>
                                                <td><c:out value="${vl.total_dig}"></c:out></td>
                                                <td><c:out value="${vl.total_sobras}"></c:out></td>


                                                <td>
                                                    <c:choose>
                                                        <c:when test="${vl.conf1_qtd != 0}">
                                                            <fmt:formatNumber value="${(vl.total_ft + vl.total_sobras) / vl.conf1_qtd}" pattern="0.00" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="Não aplicável" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>


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
                <div class="row">
                    <div class="col-lg-3 grid-margin">
                        <div class="card" >
                            <div class="card-body" style="text-align: center">

                            </div>
                        </div>
                    </div>
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <h4 class="card-title" style="text-align: center">RANKING FUNCIONÁRIOS</h4>

                                <div style="overflow-x: hidden; overflow-y: hidden">
                                    <table class="table table-bordered" id="tabelaRankingmes">
                                        <!-- Área para o gráfico -->
                                        <div style="width: 100%; height: auto;">
                                            <canvas id="vendasChart"></canvas>
                                        </div>

                                        <!-- Script para gerar o gráfico -->
                                        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                        <script>
                                            // Variáveis para o gráfico de vendas
                                            const ctxVendas = document.getElementById('vendasChart').getContext('2d');

                                            // Arrays para armazenar os dados
                                            var nomesVendas = [];
                                            var totalVendas = [];

                                            // Preenchendo os dados do gráfico
                                            <c:forEach var="venda" items="${vendasList}">
                                            nomesVendas.push("${venda.nome}");          // Nome do funcionário
                                            totalVendas.push(${venda.totalFotosVendidas}); // Total de vendas
                                            </c:forEach>

                                            // Gerando o gráfico
                                            const vendasChart = new Chart(ctxVendas, {
                                                type: 'bar', // Tipo de gráfico: 'bar' para barra
                                                data: {
                                                    labels: nomesVendas, // Nomes dos funcionários no eixo X
                                                    datasets: [{
                                                        label: 'Fotos Vendidas',
                                                        data: totalVendas, // Total de vendas no eixo Y
                                                        backgroundColor: [
                                                            'rgba(50,205,50)', // Cor vibrante 1
                                                            'rgba(54, 162, 235)',   // Cor vibrante 2 (azul)
                                                            'rgba(255, 206, 86)',   // Cor vibrante 3 (amarelo)
                                                            'rgba(75, 192, 192)',   // Cor vibrante 4 (verde claro)
                                                            'rgba(153, 102, 255)',  // Cor vibrante 5 (roxo)
                                                            'rgba(255, 99, 132)'    // Cor vibrante 6 (laranja)
                                                        ], // Cores vibrantes para as barras
                                                        borderColor: [
                                                            'rgba(107,142,35, 1)',     // Cor da borda vibrante 1
                                                            'rgba(54, 162, 235, 1)',     // Cor da borda vibrante 2
                                                            'rgba(255, 206, 86, 1)',     // Cor da borda vibrante 3
                                                            'rgba(75, 192, 192, 1)',     // Cor da borda vibrante 4
                                                            'rgba(153, 102, 255, 1)',    // Cor da borda vibrante 5
                                                            'rgba(255, 99, 132, 1)'      // Cor da borda vibrante 6
                                                        ], // Cores da borda das barras
                                                        borderWidth: 1
                                                    }]
                                                },
                                                options: {
                                                    responsive: true, // Gráfico responsivo
                                                    maintainAspectRatio: false, // Permite que o gráfico se ajuste ao tamanho do contêiner
                                                    animation: {
                                                        duration: 1500, // Duração da animação
                                                        easing: 'easeInOutCubic' // Efeito de animação
                                                    },
                                                    scales: {
                                                        y: {
                                                            beginAtZero: false, // O gráfico começa no 0
                                                            title: {
                                                                display: false,
                                                                text: 'Fotos Vendidas', // Título do eixo Y
                                                                font: {
                                                                    size: 16
                                                                }
                                                            },
                                                            ticks: {
                                                                font: {
                                                                    size: 14, // Tamanho da fonte do eixo Y
                                                                    weight: 'bold'
                                                                }
                                                            }
                                                        },
                                                        x: {
                                                            title: {
                                                                display: false, // Título do eixo X oculto
                                                            },
                                                            ticks: {
                                                                font: {
                                                                    size: 14, // Tamanho da fonte do eixo X
                                                                    weight: 'bold'
                                                                },
                                                                // Modificando os labels para mostrar nome + quantidade de fotos
                                                                callback: function(value, index, values) {
                                                                    return nomesVendas[index] + '\n(' + totalVendas[index] + ')'; // Nome + Quantidade de fotos
                                                                }
                                                            }
                                                        }
                                                    },
                                                    plugins: {
                                                        legend: {
                                                            labels: {
                                                                font: {
                                                                    size: 14, // Tamanho da fonte da legenda
                                                                    weight: 'bold'
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            });
                                        </script>
                                    </table>


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

                <div class="row">
                    <div class="col-md-6 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">VALORES ANOTADOS</h4>
                                <!-- Table Content -->
                                <div style="overflow-x: hidden; overflow-y: hidden">
                                    <table class="table table-bordered" id="tabelavaloresmes">
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col">TIPO</th>
                                            <th scope="col">VALOR</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="totalDinheiro" value="0" />
                                        <c:set var="totalDebito" value="0" />
                                        <c:set var="totalCredito" value="0" />
                                        <c:set var="totalPix" value="0" />

                                        <c:forEach items="${vendasMesList}" var="vl">
                                            <tr>
                                                <td>Total Dinheiro</td>
                                                <td><fmt:formatNumber value="${vl.valor_din_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td>Total Débito</td>
                                                <td><fmt:formatNumber value="${vl.valor_deb_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td>Total Crédito</td>
                                                <td><fmt:formatNumber value="${vl.valor_cred_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td>Total Pix</td>
                                                <td><fmt:formatNumber value="${vl.valor_pix_mes}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <c:set var="totalDinheiro" value="${totalDinheiro + vl.valor_din_mes}" />
                                            <c:set var="totalDebito" value="${totalDebito + vl.valor_deb_mes}" />
                                            <c:set var="totalCredito" value="${totalCredito + vl.valor_cred_mes}" />
                                            <c:set var="totalPix" value="${totalPix + vl.valor_pix_mes}" />
                                        </c:forEach>
                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <td style="color: #DAA520;font-weight: bold">Total Geral:</td>
                                            <td style="color: #DAA520;font-weight: bold"><fmt:formatNumber value="${totalDinheiro + totalDebito + totalCredito + totalPix}" type="currency" currencySymbol="R$" /></td>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">VALORES REAIS</h4>
                                <!-- Table Content -->
                                <div style="overflow-x: hidden; overflow-y: hidden">
                                    <table class="table table-bordered" id="tabelavaloresrealmes">
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col">TIPO</th>
                                            <th scope="col">VALOR</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:set var="totalDinheiroReal" value="0" />
                                        <c:set var="totalDebitoReal" value="0" />
                                        <c:set var="totalCreditoReal" value="0" />
                                        <c:set var="totalPixReal" value="0" />

                                        <c:forEach items="${vendasMesList}" var="vl">
                                            <tr>
                                                <td>Total Dinheiro</td>
                                                <td><fmt:formatNumber value="${vl.valor_din_mes_real}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td>Total Débito</td>
                                                <td><fmt:formatNumber value="${vl.valor_deb_mes_real}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td>Total Crédito</td>
                                                <td><fmt:formatNumber value="${vl.valor_cred_mes_real}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <tr>
                                                <td>Total Pix</td>
                                                <td><fmt:formatNumber value="${vl.valor_pix_mes_real}" type="currency" currencySymbol="R$" /></td>
                                            </tr>
                                            <c:set var="totalDinheiroReal" value="${totalDinheiroReal + vl.valor_din_mes_real}" />
                                            <c:set var="totalDebitoReal" value="${totalDebitoReal + vl.valor_deb_mes_real}" />
                                            <c:set var="totalCreditoReal" value="${totalCreditoReal + vl.valor_cred_mes_real}" />
                                            <c:set var="totalPixReal" value="${totalPixReal + vl.valor_pix_mes_real}" />
                                        </c:forEach>
                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <td style="color: #DAA520;font-weight: bold">Total Geral:</td>
                                            <td style="color: #DAA520;font-weight: bold"><fmt:formatNumber value="${totalDinheiroReal + totalDebitoReal + totalCreditoReal + totalPixReal}" type="currency" currencySymbol="R$" /></td>
                                        </tr>
                                        </tfoot>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            <%--parte 3--%>
                <div class="row">
                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">HISTÓRICO DE CONDUTA</h4>
                                <!-- Table Content -->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">FINANCEIRO</h4>
                                <!-- Table Content -->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">SALÁRIO BRUTO</h4>
                                <!-- Table Content -->
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




</script>
</body>
</html>
