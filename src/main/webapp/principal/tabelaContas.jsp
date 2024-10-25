<tbody>
<c:forEach var="conta" items="${contasList}">
    <tr>
        <td>${conta.conta_id}</td>
        <td>${conta.numero_pedido}</td>
        <td>${conta.empresa}</td>
        <td>${conta.itens}</td>
        <td>${conta.valor}</td>
        <td>${conta.data_de_pedido}</td>
        <td>${conta.data_de_pagamento}</td>
        <td>${conta.status}</td>
    </tr>
</c:forEach>
</tbody>