
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Crediário</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #DAA520;
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

        .btn-dourado {
            background-color: #DAA520;
            color: #000000;
            font-weight: 600;
        }

        .btn-dourado:hover {
            background-color: #c9a117;
        }
    </style>
</head>
<body>

<div class="container-fluid py-4 px-4">

    <!-- CARD DE RESULTADOS -->
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
                                <th>Valor Total</th>
                                <th>Status</th>

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
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalLancamento">Vender</button>
                        <button class="btn btn-dourado" data-bs-toggle="modal" data-bs-target="#modalBusca">Buscar</button>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- MODAL LANÇAR CREDIÁRIO -->
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

<!-- MODAL BUSCA -->
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
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Empresa</label>
                            <input type="text" class="form-control" placeholder="Empresa">
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
```
