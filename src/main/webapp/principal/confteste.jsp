<form action="<%= request.getContextPath() %>/ServletFechaDia"
      method="post" id="formBuscarFechamento"
      name="formBuscarFechamento">

    <input type="hidden" name="acao" value="">
    <div class="col-sm-1">
        <label class="float-label">ID:</label>
        <span class="form-bar"></span>
        <input type="text" class="form-control" id="FechaId"
               name="id" placeholder=""
               style="background-color: black" readonly
               value="${fechamento != null ? fechamento.id : ''}">
    </div>
    <div class="col-6">
        <div class="col-auto">
            <span style="color:#1ad76b; text-align: center">${msg}</span>
        </div>
    </div>

    <div class="row">
        <div class="col-3">
            <label for="dataFechamento">Data do
                Fechamento:</label>
            <input type="date" class="form-control"
                   id="dataFechamento"
                   name="data_fechamento" required
                   value="${fechamento != null ? fechamento.data_fechamento : ''}">
        </div>

        <div class="col-6">
            <label class="float-label">Observações:</label>
            <span class="form-bar"></span>
            <input type="text" class="form-control"
                   id="observacao" name="observacao"
                   placeholder=""
                   style="background-color: black" readonly
                   value="${fechamento != null ? fechamento.observacao : ''}">
        </div>

        <div class="col-2">
            <label class="float-label">TOTAL DE
                FOTOS:</label>
            <span class="form-bar"></span>
            <input type="text" class="form-control"
                   id="total_total" name="total_total"
                   placeholder=""
                   style="background-color: white; color: black"
                   disabled>
        </div>
    </div>

    <!-- Seções para FOTOS, ENCARTE e DIGITAIS em linha -->
    <div class="row mt-3">
        <div class="col-4 text-center">
            <h5 style="color: #f2a654">FOTOS</h5>
        </div>
        <div class="col-4 text-center">
            <h5 style="color: #00d25b">ENCARTES</h5>
        </div>
        <div class="col-4 text-center">
            <h5 style="color: fuchsia">DIGITAIS</h5>
        </div>
    </div>

    <div class="row">
        <!-- Inputs para FOTOS -->
        <div class="col-4">
            <div class="row">
                <div class="col-6">
                    <label style="color: #f2a654">Fotos
                        Dinheiro</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #f2a654; color: black; font-weight: bold"
                           disabled id="total_ft_din"
                           name="total_ft_din"
                           value="${fechamento != null ? fechamento.total_ft_din : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Fotos
                        Débito</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #f2a654; color: black; font-weight: bold"
                           disabled id="total_ft_deb"
                           name="total_ft_deb"
                           value="${fechamento != null ? fechamento.total_ft_deb : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Fotos
                        Crédito</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #f2a654; color: black; font-weight: bold"
                           disabled id="total_ft_cred"
                           name="total_ft_cred"
                           value="${fechamento != null ? fechamento.total_ft_cred : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Fotos
                        Pix</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #f2a654; color: black; font-weight: bold"
                           disabled id="total_ft_pix"
                           name="total_ft_pix"
                           value="${fechamento != null ? fechamento.total_ft_pix : ''}">
                </div>
            </div>
        </div>

        <!-- Inputs para ENCARTE -->
        <div class="col-4">
            <div class="row">
                <div class="col-6">
                    <label style="color: #00d25b">Encartes
                        Dinheiro</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #73b307; color: black; font-weight: bold"
                           disabled id="total_enc_din"
                           name="total_enc_din"
                           value="${fechamento != null ? fechamento.total_enc_din : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #00d25b">Encartes
                        Débito</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #73b307; color: black; font-weight: bold"
                           disabled id="total_enc_deb"
                           name="total_enc_deb"
                           value="${fechamento != null ? fechamento.total_enc_deb : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #00d25b">Encartes
                        Crédito</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #73b307; color: black; font-weight: bold"
                           disabled id="total_enc_cred"
                           name="total_enc_cred"
                           value="${fechamento != null ? fechamento.total_enc_cred : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #00d25b">Encartes
                        Pix</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: #73b307; color: black; font-weight: bold"
                           disabled id="total_enc_pix"
                           name="total_enc_pix"
                           value="${fechamento != null ? fechamento.total_enc_pix : ''}">
                </div>
            </div>
        </div>

        <!-- Inputs para DIGITAIS -->
        <div class="col-4">
            <div class="row">
                <div class="col-6">
                    <label style="color: fuchsia">Digitais
                        Dinheiro</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: fuchsia; color: black; font-weight: bold"
                           disabled id="total_dig_din"
                           name="total_dig_din"
                           value="${fechamento != null ? fechamento.total_dig_din : ''}">
                </div>

                <div class="col-6">
                    <label style="color: fuchsia">Digitais
                        Débito</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: fuchsia; color: black; font-weight: bold"
                           disabled id="total_dig_deb"
                           name="total_dig_deb"
                           value="${fechamento != null ? fechamento.total_dig_deb : ''}">
                </div>

                <div class="col-6">
                    <label style="color: fuchsia">Digitais
                        Crédito</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: fuchsia; color: black; font-weight: bold"
                           disabled id="total_dig_cred"
                           name="total_dig_cred"
                           value="${fechamento != null ? fechamento.total_dig_cred : ''}">
                </div>

                <div class="col-6">
                    <label style="color: fuchsia">Digitais
                        Pix</label>
                    <input type="number"
                           class="form-control"
                           placeholder=""
                           style="background-color: fuchsia; color: black; font-weight: bold"
                           disabled id="total_dig_pix"
                           name="total_dig_pix"
                           value="${fechamento != null ? fechamento.total_dig_pix : ''}">
                </div>

            </div>

        </div>
        <%--  Ribbons--%>

        <div class="row mt-3">
            <div class="col-lg-12 text-center">
                <h5 style="color: white">CONFERÊNCIA DE RIBBONS</h5>
            </div>

        </div>
        <div class="col-4">
            <div class="row">
                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 1 Conf</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_1_conf" name="ribbon_1_conf"
                           value="${fechamento != null ? fechamento.ribbon_1_conf : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 2 Conf</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_2_conf" name="ribbon_2_conf"
                           value="${fechamento != null ? fechamento.ribbon_2_conf : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 1 Atual</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_1" name="ribbon_1"
                           value="${fechamento != null ? fechamento.total_ribbon_1 : ''}">

                    <label style="color: #f2a654">Diferença</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           id="dif_ribbon_1" name="dif_ribbon_1" readonly>
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 2 Atual</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_2" name="ribbon_2"
                           value="${fechamento != null ? fechamento.total_ribbon_2 : ''}">
                    <label style="color: #f2a654">Diferença</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           id="dif_ribbon_2" name="dif_ribbon_2" readonly>
                </div>
            </div>
        </div>


        <div class="col-4">
            <div class="row">
                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 3 Conf</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_3_conf" name="ribbon_3_conf"
                           value="${fechamento != null ? fechamento.ribbon_3_conf : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 4 Conf</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_4_conf" name="ribbon_4_conf"
                           value="${fechamento != null ? fechamento.ribbon_4_conf : ''}">
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 3 Atual</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_3" name="ribbon_3"
                           value="${fechamento != null ? fechamento.total_ribbon_3 : ''}">
                    <label style="color: #f2a654">Diferença</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           id="dif_ribbon_3" name="dif_ribbon_3" readonly>
                </div>

                <div class="col-6">
                    <label style="color: #f2a654">Ribbon 4 Atual</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_4" name="ribbon_4"
                           value="${fechamento != null ? fechamento.total_ribbon_4 : ''}">
                    <label style="color: white">Diferença</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           id="dif_ribbon_4" name="dif_ribbon_4" readonly>
                </div>
            </div>
        </div>


        <div class="col-4">
            <div class="row">
                <div class="col-6">
                    <label style="color: f2a654">Ribbon 5 Conf</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_5_conf" name="ribbon_5_conf"
                           value="${fechamento != null ? fechamento.ribbon_5_conf : ''}">
                </div>

                <div class="col-6">
                    <label style="color: f2a654">Ribbon 6 Conf</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_6_conf" name="ribbon_6_conf"
                           value="${fechamento != null ? fechamento.ribbon_6_conf : ''}">
                </div>

                <div class="col-6">
                    <label style="color: f2a654">Ribbon 5 Atual</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_5" name="ribbon_5"
                           value="${fechamento != null ? fechamento.total_ribbon_5 : ''}">
                    <label style="color: f2a654">Diferença</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           id="dif_ribbon_5" name="dif_ribbon_5" readonly>
                </div>

                <div class="col-6">
                    <label style="color: f2a654">Ribbon 6 Atual</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           disabled id="ribbon_6" name="ribbon_6"
                           value="${fechamento != null ? fechamento.total_ribbon_6 : ''}">
                    <label style="color: f2a654">Diferença</label>
                    <input type="number" class="form-control" placeholder=""
                           style="background-color: white; color: black; font-weight: bold"
                           id="dif_ribbon_6" name="dif_ribbon_6" readonly>
                </div>
            </div>
        </div>
    </div>


    <div class="row mt-3">
        <div class="col-4">
            <input type="submit" class="btn btn-primary"
                   value="Atualizar Fechamento">
        </div>
    </div>


</form>