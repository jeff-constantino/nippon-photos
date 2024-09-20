<%@ page import="model.ModelLogin" %><%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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

                </div>
                <div class="row">
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
         <!--INSERIR BOTÃO 1 AQUI--><!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalCad">
                                                <h4>Cadastrar</h4>
                                            </button>

                                            <!-- Modal -->

                                            <div class="modal fade" id="modalCad" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Cadastro de Funcionário     </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>

                                                        <div class="container-fluid">
                                                            <div class="page-body">

                                                                <div class="row">
                                                                    <div class="col-auto">
                                                        <span span style="color:#f2a654">${msg}</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">


                                                                                    <form class="form-material"  action="<%= request.getContextPath() %>/ServletUsuarioController" method="post" id="formUser" >


                                                                                        <div class="row">

                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label" >ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="id2" name="id" placeholder="" readonly value="${modelLogin.id}">
                                                                                            </div>
                                                                                            <div class="col-8">
                                                                                                <label class="float-label">NOME:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="nome2" name="nome" placeholder=""  style="background-color: black" REQUIRED value="${modelLogin.nome}" autofocus>

                                                                                            </div>


                                                                                            <div class="form-group">

                                                                                                <label>STATUS</label>
                                                                                                <select class="form-select" id="status1" name="status">
                                                                                                    <option disabled="disabled">Selecione o Status</option>
                                                                                                    <option style="color: #00d25b" value="Ativo"  <%
                                                                                                        ModelLogin modelLogin =(ModelLogin) request.getAttribute("modelLogin");
//                                                                                                        System.out.println(modelLogin.getStatus());
                                                                                                        if (modelLogin != null && modelLogin.getStatus() =="Ativo"){
                                                                                                        out.print(" ");
                                                                                                         out.print("selected=\"selected\"");
                                                                                                         out.print(" ");
                                                                                                    }%>>Ativo</option>

                                                                                                    <option style="color: #bf3322" value="Inativo" <%
                                                                                                        modelLogin =(ModelLogin) request.getAttribute("modelLogin");
                                                                                                        if (modelLogin != null && modelLogin.getStatus() =="Inativo"){
                                                                                                        out.print(" ");
                                                                                                        out.print("selected=\"selected\"");
                                                                                                        out.print(" ");
                                                                                                    }%>>Inativo</option>

                                                                                                </select>
                                                                                            </div>
                                                                                            <div>
                                                                                                <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparForm();" >Novo</button>
                                                                                                <button  class="btn btn-outline-success waves-effect waves-light" >Cadastrar</button>
