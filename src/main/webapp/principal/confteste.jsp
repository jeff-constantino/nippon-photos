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
                                                        <div>${msg}</div>
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
                                                                    <label for="data_despesa">Data da Despesa</label>
                                                                    <input type="date" class="form-control" id="data_despesa" name="data_despesa" required
                                                                           value="${formattedDataCompra != null ? formattedDataCompra : ''}">
                                                                </div>

                                                                <div class="col-8">
                                                                    <label for="nome_despesa" class="form-label">Despesa:</label>
                                                                    <input type="text" class="form-control" id="nome_despesa" name="nome_despesa" placeholder=""
                                                                           style="background-color: black; text-transform: uppercase;"
                                                                           value="${modelDespesas.nome_despesa != null ? modelDespesas.nome_despesa : ''}">
                                                                </div>
                                                            </div>

                                                            <div class="row mb-3">
                                                                <div class="col-12">
                                                                    <label style="color: #f2a654;">Descrição</label>
                                                                    <textarea class="form-control" rows="5" style="background-color: #f2a654; color: black; font-weight: bold; text-transform: uppercase;"
                                                                              id="descricao_despesa" name="descricao_despesa" required>
                                                                        ${modelDespesas.descricao_despesa != null ? modelDespesas.descricao_despesa : ''}
                                                                    </textarea>
                                                                </div>
                                                            </div>

                                                            <div class="row mb-3">
                                                                <div class="col-6">
                                                                    <label style="color: #f2a654;">VALOR</label>
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
                                                    <div class="modal-dialog modal-xl mt-5 modal-dialog-scrollable">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="staticRanking">TODAS AS DESPESAS</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="container-fluid">
                                                                    <h3>Todas as Despesas</h3>
                                                                    <div class="table-responsive"> <!-- Adicionando a classe table-responsive -->
                                                                        <table class="table table-striped table-hover"> <!-- Classe table-hover para melhorar a interatividade -->
                                                                            <thead>
                                                                            <tr>
                                                                                <th>ID</th>
                                                                                <th>Nome</th>
                                                                                <th>Descrição</th>
                                                                                <th>Valor</th>
                                                                                <th>Data</th>
                                                                                <th>Ações</th> <!-- Coluna para os botões -->
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <c:forEach items="${todasDespesasList}" var="despesa">
                                                                                <tr>
                                                                                    <td><c:out value="${despesa.id_despesa}"/></td>
                                                                                    <td><c:out value="${despesa.nome_despesa}"/></td>
                                                                                    <td><c:out value="${despesa.descricao_despesa}"/></td>
                                                                                    <td><fmt:formatNumber value="${despesa.valor_despesa}" type="currency" currencySymbol="R$" /></td>
                                                                                    <td><fmt:formatDate value="${despesa.data_despesa}" pattern="dd/MM/yyyy"/></td>
                                                                                    <td>
                                                                                        <form method="post" action="<%= request.getContextPath() %>/ServletDespesas">
                                                                                            <input type="hidden" name="acao" value="excluirDespesa" />
                                                                                            <input type="hidden" name="id_despesa" value="${despesa.id_despesa}" />
                                                                                            <button type="submit" class="btn btn-danger btn-sm">Excluir</button> <!-- Botão menor -->
                                                                                        </form>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">FECHAR</button>
                                                                <button type="button" class="btn btn-outline-warning">ENVIAR</button>
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
                                <button type="button" class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#modalListDespesas">
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
                                            <th scope="col">Opções</th>
                                            <th scope="col">Id Despesa</th>
                                            <th scope="col">Nome Despesa</th>
                                            <th scope="col">Descrição</th>
                                            <th scope="col">Valor</th>
                                            <th scope="col">Data</th>
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
                                                <td>
                                                    <form method="post" action="<%= request.getContextPath() %>/ServletDespesas">
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


    // Inicializa o tooltip com um delay reduzido para aparecer mais rápido
    $(document).ready(function(){
        $('#tooltipButton').tooltip({
            delay: { "show": 100, "hide": 100 } // O tooltip vai aparecer em 100ms
        });
    });


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




</script>
</body>
</html>
