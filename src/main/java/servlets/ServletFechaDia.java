package servlets;

import dao.DAOFechaDia;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelFechaDia;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ServletFechaDia")
public class ServletFechaDia extends ServletGenericUtil {
    private DAOFechaDia daoFechaDia;

    @Override
    public void init() throws ServletException {
        daoFechaDia = new DAOFechaDia();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String msg;

            // Obtém os parâmetros do request
            String id = request.getParameter("id");
            String data_fechamento = request.getParameter("data_fechamento");
            String total_ft_din = request.getParameter("total_ft_din");
            String total_ft_deb = request.getParameter("total_ft_deb");
            String total_ft_cred = request.getParameter("total_ft_cred");
            String total_ft_pix = request.getParameter("total_ft_pix");
            String total_enc_din = request.getParameter("total_enc_din");
            String total_enc_deb = request.getParameter("total_enc_deb");
            String total_enc_cred = request.getParameter("total_enc_cred");
            String total_enc_pix = request.getParameter("total_enc_pix");
            String total_dig_din = request.getParameter("total_dig_din");
            String total_dig_deb = request.getParameter("total_dig_deb");
            String total_dig_cred = request.getParameter("total_dig_cred");
            String total_dig_pix = request.getParameter("total_dig_pix");
            String total_ribbon_1 = request.getParameter("total_ribbon_1");
            String total_ribbon_2 = request.getParameter("total_ribbon_2");
            String total_ribbon_3 = request.getParameter("total_ribbon_3");
            String total_ribbon_4 = request.getParameter("total_ribbon_4");
            String total_ribbon_5 = request.getParameter("total_ribbon_5");
            String desconto = request.getParameter("desconto");
            String observacao = request.getParameter("observacao");

            ModelFechaDia modelFechaDia = new ModelFechaDia();

            // Seta os dados do fechamento
            if (id != null && !id.isEmpty()) {
                modelFechaDia.setId(Long.parseLong(id));
            }

            if (data_fechamento != null && !data_fechamento.isEmpty()) {
                modelFechaDia.setData_fechamento(Date.valueOf(data_fechamento));
            }

            modelFechaDia.setTotal_ft_din(parseInt(total_ft_din));
            modelFechaDia.setTotal_ft_deb(parseInt(total_ft_deb));
            modelFechaDia.setTotal_ft_cred(parseInt(total_ft_cred));
            modelFechaDia.setTotal_ft_pix(parseInt(total_ft_pix));

            modelFechaDia.setTotal_enc_din(parseInt(total_enc_din));
            modelFechaDia.setTotal_enc_deb(parseInt(total_enc_deb));
            modelFechaDia.setTotal_enc_cred(parseInt(total_enc_cred));
            modelFechaDia.setTotal_enc_pix(parseInt(total_enc_pix));

            modelFechaDia.setTotal_dig_din(parseInt(total_dig_din));
            modelFechaDia.setTotal_dig_deb(parseInt(total_dig_deb));
            modelFechaDia.setTotal_dig_cred(parseInt(total_dig_cred));
            modelFechaDia.setTotal_dig_pix(parseInt(total_dig_pix));

            modelFechaDia.setTotal_ribbon_1(parseInt(total_ribbon_1));
            modelFechaDia.setTotal_ribbon_2(parseInt(total_ribbon_2));
            modelFechaDia.setTotal_ribbon_3(parseInt(total_ribbon_3));
            modelFechaDia.setTotal_ribbon_4(parseInt(total_ribbon_4));
            modelFechaDia.setTotal_ribbon_5(parseInt(total_ribbon_5));

            if (desconto != null && !desconto.isEmpty()) {
                modelFechaDia.setDesconto(new BigDecimal(desconto.replace(",", ".")));
            }

            modelFechaDia.setObservacao(observacao);

            // Verifica se o ID é válido
            if (modelFechaDia.getId() > 0) {
                if (daoFechaDia.existeFechaDiaId(modelFechaDia.getId())) {
                    daoFechaDia.atualizarFechaDia(modelFechaDia);
                    msg = "Fechamento atualizado com sucesso!";
                } else {
                    daoFechaDia.gravarFechaDia(modelFechaDia);
                    msg = "Fechamento gravado com sucesso!";
                }
            } else {
                daoFechaDia.gravarFechaDia(modelFechaDia);
                msg = "Fechamento gravado com sucesso!";
            }

            // Mantém os dados e mensagem na tela
            request.setAttribute("msg", msg);
            request.setAttribute("modelFechaDia", modelFechaDia);

            // Redireciona após gravar ou atualizar
            response.sendRedirect(request.getContextPath() + "/ServletFechaDia");

        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
            request.setAttribute("msg", e.getMessage());
            redirecionar.forward(request, response);
        }
    }

    // Função para converter String para int
    private int parseInt(String valor) {
        if (valor == null || valor.isEmpty()) {
            return 0;
        }
        try {
            return Integer.parseInt(valor);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Valor inválido: " + valor);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ModelFechaDia> listaFechamentos;
        String acao = request.getParameter("acao");
        String fechamentoId = request.getParameter("fechamento_id");

        try {
            // Chama o método para listar todos os fechamentos
            listaFechamentos = daoFechaDia.listarFechamentos(); // Corrigido para usar daoFechaDia
            request.setAttribute("listaFechamentos", listaFechamentos); // Passa todos os fechamentos para o JSP

            // Verifica se a ação é deletar e se o ID do fechamento é válido
            if ("deletar".equals(acao) && fechamentoId != null && !fechamentoId.isEmpty()) {
                long idParaExcluir = Long.parseLong(fechamentoId);
                try {
                    daoFechaDia.deletarFechamento(idParaExcluir); // Chama o método de exclusão
                    request.setAttribute("msg", "Fechamento com ID " + idParaExcluir + " excluído com sucesso!");
                } catch (Exception e) {
                    request.setAttribute("msg", "Erro ao excluir fechamento: " + e.getMessage());
                }
            }

        } catch (SQLException e) {
            request.setAttribute("msg", "Erro ao buscar fechamentos: " + e.getMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        // Redireciona para o JSP onde a lista de fechamentos será exibida
        request.getRequestDispatcher("/fechamentos.jsp").forward(request, response);
    }
}
