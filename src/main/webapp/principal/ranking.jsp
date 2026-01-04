<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
                                                            <c:if test="${not empty msg}">
                                                                <div>
                                                                    <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                </div>
                                                            </c:if>
                                                              <form action="<%= request.getContextPath() %>/ServletRanking" method="get" id="formDataVenda" name="formDataVenda">
                                                                  <input type="hidden" name="acao" value="imprimirRelatorioVendas">
                                                                  <div class="form-row align-items-center">
                                                                      <div class="col-auto">
                                                                          <label for="dataInicial">Data Inicial</label>
                                                                          <input type="date" class="form-control" id="dataInicial" name="dataInicial" value="${dataInicial}" onchange="setData()" >
                                                                      </div>
                                                                      <div class="col-auto">
                                                                          <label for="dataFinal">Data Final</label>
                                                                          <input type="date" class="form-control" id="dataFinal" name="dataFinal" value="${dataFinal}">
                                                                      </div>

                                                                      <!-- Espaço vazio para alinhar o botão -->
                                                                      <div class="col-auto">
                                                                          <label class="invisible">Ranking</label>
                                                                          <button type="submit" class="btn btn-primary form-control">Gerar Ranking</button>
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
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <!-- Botão à esquerda -->
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>

                                <!-- Datas à direita -->
                                <div class="d-flex justify-content-center align-items-center">
                                    <div class="me-1">
                                        <input type="date" class="form-control" id="dataInicial2" name="dataInicial"
                                               style="background-color: transparent; border: transparent; color: #DAA520; font-weight: bold; font-size: larger"
                                               value="${dataInicial}" readonly>
                                    </div>
                                    <div class="ms-1">
                                        <input type="date" class="form-control" id="dataFinal2" name="dataFinal"
                                               style="background-color: transparent; border: transparent; color: #DAA520; font-weight: bold; font-size: larger"
                                               value="${dataFinal}" readonly>
                                    </div>
                                </div>



                            </div>
                        </div>
                    </div>
                </div>

                <!-- ranking vendas -->

                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RANKING DE VENDAS</h4>

                                <!-- Área para o gráfico reduzido -->
                                <div style="width: 100%; height: auto;">
                                    <canvas id="vendasChartMini"></canvas>
                                </div>

                                <!-- Script para gerar o gráfico -->
                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                                <script>
                                    const ctxVendasMini = document.getElementById('vendasChartMini').getContext('2d');

                                    var nomesVendasMini = [];
                                    var totalVendasMini = [];
                                    var mediaVendasMini = [];  // <- NOVO (média por dia)

                                    <c:forEach var="venda" items="${vendasList}">
                                    nomesVendasMini.push([
                                        "${venda.apelido}",
                                        "${venda.totalFotosVendidas} fotos",
                                        "Média: " + (
                                            Number(${venda.diasTrabalhados}) > 0
                                                ? Number(${venda.totalFotosVendidas}) / Number(${venda.diasTrabalhados})
                                                : 0
                                        ).toFixed(0) + "/dia"
                                    ]);





                                    totalVendasMini.push(${venda.totalFotosVendidas});

                                    var dias = ${venda.diasTrabalhados};
                                    var total = ${venda.totalFotosVendidas};

                                    mediaVendasMini.push(dias > 0 ? (total / dias) : 0);

                                    </c:forEach>

                                    const vendasChartMini = new Chart(ctxVendasMini, {
                                        type: 'bar',
                                        data: {
                                            labels: nomesVendasMini,
                                            datasets: [{
                                                label: 'Fotos Vendidas',
                                                data: totalVendasMini,
                                                backgroundColor: [
                                                    'rgba(50,205,50)',
                                                    'rgba(54, 162, 235)',
                                                    'rgba(255, 206, 86)',
                                                    'rgba(75, 192, 192)',
                                                    'rgba(153, 102, 255)',
                                                    'rgba(255, 99, 132)'
                                                ],
                                                borderColor: [
                                                    'rgba(107,142,35, 1)',
                                                    'rgba(54, 162, 235, 1)',
                                                    'rgba(255, 206, 86, 1)',
                                                    'rgba(75, 192, 192, 1)',
                                                    'rgba(153, 102, 255, 1)',
                                                    'rgba(255, 99, 132, 1)'
                                                ],
                                                borderWidth: 1
                                            }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            animation: {
                                                duration: 1500,
                                                easing: 'easeInOutCubic'
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: false,
                                                    title: {
                                                        display: false
                                                    },
                                                    ticks: {
                                                        font: {
                                                            size: 14,
                                                            weight: 'bold'
                                                        }
                                                    }
                                                },
                                                x: {
                                                    title: {
                                                        display: false
                                                    },
                                                    ticks: {
                                                        font: {
                                                            size: 14,
                                                            weight: 'bold'
                                                        },
                                                        // AQUI MOSTRA: NOME / TOTAL / MÉDIA

                                                    }
                                                }
                                            },
                                            plugins: {
                                                legend: {
                                                    labels: {
                                                        font: {
                                                            size: 14,
                                                            weight: 'bold'
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- RANKING DE PRODUÇÃO -->
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RANKING DE PRODUÇÃO</h4>

                                <!-- Área para o gráfico -->
                                <div style="width: 100%; height: auto;">
                                    <canvas id="ProdChart"></canvas>
                                </div>

                                <!-- Script para gerar o gráfico -->
                                <script>
                                    const ctxProducao = document.getElementById('ProdChart').getContext('2d');

                                    // Arrays para armazenar os dados
                                    var nomesProducao = [];
                                    var totalProducao = [];

                                    // Preenchendo os dados do gráfico
                                    <c:forEach var="venda" items="${vendasList}">
                                    var producao = ${venda.totalProducao}; // Total de produção
                                    nomesProducao.push("${venda.apelido}"); // Nome do funcionário
                                    totalProducao.push(producao); // Produção total
                                    </c:forEach>

                                    // Criando um array de objetos com o nome e a produção
                                    var producaoData = nomesProducao.map((nome, index) => {
                                        return { nome: nome, totalProducao: totalProducao[index] };
                                    });

                                    // Ordenando o array de objetos pela produção de forma decrescente
                                    producaoData.sort((a, b) => b.totalProducao - a.totalProducao);

                                    // Atualizando as arrays de nomes e produção após ordenação
                                    nomesProducao = producaoData.map(item => item.nome);
                                    totalProducao = producaoData.map(item => item.totalProducao);

                                    // Gerando o gráfico
                                    const prodChart = new Chart(ctxProducao, {
                                        type: 'bar', // Tipo de gráfico: 'bar' para barra
                                        data: {
                                            labels: nomesProducao.map((nome, index) => {
                                                return nome + " - " + totalProducao[index]; // Nome e produção na mesma linha
                                            }),
                                            datasets: [{
                                                label: 'Produção Total',
                                                data: totalProducao, // Dados de produção no eixo Y
                                                backgroundColor: [
                                                    'rgba(50,205,50)', // Cor vibrante 1
                                                    'rgba(54, 162, 235)', // Cor vibrante 2 (azul)
                                                    'rgba(255, 206, 86)', // Cor vibrante 3 (amarelo)
                                                    'rgba(75, 192, 192)', // Cor vibrante 4 (verde claro)
                                                    'rgba(153, 102, 255)', // Cor vibrante 5 (roxo)
                                                    'rgba(255, 99, 132)' // Cor vibrante 6 (laranja)
                                                ], // Cores vibrantes para as barras
                                                borderColor: [
                                                    'rgba(107,142,35, 1)', // Cor da borda vibrante 1
                                                    'rgba(54, 162, 235, 1)', // Cor da borda vibrante 2
                                                    'rgba(255, 206, 86, 1)', // Cor da borda vibrante 3
                                                    'rgba(75, 192, 192, 1)', // Cor da borda vibrante 4
                                                    'rgba(153, 102, 255, 1)', // Cor da borda vibrante 5
                                                    'rgba(255, 99, 132, 1)' // Cor da borda vibrante 6
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
                                                    beginAtZero: true, // O gráfico começa no 0
                                                    title: {
                                                        display: false,
                                                        text: 'Produção Total', // Título do eixo Y
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

                            </div>
                        </div>
                    </div>
                </div>






                <!-- RANKING DE APROVEITAMENTO -->
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">RANKING DE APROVEITAMENTO</h4>

                                <!-- Área para o gráfico -->
                                <div style="width: 100%; height: auto;">
                                    <canvas id="AproveitamentoChart"></canvas>
                                </div>

                                <!-- Script para gerar o gráfico -->
                                <script>
                                    const ctx = document.getElementById('AproveitamentoChart').getContext('2d');

                                    // Arrays para armazenar os dados
                                    var nomes = [];
                                    var aproveitamento = [];

                                    // Preenchendo os dados do gráfico
                                    <c:forEach var="venda" items="${vendasList}">
                                    var vendas = ${venda.totalFotosVendidas}; // Total de vendas
                                    var producao = ${venda.totalProducao}; // Total de produção (prod1 + sobras)
                                    var aproveitamentoCalc = (vendas / producao) * 100; // Calculando o aproveitamento

                                    // Adicionando o nome e o valor de aproveitamento ao array
                                    nomes.push("${venda.apelido}");
                                    aproveitamento.push(aproveitamentoCalc.toFixed(2));
                                    </c:forEach>

                                    // Criando um array de objetos com o nome e o aproveitamento
                                    var aproveitamentoData = nomes.map((nome, index) => {
                                        return { nome: nome, aproveitamento: parseFloat(aproveitamento[index]) };
                                    });

                                    // Ordenando o array de objetos pelo aproveitamento de forma decrescente
                                    aproveitamentoData.sort((a, b) => b.aproveitamento - a.aproveitamento);

                                    // Atualizando as arrays de nomes e aproveitamento após ordenação
                                    nomes = aproveitamentoData.map(item => item.nome);
                                    aproveitamento = aproveitamentoData.map(item => item.aproveitamento);

                                    // Gerando o gráfico
                                    const aproveitamentoChart = new Chart(ctx, {
                                        type: 'bar', // Tipo de gráfico: 'bar' para barra
                                        data: {
                                            labels: nomes.map((nome, index) => {
                                                return nome + " - " + aproveitamento[index] + "%"; // Nome e aproveitamento na mesma linha
                                            }),
                                            datasets: [{
                                                label: 'Aproveitamento (%)',
                                                data: aproveitamento, // Dados de aproveitamento no eixo Y
                                                backgroundColor: [
                                                    'rgba(50,205,50)', // Cor vibrante 1
                                                    'rgba(54, 162, 235)', // Cor vibrante 2 (azul)
                                                    'rgba(255, 206, 86)', // Cor vibrante 3 (amarelo)
                                                    'rgba(75, 192, 192)', // Cor vibrante 4 (verde claro)
                                                    'rgba(153, 102, 255)', // Cor vibrante 5 (roxo)
                                                    'rgba(255, 99, 132)' // Cor vibrante 6 (laranja)
                                                ], // Cores vibrantes para as barras
                                                borderColor: [
                                                    'rgba(107,142,35, 1)', // Cor da borda vibrante 1
                                                    'rgba(54, 162, 235, 1)', // Cor da borda vibrante 2
                                                    'rgba(255, 206, 86, 1)', // Cor da borda vibrante 3
                                                    'rgba(75, 192, 192, 1)', // Cor da borda vibrante 4
                                                    'rgba(153, 102, 255, 1)', // Cor da borda vibrante 5
                                                    'rgba(255, 99, 132, 1)' // Cor da borda vibrante 6
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
                                                    beginAtZero: true, // O gráfico começa no 0
                                                    title: {
                                                        display: false,
                                                        text: 'Aproveitamento (%)', // Título do eixo Y
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
        fetch('ServletRanking')
            .then(response => response.text())
            .then(data => {
                document.getElementById('resultado').innerHTML = data;
            })
            .catch(error => console.error('Erro:', error));
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

</script>
</body>
</html>
