<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDate" %>
<%
    // Gera lista de anos dinamicamente (últimos 10 anos até o ano atual)
    int anoAtual = LocalDate.now().getYear();
    int anoInicio = anoAtual - 10;
    int anoFim = anoAtual;
    request.setAttribute("anoInicio", anoInicio);
    request.setAttribute("anoFim", anoFim);
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
                    <div class="col-12">
                        <h3 class="mb-4">Comparativo de Vendas - Ano sobre Ano (YoY)</h3>
                    </div>
                </div>

                <div class="row">

                    <!-- Período 1 -->
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title text-center mb-3">Período 1</h5>

                                <!-- Selects de Mês e Ano lado a lado -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="mes1">Mês</label>
                                            <select class="form-control" id="mes1" name="mes1" onchange="carregarDados(1)">
                                                <option value="">Selecione...</option>
                                                <option value="1">Janeiro</option>
                                                <option value="2">Fevereiro</option>
                                                <option value="3">Março</option>
                                                <option value="4">Abril</option>
                                                <option value="5">Maio</option>
                                                <option value="6">Junho</option>
                                                <option value="7">Julho</option>
                                                <option value="8">Agosto</option>
                                                <option value="9">Setembro</option>
                                                <option value="10">Outubro</option>
                                                <option value="11">Novembro</option>
                                                <option value="12">Dezembro</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="ano1">Ano</label>
                                            <select class="form-control" id="ano1" name="ano1" onchange="carregarDados(1)">
                                                <option value="">Selecione...</option>
                                                <c:forEach var="ano" begin="${anoInicio}" end="${anoFim}">
                                                    <option value="${ano}">${ano}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Inputs 2 em 2 -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Valor Total</label>
                                            <input type="text" class="form-control" id="valorTotal1" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Ribbons</label>
                                            <input type="text" class="form-control" id="ribbons1" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Fotos Vendidas</label>
                                            <input type="text" class="form-control" id="fotosVendidas1" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Sobras</label>
                                            <input type="text" class="form-control" id="sobras1" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <!-- Tabela de vendas diárias -->
                                <div class="mt-4">
                                    <h6 class="text-center mb-3">Vendas por Dia</h6>
                                    <div style="max-height: 400px; overflow-y: auto;">
                                        <table class="table table-bordered table-striped table-hover table-sm">
                                            <thead>
                                            <tr>
                                                <th>Dia</th>
                                                <th>Dia Semana</th>
                                                <th>Total</th>
                                            </tr>
                                            </thead>
                                            <tbody id="vendasDiarias1">
                                            <tr>
                                                <td colspan="3" class="text-center">Selecione mês/ano</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- Período 2 -->
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title text-center mb-3">Período 2</h5>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="mes2">Mês</label>
                                            <select class="form-control" id="mes2" name="mes2" onchange="carregarDados(2)">
                                                <option value="">Selecione...</option>
                                                <option value="1">Janeiro</option>
                                                <option value="2">Fevereiro</option>
                                                <option value="3">Março</option>
                                                <option value="4">Abril</option>
                                                <option value="5">Maio</option>
                                                <option value="6">Junho</option>
                                                <option value="7">Julho</option>
                                                <option value="8">Agosto</option>
                                                <option value="9">Setembro</option>
                                                <option value="10">Outubro</option>
                                                <option value="11">Novembro</option>
                                                <option value="12">Dezembro</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="ano2">Ano</label>
                                            <select class="form-control" id="ano2" name="ano2" onchange="carregarDados(2)">
                                                <option value="">Selecione...</option>
                                                <c:forEach var="ano" begin="${anoInicio}" end="${anoFim}">
                                                    <option value="${ano}">${ano}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Inputs 2 em 2 -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Valor Total</label>
                                            <input type="text" class="form-control" id="valorTotal2" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Ribbons</label>
                                            <input type="text" class="form-control" id="ribbons2" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Fotos Vendidas</label>
                                            <input type="text" class="form-control" id="fotosVendidas2" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Sobras</label>
                                            <input type="text" class="form-control" id="sobras2" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <h6 class="text-center mb-3">Vendas por Dia</h6>
                                    <div style="max-height: 400px; overflow-y: auto;">
                                        <table class="table table-bordered table-striped table-hover table-sm">
                                            <thead>
                                            <tr>
                                                <th>Dia</th>
                                                <th>Dia Semana</th>
                                                <th>Total</th>
                                            </tr>
                                            </thead>
                                            <tbody id="vendasDiarias2">
                                            <tr>
                                                <td colspan="3" class="text-center">Selecione mês/ano</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- Período 3 -->
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title text-center mb-3">Período 3</h5>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="mes3">Mês</label>
                                            <select class="form-control" id="mes3" name="mes3" onchange="carregarDados(3)">
                                                <option value="">Selecione...</option>
                                                <option value="1">Janeiro</option>
                                                <option value="2">Fevereiro</option>
                                                <option value="3">Março</option>
                                                <option value="4">Abril</option>
                                                <option value="5">Maio</option>
                                                <option value="6">Junho</option>
                                                <option value="7">Julho</option>
                                                <option value="8">Agosto</option>
                                                <option value="9">Setembro</option>
                                                <option value="10">Outubro</option>
                                                <option value="11">Novembro</option>
                                                <option value="12">Dezembro</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="ano3">Ano</label>
                                            <select class="form-control" id="ano3" name="ano3" onchange="carregarDados(3)">
                                                <option value="">Selecione...</option>
                                                <c:forEach var="ano" begin="${anoInicio}" end="${anoFim}">
                                                    <option value="${ano}">${ano}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Inputs 2 em 2 -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Valor Total</label>
                                            <input type="text" class="form-control" id="valorTotal3" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Ribbons</label>
                                            <input type="text" class="form-control" id="ribbons3" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Fotos Vendidas</label>
                                            <input type="text" class="form-control" id="fotosVendidas3" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Sobras</label>
                                            <input type="text" class="form-control" id="sobras3" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <h6 class="text-center mb-3">Vendas por Dia</h6>
                                    <div style="max-height: 400px; overflow-y: auto;">
                                        <table class="table table-bordered table-striped table-hover table-sm">
                                            <thead>
                                            <tr>
                                                <th>Dia</th>
                                                <th>Dia Semana</th>
                                                <th>Total</th>
                                            </tr>
                                            </thead>
                                            <tbody id="vendasDiarias3">
                                            <tr>
                                                <td colspan="3" class="text-center">Selecione mês/ano</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- Período 4 -->
                    <div class="col-md-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title text-center mb-3">Período 4</h5>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="mes4">Mês</label>
                                            <select class="form-control" id="mes4" name="mes4" onchange="carregarDados(4)">
                                                <option value="">Selecione...</option>
                                                <option value="1">Janeiro</option>
                                                <option value="2">Fevereiro</option>
                                                <option value="3">Março</option>
                                                <option value="4">Abril</option>
                                                <option value="5">Maio</option>
                                                <option value="6">Junho</option>
                                                <option value="7">Julho</option>
                                                <option value="8">Agosto</option>
                                                <option value="9">Setembro</option>
                                                <option value="10">Outubro</option>
                                                <option value="11">Novembro</option>
                                                <option value="12">Dezembro</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label for="ano4">Ano</label>
                                            <select class="form-control" id="ano4" name="ano4" onchange="carregarDados(4)">
                                                <option value="">Selecione...</option>
                                                <c:forEach var="ano" begin="${anoInicio}" end="${anoFim}">
                                                    <option value="${ano}">${ano}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Inputs 2 em 2 -->
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Valor Total</label>
                                            <input type="text" class="form-control" id="valorTotal4" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Ribbons</label>
                                            <input type="text" class="form-control" id="ribbons4" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Fotos Vendidas</label>
                                            <input type="text" class="form-control" id="fotosVendidas4" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <div class="form-group">
                                            <label>Sobras</label>
                                            <input type="text" class="form-control" id="sobras4" readonly style="background: black; color: #DAA520; font-size: 1.0rem">
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <h6 class="text-center mb-3">Vendas por Dia</h6>
                                    <div style="max-height: 400px; overflow-y: auto;">
                                        <table class="table table-bordered table-striped table-hover table-sm">
                                            <thead>
                                            <tr>
                                                <th>Dia</th>
                                                <th>Dia Semana</th>
                                                <th>Total</th>
                                            </tr>
                                            </thead>
                                            <tbody id="vendasDiarias4">
                                            <tr>
                                                <td colspan="3" class="text-center">Selecione mês/ano</td>
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
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 5px solid black;">
            <div class="modal-header" style="border-bottom: none;">
            </div>
            <div class="modal-body" style="color: black;">
                <p style="font-size: 1.5em; text-align: center">${msg}</p>
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
            $('#msgModal').modal('show');
            $.post("${pageContext.request.contextPath}/ServletVendas", { acao: "limparMsg" });
        }
    });

    // Função para aplicar cores baseadas no valor das vendas
    function aplicarCoresVendas() {
        // Aguarda um pouco para garantir que o DOM foi atualizado
        setTimeout(function() {
            // Seleciona todas as células de total vendido (terceira coluna de cada tbody)
            const celulas = document.querySelectorAll('#vendasDiarias1 tr td:nth-child(3), #vendasDiarias2 tr td:nth-child(3), #vendasDiarias3 tr td:nth-child(3), #vendasDiarias4 tr td:nth-child(3)');

            console.log('Aplicando cores em ' + celulas.length + ' células');

            celulas.forEach(td => {
                let texto = td.textContent.trim();

                // Ignora células com mensagens
                if (texto.includes('Selecione') || texto.includes('Sem vendas')) {
                    return;
                }

                // Remove "R$" e espaços, converte vírgulas/pontos para formato numérico
                let valor = texto.replace('R

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
                            event.preventDefault();
                        }
                    });
                });

                // Adiciona o evento keydown ao documento
                document.addEventListener('keydown', navigateFocusableElements);

                // Aplicar cores nos valores das vendas diárias
                aplicarCoresVendas();
</script>

<script>
    // Função para aplicar cores baseadas no valor das vendas
    function aplicarCoresVendas() {
        // Seleciona todas as células de total vendido (terceira coluna de cada tbody)
        const celulas = document.querySelectorAll('#vendasDiarias1 td:nth-child(3), #vendasDiarias2 td:nth-child(3), #vendasDiarias3 td:nth-child(3), #vendasDiarias4 td:nth-child(3)');

        celulas.forEach(td => {
            let texto = td.textContent.trim();

            // Remove "R$" e converte vírgulas/pontos para formato numérico
            let valor = texto.replace('R

                </body>
        </html>, '').replace(/\./g, '').replace(',', '.').trim();
            let numero = parseFloat(valor);

            if (!isNaN(numero)) {
                if (numero <= 999.99) {
                    td.style.color = 'red';
                    td.style.fontWeight = 'bold';
                } else if (numero <= 1999.99) {
                    td.style.color = 'white';
                    td.style.fontWeight = 'bold';
                } else if (numero <= 2999.99) {
                    td.style.color = 'yellow';
                    td.style.fontWeight = 'bold';
                } else if (numero <= 3999.99) {
                    td.style.color = '#00ccff'; // azul claro
                    td.style.fontWeight = 'bold';
                } else {
                    td.style.color = 'fuchsia';
                    td.style.fontWeight = 'bold';
                }
            }
        });
    }
</script>

</body>
</html>, '').replace(/\s/g, '').replace(/\./g, '').replace(',', '.').trim();
let numero = parseFloat(valor);

