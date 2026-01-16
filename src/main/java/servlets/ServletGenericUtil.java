package servlets;

import dao.DAOUsuarioRepository;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.Serializable;
import java.sql.Connection;

public class ServletGenericUtil extends HttpServlet implements Serializable {
    private static final long serialVersionUID = 1L;
    // ✅ REMOVIDO: private final DAOUsuarioRepository daoUsuarioRepository

    public Long getUserLogado(HttpServletRequest request) throws Exception {
        Connection conn = (Connection) request.getAttribute("connection");
        DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository(conn);

        HttpSession session = request.getSession();
        String usuarioLogado = (String) session.getAttribute("usuario");
        return daoUsuarioRepository.consultarUsuarioLogado(usuarioLogado).getId();
    }
}