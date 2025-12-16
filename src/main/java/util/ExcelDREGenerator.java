package util;

import model.ModelFechaMes;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

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

    public ExcelDREGenerator() {
        this.workbook = new XSSFWorkbook();
        this.sheet = workbook.createSheet("DRE");
        createStyles();
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

        // Configurar largura das colunas
        sheet.setColumnWidth(0, 8000);  // Coluna de descrição
        sheet.setColumnWidth(1, 5000);  // Coluna de valores

        // ========== TÍTULO ==========
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("DEMONSTRAÇÃO DO RESULTADO DO EXERCÍCIO (DRE)");
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 1));
        titleRow.setHeightInPoints(25);

        // Subtítulo com mês/ano
        Row subtitleRow = sheet.createRow(rowNum++);
        Cell subtitleCell = subtitleRow.createCell(0);
        subtitleCell.setCellValue(mesAno.toUpperCase());
        subtitleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 1));
        subtitleRow.setHeightInPoints(20);

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
}