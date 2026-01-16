<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDate" %>
<%
    int anoAtual = LocalDate.now().getYear();
    int anoInicio = anoAtual - 10;
    int anoFim = anoAtual;
    request.setAttribute("anoInicio", anoInicio);
    request.setAttribute("anoFim", anoFim);
%>
<!DOCTYPE html>
<html lang="pt-br">
<jsp:include page="header.jsp"></jsp:include>
<style>
    /* Estilos para garantir a responsividade e leitura de valores grandes */
    .card {
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        border-radius: 8px;
        margin-bottom: 20px;
    }

    .card-title {
        font-weight: bold;
        color: #333;
        font-size: 1.1rem;
    }

    .form-group label {
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        color: #666;
        margin-bottom: 3px;
    }

    /* Display de valores (Estilo Digital/Caixa) */
    .display-valor {
        background: black !important;
        color: #DAA520 !important;
        font-family: 'Courier New', Courier, monospace;
        font-weight: bold;
        text-align: center;
        padding: 5px 2px !important;
        border: 1px solid #444;
    }

    /* Ajuste específico para o valor financeiro grande */
    .font-financeiro {
        font-size: 0.85rem !important; /* Tamanho ideal para R$ 00.000,00 */
        letter-spacing: -0.5px;
    }

    .font-num {
        font-size: 1rem !important;
    }

    /* Tabela de Vendas Diárias */
    .table-container {
        max-height: 380px;
        overflow-y: auto;
        border: 1px solid #eee;
        border-radius: 4px;
    }

    .table-sm th, .table-sm td {
        font-size: 0.78rem;
        padding: 0.4rem !important;
    }

    /* Ajuste de grid para telas médias (Tablets) */
    @media (min-width: 768px) and (max-width: 1199px) {
        .col-custom {
            flex: 0 0 50%;
            max-width: 50%;
        }
    }
</style>

<body>
<div class="container-scroller">
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="navbar.jsp"></jsp:include>
        <div class="main-panel">
            <div class="content-wrapper" style="min-height: calc(98vh - 100px);">

                <div class="row">
                    <div class="col-12 text-center">
                        <h3 class="mb-4" style="color: black; font-weight: bold;">Comparativo de Vendas</h3>
                    </div>
                </div>

                <div class="row">
                    <c:forEach var="i" begin="1" end="4">
                        <div class="col-12 col-md-6 col-xl-3 mb-4 col-custom">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title text-center mb-3">Período ${i}</h5>

                                    <div class="row">
                                        <div class="col-7">
                                            <div class="form-group">
                                                <label for="mes${i}">Mês</label>
                                                <select class="form-control form-control-sm" id="mes${i}" onchange="carregarDados(${i})">
                                                    <option value="">Selecione...</option>
                                                    <option value="1">Janeiro</option><option value="2">Fevereiro</option>
                                                    <option value="3">Março</option><option value="4">Abril</option>
                                                    <option value="5">Maio</option><option value="6">Junho</option>
                                                    <option value="7">Julho</option><option value="8">Agosto</option>
                                                    <option value="9">Setembro</option><option value="10">Outubro</option>
                                                    <option value="11">Novembro</option><option value="12">Dezembro</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="form-group">
                                                <label for="ano${i}">Ano</label>
                                                <select class="form-control form-control-sm" id="ano${i}" onchange="carregarDados(${i})">
                                                    <option value="">Ano...</option>
                                                    <c:forEach var="ano" begin="${anoInicio}" end="${anoFim}">
                                                        <option value="${ano}">${ano}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-8">
                                            <div class="form-group">
                                                <label>Valor Total</label>
                                                <input type="text" class="form-control display-valor font-financeiro" id="valorTotal${i}" readonly placeholder="R$ 0,00">
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label>Ribbons</label>
                                                <input type="text" class="form-control display-valor font-num" id="ribbons${i}" readonly>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label>Fotos</label>
                                                <input type="text" class="form-control display-valor font-num" id="fotosVendidas${i}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label>Sobras</label>
                                                <input type="text" class="form-control display-valor font-num" id="sobras${i}" readonly>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-3">
                                        <h6 class="text-center mb-2" style="font-size: 0.85rem; font-weight: bold;">Vendas por Dia</h6>
                                        <div class="table-container">
                                            <table class="table table-bordered table-striped table-hover table-sm mb-0">
                                                <thead class="bg-light">
                                                <tr>
                                                    <th>Dia</th>
                                                    <th>Semana</th>
                                                    <th>Total</th>
                                                </tr>
                                                </thead>
                                                <tbody id="vendasDiarias${i}">
                                                <tr>
                                                    <td colspan="3" class="text-center">Aguardando dados...</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
