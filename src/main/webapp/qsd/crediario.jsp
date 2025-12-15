<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Crediário</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            /* Definimos a cor inicial. Esta será mudada pelo JS */
            background-color: #3A86FF;
            transition: background-color 0.5s ease;
        }

        .card-preta {
            background-color: #000000;
            color: #ffffff;
            border-radius: 12px;
        }

        .card-preta .form-control,
        .card-preta .form-select {
            background-color: #1c1c1c;
            color: #ffffff;
            border: 1px solid #444;
        }

        .card-preta .form-control::placeholder {
            color: #bbbbbb;
        }

        /* 1. ESTILOS DINÂMICOS PARA BOTÕES E BACKGROUND (AJUSTADOS) */

        /* Cor inicial do botão (será alterada via JavaScript) */
        .btn-dourado {
            background-color: #DAA520;
            color: #000000;
            font-weight: 600;
            border: none; /* Para garantir que o hover funcione bem */
            transition: background-color 0.3s ease;
        }

        /* O hover também será ajustado via JavaScript, mas deixamos o padrão para não quebrar */
        .btn-dourado:hover {
            background-color: #c9a117;
        }

        /* Novo estilo para o seletor de cor */
        .color-picker-container {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            margin-bottom: 1rem;
        }

        .color-picker-container label {
            margin-right: 0.5rem;
            font-weight: bold;
            /* Usamos classes Bootstrap (text-dark/text-light) para cor da label */
        }

        .color-picker-container input[type="color"] {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 44px;
            height: 44px;
            background: none;
            border: 2px solid #333; /* Borda escura para destacar o seletor */
            padding: 0;
            cursor: pointer;
            border-radius: 5px;
            overflow: hidden;
            transition: border-color 0.5s ease; /* Transição da borda */
        }

        .color-picker-container input[type="color"]::-webkit-color-swatch {
            border: none;
            border-radius: 5px;
            padding: 0;
        }

        .color-picker-container input[type="color"]::-moz-color-swatch {
            border: none;
            border-radius: 5px;
            padding: 0;
        }

    </style>
</head>
<body>

<div class="container-fluid py-4 px-4">



    <div class="row mb-4">
        <div class="col-12">
            <div class="card card-preta">
                <div class="card-body">
                    <h4 class="card-title text-center mb-3">RESULTADO DA BUSCA</h4>

                    <div class="table-responsive">
                        <table class="table table-dark table-bordered mb-0">
                            <thead>
                            <tr>
                                <th>Data</th>
                                <th>Nome</th>
                                <th>Empresa</th>
                                <th>Produtos</th>
                                <th>Valor Total</th>
                                <th>Status</th>
                                <th>Opções</th>

                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td colspan="4" class="text-center">Nenhum resultado</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center mt-3">
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalBusca">Buscar</button>
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalLancamento">Vender</button>
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalRelatorio">Relatórios</button>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="row">
    <div class="col-12 color-picker-container">
        <label for="background-color-picker" id="color-picker-label" class="text-dark">Alterar cor de fundo:</label>
        <input type="color" id="background-color-picker" value="#DAA520" title="Seletor de cor de fundo">
    </div>
</div>

<div class="modal fade" id="modalLancamento" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Lançar Crediário</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label">Data</label>
                            <input type="date" class="form-control">
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">Nome</label>
                            <input type="text" class="form-control" placeholder="Nome do cliente">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Empresa</label>
                        <input type="text" class="form-control" placeholder="Empresa">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Produtos</label>
                        <textarea class="form-control" rows="4" placeholder="Descrição dos produtos"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Valor Total</label>
                        <input type="text" class="form-control" placeholder="R$ 0,00">
                    </div>
                </form>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-dourado">Salvar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalBusca" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Buscar Crediário</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nome</label>
                            <input type="text" class="form-control" placeholder="Nome do cliente">
                        </div>

                        <div class="table-responsive">
                            <table class="table table-dark table-bordered mb-0">
                                <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Empresa</th>
                                    <th>Opções</th>

                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td colspan="4" class="text-center">Nenhum resultado</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </form>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                <button type="button" class="btn btn-dourado">Buscar</button>
            </div>
        </div>
    </div>

</div>

