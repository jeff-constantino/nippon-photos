<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <title>#SaaS</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS BASE -->
    <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css?v=2">

    <!-- ESTILOS CUSTOMIZADOS -->
    <style>
        body {
            background-image: url("images/BG.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .texto-destaque {
            color: #fff;
            text-shadow:
                    0px 0px 4px rgba(0,0,0,0.9),
                    0px 0px 12px rgba(0,0,0,0.7);
        }

        .container-login100 {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .login100-pic {
            width: 30%;
            display: flex;
            justify-content: center;
            margin-right: 40px;
        }

        .login100-pic img {
            width: 80%;
        }

        .wrap-login100 {
            width: 40%;
            min-width: 350px;
        }

        /* ===== MOBILE ===== */
        @media (max-width: 768px) {

            .container-login100 {
                flex-direction: column;
                padding-bottom: 80px;
            }

            .login100-pic {
                width: 70%;
                margin: 0 0 25px 0;
            }

            .login100-pic img {
                width: 100%;
            }

            .wrap-login100 {
                width: 90%;
                min-width: unset;
            }

            .login100-form-title {
                font-size: 24px !important;
            }

            .input100 {
                font-size: 16px !important;
                height: 50px !important;
            }

            .login100-form-btn {
                font-size: 18px !important;
                height: 55px !important;
                width: 100% !important;
            }
        }
    </style>
</head>

<body>

<div class="limiter">

    <div class="container-login100">

        <!-- LOGO -->
        <div class="login100-pic js-tilt" data-tilt>
            <img src="images/img-01.webp" alt="IMG">
        </div>

        <!-- FORMULÁRIO -->
        <div class="wrap-login100">

            <form class="login100-form validate-form"
                  action="<%= request.getContextPath() %>/ServletLogin"
                  method="post">

                <span class="login100-form-title texto-destaque">
                    Autenticação de usuário
                </span>

                <h4 class="msg texto-destaque">${msg}</h4>

                <div class="wrap-input100 validate-input" data-validate="INSIRA O LOGIN">
                    <input class="input100" type="text" name="login" placeholder="Login" autofocus>
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-user" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate="INSIRA A SENHA">
                    <input class="input100" type="password" name="senha" placeholder="Senha">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-lock" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="container-login100-form-btn">
                    <button class="login100-form-btn">
                        Entrar
                    </button>
                </div>

            </form>
        </div>

    </div>

</div>

<!-- SCRIPTS -->
<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="vendor/bootstrap/js/popper.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="vendor/select2/select2.min.js"></script>
<script src="vendor/tilt/tilt.jquery.min.js"></script>
<script>
    $('.js-tilt').tilt({ scale: 1.1 })
</script>
<script src="js/main.js"></script>

</body>

<footer style="
    width: 100%;
    background: rgba(0,0,0,0.85);
    color: #ffffff;
    text-align: center;
    padding: 15px 0;
    font-size: 1vw;
    font-family: Arial, sans-serif;
    position: fixed;
    bottom: 0;
    left: 0;
">
    © 2025 - #SaaS Desenvolvido por Jeff Constantino - Todos os direitos reservados
</footer>

</html>
