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
                        <c:forEach var="funcionario" items="${funcionarios}">
                            <option value="${funcionario.id}"
                                    class="${funcionario.status == 'Ativo' ? 'text-success' : 'text-danger'}"
                                    <c:if test="${funcionario.id == funcionarioId}">selected</c:if>>
                                    ${funcionario.nome}
                            </option>
                        </c:forEach>
                    </select>
                </div>


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




document.addEventListener("DOMContentLoaded", function() {
fetch('ServletRelVenda')
.then(response => response.text())
.then(data => {
const resultadoElement = document.getElementById('resultado');
if (resultadoElement) {  // Verifique se o elemento existe
resultadoElement.innerHTML = data;
} else {
console.error("Elemento 'resultado' não encontrado no DOM.");
}
})
.catch(error => console.error('Erro:', error));
});
