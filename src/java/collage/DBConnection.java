package collage;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con;

    public static Connection getConnection() {

        try {

            if (con == null || con.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/vehicle_rental",
                        "root",
                        "123456789"
                );

                System.out.println("Database Connected Successfully");

            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return con;
    }

    // Test Database Connection
    public static void main(String[] args) {

        Connection conn = DBConnection.getConnection();

        if (conn != null) {
            System.out.println("Connection Successful");
        } else {
            System.out.println("Connection Failed");
        }

    }

}