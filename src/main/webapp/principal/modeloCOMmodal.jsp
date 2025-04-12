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
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table">


                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalProd">
                                                <h4>Configurações de Produtos</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modal2">
                                                <h4>Configurações de Materiais</h4>
                                            </button>

                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">
                                                <h4>Configurações Gerais</h4>
                                            </button>
                                        </div>


                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <%--TODOS MODAIS  --%>
                <div class="row">
                    <div class="col-sm-4 grid-margin">



                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">


                                    <!-- Modal -->
                                    <div class="modal fade" id="modalProd" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticBackdropLabel">Vendas do dia</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">

                                                            <%--body modal 1--%>
                                                            <form id="configForm" method="post"
                                                                  action="<%= request.getContextPath() %>/ServletConfig">

                                                                <div class="row">
                                                                    <div class="col-auto">
                                                                        <span style="color:#1ad76b; text-align: center">${msg}</span>
                                                                    </div>
                                                                </div>

                                                                <div class="row mb-3">
                                                                    <div class="col-sm-1">
                                                                        <label class="float-label">ID:</label>
                                                                        <span class="form-bar"></span>
                                                                        <input type="text" class="form-control" style="background-color: black" id="idConf"
                                                                               name="idConf" placeholder=""
                                                                               value="${modelConfig.idConf}" readonly>
                                                                    </div>


                                                                    <div class="col-4">
                                                                        <label for="prod1_nome">Produto 1 Nome</label>
                                                                        <input type="text" class="form-control" id="prod1_nome"
                                                                               name="prod1_nome" required
                                                                               value="${modelConfig.prod1_nome}">
                                                                    </div>

                                                                    <div class="col-4">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <label for="prod1_valor">Produto 1 Valor</label>
                                                                                <input type="text" class="form-control"
                                                                                       id="prod1_valor" name="prod1_valor"
                                                                                       required
                                                                                       value="${modelConfig.prod1_valor}">
                                                                            </div>

                                                                            <div class="col-6">
                                                                                <label for="prod1_valor2">Produto 1 Valor
                                                                                    2</label>
                                                                                <input type="text" class="form-control"
                                                                                       id="prod1_valor2" name="prod1_valor2"
                                                                                       required
                                                                                       value="${modelConfig.prod1_valor2}">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="row mb-3">
                                                                    <div class="col-4">
                                                                        <label for="prod2_nome">Produto 2 Nome</label>
                                                                        <input type="text" class="form-control" id="prod2_nome"
                                                                               name="prod2_nome" required
                                                                               value="${modelConfig.prod2_nome}">
                                                                    </div>
                                                                    <div class="col-4">
                                                                        <label for="prod2_valor">Produto 2 Valor</label>
                                                                        <input type="text" class="form-control" id="prod2_valor"
                                                                               name="prod2_valor" required
                                                                               value="${modelConfig.prod2_valor}">
                                                                    </div>
                                                                </div>

                                                                <div class="row mb-3">
                                                                    <div class="col-4">
                                                                        <label for="prod3_nome">Produto 3 Nome</label>
                                                                        <input type="text" class="form-control" id="prod3_nome"
                                                                               name="prod3_nome" required
                                                                               value="${modelConfig.prod3_nome}">
                                                                    </div>
                                                                    <div class="col-4">
                                                                        <label for="prod3_valor">Produto 3 Valor</label>
                                                                        <input type="text" class="form-control" id="prod3_valor"
                                                                               name="prod3_valor" required
                                                                               value="${modelConfig.prod3_valor}">
                                                                    </div>
                                                                </div>
                                                                <button type="submit" class="btn btn-outline-success">Salvar
                                                                </button>

                                                            </form>


                                                        </div>

                                                        <div class="row">
                                                            <div class="col">
                                                                <DIV></DIV>

                                                            </div>
                                                            <div class="col">

                                                            </div>

                                                        </div>
                                                        <div class="row">

                                                        </div>
                                                    </div>

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
                    <div class="col-sm-4 grid-margin">


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!--INSERIR BOTÃO 2 AQUI-->
                                    <!-- Button trigger modal -->


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticRanking">RANKING</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <div class="col-lg-6 grid-margin stretch-card">
                                                                <H5>CORPO DO RANKING</H5>
                                                            </div>




                                                        </div>

                                                    </div>

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
                    <div class="col-sm-4 grid-margin">


                        <div class="row">
                            <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                <div class="d-flex d-sm-block d-md-flex align-items-center">
                                    <!--INSERIR BOTÃO 3 AQUI-->
                                    <!-- Button trigger modal -->


                                    <!-- Modal -->
                                    <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-xl mt-5">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticFinalizar">FINALIZAR</h5>

                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="container-fluid">
                                                        <div class="row">
                                                            <div class="col-lg-6 grid-margin stretch-card">
                                                                <H5>CORPO DA FINALIZAÇÃO</H5>
                                                            </div>




                                                        </div>

                                                    </div>

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

                <%--BLOCO 1                --%>
                <style>
                    .minha-tabela {
                        border-collapse: collapse; /* Remove espaço entre as bordas */
                        width: 100%; /* Opcional: para garantir que a tabela ocupe toda a largura */
                    }

                    .minha-tabela td, .minha-tabela th {
                        padding: 2px; /* Diminui o padding das células */
                        vertical-align: middle; /* Alinha verticalmente ao meio */
                        font-size: 14px; /* Ajusta o tamanho da fonte (opcional) */
                    }
                </style>

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">PRODUTOS</h4>
                                <div class="table-responsive">
                                    <table class="table table-bordered minha-tabela">
                                        <thead class="thead-light">

                                        <c:if test="${not empty configs}">
                                        <table class="table table-bordered">

                                            <tr>
                                                <th>Ações</th>
                                                <th>ID</th>
                                                <th>Produto 1</th>
                                                <th>Valor 1</th>
                                                <th>Valor 2</th>
                                                <th>Produto 2</th>
                                                <th>Valor</th>
                                                <th>Produto 3</th>
                                                <th>Valor</th>


                                            </tr>

                                            <tbody>
                                            <c:forEach items="${configs}" var="modelConf">
                                                <tr>
                                                    <td>
                                                        <a class="btn btn-outline-success waves-effect waves-light"
                                                           href="javascript:void(0);"
                                                           data-bs-toggle="modal"
                                                           data-bs-target="#modalProd"
                                                           onclick="gerenciar(
                                                               ${modelConf.idConf},
                                                                   '${modelConf.prod1_nome}',
                                                                   '${modelConf.prod1_valor}',
                                                                   '${modelConf.prod1_valor2}',
                                                                   '${modelConf.prod2_nome}',
                                                                   '${modelConf.prod2_valor}',
                                                                   '${modelConf.prod3_nome}',
                                                                   '${modelConf.prod3_valor}')">
                                                            Editar
                                                        </a>
                                                    </td>
                                                    <td><c:out value="${modelConf.idConf}"/></td>
                                                    <td><c:out value="${modelConf.prod1_nome}"/></td>
                                                    <td><c:out value="${modelConf.prod1_valor}"/></td>
                                                    <td><c:out value="${modelConf.prod1_valor2}"/></td>
                                                    <td><c:out value="${modelConf.prod2_nome}"/></td>
                                                    <td><c:out value="${modelConf.prod2_valor}"/></td>
                                                    <td><c:out value="${modelConf.prod3_nome}"/></td>
                                                    <td><c:out value="${modelConf.prod3_valor}"/></td>

                                                </tr>
                                            </c:forEach>
                                            </tbody>


                                            </c:if>
                                            <c:if test="${empty configs}">
                                            <p>Nenhuma configuração encontrada.</p>
                                            </c:if>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <%--BLOCO 2--%>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">MATERIAL</h4>
                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--BLOCO 3--%>

                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title" style="text-align: center">GERAIS</h4>
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


</SCRIPT>


</body>
</html>