<div class="modal fade" id="modalRelatorio" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content card-preta">
            <div class="modal-header border-0">
                <h5 class="modal-title">Relatórios Gerenciais</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nome</label>
                            <input type="text" class="form-control" placeholder="Nome do cliente">
                        </div>

                        <div class="table-responsive">
                            <table class="table table-dark table-bordered mb-0">
                                <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Empresa</th>
                                    <th>Opções</th>

                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td colspan="4" class="text-center">Nenhum resultado</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </form>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                <button type="button" class="btn btn-dourado">Buscar</button>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const colorPicker = document.getElementById('background-color-picker');
        const colorLabel = document.getElementById('color-picker-label');
        const buttons = document.querySelectorAll('.btn-dourado');
        const defaultColor = '#DAA520'; // Cor inicial

        /**
         * Converte HEX para uma cor mais escura (para o efeito hover)
         * @param {string} hex - Cor HEX (#RRGGBB).
         * @param {number} percent - Porcentagem para escurecer (ex: -10 para escurecer 10%).
         * @returns {string} Cor HEX mais escura.
         */
        function shadeColor(hex, percent) {
            let R = parseInt(hex.substring(1, 3), 16);
            let G = parseInt(hex.substring(3, 5), 16);
            let B = parseInt(hex.substring(5, 7), 16);

            R = parseInt(R * (100 + percent) / 100);
            G = parseInt(G * (100 + percent) / 100);
            B = parseInt(B * (100 + percent) / 100);

            R = (R < 255) ? R : 255;
            G = (G < 255) ? G : 255;
            B = (B < 255) ? B : 255;

            const RR = ((R.toString(16).length === 1) ? "0" + R.toString(16) : R.toString(16));
            const GG = ((G.toString(16).length === 1) ? "0" + G.toString(16) : G.toString(16));
            const BB = ((B.toString(16).length === 1) ? "0" + B.toString(16) : B.toString(16));

            return "#" + RR + GG + BB;
        }

        /**
         * Ajusta a cor do texto da label e a borda do color picker.
         * @param {string} hex - Cor HEX atual do fundo.
         */
        function ajustarContraste(hex) {
            // 1. Ajusta o contraste da label
            const r = parseInt(hex.slice(1, 3), 16);
            const g = parseInt(hex.slice(3, 5), 16);
            const b = parseInt(hex.slice(5, 7), 16);
            const luminosidade = (0.299 * r + 0.587 * g + 0.114 * b) / 255;

            if (luminosidade < 0.5) {
                // Cor de fundo escura, usa texto claro e borda clara
                colorLabel.classList.remove('text-dark');
                colorLabel.classList.add('text-light');
                colorPicker.style.borderColor = '#ffffff'; // Borda branca
            } else {
                // Cor de fundo clara, usa texto escuro e borda escura
                colorLabel.classList.remove('text-light');
                colorLabel.classList.add('text-dark');
                colorPicker.style.borderColor = '#333333'; // Borda escura
            }
        }

        /**
         * Aplica a nova cor ao fundo e aos botões.
         * @param {string} novaCor - Cor HEX para aplicar.
         */
        function aplicarCor(novaCor) {
            document.body.style.backgroundColor = novaCor;

            // Calcula a cor para o efeito hover (escurecendo em 10%)
            const hoverCor = shadeColor(novaCor, -10);

            // Aplica a cor nos botões
            buttons.forEach(button => {
                button.style.backgroundColor = novaCor;

                // Remove o estilo de hover anterior e adiciona um novo listener
                button.onmouseover = function() {
                    button.style.backgroundColor = hoverCor;
                };
                button.onmouseout = function() {
                    button.style.backgroundColor = novaCor;
                };
            });

            ajustarContraste(novaCor);

            // Salva no Local Storage
            localStorage.setItem('credarioBackgroundColor', novaCor);
        }

        // Event listener para mudança de cor
        colorPicker.addEventListener('input', function() {
            aplicarCor(colorPicker.value);
        });

        // Carrega a cor salva ou aplica a cor padrão
        const savedColor = localStorage.getItem('credarioBackgroundColor');
        if (savedColor) {
            colorPicker.value = savedColor;
            aplicarCor(savedColor);
        } else {
            // Aplica a cor padrão na inicialização se não houver cor salva
            aplicarCor(defaultColor);
        }

    });
</script>
</body>
</html>