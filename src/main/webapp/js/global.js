$(document).ready(function () {
    var msg = "${msg}"; // Recupera a mensagem da sessão
    console.log("Mensagem recuperada:", msg); // Log para depuração

    // Verifica se a mensagem não está vazia
    if (msg && msg.trim() !== "") {
        console.log("Exibindo modal com mensagem:", msg); // Log para depuração
        $('#msgModal').modal('show'); // Exibe o modal com a mensagem

        // Limpa a mensagem após exibi-la
        $('#msgModal').on('hidden.bs.modal', function () {
            console.log("Modal fechado. Limpando mensagem."); // Log para depuração
            $.post("${pageContext.request.contextPath}/ServletVendas", { acao: "limparMsg" });
        });
    } else {
        console.log("Nenhuma mensagem para exibir."); // Log para depuração
    }
});