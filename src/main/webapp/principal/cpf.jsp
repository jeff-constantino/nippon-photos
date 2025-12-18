<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teste CPF e PIS</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
        }
        .box {
            width: 420px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        input {
            width: 260px;
            padding: 6px;
            margin-top: 8px;
            margin-bottom: 8px;
            font-size: 16px;
        }
        button {
            padding: 6px 12px;
            cursor: pointer;
        }
        .valid {
            border: 2px solid green !important;
        }
        .invalid {
            border: 2px solid red !important;
        }
        .btn-copy {
            background: #007bff;
            color: #fff;
            border: none;
            margin-left: 10px;
        }
    </style>

</head>
<body>

<h2>Validação e Geração de CPF / PIS</h2>

<!-- ========================= CPF ============================ -->
<div class="box">
    <h3>Testar CPF</h3>

    <input type="text" id="cpf" placeholder="Digite CPF" maxlength="14">
    <button onclick="testarCPF()">Validar</button>

    <p id="resCPF"></p>

    <hr>

    <button onclick="gerarCPF()">Gerar CPF válido</button>
    <input type="text" id="cpfGerado" readonly style="width:200px;">
    <button class="btn-copy" onclick="copiar('cpfGerado')">Copiar</button>
</div>


<!-- ========================= PIS ============================ -->
<div class="box">
    <h3>Testar PIS</h3>

    <input type="text" id="pis" placeholder="Digite PIS" maxlength="14">
    <button onclick="testarPIS()">Validar</button>

    <p id="resPIS"></p>

    <hr>

    <button onclick="gerarPIS()">Gerar PIS válido</button>
    <input type="text" id="pisGerado" readonly style="width:200px;">
    <button class="btn-copy" onclick="copiar('pisGerado')">Copiar</button>
</div>



<script>

    // ============================ MÁSCARAS ===============================

    function mascaraCPF(v) {
        v = v.replace(/\D/g, "");
        v = v.replace(/(\d{3})(\d)/, "$1.$2");
        v = v.replace(/(\d{3})(\d)/, "$1.$2");
        v = v.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
        return v;
    }

    function mascaraPIS(v) {
        v = v.replace(/\D/g, "");
        v = v.replace(/(\d{3})(\d)/, "$1.$2");
        v = v.replace(/(\d{5})(\d)/, "$1.$2");
        v = v.replace(/(\d{2})(\d{1})$/, "$1-$2");
        return v;
    }

    document.getElementById("cpf").addEventListener("input", function () {
        this.value = mascaraCPF(this.value);
        validarTempoRealCPF(this);
    });

    document.getElementById("pis").addEventListener("input", function () {
        this.value = mascaraPIS(this.value);
        validarTempoRealPIS(this);
    });



    // ============================ VALIDAR CPF ===============================

    function validarCPF(cpf) {
        cpf = cpf.replace(/\D/g, "");
        if (cpf.length !== 11) return false;
        if (/^(.)\1+$/.test(cpf)) return false;

        let soma = 0, resto;

        for (let i = 1; i <= 9; i++)
            soma += parseInt(cpf.substring(i - 1, i)) * (11 - i);

        resto = (soma * 10) % 11;
        if (resto === 10 || resto === 11) resto = 0;
        if (resto !== parseInt(cpf.substring(9, 10))) return false;

        soma = 0;
        for (let i = 1; i <= 10; i++)
            soma += parseInt(cpf.substring(i - 1, i)) * (12 - i);

        resto = (soma * 10) % 11;
        if (resto === 10 || resto === 11) resto = 0;

        return resto === parseInt(cpf.substring(10, 11));
    }


    // ============================ VALIDAR PIS ===============================

    function validarPIS(pis) {
        pis = pis.replace(/\D/g, "");
        if (pis.length !== 11) return false;

        const pesos = [3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
        let soma = 0;

        for (let i = 0; i < 10; i++) {
            soma += parseInt(pis.charAt(i)) * pesos[i];
        }

        const resto = soma % 11;
        const digito = resto < 2 ? 0 : 11 - resto;

        return digito === parseInt(pis.charAt(10));
    }


    // ============================ TEMPO REAL ===============================

    function validarTempoRealCPF(el) {
        if (el.value.length < 14) {
            el.classList.remove("valid", "invalid");
            return;
        }
        el.classList.toggle("valid", validarCPF(el.value));
        el.classList.toggle("invalid", !validarCPF(el.value));
    }

    function validarTempoRealPIS(el) {
        if (el.value.length < 14) {
            el.classList.remove("valid", "invalid");
            return;
        }
        el.classList.toggle("valid", validarPIS(el.value));
        el.classList.toggle("invalid", !validarPIS(el.value));
    }


    // ============================ BOTÕES DE VALIDAR ===============================

    function testarCPF() {
        let cpf = document.getElementById("cpf").value;
        let res = document.getElementById("resCPF");

        if (validarCPF(cpf)) {
            res.innerHTML = "CPF válido.";
            res.style.color = "green";
        } else {
            res.innerHTML = "CPF inválido.";
            res.style.color = "red";
        }
    }

    function testarPIS() {
        let pis = document.getElementById("pis").value;
        let res = document.getElementById("resPIS");

        if (validarPIS(pis)) {
            res.innerHTML = "PIS válido.";
            res.style.color = "green";
        } else {
            res.innerHTML = "PIS inválido.";
            res.style.color = "red";
        }
    }


    // ============================ GERADOR CPF ===============================

    function gerarCPF() {
        let n = [];
        for (let i = 0; i < 9; i++) n.push(Math.floor(Math.random() * 9));

        let soma1 = 0;
        for (let i = 0; i < 9; i++) soma1 += n[i] * (10 - i);
        let d1 = (soma1 * 10) % 11;
        if (d1 === 10) d1 = 0;

        let soma2 = 0;
        for (let i = 0; i < 9; i++) soma2 += n[i] * (11 - i);
        soma2 += d1 * 2;
        let d2 = (soma2 * 10) % 11;
        if (d2 === 10) d2 = 0;

        let cpf = [...n, d1, d2].join("");

        document.getElementById("cpfGerado").value = mascaraCPF(cpf);
    }


    // ============================ GERADOR PIS ===============================

    function gerarPIS() {
        let n = [];
        for (let i = 0; i < 10; i++) n.push(Math.floor(Math.random() * 9));

        const pesos = [3,2,9,8,7,6,5,4,3,2];
        let soma = 0;

        for (let i = 0; i < 10; i++) {
            soma += n[i] * pesos[i];
        }

        let resto = soma % 11;
        let d = resto < 2 ? 0 : 11 - resto;

        let pis = [...n, d].join("");
        document.getElementById("pisGerado").value = mascaraPIS(pis);
    }


    // ============================ COPIAR ===============================

    function copiar(id) {
        let campo = document.getElementById(id);
        campo.select();
        campo.setSelectionRange(0, 9999);
        navigator.clipboard.writeText(campo.value);
        alert("Copiado!");
    }

</script>

</body>
</html>