</div>

<jsp:include page="pluginsJS.jsp"></jsp:include>

<div class="modal fade" id="msgModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="background-color: #f2a654; color: black; border: 3px solid black;">
            <div class="modal-body text-center">
                <p style="font-size: 1.2em; font-weight: bold; margin-top: 15px;">${msg}</p>
                <small>Pressione ESC para fechar</small>
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

    /**
     * Converte valores do padrão americano (35,925.99)
     * para o padrão brasileiro (35.925,99)
     */
    function formatarParaBR(valor) {
        if (valor === null || valor === undefined || valor === "") return "0,00";

        // Remove vírgulas de milhar se existirem e converte para número
        let numero = typeof valor === 'string' ?
            parseFloat(valor.replace(/,/g, "")) : valor;

        if (isNaN(numero)) return "0,00";

        return numero.toLocaleString('pt-BR', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }

    function aplicarCoresVendas() {
        setTimeout(function() {
            const celulas = $("td:nth-child(3)");

            celulas.each(function() {
                let td = $(this);
                let texto = td.text().trim();

                if (!texto || texto.includes('Total') || texto.includes('Selecione') || texto.includes('Sem vendas')) {
                    return;
                }

                // Limpeza para o novo formato brasileiro:
                // Remove "R$", remove o "." do milhar e troca a "," decimal por "."
                let valorLimpo = texto
                    .replace("R$", "")
                    .replace(/\./g, "")   // Remove pontos de milhar
                    .replace(",", ".")    // Troca vírgula decimal por ponto
                    .trim();

                let numero = parseFloat(valorLimpo);

                if (!isNaN(numero)) {
                    let cor = '';

                    if (numero <= 999.99) {
                        cor = 'red';
                    } else if (numero <= 1999.99) {
                        cor = 'white';
                    } else if (numero <= 2999.99) {
                        cor = 'yellow';
                    } else if (numero <= 3999.99) {
                        cor = '#00ccff';
                    } else {
                        cor = 'fuchsia';
                    }

                    td.attr('style', function(i, s) {
                        return 'color: ' + cor + ' !important; font-weight: bold !important;';
                    });
                }
            });
        }, 300);
    }

    function carregarDados(periodo) {
        const mes = $('#mes' + periodo).val();
        const ano = $('#ano' + periodo).val();

        if (mes && ano) {
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
                    // Aplicando a formatação R$ 00.000,00 nos inputs
                    $('#valorTotal' + periodo).val('R$ ' + formatarParaBR(response.valorTotal));
                    $('#fotosVendidas' + periodo).val(response.fotosVendidas);
                    $('#sobras' + periodo).val(response.sobras);
                    $('#ribbons' + periodo).val(response.ribbons);

                    let html = '';
                    if (response.vendasDiarias && response.vendasDiarias.length > 0) {
                        response.vendasDiarias.forEach(function(dia) {
                            html += '<tr>';
                            html += '<td>' + dia.dia + '</td>';
                            html += '<td>' + dia.diaSemana + '</td>';
                            // Aplicando a formatação R$ 00.000,00 na tabela
                            html += '<td>R$ ' + formatarParaBR(dia.totalVendido) + '</td>';
                            html += '</tr>';
                        });
                    } else {
                        html = '<tr><td colspan="3" class="text-center">Sem vendas neste período</td></tr>';
                    }
                    $('#vendasDiarias' + periodo).html(html);

                    aplicarCoresVendas();
                },
                error: function(xhr, status, error) {
                    console.error('Erro ao buscar dados:', error);
                }
            });
        }
    }

    function navigateFocusableElements(event) {
        const focusableElements = Array.from(
            document.querySelectorAll('input, select, textarea, button, [tabindex]:not([tabindex="-1"])')
        ).filter(element => !element.disabled && element.tabIndex !== -1);

        if (focusableElements.length === 0) return;

        const currentElement = document.activeElement;
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

    document.addEventListener('keydown', navigateFocusableElements);
</script>
</body>
</html>