console.log('Valor: ' + texto + ' -> ' + numero);

if (!isNaN(numero)) {
if (numero <= 999.99) {
td.style.color = 'red';
td.style.fontWeight = 'bold';
} else if (numero <= 1999.99) {
td.style.color = 'white';
td.style.fontWeight = 'bold';
} else if (numero <= 2999.99) {
td.style.color = 'yellow';
td.style.fontWeight = 'bold';
} else if (numero <= 3999.99) {
td.style.color = '#00ccff'; // azul claro
td.style.fontWeight = 'bold';
} else {
td.style.color = 'fuchsia';
td.style.fontWeight = 'bold';
}
}
});
}, 100);
}

// Função para carregar dados quando o select mudar
function carregarDados(periodo) {
const mes = document.getElementById('mes' + periodo).value;
const ano = document.getElementById('ano' + periodo).value;

if (mes && ano) {
console.log(`Carregando dados do Período ${periodo}: ${mes}/${ano}`);

// Chamada AJAX para buscar os dados
$.ajax({
url: '${pageContext.request.contextPath}/ServletComparativoYoY',
type: 'GET',
data: {
acao: 'buscarDados',
mes: mes,
ano: ano,
periodo: periodo
},
success: function(response) {
console.log('Resposta recebida para período ' + periodo);

// Preencher os campos de resumo
$('#valorTotal' + periodo).val('R$ ' + response.valorTotal);
$('#fotosVendidas' + periodo).val(response.fotosVendidas);
$('#sobras' + periodo).val(response.sobras);
$('#ribbons' + periodo).val(response.ribbons);

// Preencher a tabela de vendas diárias
let html = '';
if (response.vendasDiarias && response.vendasDiarias.length > 0) {
response.vendasDiarias.forEach(function(dia) {
html += '<tr>';
html += '<td>' + dia.dia + '</td>';
html += '<td>' + dia.diaSemana + '</td>';
html += '<td>R$ ' + dia.totalVendido + '</td>';
html += '</tr>';
});
} else {
html = '<tr><td colspan="3" class="text-center">Sem vendas neste período</td></tr>';
}
$('#vendasDiarias' + periodo).html(html);

console.log('Tabela atualizada, aplicando cores...');

// Aplica as cores após carregar os dados
aplicarCoresVendas();
},
error: function(xhr, status, error) {
console.error('Erro ao buscar dados:', error);
alert('Erro ao buscar dados do período ' + periodo);
}
});
}
}

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
event.preventDefault();
}
});
});

