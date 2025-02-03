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
                                            <div class="modal fade" id="modalDespesa" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                          <div class="modal-body">
                                                            <c:if test="${not empty msg}">
                                                                <div class="alert alert-info">${msg}</div>
                                                            </c:if>
<%-- INSERIR PAGINA MODAL AQUI--%>
                                                              <form action="<%= request.getContextPath() %>/ServletDespesas" method="post" id="gravarDespesa" name="lançarDespesa">
                                                                  <input type="hidden" name="acao" value="gravarDespesa" />
                                                                  <input type="hidden" id="valorOriginal" name="valorOriginal">

                                                                  <div class="container mt-4">
                                                                      <div class="row">
                                                                          <div class="col-12">
                                                                              <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                          </div>
                                                                      </div>

                                                                      <div class="row mb-3">
                                                                          <div class="col-4">
                                                                              <label for="data_despesa">DATA DA DESPESA</label>
                                                                              <input type="date" class="form-control" id="data_despesa" name="data_despesa" required
                                                                                     value="${formattedDataCompra != null ? formattedDataCompra : ''}">
                                                                          </div>

                                                                          <div class="col-8">
                                                                              <label for="nome_despesa" class="form-label">DESPESA:</label>
                                                                              <input type="text" class="form-control" id="nome_despesa" name="nome_despesa" placeholder=""
                                                                                     style="background-color: black; text-transform: uppercase;"
                                                                                     value="${modelDespesas.nome_despesa != null ? modelDespesas.nome_despesa : ''}">
                                                                          </div>
                                                                      </div>

                                                                      <div class="row mb-3">
                                                                          <div class="col-12">
                                                                              <label>DESCRIÇÃO</label>
                                                                              <input type="text" class="form-control" style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;"
                                                                                        id="descricao_despesa" name="descricao_despesa" required>
                                                                                  ${modelDespesas.descricao_despesa != null ? modelDespesas.descricao_despesa : ''}
                                                                              </input>
                                                                          </div>
                                                                      </div>

                                                                      <div class="row mb-3">
                                                                          <div class="col-6">
                                                                              <label>VALOR</label>
                                                                              <div class="input-group">
                                                                                  <div class="input-group-prepend">
                                                                                      <span class="input-group-text" style="color: #f2a654; font-weight: bold">R$</span>
                                                                                  </div>
                                                                                  <input type="text" class="form-control" style="background-color: #f2a654; color: black; font-weight: bold"
                                                                                         id="valor_despesa" name="valor_despesa_exibido" required oninput="formatarValor(this);"
                                                                                         value="${modelDespesas.valor_despesa != null ? modelDespesas.valor_despesa : ''}">
                                                                                  <input type="hidden" id="valorBruto" name="valor_despesa" value="">
                                                                              </div>
                                                                          </div>
                                                                          <div class="col-3">
                                                                              <label>FORMA DE PAGAMENTO</label>
                                                                              <select class="form-select" id="pagamentoDespesa" name="pagamento_despesa"
                                                                                      required>
                                                                                  <option style="color: #0a58ca"
                                                                                          value="---------" ${modelDespesas.pagamento_despesa == '---------' ? 'selected' : ''}>
                                                                                      ---------
                                                                                  </option>
                                                                                  <option style="color:white"
                                                                                          value="dinheiro" ${modelDespesas.pagamento_despesa == 'DINHEIRO' ? 'selected' : ''}>
                                                                                      DINHEIRO
                                                                                  </option>
                                                                                  <option style="color: #DAA520"
                                                                                          value="cartao" ${modelDespesas.pagamento_despesa == 'CARTAO' ? 'selected' : ''}>
                                                                                      CARTÃO
                                                                                  </option>
                                                                                  <option style="color: #00d25b"
                                                                                          value="pix" ${modelDespesas.pagamento_despesa == 'PIX' ? 'selected' : ''}>
                                                                                      PIX
                                                                                  </option>
                                                                              </select>
                                                                          </div>
                                                                      </div>

                                                                      <div class="row">
                                                                          <div class="col-12 mt-3">
                                                                              <button type="submit" class="btn btn-outline-success waves-effect waves-light">Salvar</button>
                                                                              <button type="button" class="btn btn-outline-warning waves-effect waves-light" onclick="limparGravarDespesa();">Limpar</button>
                                                                          </div>
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

