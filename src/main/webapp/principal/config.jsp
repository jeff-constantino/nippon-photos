<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelConfig" %>
<%@ page import="dao.DAOConfig" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="pt-br">
<jsp:include page="header.jsp"></jsp:include>

<body>
<div class="container-scroller">
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div class="container-fluid page-body-wrapper">
        <jsp:include page="navbar.jsp"></jsp:include>
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-xl-12">
                        <h4 class="card-title">Configuração de Produtos</h4>
                        <div class="card">
                            <div class="card-body">
                                <form id="configForm" method="post" action="<%= request.getContextPath() %>/ServletConfig" >

                                    <div class="row mb-3">
                                        <div class="col-sm-1">
                                            <label class="float-label">ID:</label>
                                            <span class="form-bar"></span>
                                            <input type="text" class="form-control" id="idConf" name="idConf" placeholder="" value="${modelConfig.idConf}" readonly>
                                        </div>

                                        <div class="row">
                                            <div class="col-auto">
                                                <span id="msg" style="color:#f2a654">${msg}</span>
                                            </div>
                                        </div>

                                        <div class="col-4">
                                            <label for="prod1_nome">Produto 1 Nome</label>
                                            <input type="text" class="form-control" id="prod1_nome" name="prod1_nome" required value="${modelConfig.prod1_nome}">
                                        </div>

                                        <div class="col-4">
                                            <div class="row">
                                                <div class="col-6">
                                                    <label for="prod1_valor">Produto 1 Valor</label>
                                                    <input type="text" class="form-control" id="prod1_valor" name="prod1_valor" required value="${modelConfig.prod1_valor}">
                                                </div>

                                                <div class="col-6">
                                                    <label for="prod1_valor2">Produto 1 Valor 2</label>
                                                    <input type="text" class="form-control" id="prod1_valor2" name="prod1_valor2" required value="${modelConfig.prod1_valor2}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <label for="prod2_nome">Produto 2 Nome</label>
                                            <input type="text" class="form-control" id="prod2_nome" name="prod2_nome" required value="${modelConfig.prod2_nome}">
                                        </div>
                                        <div class="col-4">
                                            <label for="prod2_valor">Produto 2 Valor</label>
                                            <input type="text" class="form-control" id="prod2_valor" name="prod2_valor" required value="${modelConfig.prod2_valor}">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <label for="prod3_nome">Produto 3 Nome</label>
                                            <input type="text" class="form-control" id="prod3_nome" name="prod3_nome" required value="${modelConfig.prod3_nome}">
                                        </div>
                                        <div class="col-4">
                                            <label for="prod3_valor">Produto 3 Valor</label>
                                            <input type="text" class="form-control" id="prod3_valor" name="prod3_valor" required value="${modelConfig.prod3_valor}">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-4">
                                            <label for="comissao">Comissão</label>
                                            <input type="text" class="form-control" id="comissao" name="comissao" required value="${modelConfig.comissao}">
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-outline-success">Salvar</button>

                                </form>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xl-12">
                        <h4 class="card-title">Consultas de Configurações</h4>
                        <div class="card">
                            <div class="card-body">
                                <c:if test="${not empty configs}">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>Ações</th>
                                            <th>ID</th>
                                            <th>Produto 1 Nome</th>
                                            <th>Produto 1 Valor</th>
                                            <th>Produto 1 Valor 2</th>
                                            <th>Produto 2 Nome</th>
                                            <th>Produto 2 Valor</th>
                                            <th>Produto 3 Nome</th>
                                            <th>Produto 3 Valor</th>
                                            <th>Comissão</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${configs}" var="modelConf">
                                            <tr>
                                                <td>
                                                    <a class="btn btn-outline-success waves-effect waves-light"
                                                       href="javascript:void(0);"
                                                       onclick="gerenciarConfig(
                                                           ${modelConf.idConf},
                                                               '${modelConf.prod1_nome}',
                                                               '${modelConf.prod1_valor}',
                                                               '${modelConf.prod1_valor2}',
                                                               '${modelConf.prod2_nome}',
                                                               '${modelConf.prod2_valor}',
                                                               '${modelConf.prod3_nome}',
                                                               '${modelConf.prod3_valor}',
                                                               '${modelConf.comissao}')">
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
                                                <td><c:out value="${modelConf.comissao}"/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>


                                    </c:if>
                                <c:if test="${empty configs}">
                                    <p>Nenhuma configuração encontrada.</p>
                                </c:if>


                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="footer.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
<jsp:include page="pluginsJS.jsp"></jsp:include>

<script>
    function gerenciarConfig(idConf, prod1_nome, prod1_valor, prod1_valor2, prod2_nome, prod2_valor, prod3_nome, prod3_valor, comissao) {
        document.getElementById('idConf').value = idConf;
        document.getElementById('prod1_nome').value = prod1_nome;
        document.getElementById('prod1_valor').value = prod1_valor;
        document.getElementById('prod1_valor2').value = prod1_valor2;
        document.getElementById('prod2_nome').value = prod2_nome;
        document.getElementById('prod2_valor').value = prod2_valor;
        document.getElementById('prod3_nome').value = prod3_nome;
        document.getElementById('prod3_valor').value = prod3_valor;
        document.getElementById('comissao').value = comissao;
    }






</script>
</body>
</html>
