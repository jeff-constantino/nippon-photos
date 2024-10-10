<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
        <a class="sidebar-brand brand-logo" href="<%= request.getContextPath() %>/ServletPrincipal"><img src="<%= request.getContextPath() %>/assets/images/logo.svg" alt="logo" /></a>
        <a class="sidebar-brand brand-logo-mini" href="<%= request.getContextPath() %>/ServletPrincipal"><img src="<%= request.getContextPath() %>/assets/images/logo-mini.svg" alt="logo" /></a>
    </div>
    <br>
    <div class="dropdown-divider"></div>
    <ul class="nav">
        <li class="nav-item profile">
            <div class="profile-desc">
                <div class="profile-pic">
                    <div class="count-indicator">
                        <img class="img-xs rounded-circle " src="<%= request.getContextPath() %>/assets/images/faces/face.jpg" alt="">
                        <span class="count bg-success"></span>
                    </div>
                    <div class="profile-name">
                        <h5 class="mb-0 font-weight-normal"><%=request.getSession().getAttribute("usuario") %></h5>

                    </div>
                </div>

            </div>
        </li>
        <li class="nav-item nav-category">
            <span class="nav-link" href="<%= request.getContextPath() %>/ServletPrincipal">ADMINISTRAÇÃO</span>
        </li>
        <li class="nav-item menu-items">
            <a class="nav-link" href="<%= request.getContextPath() %>/ServletPrincipal">
              <span class="menu-icon">
                <i class="mdi mdi-speedometer"></i>
              </span>
                <span class="menu-title">Inicio</span>
            </a>
        </li>


        <li class="nav-item menu-items">
            <a class="nav-link" data-bs-toggle="collapse" href="#financeiro" aria-expanded="false" aria-controls="financeiro">
              <span class="menu-icon">
                <i class="mdi mdi-chart-bar"></i>
              </span>
                <span class="menu-title">Financeiro</span>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="financeiro">
                <ul class="nav flex-column sub-menu">

                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletContas">Contas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletDespesas">Despesas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Vendas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Cartões e Pix</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Salários</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Vales</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Fechamento do Mês</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Ranking de Funcionários</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/principal/deathnote.jsp">Death Note</a></li>
                </ul>
            </div>
        </li>



        <li class="nav-item menu-items">
            <a class="nav-link" data-bs-toggle="collapse" href="#relatorio" aria-expanded="false" aria-controls="relatorio">
              <span class="menu-icon">
                <i class="mdi mdi-chart-bar"></i>
              </span>
                <span class="menu-title">Relatório</span>
                <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="relatorio">
                <ul class="nav flex-column sub-menu">

                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletRelVenda">Vendas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletFuncionario">Funcionários</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">Contas e Despesas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="">DRE</a></li>
                </ul>
            </div>
        </li>

        <li class="nav-item menu-items">
                        <a class="nav-link" data-bs-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
                          <span class="menu-icon">
                            <i class="mdi mdi-security"></i>
                          </span>
                            <span class="menu-title">ADMIN</span>
                            <i class="menu-arrow"></i>
                        </a>
                        <div class="collapse" id="auth">
                            <ul class="nav flex-column sub-menu">
                                <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletUsuarioController?acao=listarUser"> Funcionários </a></li>
                                <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletConfig"> Configurações </a></li>
                                <li class="nav-item"> <a class="nav-link" href=""> 404 </a></li>
                                <li class="nav-item"> <a class="nav-link" href=""> 505 </a></li>
                                <li class="nav-item"> <a class="nav-link" href=""> 606 </a></li>
                            </ul>
                        </div>
                    </li>

<%--  <li class="nav-item menu-items">--%>
<%--            <a class="nav-link" href="pages/tables/basic-table.html">--%>
<%--              <span class="menu-icon">--%>
<%--                <i class="mdi mdi-table-large"></i>--%>
<%--              </span>--%>
<%--                <span class="menu-title">Tables</span>--%>
<%--                <i class="menu-arrow"></i>--%>
<%--            </a>--%>
<%--        </li>--%>
<%--        <li class="nav-item menu-items">--%>
<%--            <a class="nav-link" href="pages/charts/chartjs.html">--%>
<%--              <span class="menu-icon">--%>
<%--                <i class="mdi mdi-chart-bar"></i>--%>
<%--              </span>--%>
<%--                <span class="menu-title">Charts</span>--%>
<%--                <i class="menu-arrow"></i>--%>
<%--            </a>--%>
<%--        </li>--%>
<%--        <li class="nav-item menu-items">--%>
<%--            <a class="nav-link" href="pages/icons/font-awesome.html">--%>
<%--              <span class="menu-icon">--%>
<%--                <i class="mdi mdi-contacts"></i>--%>
<%--              </span>--%>
<%--                <span class="menu-title">Icons</span>--%>
<%--                <i class="menu-arrow"></i>--%>
<%--            </a>--%>
<%--        </li>--%>
<%--
<%--        <li class="nav-item menu-items">--%>
<%--            <a class="nav-link" href="docs/documentation.html">--%>
<%--              <span class="menu-icon">--%>
<%--                <i class="mdi mdi-file-document"></i>--%>
<%--              </span>--%>
<%--                <span class="menu-title">Documentation</span>--%>
<%--            </a>--%>
<%--        </li>--%>
    </ul>
</nav>