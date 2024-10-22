// Verifica a ação do botão
String acao = request.getParameter("acao");


if ("atualizarFechamento".equals(acao)) {
// Chama o método para atualizar o fechamento
try {
daoFechaDia.atualizarFechamento(fechamento);
request.setAttribute("msg", "Fechamento atualizado com sucesso!"); // Mensagem de sucesso
} catch (Exception e) {
request.setAttribute("msg", "Erro ao atualizar o fechamento: " + e.getMessage()); // Mensagem de erro
}
} else {
// Verifica se já existe um fechamento com a mesma data, somente se não for atualizar
if (daoFechaDia.verificarExistenciaFechamento(fechamento.getData_fechamento().toLocalDate())) {
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); // Formato desejado
String dataFormatada = sdf.format(fechamento.getData_fechamento());
request.setAttribute("msg", "Já existe um fechamento com a data " + dataFormatada);
request.setAttribute("atualizacaoNecessaria", true); // Indica que uma atualização é necessária
} else {
// Gravar no banco de dados
try {
daoFechaDia.gravarFechamento(fechamento);
request.setAttribute("msg", "Fechamento gravado com sucesso!"); // Mensagem de sucesso
} catch (Exception e) {
request.setAttribute("msg", "Erro ao gravar o fechamento: " + e.getMessage()); // Mensagem de erro
}
}
}

// Encaminhar para a página apropriada
RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
dispatcher.forward(request, response);
}




String acao = request.getParameter("acao");

// Verifica se a ação é vazia ou nula
if (acao == null || acao.isEmpty()) {
// Redireciona para a página principal se a ação não for fornecida
response.sendRedirect("principal/fechadia.jsp");
return; // Importante retornar para evitar que o código continue
}

// Lógica para "buscarfechamento"
if (acao.equals("buscarfechamento")) {
try {
// Obtém a data da requisição (formato a ser ajustado conforme necessário)
String dataParam = request.getParameter("data_fechamento");
Date dataFechamento = Date.valueOf(dataParam); // Certifique-se de que o formato está correto

// Chame o DAO ou serviço para buscar os dados de fechamento
DAOFechaDia daoFechamento = new DAOFechaDia();
ModelFechaDia fechamento = daoFechamento.buscarFechamento(dataFechamento); // Passando a data como argumento

// Adiciona o fechamento na requisição
request.setAttribute("fechamento", fechamento);

// Encaminha a requisição para a página JSP
RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
dispatcher.forward(request, response);

} catch (SQLException e) {
// Tratamento de erro SQL (exemplo: log e mensagem de erro)
e.printStackTrace(); // Log do erro para análise
request.setAttribute("msgErro", "Erro ao buscar fechamento: " + e.getMessage());

// Redireciona para uma página de erro ou volta para a mesma página com a mensagem de erro
RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
dispatcher.forward(request, response);

} catch (Exception e) {
// Tratamento de erro genérico (caso surja alguma outra exceção inesperada)
e.printStackTrace(); // Log do erro para análise
request.setAttribute("msgErro", "Erro inesperado: " + e.getMessage());

// Redireciona para uma página de erro ou volta para a mesma página com a mensagem de erro
RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
dispatcher.forward(request, response);
}
return; // Interrompe a execução após o forward
}

// Se a ação não for "buscarfechamento", redireciona para a página principal
RequestDispatcher dispatcher = request.getRequestDispatcher("principal/fechadia.jsp");
dispatcher.forward(request, response);
}