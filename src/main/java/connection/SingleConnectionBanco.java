package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {

    private static final String banco = "jdbc:postgresql://localhost:5432/jeffe6510_nippon?sslmode=disable&tcpKeepAlive=true&socketTimeout=30";
    private static final String user = "jeffe6510";
    private static final String senha = "Aplic@tiv0";
    private static Connection connection = null;

    public static Connection getConnection() {
        return connection;
    }

    static {
        conectar();
    }

    public SingleConnectionBanco() { /*quando tiver uma instancia vai conectar*/

        conectar();

    }

    private static void conectar() {
        try {
            if (connection == null) {
                Class.forName("org.postgresql.Driver");/*carrega o driver de conexao do banco*/
                connection = DriverManager.getConnection(banco, user, senha);
                connection.setAutoCommit(false);/*para n�o efetuar altera��es no banco sem nosso comando*/



            }



        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
