
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
    Configuração de estilos e layout da Calculadora
--%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Calculadora de Vendas - Nippon Photos</title>

    <style>
        :root {
            --card-bg: #000000;
            --accent: #daa520;  /* Cor Dourada */
            --text-color: #ffffff;
        }

        body {
            margin: 0;
            background-color: #daa520; /* Fundo Dourado */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* Container centralizado e largo */
        .container {
            width: 95%;
            max-width: 1200px;
            background: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.8);
            padding: 40px;
            color: var(--text-color);
        }

        h1 {
            margin-top: 0;
            color: var(--accent);
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 2px solid #222;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th {
            background: #111;
            color: var(--accent);
            padding: 15px;
            font-size: 14px;
            text-transform: uppercase;
            border-bottom: 2px solid var(--accent);
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #222;
            text-align: center;
        }

        /* Estilo dos campos de entrada */
        input[type=number] {
            width: 110px;
            padding: 12px;
            border: 1px solid #444;
            border-radius: 8px;
            text-align: center;
            background: #1a1a1a;
            color: #fff;
            font-size: 18px;
            font-weight: bold;
        }

        input:focus {
            border-color: var(--accent);
            background: #252525;
            outline: none;
            box-shadow: 0 0 10px rgba(218, 165, 32, 0.5);
        }

        .total-highlight {
            font-weight: bold;
            color: var(--accent);
            font-size: 18px;
        }

        .grand-total-row td {
            font-size: 26px;
            color: var(--accent);
            border-top: 3px solid var(--accent);
            padding-top: 25px;
            font-weight: 900;
        }

        button {
            padding: 15px 40px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background: #333;
            color: white;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        button:hover {
            background: #444;
            transform: translateY(-2px);
        }

        /* Esconder setas padrão do navegador */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
</head>

<body>
<div class="container">
    <h1>Conferência de Vendas</h1>

    <table>
        <thead>
        <tr>
            <th>Ribbon Anterior</th>
            <th>Troca de Ribbon</th>
            <th>Ribbon Atual</th>
            <th>Fotos Reveladas</th>
        </tr>
        </thead>
        <tbody id="ribbonGroup">
        <tr>
            <td><input type="number" id="ribbonAnterior" value="0" class="nav-input"></td>
            <td><input type="number" id="trocaRibbon" value="0" class="nav-input"></td>
            <td><input type="number" id="ribbonAtual" value="0" class="nav-input"></td>
            <td class="total-highlight" id="fotosReveladas">0</td>
        </tr>
        </tbody>
    </table>

    <table>
        <thead>
        <tr>
            <th>Forma de Pagamento</th>
            <th>Fotos (R$15)</th>
            <th>Encartes (R$5)</th>
            <th>Arquivos (R$5)</th>
            <th>Subtotal</th>
        </tr>
        </thead>
        <tbody id="salesGroup">
        <tr>
            <td style="color: var(--accent); font-weight: bold;">Dinheiro</td>
            <td><input type="number" class="nav-input inp-fotos"></td>
            <td><input type="number" class="nav-input inp-enc"></td>
            <td><input type="number" class="nav-input inp-arq"></td>
            <td class="total-highlight subtotal">R$ 0,00</td>
        </tr>
        <tr>
            <td style="color: var(--accent); font-weight: bold;">Débito</td>
            <td><input type="number" class="nav-input inp-fotos"></td>
            <td><input type="number" class="nav-input inp-enc"></td>
            <td><input type="number" class="nav-input inp-arq"></td>
            <td class="total-highlight subtotal">R$ 0,00</td>
        </tr>
        <tr>
            <td style="color: var(--accent); font-weight: bold;">Crédito</td>
            <td><input type="number" class="nav-input inp-fotos"></td>
            <td><input type="number" class="nav-input inp-enc"></td>
            <td><input type="number" class="nav-input inp-arq"></td>
            <td class="total-highlight subtotal">R$ 0,00</td>
        </tr>
        <tr>
            <td style="color: var(--accent); font-weight: bold;">Pix</td>
            <td><input type="number" class="nav-input inp-fotos"></td>
            <td><input type="number" class="nav-input inp-enc"></td>
            <td><input type="number" class="nav-input inp-arq"></td>
            <td class="total-highlight subtotal">R$ 0,00</td>
        </tr>
        </tbody>
        <tfoot>
        <tr class="grand-total-row">
            <td colspan="4" style="text-align:right">Total Geral:</td>
            <td id="grandTotal">R$ 0,00</td>
        </tr>
        </tfoot>
    </table>

    <div style="text-align: center;">
        <button id="resetBtn" type="button">Limpar Campos</button>
    </div>
</div>

<script>
    (function() {
        const PRECO_FOTOS = 15.0;
        const PRECO_ENC = 5.0;
        const PRECO_ARQ = 5.0;

        function calcular() {
            let totalGeral = 0;
            document.querySelectorAll('#salesGroup tr').forEach(row => {
                const f = parseFloat(row.querySelector('.inp-fotos').value) || 0;
                const e = parseFloat(row.querySelector('.inp-enc').value) || 0;
                const a = parseFloat(row.querySelector('.inp-arq').value) || 0;
                const subtotal = (f * PRECO_FOTOS) + (e * PRECO_ENC) + (a * PRECO_ARQ);
                totalGeral += subtotal;
                row.querySelector('.subtotal').textContent = subtotal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            });
            document.getElementById('grandTotal').textContent = totalGeral.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
            const ant = parseFloat(document.getElementById('ribbonAnterior').value) || 0;
            const tro = parseFloat(document.getElementById('trocaRibbon').value) || 0;
            const atu = parseFloat(document.getElementById('ribbonAtual').value) || 0;
            document.getElementById('fotosReveladas').textContent = (ant + tro) - atu;
        }

        function limparCampos() {
            if(confirm("Deseja realmente limpar todos os campos?")) {
                document.querySelectorAll('input').forEach(i => i.value = i.id.includes('ribbon') ? '0' : '');
                calcular();
            }
        }

        // Eventos de Teclado (Setas + ESC)
        document.addEventListener('keydown', function(e) {
            // Atalho ESC para limpar
            if (e.key === 'Escape') {
                limparCampos();
                return;
            }

            const active = document.activeElement;
            if (!active.classList.contains('nav-input')) return;

            const allRows = Array.from(document.querySelectorAll('tbody tr'));
            const currentRow = active.closest('tr');
            const rowIdx = allRows.indexOf(currentRow);
            const currentInputsInRow = Array.from(currentRow.querySelectorAll('.nav-input'));
            const colIdx = currentInputsInRow.indexOf(active);

            let nRow = rowIdx;
            let nCol = colIdx;

            if (e.key === 'ArrowRight') nCol++;
            else if (e.key === 'ArrowLeft') nCol--;
            else if (e.key === 'ArrowDown') nRow++;
            else if (e.key === 'ArrowUp') nRow--;
            else return;

            const targetRow = allRows[nRow];
            if (targetRow) {
                const targetInputs = targetRow.querySelectorAll('.nav-input');
                const targetInput = targetInputs[nCol] || targetInputs[targetInputs.length - 1];
                if (targetInput) {
                    e.preventDefault();
                    targetInput.focus();
                    targetInput.select();
                }
            }
        });

        // Listeners de Input e Botão
        document.querySelector('.container').addEventListener('input', calcular);
        document.getElementById('resetBtn').addEventListener('click', limparCampos);
    })();
</script>
</body>
</html>