<%--modallistDespesas--%>
                                            <div>
                                                <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                                    <div class="d-flex d-sm-block d-md-flex align-items-center">
                                                        <div class="modal fade" id="modalListDespesas" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-xl" style="height: 100vh; width: auto; max-width: none;"> <!-- Altura total da viewport e largura ajustável -->
                                                                <div class="modal-content" style="height: 100%; margin: 0;"> <!-- Altura total do modal -->
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="staticRanking">TODAS AS DESPESAS</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body" style="height: calc(100% - 56px); overflow:  hidden;"> <!-- Ajusta altura do corpo do modal e remove rolagem -->
                                                                        <div class="container-fluid h-100"> <!-- Altura total do container -->

                                                                            <form id="modalDespesas" action="ServletDespesas" method="get">
<%--                                                                                <input type="hidden" name="acao" value="imprimirRelatorioDespesas">--%>
                                                                                <input type="hidden" name="pagina" id="pagina" value="1"> <!-- ID para manipulação via JavaScript -->
                                                                                <div class="row h-100"> <!-- Altura total para a linha -->
                                                                                    <div class="col-lg-12 grid-margin stretch-card h-100"> <!-- Altura total para a coluna -->
                                                                                        <div class="table-responsive h-100"> <!-- Altura total para a tabela -->
                                                                                            <table class="table table-striped table-bordered" id="tabelaContas">
                                                                                                <thead>
                                                                                                <tr>
                                                                                                    <th>ID</th>
                                                                                                    <th>Nome</th>
                                                                                                    <th>Descrição</th>
                                                                                                    <th>Valor</th>
                                                                                                    <th>Data</th>
                                                                                                    <th>Forma de Pagamento</th>
                                                                                                    <th>Opções</th> <!-- Coluna para os botões -->
                                                                                                </tr>
                                                                                                </thead>
                                                                                                <tbody id="tabelaContasBody">
                                                                                                <!-- As linhas da tabela serão inseridas aqui via AJAX -->
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </form>


                                                                        </div>
                                                                    </div>
                                                                    <!-- Paginação -->
                                                                    <div class="pagination">

                                                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                                                            <a href="#" class="btn btn-outline-primary page-link" data-pagina="${i}">${i}</a>
                                                                        </c:forEach>

                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                                                    </div>
                                                                </div>
                                                            </div>
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
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalDespesa">
                                    <h4>Lançar Despesas</h4>
                                </button>
                                <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalListDespesas">
                                    <h4>Todas as Despesas</h4>
                                </button><div>
                                <span style="color:#1ad76b; text-align: center">${msg}</span>
                            </div>
                                <h4 class="card-title" style="text-align: center">Informações da Despesa</h4>
                                <div>


                                </div>

                                <div style="height: 300px; overflow-y: auto;">

                                    <table class="table" id="tabelareldespesas">
                                        <thead>
                                        <tr>
                                            <th scope="col">Id Despesa</th>
                                            <th scope="col">Nome Despesa</th>
                                            <th scope="col">Descrição</th>
                                            <th scope="col">Valor</th>
                                            <th scope="col">Data</th>
                                            <th scope="col">Forma de Pagamento</th>
                                            <th scope="col">Opções</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${despesasList}" var="despesa">
                                            <tr>
                                                <td><c:out value="${despesa.id_despesa}"/></td>
                                                <td><c:out value="${despesa.nome_despesa}"/></td>
                                                <td><c:out value="${despesa.descricao_despesa}"/></td>

                                                <td><fmt:formatNumber value="${despesa.valor_despesa}" type="currency" currencySymbol="R$" /></td>

                                                <td><fmt:formatDate value="${despesa.data_despesa}" pattern="dd/MM/yyyy"/></td> <!-- Formata a data -->
                                                <td><c:out value="${despesa.pagamento_despesa}"/></td>

                                                <td>
                                                    <form method="get" action="<%= request.getContextPath() %>/ServletDespesas">
                                                        <input type="hidden" name="acao" value="excluirDespesa" />
                                                        <input type="hidden" name="id_despesa" value="${despesa.id_despesa}" />
                                                        <button type="submit" class="btn btn-danger">Excluir</button>
                                                    </form>
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

    function formatarValor(input) {
        // Remove caracteres não numéricos exceto vírgulas e pontos
        let valor = input.value.replace(/\D/g, '');

        // Formata o valor para exibição
        if (valor) {
            valor = (valor / 100).toFixed(2); // Converte para formato decimal
            valor = valor.replace('.', ','); // Troca ponto por vírgula (para exibição)
            valor = valor.replace(/\B(?=(\d{3})+(?!\d))/g, '.'); // Adiciona separadores de milhar (para exibição)
        }

        // Atualiza o campo de exibição com formatação
        input.value = valor;

        // Atualiza o campo oculto com o valor sem formatação de milhar e com ponto como decimal
        const valorSemFormatacao = input.value.replace(/\./g, '').replace(',', '.'); // Remove separadores de milhar e troca vírgula por ponto
        document.getElementById('valorBruto').value = valorSemFormatacao;
    }





    function limparGravarDespesa() {
        // Limpa os campos do formulário
        $('#gravarDespesa')[0].reset();
    }

    function formatarData(data) {
        // Função para formatar a data no formato 'dd/MM/yyyy'
        var partes = data.split('-'); // Divide a data no formato 'yyyy-MM-dd'
        if (partes.length === 3) {
            return `${partes[2]}/${partes[1]}/${partes[0]}`; // Converte 'yyyy-MM-dd' para 'dd/MM/yyyy'
        }
        return data; // Retorna a data original se não estiver no formato esperado
    }

    document.addEventListener("DOMContentLoaded", function() {
        // Itera sobre as células com a classe 'data-despesa' e aplica a formatação
        document.querySelectorAll('.data-despesa').forEach(function (element) {
            var dataOriginal = element.textContent.trim(); // Obtém o texto da célula
            if (dataOriginal) { // Verifica se há conteúdo
                var dataFormatada = formatarData(dataOriginal); // Formata a data
                element.textContent = dataFormatada; // Substitui o texto original pela data formatada
            }
        });
    });



    function excluirDespesa(id_despesa) {
        if (confirm("Tem certeza que deseja excluir esta despesa?")) {
            // Enviar a requisição para a servlet
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "<%= request.getContextPath() %>/ServletDespesas", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onload = function() {
                if (xhr.status === 200) {
                    // Atualize a página ou remova a linha da tabela
                    alert("Despesa excluída com sucesso!");
                    // Opcional: você pode remover a linha da tabela diretamente, se desejar
                    location.reload(); // Atualiza a página para refletir as mudanças
                } else {
                    alert("Erro ao excluir a despesa.");
                }
            };

            xhr.send("acao=excluirDespesa&id_despesa=" + id_despesa);
        }
    }

    function carregarDespesas(pagina = 1) {
        $.ajax({
            url: 'ServletDespesas',
            method: 'GET',
            data: {
                acao: 'imprimirRelatorioDespesas',
                pagina: pagina // Passando a página atual
            },
            success: function(data) {
                $('#modalListDespesas tbody').html(data); // Atualiza apenas o tbody com os dados retornados
                $('#pagina').val(pagina); // Atualiza o valor da página no formulário oculto, se necessário
            },
            error: function() {
                console.error('Erro ao carregar despesas.');
            }
        });
    }

    // Evento para abrir o modal e carregar as despesas apenas ao abrir
    $('#modalListDespesas').on('shown.bs.modal', function() {
        carregarDespesas(); // Carrega as despesas ao abrir o modal
    });

    // Lógica para a paginação
    $(document).on('click', '.pagination a', function(event) {
        event.preventDefault(); // Impede o comportamento padrão do link
        const pagina = $(this).data('pagina'); // Obtém o número da página
        carregarDespesas(pagina); // Chama a função correta para carregar as despesas
    });


</script>
</body>
</html>
