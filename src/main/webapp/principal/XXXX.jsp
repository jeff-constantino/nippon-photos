<!-- ranking vendas -->
<div class="row">
    <div class="col-12 grid-margin">
        <div class="card">
            <div class="card-body">




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