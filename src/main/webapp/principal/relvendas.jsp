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
            <div class="content-wrapper">
              <div class="row">
                    <div class="col-xl-12">



                    </div>
                    <div class="row ">
                        <div class="col-12 grid-margin">
                            <div class="card">

                                <div class="card-body" >

                                    <h4 class="card-title">Relatório de Vendas:</h4>

                                    <form action="<%= request.getContextPath() %>/ServletVendas?acao=imprimirRelatorioVendas" method="post" id="formBuscarVenda" name="formBuscarVenda">
                                        <div class="form-row align-items-center">
                                            <div class="col-auto">
                                                <label class="sr-only" for="inlineFormInput">Name</label>
                                                <input type="text" class="form-control mb-2" id="inlineFormInput" placeholder="Jane Doe">
                                            </div>
                                            <div class="col-auto">
                                                <label class="sr-only" for="inlineFormInputGroup">Username</label>
                                                <div class="input-group mb-2">
                                                    <div class="input-group-prepend">
                                                        <div class="input-group-text">@</div>
                                                    </div>
                                                    <input type="text" class="form-control" id="inlineFormInputGroup" placeholder="Username">
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <div class="form-check mb-2">
                                                    <input class="form-check-input" type="checkbox" id="autoSizingCheck">
                                                    <label class="form-check-label" for="autoSizingCheck">
                                                        Remember me
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <button type="submit" class="btn btn-primary mb-2">Submit</button>
                                            </div>
                                        </div>

                                    </form>

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



</body>
</html>