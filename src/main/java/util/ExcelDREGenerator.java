package util;

import model.ModelFechaMes;
import model.ModelContas; // Importado para listas de detalhe
import model.ModelDespesas; // Importado para listas de detalhe
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class ExcelDREGenerator {

    private Workbook workbook;
    private Sheet sheet;
    private int rowNum = 0;

    // Estilos
    private CellStyle titleStyle;
    private CellStyle headerStyle;
    private CellStyle normalStyle;
    private CellStyle currencyStyle;
    private CellStyle totalStyle;
    private CellStyle subtotalStyle;
    private CellStyle positiveStyle;
    private CellStyle negativeStyle;
    private CellStyle dateStyle; // Novo estilo para datas

    public ExcelDREGenerator() {
        // O workbook será criado em cada método de geração para garantir que os relatórios sejam arquivos independentes.
    }

    private void createStyles() {
        // Fonte para título
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 16);
        titleFont.setColor(IndexedColors.WHITE.getIndex());

        // Fonte para cabeçalho
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short) 12);
        headerFont.setColor(IndexedColors.WHITE.getIndex());

        // Fonte normal bold
        Font boldFont = workbook.createFont();
        boldFont.setBold(true);

        // Estilo título
        titleStyle = workbook.createCellStyle();
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        titleStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
        titleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Estilo cabeçalho
        headerStyle = workbook.createCellStyle();
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setBorderBottom(BorderStyle.THIN);
        headerStyle.setBorderTop(BorderStyle.THIN);
        headerStyle.setBorderLeft(BorderStyle.THIN);
        headerStyle.setBorderRight(BorderStyle.THIN);

        // Estilo normal
        normalStyle = workbook.createCellStyle();
        normalStyle.setBorderBottom(BorderStyle.THIN);
        normalStyle.setBorderLeft(BorderStyle.THIN);
        normalStyle.setBorderRight(BorderStyle.THIN);

        // Estilo data
        dateStyle = workbook.createCellStyle();
        dateStyle.cloneStyleFrom(normalStyle);
        dateStyle.setDataFormat(workbook.createDataFormat().getFormat("dd/MM/yyyy"));

        // Estilo moeda
        currencyStyle = workbook.createCellStyle();
        currencyStyle.cloneStyleFrom(normalStyle);
        currencyStyle.setDataFormat(workbook.createDataFormat().getFormat("R$ #,##0.00"));

        // Estilo total
        totalStyle = workbook.createCellStyle();
        totalStyle.setFont(boldFont);
        totalStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        totalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        totalStyle.setBorderBottom(BorderStyle.MEDIUM);
        totalStyle.setBorderTop(BorderStyle.MEDIUM);
        totalStyle.setBorderLeft(BorderStyle.THIN);
        totalStyle.setBorderRight(BorderStyle.THIN);
        totalStyle.setDataFormat(workbook.createDataFormat().getFormat("R$ #,##0.00"));

        // Estilo subtotal
        subtotalStyle = workbook.createCellStyle();
        subtotalStyle.setFont(boldFont);
        subtotalStyle.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
        subtotalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        subtotalStyle.setBorderBottom(BorderStyle.THIN);
        subtotalStyle.setBorderTop(BorderStyle.THIN);
        subtotalStyle.setBorderLeft(BorderStyle.THIN);
        subtotalStyle.setBorderRight(BorderStyle.THIN);
        subtotalStyle.setDataFormat(workbook.createDataFormat().getFormat("R$ #,##0.00"));

        // Estilo positivo (lucro)
        positiveStyle = workbook.createCellStyle();
        positiveStyle.cloneStyleFrom(totalStyle);
        Font greenFont = workbook.createFont();
        greenFont.setBold(true);
        greenFont.setColor(IndexedColors.GREEN.getIndex());
        positiveStyle.setFont(greenFont);

        // Estilo negativo (prejuízo)
        negativeStyle = workbook.createCellStyle();
        negativeStyle.cloneStyleFrom(totalStyle);
        Font redFont = workbook.createFont();
        redFont.setBold(true);
        redFont.setColor(IndexedColors.RED.getIndex());
        negativeStyle.setFont(redFont);
    }

    public byte[] gerarDRE(ModelFechaMes fechamento, String mesAno,
                           BigDecimal totalImpostos, BigDecimal totalDespesasAdm,
                           BigDecimal icms, BigDecimal pis, BigDecimal cofins,
                           BigDecimal inss, BigDecimal irpj, BigDecimal csll,
                           BigDecimal aluguel, BigDecimal bonificacoes,
                           BigDecimal prestacoes, BigDecimal internet,
                           BigDecimal outrasDespesas) throws IOException {

        // --- INICIALIZAÇÃO ESPECÍFICA DRE ---
        this.workbook = new XSSFWorkbook();
        this.sheet = workbook.createSheet("DRE");
        this.rowNum = 0;
        createStyles();
        // ------------------------------------

        // Configurar largura das colunas
        sheet.setColumnWidth(0, 8000);  // Coluna de descrição
        sheet.setColumnWidth(1, 5000);  // Coluna de valores

        // ========== TÍTULO ==========
            createSheetTitle(sheet, "DRE MENSAL", mesAno, 1);

        rowNum++; // Linha em branco

        // ========== RECEITAS OPERACIONAIS ==========
        createSectionHeader("RECEITAS OPERACIONAIS");

        BigDecimal valorDin = fechamento.getValor_din_mes() != null ? fechamento.getValor_din_mes() : BigDecimal.ZERO;
        BigDecimal valorDeb = fechamento.getValor_deb_mes() != null ? fechamento.getValor_deb_mes() : BigDecimal.ZERO;
        BigDecimal valorCred = fechamento.getValor_cred_mes() != null ? fechamento.getValor_cred_mes() : BigDecimal.ZERO;
        BigDecimal valorPix = fechamento.getValor_pix_mes() != null ? fechamento.getValor_pix_mes() : BigDecimal.ZERO;

        createDataRow("Dinheiro", valorDin);
        createDataRow("Débito", valorDeb);
        createDataRow("Crédito", valorCred);
        createDataRow("Pix", valorPix);

        BigDecimal receitaBruta = valorDin.add(valorDeb).add(valorCred).add(valorPix);
        createSubtotalRow("RECEITA BRUTA", receitaBruta);

        rowNum++; // Linha em branco

        // ========== DESPESAS OPERACIONAIS ==========
        createSectionHeader("DESPESAS OPERACIONAIS");

        BigDecimal valorRibbons = fechamento.getTotal_ribbons() != null ? fechamento.getTotal_ribbons() : BigDecimal.ZERO;
        BigDecimal valorEncartes = fechamento.getValor_enc() != null ? fechamento.getValor_enc() : BigDecimal.ZERO;
        BigDecimal jurosCartoes = fechamento.getJuros_cartoes() != null ? fechamento.getJuros_cartoes() : BigDecimal.ZERO;

        createDataRow("Ribbons", valorRibbons);
        createDataRow("Encartes", valorEncartes);
        createDataRow("Juros dos Cartões", jurosCartoes);

        BigDecimal totalCustosOperacionais = valorRibbons.add(valorEncartes).add(jurosCartoes);
        createSubtotalRow("TOTAL CUSTOS OPERACIONAIS", totalCustosOperacionais);

        rowNum++; // Linha em branco

        // ========== CÁLCULO FINANCEIRO ==========
        createSectionHeader("CÁLCULO FINANCEIRO");

        createDataRow("Receita Bruta", receitaBruta);
        createDataRow("(-) Custos Operacionais", totalCustosOperacionais.negate());

        BigDecimal lucroBruto = receitaBruta.subtract(totalCustosOperacionais);
        createSubtotalRow("LUCRO BRUTO", lucroBruto);

        rowNum++; // Linha em branco

        // ========== IMPOSTOS SOBRE VENDAS ==========
        createSectionHeader("IMPOSTOS SOBRE VENDAS");

        createDataRow("ICMS", icms);
        createDataRow("PIS", pis);
        createDataRow("COFINS", cofins);
        createDataRow("INSS", inss);
        createDataRow("IRPJ", irpj);
        createDataRow("CSLL", csll);
        createSubtotalRow("TOTAL IMPOSTOS", totalImpostos);

        rowNum++; // Linha em branco

        // ========== DESPESAS ADMINISTRATIVAS ==========
        createSectionHeader("DESPESAS ADMINISTRATIVAS");

        BigDecimal salarios = fechamento.getSalarios() != null ? fechamento.getSalarios() : BigDecimal.ZERO;
        BigDecimal vales = fechamento.getValor_vale_total() != null ? fechamento.getValor_vale_total() : BigDecimal.ZERO;
        BigDecimal totalSalarios = salarios.add(vales);

        BigDecimal contas = fechamento.getValor_total_contas() != null ? fechamento.getValor_total_contas() : BigDecimal.ZERO;
        BigDecimal despesas = fechamento.getValor_total_despesas() != null ? fechamento.getValor_total_despesas() : BigDecimal.ZERO;

        createDataRow("Aluguel", aluguel);
        createDataRow("Salários", totalSalarios);
        createDataRow("Contas", contas);
        createDataRow("Despesas Gerais", despesas);
        createDataRow("Bonificações", bonificacoes);
        createDataRow("Prestações de Equipamentos", prestacoes);
        createDataRow("Internet", internet);
        createDataRow("Outras Despesas", outrasDespesas);
        createSubtotalRow("TOTAL DESPESAS ADMINISTRATIVAS", totalDespesasAdm);

        rowNum++; // Linha em branco

        // ========== RESULTADO FINAL ==========
        createSectionHeader("RESULTADO FINAL");

        createDataRow("Lucro Bruto", lucroBruto);
        createDataRow("(-) Impostos sobre Vendas", totalImpostos.negate());
        createDataRow("(-) Despesas Administrativas", totalDespesasAdm.negate());

        BigDecimal lucroLiquido = lucroBruto.subtract(totalImpostos).subtract(totalDespesasAdm);
        createTotalRow("LUCRO LÍQUIDO", lucroLiquido);

        // Gera o arquivo
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray();
    }


    /**
     * Gera o relatório de Fechamento Mensal, incluindo as abas de detalhe.
     */
    public byte[] gerarRelatorioFechaMes(
            Map<String, BigDecimal> dados,
            String mesAno,
            List<ModelContas> contasMes,
            List<ModelDespesas> despesasMes) throws IOException {

        // --- INICIALIZAÇÃO ESPECÍFICA FECHAMENTO ---
        this.workbook = new XSSFWorkbook();
        this.sheet = workbook.createSheet("Resumo_Fechamento");
        this.rowNum = 0;
        createStyles();
        // --------------------------------------------

        // Configurar largura das colunas
        sheet.setColumnWidth(0, 9000);  // Coluna de descrição
        sheet.setColumnWidth(1, 5000);  // Coluna de valores

        // ========== TÍTULO DO RESUMO ==========
        createSheetTitle(sheet, "RELATÓRIO DE FECHAMENTO MENSAL", mesAno, 1);

        // ========== DADOS DO MAPA (RESUMO) ==========

        for (Map.Entry<String, BigDecimal> entry : dados.entrySet()) {
            String description = entry.getKey();
            BigDecimal value = entry.getValue();

            if (description.startsWith("---") && description.endsWith("---")) {
                createSectionHeader(description.replace("---", "").trim().toUpperCase());
            } else if (value == null) {
                rowNum++;
            } else if (description.contains("SALDO EM CAIXA")) {
                createTotalRow(description, value);
            } else {
                createDataRow(description, value);
            }
        }

        // ======================================
        // ADICIONAR TABELAS DETALHADAS (NOVAS ABAS)
        // ======================================

        // 1. Despesas Detalhe
        if (despesasMes != null && !despesasMes.isEmpty()) {
            createDetailedSheetDespesas(despesasMes, mesAno);
        }

        // 2. Contas Detalhe
        if (contasMes != null && !contasMes.isEmpty()) {
            createDetailedSheetContas(contasMes, mesAno);
        }

        // Gera o arquivo (Workbook)
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream.toByteArray();
    }


    // =========================================================================
    // MÉTODOS AUXILIARES
    // =========================================================================

    // Método auxiliar para criar o título e subtítulo
    private void createSheetTitle(Sheet targetSheet, String title, String mesAno, int mergeColumns) {
        // Título
        Row titleRow = targetSheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue(title);
        titleCell.setCellStyle(titleStyle);
        targetSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, mergeColumns));
        titleRow.setHeightInPoints(25);

        // Subtítulo
        Row subtitleRow = targetSheet.createRow(rowNum++);
        Cell subtitleCell = subtitleRow.createCell(0);
        subtitleCell.setCellValue(mesAno.toUpperCase());
        subtitleCell.setCellStyle(titleStyle);
        targetSheet.addMergedRegion(new CellRangeAddress(1, 1, 0, mergeColumns));
        subtitleRow.setHeightInPoints(20);

        rowNum++; // Linha em branco
    }


    private void createSectionHeader(String title) {
        Row row = sheet.createRow(rowNum++);
        Cell cell = row.createCell(0);
        cell.setCellValue(title);
        cell.setCellStyle(headerStyle);

        Cell cell2 = row.createCell(1);
        cell2.setCellStyle(headerStyle);

        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 0, 1));
    }

    private void createDataRow(String description, BigDecimal value) {
        Row row = sheet.createRow(rowNum++);

        Cell descCell = row.createCell(0);
        descCell.setCellValue(description);
        descCell.setCellStyle(normalStyle);

        Cell valueCell = row.createCell(1);
        valueCell.setCellValue(value.doubleValue());
        valueCell.setCellStyle(currencyStyle);
    }

    private void createSubtotalRow(String description, BigDecimal value) {
        Row row = sheet.createRow(rowNum++);

        Cell descCell = row.createCell(0);
        descCell.setCellValue(description);
        descCell.setCellStyle(subtotalStyle);

        Cell valueCell = row.createCell(1);
        valueCell.setCellValue(value.doubleValue());
        valueCell.setCellStyle(subtotalStyle);
    }

    private void createTotalRow(String description, BigDecimal value) {
        Row row = sheet.createRow(rowNum++);

        Cell descCell = row.createCell(0);
        descCell.setCellValue(description);

        Cell valueCell = row.createCell(1);
        valueCell.setCellValue(value.doubleValue());

        // Aplica estilo baseado no valor (positivo = verde, negativo = vermelho)
        if (value.compareTo(BigDecimal.ZERO) > 0) {
            descCell.setCellStyle(positiveStyle);
            valueCell.setCellStyle(positiveStyle);
        } else if (value.compareTo(BigDecimal.ZERO) < 0) {
            descCell.setCellStyle(negativeStyle);
            valueCell.setCellStyle(negativeStyle);
        } else {
            descCell.setCellStyle(totalStyle);
            valueCell.setCellStyle(totalStyle);
        }
    }

    // =========================================================================
    // MÉTODOS PARA DETALHES DAS TABELAS (NOVAS SHEETS)
    // =========================================================================


    private void createDetailedSheetDespesas(List<ModelDespesas> despesasMes, String mesAno) {
        Sheet despesaSheet = workbook.createSheet("Despesas_Detalhes");
        this.sheet = despesaSheet;
        this.rowNum = 0;

        // Headers e Título
        createSheetTitle(despesaSheet, "DETALHE DE DESPESAS DO MÊS", mesAno, 5);

        String[] headers = {"Nome Despesa", "Descrição", "Valor", "Data", "Forma de Pagamento", "ID Despesa"};
        Row headerRow = despesaSheet.createRow(rowNum++);

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            despesaSheet.setColumnWidth(i, i == 1 ? 8000 : 4000); // Descrição maior
        }

        // Corpo da Tabela
        for (ModelDespesas despesa : despesasMes) {
            Row row = despesaSheet.createRow(rowNum++);

            // 0: Nome Despesa
            Cell nomeCell = row.createCell(0);
            nomeCell.setCellValue(despesa.getNome_despesa());
            nomeCell.setCellStyle(normalStyle);

            // 1: Descrição
            Cell descCell = row.createCell(1);
            descCell.setCellValue(despesa.getDescricao_despesa());
            descCell.setCellStyle(normalStyle);

            // 2: Valor (Moeda)
            Cell valorCell = row.createCell(2);
            valorCell.setCellValue(despesa.getValor_despesa());
            valorCell.setCellStyle(currencyStyle);

            // 3: Data
            Cell dataCell = row.createCell(3);
            if (despesa.getData_despesa() != null) {
                dataCell.setCellValue(despesa.getData_despesa());
                dataCell.setCellStyle(dateStyle);
            } else {
                dataCell.setCellStyle(normalStyle);
            }

            // 4: Forma de Pagamento
            Cell pagCell = row.createCell(4);
            pagCell.setCellValue(despesa.getPagamento_despesa());
            pagCell.setCellStyle(normalStyle);

            // 5: ID Despesa
            Cell idCell = row.createCell(5);
            idCell.setCellValue(despesa.getId_despesa());
            idCell.setCellStyle(normalStyle);
        }
    }

    private void createDetailedSheetContas(List<ModelContas> contasMes, String mesAno) {
        Sheet contasSheet = workbook.createSheet("Contas_Pagas_Detalhes");
        this.sheet = contasSheet;
        this.rowNum = 0;

        // Headers e Título
        createSheetTitle(contasSheet, "DETALHE DE CONTAS PAGAS NO MÊS", mesAno, 8);

        String[] headers = {"Nº Pedido", "Empresa", "Itens", "Valor", "Data Pedido", "Data Pagamento", "Status", "Pagamento", "ID"};
        Row headerRow = contasSheet.createRow(rowNum++);

        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            contasSheet.setColumnWidth(i, i == 2 ? 6000 : 4000); // Itens um pouco maior
        }

        // Corpo da Tabela
        for (ModelContas contas : contasMes) {
            Row row = contasSheet.createRow(rowNum++);

            // 0: Nº Pedido
            Cell pedidoCell = row.createCell(0);
            pedidoCell.setCellValue(contas.getNumero_pedido());
            pedidoCell.setCellStyle(normalStyle);

            // 1: Empresa
            Cell empresaCell = row.createCell(1);
            empresaCell.setCellValue(contas.getEmpresa());
            empresaCell.setCellStyle(normalStyle);

            // 2: Itens
            Cell itensCell = row.createCell(2);
            itensCell.setCellValue(contas.getItens());
            itensCell.setCellStyle(normalStyle);

            // 3: Valor (Moeda)
            Cell valorCell = row.createCell(3);
            valorCell.setCellValue(contas.getValor());
            valorCell.setCellStyle(currencyStyle);

            // 4: Data Pedido
            Cell pedidoDataCell = row.createCell(4);
            if (contas.getData_de_pedido() != null) {
                pedidoDataCell.setCellValue(contas.getData_de_pedido());
                pedidoDataCell.setCellStyle(dateStyle);
            } else {
                pedidoDataCell.setCellStyle(normalStyle);
            }

            // 5: Data Pagamento
            Cell pagamentoDataCell = row.createCell(5);
            if (contas.getData_de_pagamento() != null) {
                pagamentoDataCell.setCellValue(contas.getData_de_pagamento());
                pagamentoDataCell.setCellStyle(dateStyle);
            } else {
                pagamentoDataCell.setCellStyle(normalStyle);
            }

            // 6: Status
            Cell statusCell = row.createCell(6);
            statusCell.setCellValue(contas.getStatus());
            statusCell.setCellStyle(normalStyle);

            // 7: Pagamento
            Cell pagamentoCell = row.createCell(7);
            pagamentoCell.setCellValue(contas.getPagamento());
            pagamentoCell.setCellStyle(normalStyle);

            // 8: ID
            Cell idCell = row.createCell(8);
            idCell.setCellValue(contas.getConta_id());
            idCell.setCellStyle(normalStyle);
        }
    }
}