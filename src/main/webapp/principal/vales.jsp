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
                                            <div class="modal fade" id="modalVales" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl mt-5">
                                                    <div class="modal-content">
                                                          <div class="modal-body">
                                                            <c:if test="${not empty msg}">
                                                                <div>
                                                                    <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                </div>
                                                            </c:if>
                                                            <form action="<%= request.getContextPath() %>/ServletVales" method="post" id="formDataVenda" name="formDaVale">
                                                                <input type="hidden" name="acao" value="inserirVale">
                                                                <div class="form-row align-items-center">
                                                                    <div class="col-2">
                                                                        <label class="float-label">id:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control"
                                                                               id="id_funcionario" name="id_funcionario" placeholder=""
                                                                               style="background-color: black; color: white;  text-transform: uppercase;"
                                                                             READONLY  value="${funcionário.id}">
                                                                    </div>

                                                                    <div class="col-auto">
                                                                        <label for="data">Data</label>
                                                                        <input type="date" class="form-control" id="data" name="data" value="${data}">
                                                                    </div>

                                                                    <div class="col-auto">
                                                                        <label>Funcionário</label>
                                                                        <select class="form-control" id="nome_funcionario" name="nome_funcionario" onchange="atualizarIdFuncionario()">
                                                                            <option value="">Selecione um Funcionário</option>
                                                                            <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                <c:if test="${funcionario.status == 'ATIVO'}">
                                                                                    <option value="${funcionario.nome}"
                                                                                            data-id="${funcionario.id}"
                                                                                            class="text-success"
                                                                                            <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                            ${funcionario.nome}
                                                                                    </option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:forEach var="funcionario" items="${funcionarios}" varStatus="status">
                                                                                <c:if test="${funcionario.status != 'ATIVO'}">
                                                                                    <option value="${funcionario.nome}"
                                                                                            data-id="${funcionario.id}"
                                                                                            class="text-danger"
                                                                                            <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                                                                            ${funcionario.nome}
                                                                                    </option>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </select>

                                                                    </div>
                                                                    <div class="col-6">
                                                                        <label class="float-label">OBSERVAÇÃO:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control"
                                                                               id="observacao" name="observacao" placeholder=""
                                                                               style="background-color: white; color: black;  text-transform: uppercase;"
                                                                               value="${observacao}">
                                                                    </div>
                                                                    <div class="col-3">
                                                                        <label class="float-label">Valor:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="number" class="form-control"
                                                                               id="valor" name="valor" placeholder=""
                                                                               style="background-color: black; color: #DAA520"
                                                                               value="${valor}">
                                                                    </div>

                                                                </div>
                                                                <div class="row">
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
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalVales">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <h4 class="card-title" STYLE="text-align: center">RELATÓRIO DE VALES</h4>

                                <div  style="overflow-x: auto; overflow-y: hidden;">



                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th scope="col">NOME</th>
                                            <th scope="col">DATA</th>
                                            <th scope="col">VALOR</th>
                                            <th scope="col">Id Vale</th>
                                            <th scope="col">OPÇÕES</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="vale" items="${vales}">
                                            <tr>
                                                <td>${vale.nome_funcionario}</td>
                                                <td>${vale.data}</td>
                                                <td>${vale.valor}</td>
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

    $(document).ready(function() {
        var msg = "${msg}";
        if (msg) {
            $('#msgModal').modal('show'); // Exibe o modal com a mensagem
        }
    });



    function atualizarIdFuncionario() {
        const selectElement = document.getElementById("nome_funcionario");
        const selectedOption = selectElement.options[selectElement.selectedIndex];
        const funcionarioId = selectedOption.getAttribute("data-id");
        document.getElementById("id_funcionario").value = funcionarioId || '';
    }

</script>
</body>
</html>
