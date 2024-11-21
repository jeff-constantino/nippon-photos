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
                                                            <form action="<%= request.getContextPath() %>/ServletRelVenda" method="get" id="formDataVenda" name="formDataVenda">
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
                                                                    <div class="col-auto">
                                                                        <label>Funcionário</label>
                                                                        <select class="form-control" id="funcionarioId" name="funcionarioId">
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
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalData">
                                    <h4>Gerar Relatório</h4>
                                </button>
                                <h4 class="card-title" STYLE="text-align: center">RELATÓRIO DE VENDAS</h4>

                                <div  style="overflow-x: auto; overflow-y: hidden;">
                                    <%-- Inicializando as variáveis de soma para cada coluna --%>
                                    <c:set var="totalProd1Din" value="0" />
                                    <c:set var="totalProd1Deb" value="0" />
                                    <c:set var="totalProd1Cred" value="0" />
                                    <c:set var="totalProd1Pix" value="0" />
                                    <c:set var="totalProd2Din" value="0" />
                                    <c:set var="totalProd2Deb" value="0" />
                                    <c:set var="totalProd2Cred" value="0" />
                                    <c:set var="totalProd2Pix" value="0" />
                                    <c:set var="totalProd3Din" value="0" />
                                    <c:set var="totalProd3Deb" value="0" />
                                    <c:set var="totalProd3Cred" value="0" />
                                    <c:set var="totalProd3Pix" value="0" />
                                    <c:set var="totalSobras" value="0" />

                                    <table class="table" id="tabelarelvendas">
                                        <thead>
                                        <tr>

                                            <th scope="col">NOME</th>
                                            <th scope="col">DATA</th>
                                            <th scope="col">Ft Din</th>
                                            <th scope="col">Ft Deb</th>
                                            <th scope="col">Ft Cred</th>
                                            <th scope="col">Ft Pix</th>
                                            <th scope="col">Enc Din</th>
                                            <th scope="col">Enc Deb</th>
                                            <th scope="col">Enc Cred</th>
                                            <th scope="col">Enc Pix</th>
                                            <th scope="col">Dig Din</th>
                                            <th scope="col">Dig Deb</th>
                                            <th scope="col">Dig Cred</th>
                                            <th scope="col">Dig Pix</th>
                                            <th scope="col">Sobras</th>
                                            <th scope="col">Id Venda</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${vendasList}" var="mv">
                                            <tr>
                                                <td><c:out value="${mv.nome}" /></td>
                                                <td><c:out value="${mv.data_venda}" /></td>
                                                <td><c:out value="${mv.prod1_din}" /></td>
                                                <td><c:out value="${mv.prod1_deb}" /></td>
                                                <td><c:out value="${mv.prod1_cred}" /></td>
                                                <td><c:out value="${mv.prod1_pix}" /></td>
                                                <td><c:out value="${mv.prod2_din}" /></td>
                                                <td><c:out value="${mv.prod2_deb}" /></td>
                                                <td><c:out value="${mv.prod2_cred}" /></td>
                                                <td><c:out value="${mv.prod2_pix}" /></td>
                                                <td><c:out value="${mv.prod3_din}" /></td>
                                                <td><c:out value="${mv.prod3_deb}" /></td>
                                                <td><c:out value="${mv.prod3_cred}" /></td>
                                                <td><c:out value="${mv.prod3_pix}" /></td>
                                                <td><c:out value="${mv.sobras}" /></td>
                                                <td><c:out value="${mv.venda_id}" /></td>
                                            </tr>

                                            <%-- Acumulando os valores para cada coluna --%>
                                            <c:set var="totalProd1Din" value="${totalProd1Din + mv.prod1_din}"  />
                                            <c:set var="totalProd1Deb" value="${totalProd1Deb + mv.prod1_deb}" />
                                            <c:set var="totalProd1Cred" value="${totalProd1Cred + mv.prod1_cred}" />
                                            <c:set var="totalProd1Pix" value="${totalProd1Pix + mv.prod1_pix}" />
                                            <c:set var="totalProd2Din" value="${totalProd2Din + mv.prod2_din}" />
                                            <c:set var="totalProd2Deb" value="${totalProd2Deb + mv.prod2_deb}" />
                                            <c:set var="totalProd2Cred" value="${totalProd2Cred + mv.prod2_cred}" />
                                            <c:set var="totalProd2Pix" value="${totalProd2Pix + mv.prod2_pix}" />
                                            <c:set var="totalProd3Din" value="${totalProd3Din + mv.prod3_din}" />
                                            <c:set var="totalProd3Deb" value="${totalProd3Deb + mv.prod3_deb}" />
                                            <c:set var="totalProd3Cred" value="${totalProd3Cred + mv.prod3_cred}" />
                                            <c:set var="totalProd3Pix" value="${totalProd3Pix + mv.prod3_pix}" />
                                            <c:set var="totalSobras" value="${totalSobras + mv.sobras}" />
                                        </c:forEach>

                                        <%-- Exibindo os totais em uma linha ao final da tabela --%>
                                        <tr>
                                            <td colspan="2" style="color: #f2a654"><strong>Total:</strong></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd1Din}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd1Deb}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd1Cred}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd1Pix}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd2Din}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd2Deb}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd2Cred}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd2Pix}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd3Din}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd3Deb}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd3Cred}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalProd3Pix}" /></td>
                                            <td style="color: #f2a654"><c:out value="${totalSobras}" /></td>
                                            <td></td>
                                        </tr>
                                        </tbody>
                                    </table>

                                    <!-- Controles de paginação -->
                                    <div class="pagination">

                                        <c:forEach var="i" begin="1" end="${totalPaginas}">
                                            <a href="ServletRelVenda?acao=imprimirRelatorioVendas&pagina=${i}" class="page-link ${i == paginaAtual ? 'active' : ''}">${i}</a>
                                        </c:forEach>

                                    </div>
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


    window.onload = function() {
        fetch('ServletRelVenda')
            .then(response => response.text())
            .then(data => {
                document.getElementById('resultado').innerHTML = data;
            })
            .catch(error => console.error('Erro:', error));
    }

</script>
</body>
</html>
