package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {
    private static final String banco = "jdbc:postgresql://localhost:5432/jeffe6510_nippon?sslmode=disable&tcpKeepAlive=true&socketTimeout=30";
    private static final String user = "jeffe6510_admin";
    private static final String senha = "Aplic@tiv0";

    private static Connection connection = null;

    public static Connection getConnection() {
        return connection;
    }

    static {
        conectar();
    }

    public SingleConnectionBanco() {
        conectar();
    }

    private static void conectar() {
        try {
            if (connection == null) {
                Class.forName("org.postgresql.Driver");
                connection = DriverManager.getConnection(banco, user, senha);
                connection.setAutoCommit(false);

                var ps = connection.prepareStatement("SELECT current_user");
                var rs = ps.executeQuery();
                if (rs.next()) {
                    System.out.println("USUARIO BANCO = " + rs.getString(1));
                }
                rs.close();
                ps.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}