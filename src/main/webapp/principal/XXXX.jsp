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