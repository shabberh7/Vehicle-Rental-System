package collage;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con;

    public static Connection getConnection() {

        try {

            if (con == null || con.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                String host = System.getenv("DB_HOST");
                String port = System.getenv("DB_PORT");
                String database = System.getenv("DB_NAME");
                String user = System.getenv("DB_USER");
                String password = System.getenv("DB_PASSWORD");

                String url = "jdbc:mysql://" + host + ":" + port + "/" + database;

                con = DriverManager.getConnection(url, user, password);

                System.out.println("Database Connected Successfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