<%--  BOTOES MODAL--%>
                                                                                            </div>

                                                                                        </div>
                                                                                    </form>

                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-multiple-plus text-success ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalCad" ></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">

 <!--INSERIR BOTÃO 2 AQUI-->
                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-behance" data-bs-toggle="modal" data-bs-target="#modalBusca">
                                                <h4>Consultar</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalBusca" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" >Pesquisa de Funcionário     </h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>

                                                        <div class="container-fluid">
                                                            <div class="page-body">

                                                                <div class="row">
                                                                    <div class="col-auto">
                                                                        <span span style="color:#f2a654">${msg}</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="modal-body" >
                                                            <div class="container-fluid">
                                                                <div class="page-body">

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <!-- Basic Form Inputs card start -->
                                                                            <div class="card">
                                                                                <div class="card-block">

                                                                                    <form class="form-material"  id="formBuscaUser" method="get" action="<%= request.getContextPath() %>/ServletUsuarioController">

                                                                                        <div class="row">




                                                                                            <div class="col-sm-1">
                                                                                                <label class="float-label" >ID:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="idBusca" name="id" placeholder="" readonly value="${modelLogin.id}">
                                                                                            </div>
                                                                                            <div class="col-4">
                                                                                                <label class="float-label">NOME:</label>
                                                                                                <span class="form-bar"></span>
                                                                                                <input type="text" class="form-control" id="nomeBusca" name="nome" placeholder=""  style="background-color: black" REQUIRED value="${modelLogin.nome}" autofocus>

                                                                                            </div>

                                                                                            <div>
                                                                                                <button type="button" class="btn btn-outline-primary waves-effect waves-light" onclick="limparbuscaForm();" >Novo</button>
                                                                                                <button  type="button" class="btn btn-outline-success waves-effect waves-light" onclick="buscarUsuario();">Pesquisar</button>
 <%--  BOTOES MODAL busca--%>
                                                                                            </div>
                                                                                            <div style="overflow-x: hidden">
                                                                                            <div style="height: 300px; overflow-y: auto ">
                                                                                                <table class="table" id="tabelaresultados">
                                                                                                    <thead>
                                                                                                    <tr>
                                                                                                        <th scope="col">ID</th>
                                                                                                        <th scope="col">NOME</th>
                                                                                                        <th scope="col">GERENCIAR</th>

                                                                                                    </tr>
                                                                                                    </thead>
                                                                                                    <tbody>

                                                                                                    </tbody>
                                                                                                </table>

                                                                                            </div>
                                                                                            </div>
                                                                                            <span id="totalResultados"></span>

                                                                                        </div>

                                                                                    </form>

                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                   <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-question text-behance ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalbusca" ></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                                            <!--INSERIR BOTÃO 3 AQUI-->
                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal3">
                                                <h4>Excluir</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modal3" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
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
                                                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">SAIR</button>
                                                            <button type="button" class="btn btn-outline-warning">ENVIAR</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                                        <i class="icon-lg mdi mdi-account-remove text-danger ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modal3" ></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body" >
                                <h4 class="card-title">FUNCIONÁRIOS</h4> <span style="color: #f2a654" id="msg">${msg}</span>
                                <div class="table-responsive"style="overflow-x: hidden">
                                    <table class="table" >
 <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                        <form action="<%= request.getContextPath() %>/ServletUsuarioController" method="post" id="formUser2" name="formUser2" >
                                            <input type="hidden" name="acao" acao value="">
                                            <div class="row">

                                                <div class="col-sm-1">
                                                    <label class="float-label" >ID:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control" id="id" name="id" placeholder="" readonly value="${modelLogin.id}">
                                                </div>
                                                <div class="col-8">
                                                    <label class="float-label">NOME:</label>
                                                    <span class="form-bar"></span>
                                                    <input type="text" class="form-control" id="nome" name="nome" placeholder=""  style="background-color: black" REQUIRED value="${modelLogin.nome}">

                                                    <br>
                                                    <div class="form-group">

                                                        <label>STATUS</label>
                                                        <select class="form-select" id="status2" name="status">
                                                            <option disabled="disabled">Selecione o Status</option>
                                                            <option style="color: #00d25b" value="Ativo"  <%
                                                                modelLogin =(ModelLogin) request.getAttribute("modelLogin");
                                                                if (modelLogin != null && modelLogin.getStatus() =="Ativo"){
                                                                    out.print(" ");
                                                                    out.print("selected=\"selected\"");
                                                                    out.print(" ");
                                                                }%>>Ativo</option>

                                                            <option style="color: #bf3322" value="Inativo" <%
                                                                modelLogin =(ModelLogin) request.getAttribute("modelLogin");
                                                                if (modelLogin != null && modelLogin.getStatus() =="Inativo"){
                                                                    out.print(" ");
                                                                    out.print("selected=\"selected\"");
                                                                    out.print(" ");
                                                                }%>>Inativo</option>

                                                        </select>
                                                    </div>

                                                </div>


                                                <br>

                                                <div>
                                                    <button  class="btn btn-outline-success waves-effect waves-light" >Atualizar</button>
                                                    <button type="button"  class="btn btn-outline-danger waves-effect waves-light" onclick="criarDeleteComAjax();" >Excluir</button>
                                                </div>

                                            </div>

                                        </form>

                                    </table>
                                    <h5>Funcionários Cadastrados:</h5>


                                    <div style="overflow-x: hidden">
                                        <div style="height: 300px; overflow-y: auto ">
                                            <table class="table" id="tabelaresultadosview">
                                                <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">NOME</th>
                                                    <th scope="col">GERENCIAR</th>

                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach items="${modelLogins}" var ="mL">
                                                    <tr>
                                                        <td>
                                                            <c:out value="${mL.id}"></c:out>
                                                        </td>
                                                        <td>
                                                            <c:out value="${mL.nome}"></c:out>
                                                        </td>
                                                        <td><a class="btn btn-outline-success waves-effect waves-light" href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${mL.id}" >Gerenciar</a></td>

                                                    </tr>

                                                </c:forEach>


                                                </tbody>
                                            </table>

                                        </div>
                                    </div>

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
<SCRIPT type="text/javascript">
    function verEditar(id){
        var urlAction = document.getElementById('formBuscaUser').action;

       window.location.href = urlAction + '?acao=buscarEditar&id='+id;
    }


    function criarCadastro(){
       document.getElementById("acao").value = 'cadastrar';
        document.getElementById("formUser").submit();



    }

    function buscarUsuario(){
        var nomeBusca = document.getElementById('nomeBusca').value;
        //valida que precisa ter valor para continuar BUSCANDO
        if (nomeBusca != null && nomeBusca !='' && nomeBusca.trim() != ''){
            var urlAction = document.getElementById('formBuscaUser').action;
            $.ajax({
                method: 'GET',
                url : urlAction,
                data : "nomeBusca=" + nomeBusca + '&acao=buscaruserajax',
                success : function (response){
                    const json = JSON.parse(response);


                    $('#tabelaresultados > tbody > tr').remove();
                  for (var p = 0; p < json.length; p++){
                      $('#tabelaresultados > tbody').append('<tr> <td>' + json[p].id + '</td> <td>' +json[p].nome+ '</td> <td> <button  type="button" class="btn btn-outline-success waves-effect waves-light" onclick="verEditar('+json[p].id+')">Editar</button></td></tr>');

                  }
                  document.getElementById('totalResultados').textContent = 'Resultados: '+json.length;

                }

            }).fail(function (xhr, status, errorThrown){
                alert('Erro ao Pesquisar o Funcionário :'+xhr.responseText);
            });

        }

    }


    function criarDeleteComAjax(){
        if (confirm('Deseja realmente excluir o Funcionário?')){
            var urlAction = document.getElementById('formUser2').action;
            var idUser = document.getElementById('id').value;

            $.ajax({
                method : "get",
                url : urlAction,
                data : "id=" + idUser + '&acao=deletarajax',
                success : function (response){
                    limparForm2();
                    document.getElementById('msg').textContent = response;
                }

            }).fail(function (xhr, status, errorThrown){
                alert('Erro ao Excluir o Funcionário :'+xhr.responseText);
            });
        }
    }

    function criarDelete() {
        if (confirm('Deseja realmente excluir o Funcionário?')) {

            document.getElementById("formUser2").method = 'get';
            document.getElementById("acao").value = 'deletar';
            document.getElementById("formUser2").submit();

        }
    }




    function limparForm(){
        var elementos =document.getElementById("formUser").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }
    function limparForm2(){
        var elementos =document.getElementById("formUser2").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }
    function  limparbuscaForm(){
        var elementos =document.getElementById("formBuscaUser").elements;
        for (p=0;p<elementos.length;p++){
            elementos[p].value = '';
        }

    }





</SCRIPT>
</body>
</html>
