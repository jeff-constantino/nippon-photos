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

                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletFechaDia">Fechamento Diário</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletConfDiario">Conferência Diária</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletFechaMes">Fechamento do Mês</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletDre">DRE</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletContas">Contas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletDespesas">Despesas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletSalarios">Salários</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletVales">Vales</a></li>


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
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletRelMes">Relatório do Mês</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletContasDespesasRel">Contas e Despesas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletComparativoYoY">Comparativo de Vendas</a></li>
                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletRanking">Ranking de Funcionários</a></li>
                    <%--                    <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletFuncionario">Funcionários</a></li>--%>

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
<%--                                <li class="nav-item"> <a class="nav-link" href="">Cartões e Pix</a></li>--%>
                                <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletControleRibbon"> Controle de Ribbon </a></li>
<%--                                <li class="nav-item"> <a class="nav-link" href=""> 505 </a></li>--%>
<%--                                <li class="nav-item"> <a class="nav-link" href=""> 606 </a></li>--%>
                                <li class="nav-item"> <a class="nav-link" href="<%= request.getContextPath() %>/ServletMedidasDisciplinares">Medidas Disciplinares</a></li>
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
<!-- Script para manter menu expandido -->
<script src="<%= request.getContextPath() %>/js/menu.js"></script>