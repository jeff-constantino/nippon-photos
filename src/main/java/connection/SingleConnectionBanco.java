package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {

    private static final String banco = "jdbc:postgresql://localhost:5432/jeffe6510_nippon?autoReconnect=true";
    private static final String user = "jeffe6510_nippon";
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
