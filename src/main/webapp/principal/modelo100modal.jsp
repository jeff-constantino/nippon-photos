
<%@ page import="model.ModelLogin" %>
<%@ page import="model.ModelVendas" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <div class="content-wrapper" style="min-height: calc(100vh - 70px);">
                <div class="row">
                    <div class="col-xl-12">



                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">

                                <div class="card-body" >

                                    <h4 class="card-title">Vendas do Dia</h4>

                                    <%--PAGINA PRINCIPAL                  --%>

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
