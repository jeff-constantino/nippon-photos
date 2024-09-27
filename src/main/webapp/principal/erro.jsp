<%--
  Created by IntelliJ IDEA.
  User: Constantino
  Date: 15/09/2024
  Time: 19:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tela de Erro</title>
</head>
<body>
<h1>Mensagem de Erro, entre em contato com o suporte do sistema!</h1>
<%
out.print(request.getAttribute("msg"));
%>

</body>
</html>
