<%--
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

                </div>
                <div class="row">
                    <div class="col-sm-4 grid-margin">
                        <div class="card">
                            <div class="card-body">

                                <div class="row">
                                    <div class="col-8 col-sm-12 col-xl-8 my-auto">
                                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                                            <!--INSERIR BOTÃO 1 AQUI--><!-- Button trigger modal -->
                                            <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalPDV">
                                                <h4>Venda Diária</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modalPDV" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticBackdropLabel">Vendas do dia</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <label for="PdvId">ID</label>
                                                                        <input type="text" class="form-control" id="PdvId" placeholder="ID">
                                                                    </div>
                                                                    <div class="col-8">
                                                                        <label for="PdvNome">Nome</label>
                                                                        <input type="text" class="form-control" id="PdvNome" placeholder="JEFFERSON CONSTANTINO GUIMARÃES" DISABLED style="background-color: black">

                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="PdvTotal">Total</label>
                                                                        <input type="text" class="form-control" id="PdvTotal" placeholder="143,00" DISABLED style="background-color: black">
                                                                    </div>


                                                                </div>
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <input type="text" class="form-control" id="Hfotos" placeholder="" HIDDEN="" >
                                                                        <label for="nome" style="color: #f2a654; padding-left: 120px;padding-top: 10px; font-size: 30px">FOTOS</label>
                                                                    </div>
                                                                    <div class="col">
                                                                        <input type="text" class="form-control" id="Hencartes" placeholder="" HIDDEN="">
                                                                        <label for="nome" STYLE="color: #00d25b; padding-left: 90px;padding-top: 10px; font-size: 30px">ENCARTES</label>
                                                                    </div>
                                                                    <div class="col">
                                                                        <input type="text" class="form-control" id="Hdigitais" placeholder="" HIDDEN="">
                                                                        <label for="nome" style="color: fuchsia; padding-left: 100px;padding-top: 10px; font-size: 30px">DIGITAIS</label>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <DIV></DIV>
                                                                        <DIV></DIV>
                                                                        <label for="FDin"style="color: #f2a654">DINHEIRO</label>
                                                                        <input type="text" class="form-control" id="FDin" placeholder="" style="background-color: white; color: black">

                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="FtDinValor"style="color: #f2a654">VALOR</label>
                                                                        <input type="text" class="form-control" id="FtDinValor" placeholder="" DISABLED STYLE="background-color: #DAA520">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncDin"style="color: #00d25b">DINHEIRO</label>
                                                                        <input type="text" class="form-control" id="EncDin" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncDinValor"style="color: #00d25b">VALOR</label>
                                                                        <input type="text" class="form-control" id="EncDinValor" placeholder="" DISABLED STYLE="background-color: #2b542c">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigDin"style="color: fuchsia">DINHEIRO</label>
                                                                        <input type="text" class="form-control" id="DigDin" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigiDinValor"style="color: fuchsia">VALOR</label>
                                                                        <input type="text" class="form-control" id="DigiDinValor" placeholder="" DISABLED STYLE="background-color: #6a008a">
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <DIV></DIV>
                                                                        <DIV></DIV>
                                                                        <label for="FtDeb"style="color: #f2a654">DÉBITO</label>
                                                                        <input type="text" class="form-control" id="FtDeb" placeholder="" style="background-color: white; color: black">

                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="FtDebValor"style="color: #f2a654">VALOR</label>
                                                                        <input type="text" class="form-control" id="FtDebValor" placeholder="" DISABLED STYLE="background-color: #DAA520">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncDeb"style="color: #00d25b">DÉBITO</label>
                                                                        <input type="text" class="form-control" id="EncDeb" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncDebValor"style="color: #00d25b">VALOR</label>
                                                                        <input type="text" class="form-control" id="EncDebValor" placeholder="" DISABLED STYLE="background-color: #2b542c">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigDeb"style="color: fuchsia">DÉBITO</label>
                                                                        <input type="text" class="form-control" id="DigDeb" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigDebValor"style="color: fuchsia">VALOR</label>
                                                                        <input type="text" class="form-control" id="DigDebValor" placeholder="" DISABLED STYLE="background-color: #6a008a">
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <DIV></DIV>
                                                                        <DIV></DIV>
                                                                        <label for="FtCred"style="color: #f2a654">CRÉDITO</label>
                                                                        <input type="text" class="form-control" id="FtCred" placeholder="" style="background-color: white; color: black">

                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="FtCredValor"style="color: #f2a654">VALOR</label>
                                                                        <input type="text" class="form-control" id="FtCredValor" placeholder="" DISABLED STYLE="background-color: #DAA520">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncCred"style="color: #00d25b">CRÉDITO</label>
                                                                        <input type="text" class="form-control" id="EncCred" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncCredValor"style="color: #00d25b">VALOR</label>
                                                                        <input type="text" class="form-control" id="EncCredValor" placeholder="" DISABLED STYLE="background-color: #2b542c">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigCred"style="color: fuchsia">CRÉDITO</label>
                                                                        <input type="text" class="form-control" id="DigCred" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigCredValor"style="color: fuchsia">VALOR</label>
                                                                        <input type="text" class="form-control" id="DigCredValor" placeholder="" DISABLED STYLE="background-color: #6a008a">
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <DIV></DIV>
                                                                        <DIV></DIV>
                                                                        <label for="FtPix"style="color: #f2a654">PIX</label>
                                                                        <input type="text" class="form-control" id="FtPix" placeholder="" style="background-color: white; color: black">

                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="FtPixValor"style="color: #f2a654">VALOR</label>
                                                                        <input type="text" class="form-control" id="FtPixValor" placeholder="" DISABLED STYLE="background-color: #DAA520">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncPix"style="color: #00d25b">PIX</label>
                                                                        <input type="text" class="form-control" id="EncPix" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncPixValor"style="color: #00d25b">VALOR</label>
                                                                        <input type="text" class="form-control" id="EncPixValor" placeholder="" DISABLED STYLE="background-color: #2b542c">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="EncPix"style="color: fuchsia">PIX</label>
                                                                        <input type="text" class="form-control" id="DigPix" placeholder="" style="background-color: white; color: black">
                                                                    </div>
                                                                    <div class="col">
                                                                        <label for="DigPixValor"style="color: fuchsia">VALOR</label>
                                                                        <input type="text" class="form-control" id="DigPixValor" placeholder="" DISABLED STYLE="background-color: #6a008a">
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-2">
                                                                        <DIV></DIV>
                                                                        <DIV></DIV>
                                                                        <label for="sobras">SOBRAS</label>
                                                                        <input type="text" class="form-control" id="sobras" placeholder="" style="background-color: #58151c">

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
                                        <i class="icon-lg mdi mdi-hexagon-multiple text-warning ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modalPDV" ></i>
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
                                            <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#modal2">
                                                <h4>Desempenho</h4>
                                            </button>

                                            <!-- Modal -->
                                            <div class="modal fade" id="modal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="staticRanking">RANKING</h5>

                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <div class="col-lg-6 grid-margin stretch-card">
                                                                        <H5>CORPO DO RANKING</H5>
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
                                        <i class="icon-lg mdi mdi-account-star text-success ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modal2" ></i>
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
                                                <h4>Finalizar Dia</h4>
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
                                        <i class="icon-lg mdi mdi-power text-danger ml-auto" type="button"  data-bs-toggle="modal" data-bs-target="#modal3" ></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row ">
                    <div class="col-12 grid-margin">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">PAGINA INICIAL</h4>
                                <div class="table-responsive">
                                    <table class="table">
                                        <!-- INSERIR INFORMAÇÕES PAGINA INICIAL AQUI-->
                                    </table>
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
</body>
</html>
