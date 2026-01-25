<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Controle de Estoque</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #ffffff;
        }

        .card-estoque {
            border-radius: 18px;
            color: #fff;
            cursor: pointer;
            transition: transform .15s ease;
            min-height: 150px;
        }

        .card-estoque:hover {
            transform: scale(1.02);
        }

        .card-estoque h5 {
            font-size: 1.4rem;
            font-weight: 600;
        }

        /* Mobile: cards ainda maiores */
        @media (max-width: 768px) {
            .card-estoque {
                min-height: 190px;
            }

            .card-estoque h5 {
                font-size: 1.6rem;
            }
        }

        /* Cores */
        .bg-cadastro { background-color: #ffbd00; color: #000; }
        .bg-relatorio { background-color: #6c757d; }
        .bg-entrada { background-color: #00a6fb; }
        .bg-saida { background-color: #dd1c1a; }
        .bg-troca { background-color: #5a189a; }
    </style>
</head>

<body>

<div class="container py-4">
    <h4 class="mb-4 text-center">Controle de Estoque</h4>

    <div class="row g-3">

        <!-- RELATÓRIO (TOPO – 2 COLUNAS) -->
        <div class="col-12">
            <div class="card card-estoque bg-relatorio d-flex align-items-center justify-content-center"
                 data-bs-toggle="modal" data-bs-target="#modalRelatorio">
                <h5>Relatório</h5>
            </div>
        </div>

        <!-- CADASTRO -->
        <div class="col-6">
            <div class="card card-estoque bg-cadastro d-flex align-items-center justify-content-center"
                 data-bs-toggle="modal" data-bs-target="#modalCadastro">
                <h5>Cadastro</h5>
            </div>
        </div>
        <!-- TROCAS -->
        <div class="col-6">
            <div class="card card-estoque bg-troca d-flex align-items-center justify-content-center"
                 data-bs-toggle="modal" data-bs-target="#modalTroca">
                <h5>Trocas</h5>
            </div>
        </div>

        <!-- ENTRADA -->
        <div class="col-6">
            <div class="card card-estoque bg-entrada d-flex align-items-center justify-content-center"
                 data-bs-toggle="modal" data-bs-target="#modalEntrada">
                <h5>Entrada</h5>
            </div>
        </div>

        <!-- SAÍDA -->
        <div class="col-6">
            <div class="card card-estoque bg-saida d-flex align-items-center justify-content-center"
                 data-bs-toggle="modal" data-bs-target="#modalSaida">
                <h5>Saída</h5>
            </div>
        </div>



    </div>
</div>

<!-- ================= MODAIS ================= -->

<!-- Relatório -->
<div class="modal fade" id="modalRelatorio" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content bg-relatorio text-white">
            <div class="modal-header">
                <h5 class="modal-title">Relatório de Estoque</h5>
            </div>
            <div class="modal-body">
                Conteúdo do relatório
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<!-- Cadastro -->
<div class="modal fade" id="modalCadastro" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-cadastro">
            <div class="modal-header">
                <h5 class="modal-title">Cadastro de Produto</h5>
            </div>
            <div class="modal-body">
                Conteúdo do cadastro
            </div>
            <div class="modal-footer">
                <button class="btn btn-dark" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<!-- Entrada -->
<div class="modal fade" id="modalEntrada" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-entrada text-white">
            <div class="modal-header">
                <h5 class="modal-title">Entrada de Estoque</h5>
            </div>
            <div class="modal-body">
                Conteúdo da entrada
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<!-- Saída -->
<div class="modal fade" id="modalSaida" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-saida text-white">
            <div class="modal-header">
                <h5 class="modal-title">Saída de Estoque</h5>
            </div>
            <div class="modal-body">
                Conteúdo da saída
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<!-- Trocas -->
<div class="modal fade" id="modalTroca" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-troca text-white">
            <div class="modal-header">
                <h5 class="modal-title">Trocas</h5>
            </div>
            <div class="modal-body">
                Conteúdo das trocas
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