// Adiciona o evento keydown ao documento
document.addEventListener('keydown', navigateFocusableElements);

// Aplicar cores nos valores das vendas diárias
aplicarCoresVendas();
</script>

<script>
    // Função para aplicar cores baseadas no valor das vendas
    function aplicarCoresVendas() {
        // Seleciona todas as células de total vendido (terceira coluna de cada tbody)
        const celulas = document.querySelectorAll('#vendasDiarias1 td:nth-child(3), #vendasDiarias2 td:nth-child(3), #vendasDiarias3 td:nth-child(3), #vendasDiarias4 td:nth-child(3)');

        celulas.forEach(td => {
            let texto = td.textContent.trim();

            // Remove "R$" e converte vírgulas/pontos para formato numérico
            let valor = texto.replace('R

                </body>
        </html>, '').replace(/\./g, '').replace(',', '.').trim();
            let numero = parseFloat(valor);

            if (!isNaN(numero)) {
                if (numero <= 999.99) {
                    td.style.color = 'red';
                    td.style.fontWeight = 'bold';
                } else if (numero <= 1999.99) {
                    td.style.color = 'white';
                    td.style.fontWeight = 'bold';
                } else if (numero <= 2999.99) {
                    td.style.color = 'yellow';
                    td.style.fontWeight = 'bold';
                } else if (numero <= 3999.99) {
                    td.style.color = '#00ccff'; // azul claro
                    td.style.fontWeight = 'bold';
                } else {
                    td.style.color = 'fuchsia';
                    td.style.fontWeight = 'bold';
                }
            }
        });
    }
</script>

</body>
</html>