package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VehicleServlet")
public class VehicleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> vehicleList = new ArrayList<>();

        String sql =
                "SELECT id, name, brand, type, price, image, status "
                + "FROM vehicles ORDER BY id ASC";

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/Deshboard.jsp?error=database"
                );

                return;
            }

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                String[] vehicle =
                        new String[13];

                String carName =
                        rs.getString("name");

                String image =
                        rs.getString("image");

                /*
                 Agar database me image blank hai,
                 to car name ke according image lagegi.
                */
                if (image == null
                        || image.trim().isEmpty()) {

                    image =
                            VehicleImageUtil.getImage(
                                    carName
                            );
                }

                vehicle[0] =
                        String.valueOf(
                                rs.getInt("id")
                        );

                vehicle[1] =
                        carName;

                vehicle[2] =
                        image;

                vehicle[3] =
                        rs.getString("price");

                /*
                 Railway table me abhi ye extra
                 columns nahi hain, isliye normal
                 default details bhej rahe hain.
                */

                vehicle[4] =
                        rs.getString("brand");

                vehicle[5] =
                        "Premium";

                vehicle[6] =
                        "High Performance";

                vehicle[7] =
                        "Petrol";

                vehicle[8] =
                        "5";

                vehicle[9] =
                        "Automatic";

                vehicle[10] =
                        rs.getString("type");

                vehicle[11] =
                        "Premium luxury vehicle available for rental.";

                vehicle[12] =
                        rs.getString("status");

                vehicleList.add(vehicle);
            }

            rs.close();
            ps.close();

            request.setAttribute(
                    "vehicleList",
                    vehicleList
            );

            RequestDispatcher rd =
                    request.getRequestDispatcher(
                            "/vehicle.jsp"
                    );

            rd.forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/Deshboard.jsp?error=vehicles"
            );
        }
    }
}
