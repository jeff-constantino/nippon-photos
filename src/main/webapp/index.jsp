<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <title>ACESSO AO SISTEMA</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!--===============================================================================================-->
  <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
  <!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="css/util.css">
  <link rel="stylesheet" type="text/css" href="css/main.css">
  <!--===============================================================================================-->
</head>
<style>
    .texto-destaque {
        color: #FFFFFF;
        text-shadow:
                0px 0px 4px rgba(0,0,0,0.9),   /* sombra forte para contraste */
                0px 0px 12px rgba(0,0,0,0.7);  /* reforço */
    }
</style>
<body style="background-image: url('images/BG.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">


<div class="limiter">
    <div class="container-login100" style="display: flex; align-items: center; justify-content: center;">

        <!-- IMAGEM À ESQUERDA -->
        <div class="login100-pic js-tilt" data-tilt
             style="width: 30%; margin-right: 40px; display: flex; justify-content: center;">
            <img src="images/img-01.png" alt="IMG" style="width: 80%;">
        </div>

        <!-- FORMULÁRIO CENTRALIZADO -->
        <div class="wrap-login100" style="width: 40%; min-width: 350px;">
            <form class="login100-form validate-form"
                  action="<%= request.getContextPath() %>/ServletLogin" method="post">


                <span class="login100-form-title texto-destaque" style="font-size: 2vw;">
    Autenticação de usuário
</span>

                <div><h4 class="msg texto-destaque">${msg}</h4></div>

                <div class="wrap-input100 validate-input" data-validate="INSIRA O LOGIN">
                    <input class="input100" type="text" name="login" placeholder="Login" autofocus
                           style="font-size: 1vw; height: 5vh;">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                <i class="fa fa-user" aria-hidden="true"></i>
              </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate="INSIRA A SENHA">
                    <input class="input100" type="password" name="senha" placeholder="Senha"
                           style="font-size: 1vw; height: 5vh;">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                <i class="fa fa-lock" aria-hidden="true"></i>
              </span>
                </div>

                <div class="container-login100-form-btn" style="padding-top: 2vh;">
                    <button class="login100-form-btn"
                            style="font-size: 2vw; height: 7vh; width: 60vw;">
                        Entrar
                    </button>
                </div>

            </form>
        </div>

    </div>
</div>




<!--===============================================================================================-->
<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="vendor/bootstrap/js/popper.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
<script src="vendor/tilt/tilt.jquery.min.js"></script>
<script >
  $('.js-tilt').tilt({
    scale: 1.1
  })
</script>
<!--===============================================================================================-->
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
    © 2025 - Hashtag Software as a Service - Todos os direitos reservados
</footer>
</html>


