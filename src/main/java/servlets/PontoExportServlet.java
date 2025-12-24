package servlets;

import dao.PontoDAO;
import model.Ponto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Servlet para exportar relatórios em Excel
 */
@WebServlet("/ponto-export")
public class PontoExportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            int funcId = Integer.parseInt(req.getParameter("funcId"));
            Date dataInicio = Date.valueOf(req.getParameter("dataInicio"));
            Date dataFim = Date.valueOf(req.getParameter("dataFim"));

            PontoDAO dao = new PontoDAO();
            List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);

            // Buscar nome do funcionário
            Ponto func = registros.isEmpty() ? null : registros.get(0);
            String nomeFuncionario = func != null ? func.getFuncNome() : "Funcionário";

            // Criar workbook Excel
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Relatório de Ponto");

            // Estilos
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            CellStyle dateStyle = workbook.createCellStyle();
            dateStyle.setDataFormat(workbook.createDataFormat().getFormat("dd/mm/yyyy"));

            CellStyle timeStyle = workbook.createCellStyle();
            timeStyle.setDataFormat(workbook.createDataFormat().getFormat("hh:mm"));

            CellStyle alertaStyle = workbook.createCellStyle();
            alertaStyle.setFillForegroundColor(IndexedColors.RED.getIndex());
            alertaStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            // Cabeçalho
            Row headerRow = sheet.createRow(0);
            String[] colunas = {"Data", "Dia Semana", "Entrada", "Saída Intervalo", "Retorno Intervalo",
                    "Saída", "Horas Trabalhadas", "Atraso", "Horas Noturnas", "Status"};

            for (int i = 0; i < colunas.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(colunas[i]);
                cell.setCellStyle(headerStyle);
            }

            // Dados
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            int rowNum = 1;

            for (Ponto reg : registros) {
                Row row = sheet.createRow(rowNum++);

                // Data
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(dateFormat.format(reg.getRegData()));

                // Dia da semana
                row.createCell(1).setCellValue(reg.getDiaSemanaTexto());

                // Entrada
                if (reg.getRegEntrada() != null) {
                    row.createCell(2).setCellValue(timeFormat.format(reg.getRegEntrada()));
                }

                // Saída Intervalo
                if (reg.getRegSaidaIntervalo() != null) {
                    row.createCell(3).setCellValue(timeFormat.format(reg.getRegSaidaIntervalo()));
                }

                // Retorno Intervalo
                if (reg.getRegRetornoIntervalo() != null) {
                    row.createCell(4).setCellValue(timeFormat.format(reg.getRegRetornoIntervalo()));
                }

                // Saída
                if (reg.getRegSaida() != null) {
                    row.createCell(5).setCellValue(timeFormat.format(reg.getRegSaida()));
                }

                // Horas Trabalhadas
                row.createCell(6).setCellValue(reg.getHorasTrabalhadasFormatado());

                // Atraso
                Cell atrasoCell = row.createCell(7);
                if (reg.getRegMinutosAtraso() != null && reg.getRegMinutosAtraso() > 0) {
                    atrasoCell.setCellValue(reg.getAtrasoFormatado());
                    atrasoCell.setCellStyle(alertaStyle);
                } else {
                    atrasoCell.setCellValue("-");
                }

                // Horas Noturnas
                row.createCell(8).setCellValue(reg.getHorasNoturnoFormatado());

                // Status
                row.createCell(9).setCellValue(reg.getStatusDia());
            }

            // Auto-size colunas
            for (int i = 0; i < colunas.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Configurar response para download
            String filename = "Relatorio_" + nomeFuncionario.replaceAll(" ", "_") + "_" +
                    new SimpleDateFormat("yyyyMMdd").format(dataInicio) + ".xlsx";

            resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

            // Escrever workbook no response
            workbook.write(resp.getOutputStream());
            workbook.close();

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao gerar Excel: " + e.getMessage());
        }
    }
}