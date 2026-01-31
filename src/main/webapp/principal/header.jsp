<%--
  Created by IntelliJ IDEA.
  User: Jeff Constantino
  Date: 15/09/2024
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>NIPPON ADM</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/font-awesome/css/font-awesome.min.css">

    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/jvectormap/jquery-jvectormap.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/flag-icon-css/css/flag-icons.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/owl-carousel-2/owl.carousel.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/vendors/owl-carousel-2/owl.theme.default.min.css">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <!-- End layout styles -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico" />

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>-->
     <!-- Chart.js para gráficos -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>


    <style>
        /* Esconde as setas dos inputs do tipo number */
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type="number"] {
            -moz-appearance: textfield; /* Firefox */
        }
        .pagination a.page-link {
            margin: 0 5px; /* Adiciona espaço horizontal de 5px entre os links */
            padding: 8px 12px; /* Define o padding dentro dos links para aumentar o clique */
            text-decoration: none;
            border: 1px solid #ddd; /* Adiciona uma borda ao redor dos links */
            color: #007bff;
        }

        .pagination a.page-link.active {
            background-color: #007bff;
            color: white; /* Deixa o link da página ativa com cores diferentes */
        }

        .pagination a.page-link:hover {
            background-color: #ddd; /* Adiciona um efeito de hover */
            color: #007bff;
        }
    </style>

    <!-- FIX: Força menus do sidebar a ficarem fechados quando não tiverem .show -->
    <style>
        /* Força que menus sem .show fiquem escondidos */
        .sidebar .collapse:not(.show) {
            display: none !important;
            height: 0 !important;
            overflow: hidden !important;
        }

        .sidebar .collapse.show {
            display: block !important;
        }

        /* Previne transições que possam causar problemas */
        .sidebar .collapse {
            transition: none !important;
        }
    </style>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- jQuery UI (para datepicker) -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- jquery.maskMoney plugin -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-maskmoney/3.0.2/jquery.maskMoney.min.js"></script>


    <!-- Verificação automática de sessão -->
    <script>
        (function() {
            var contextPath = '${pageContext.request.contextPath}';

            // Verificar sessão a cada 5 minutos
            setInterval(function() {
                fetch(contextPath + '/api/verificar-sessao')
                    .then(function(response) {
                        if (!response.ok) {
                            alert('Sua sessão expirou. Você será redirecionado para o login.');
                            window.location.href = contextPath + '/index.jsp';
                        }
                    })
                    .catch(function() {
                        window.location.href = contextPath + '/index.jsp';
                    });
            }, 5 * 60 * 1000); // 5 minutos

            // Verificar quando o tablet "acordar"
            document.addEventListener('visibilitychange', function() {
                if (document.visibilityState === 'visible') {
                    fetch(contextPath + '/api/verificar-sessao')
                        .then(function(response) {
                            if (!response.ok) {
                                alert('Sua sessão expirou. Você será redirecionado para o login.');
                                window.location.href = contextPath + '/index.jsp';
                            }
                        })
                        .catch(function() {
                            window.location.href = contextPath + '/index.jsp';
                        });
                }
            });
        })();
    </script>
</head>

</head>