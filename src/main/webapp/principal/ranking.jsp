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
                                                                          <input type="date" class="form-control" id="dataInicial" name="dataInicial" value="${dataInicial}">
                                                                      </div>
                                                                      <div class="col-auto">
                                                                          <label for="dataFinal">Data Final</label>
                                                                          <input type="date" class="form-control" id="dataFinal" name="dataFinal" value="${dataFinal}">
                                                                      </div>

                                                                      <!-- Espaço vazio para alinhar o botão -->
                                                                      <div class="col-auto">
                                                                          <label for="ranking" class="invisible">Ranking</label>
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
                <!-- Div que contém o gráfico -->
                <div class="row">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <h4 class="card-title" style="text-align: center">RANKING DE VENDAS</h4>

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
                                    nomesProducao.push("${venda.nome}"); // Nome do funcionário
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
                                    nomes.push("${venda.nome}");
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

    $(document).ready(function() {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem
        }
    });

    // Função para navegar entre elementos focáveis com as setas
    function navigateFocusableElements(event) {
        // Lista de elementos que podem receber foco, excluindo elementos com tabindex -1
        const focusableElements = Array.from(
            document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')
        ).filter(element => !element.disabled && element.tabIndex !== -1); // Filtra elementos desabilitados e tabindex -1

        if (focusableElements.length === 0) return; // Se não houver elementos focáveis, sai da função

        const currentElement = document.activeElement; // Elemento atual com foco
        let currentIndex = focusableElements.indexOf(currentElement); // Índice do elemento atual

        switch (event.key) {
            case 'ArrowRight': // Seta para a direita
            case 'ArrowDown': // Seta para baixo
                currentIndex = (currentIndex + 1) % focusableElements.length; // Próximo elemento
                break;
            case 'ArrowLeft': // Seta para a esquerda
            case 'ArrowUp': // Seta para cima
                currentIndex = (currentIndex - 1 + focusableElements.length) % focusableElements.length; // Elemento anterior
                break;
            default:
                return; // Ignora outras teclas
        }

        focusableElements[currentIndex].focus(); // Define o foco no elemento correspondente
    }

    // Adiciona o evento keydown ao documento
    document.addEventListener('keydown', navigateFocusableElements);

    // Bloqueia a alteração de valor com as setas nos inputs do tipo number
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('keydown', function(event) {
            if (event.key === 'ArrowUp' || event.key === 'ArrowDown') {
                event.preventDefault(); // Impede a alteração do valor
            }
        });
    });

    // Fim de navegação por setas


    window.onload = function() {
        fetch('ServletRanking')
            .then(response => response.text())
            .then(data => {
                document.getElementById('resultado').innerHTML = data;
            })
            .catch(error => console.error('Erro:', error));
    }

</script>
</body>
</html>
