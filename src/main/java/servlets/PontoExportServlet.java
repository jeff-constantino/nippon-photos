package servlets;

import dao.PontoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Ponto;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/ponto-export")
public class PontoExportServlet extends HttpServlet {
    // ✅ REMOVIDO: campos de DAO

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("connection");
        req.setCharacterEncoding("UTF-8");

        try {
            int funcId = Integer.parseInt(req.getParameter("funcId"));
            Date dataInicio = Date.valueOf(req.getParameter("dataInicio"));
            Date dataFim = Date.valueOf(req.getParameter("dataFim"));

            PontoDAO dao = new PontoDAO(conn);
            List<Ponto> registros = dao.buscarRegistrosPeriodo(funcId, dataInicio, dataFim);

            Ponto func = registros.isEmpty() ? null : registros.get(0);
            String nomeFuncionario = func != null ? func.getFuncNome() : "Funcionário";

            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Relatório de Ponto");

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

            CellStyle autorizadoStyle = workbook.createCellStyle();
            autorizadoStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            autorizadoStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            Row headerRow = sheet.createRow(0);
            String[] colunas = {"Data", "Dia Semana", "Entrada", "Saída Intervalo", "Retorno Intervalo",
                    "Saída", "Horas Trabalhadas", "Atraso", "Horas Noturnas", "Status", "Motivo/Observação"};

            for (int i = 0; i < colunas.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(colunas[i]);
                cell.setCellStyle(headerStyle);
            }

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            int rowNum = 1;

            for (Ponto reg : registros) {
                Row row = sheet.createRow(rowNum++);
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(dateFormat.format(reg.getRegData()));
                row.createCell(1).setCellValue(reg.getDiaSemanaTexto());
                if (reg.getRegEntrada() != null) row.createCell(2).setCellValue(timeFormat.format(reg.getRegEntrada()));
                if (reg.getRegSaidaIntervalo() != null) row.createCell(3).setCellValue(timeFormat.format(reg.getRegSaidaIntervalo()));
                if (reg.getRegRetornoIntervalo() != null) row.createCell(4).setCellValue(timeFormat.format(reg.getRegRetornoIntervalo()));
                if (reg.getRegSaida() != null) row.createCell(5).setCellValue(timeFormat.format(reg.getRegSaida()));
                row.createCell(6).setCellValue(reg.getHorasTrabalhadasFormatado());

                Cell atrasoCell = row.createCell(7);
                boolean temAtraso = reg.getRegMinutosAtraso() != null && reg.getRegMinutosAtraso() > 0;
                boolean atrasoAutorizado = reg.getAtrasoAutorizado() != null && reg.getAtrasoAutorizado();

                if (temAtraso) {
                    String textoAtraso = reg.getAtrasoFormatado();
                    if (atrasoAutorizado) {
                        textoAtraso += " (Autorizado)";
                        atrasoCell.setCellStyle(autorizadoStyle);
                    } else {
                        atrasoCell.setCellStyle(alertaStyle);
                    }
                    atrasoCell.setCellValue(textoAtraso);
                } else {
                    atrasoCell.setCellValue("-");
                }

                row.createCell(8).setCellValue(reg.getHorasNoturnoFormatado());
                row.createCell(9).setCellValue(reg.getStatusDia());

                Cell motivoCell = row.createCell(10);
                if (reg.getJustTipo() != null) {
                    String motivo = reg.getJustTipo();
                    if (reg.getJustDescricao() != null && !reg.getJustDescricao().trim().isEmpty()) {
                        motivo += ": " + reg.getJustDescricao();
                    }
                    motivoCell.setCellValue(motivo);
                    motivoCell.setCellStyle(autorizadoStyle);
                } else if (reg.getRegObservacao() != null && !reg.getRegObservacao().trim().isEmpty()) {
                    motivoCell.setCellValue(reg.getRegObservacao());
                } else {
                    motivoCell.setCellValue("-");
                }
            }

            for (int i = 0; i < colunas.length; i++) {
                sheet.autoSizeColumn(i);
            }

            String filename = "Relatorio_" + nomeFuncionario.replaceAll(" ", "_") + "_" +
                    new SimpleDateFormat("yyyyMMdd").format(dataInicio) + ".xlsx";

            resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

            workbook.write(resp.getOutputStream());
            workbook.close();

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao gerar Excel: " + e.getMessage());
        }
    }
}