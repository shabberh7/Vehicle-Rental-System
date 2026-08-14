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

        String sql = "SELECT * FROM vehicles ORDER BY id ASC";

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/Deshboard.jsp?error=database"
                );

                return;
            }

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String[] vehicle = new String[13];

                String carName = rs.getString("car_name");

                vehicle[0] = String.valueOf(rs.getInt("id"));
                vehicle[1] = carName;

                /*
                 * Car name ke according image automatically
                 * images/cars folder se select hogi.
                 */
                vehicle[2] = VehicleImageUtil.getImage(carName);

                vehicle[3] = rs.getString("price");
                vehicle[4] = rs.getString("engine");
                vehicle[5] = rs.getString("power");
                vehicle[6] = rs.getString("speed");
                vehicle[7] = rs.getString("fuel");
                vehicle[8] = rs.getString("seats");
                vehicle[9] = rs.getString("transmission");
                vehicle[10] = rs.getString("category");
                vehicle[11] = rs.getString("description");
                vehicle[12] = rs.getString("status");

                vehicleList.add(vehicle);
            }

            rs.close();
            ps.close();

            request.setAttribute("vehicleList", vehicleList);

            RequestDispatcher rd =
                    request.getRequestDispatcher("/vehicle.jsp");

            rd.forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/Deshboard.jsp?error=vehicles"
            );
        }
    }

    /*
     * Car ke naam ke according image path return karta hai.
     */
    private String getVehicleImage(String carName) {

        if (carName == null || carName.trim().isEmpty()) {

            return "images/cars/bugatti.jpg";
        }

        String name = carName.toLowerCase().trim();

        /*
         * Specific models ko pehle check karna zaroori hai.
         */

        if (name.contains("aventador")) {

            return "images/cars/aventador.jpg";

        } else if (name.contains("bugatti")) {

            return "images/cars/bugatti.jpg";

        } else if (name.contains("ferrari")) {

            return "images/cars/ferrari.jpg";

        } else if (name.contains("lamborghini")) {

            return "images/cars/lamborghini.jpg";

        } else if (name.contains("aston martin")
                || name.contains("astonmartin")) {

            return "images/cars/astonmartin.jpg";

        } else if (name.contains("audi")) {

            return "images/cars/audir8.jpg";

        } else if (name.contains("bmw")) {

            return "images/cars/bmwm8.jpg";

        } else if (name.contains("bentley")) {

            return "images/cars/bentley.jpg";

        } else if (name.contains("rolls royce")
                || name.contains("rolls-royce")
                || name.contains("rollsroyce")) {

            return "images/cars/rollsroyce.jpg";

        } else if (name.contains("range rover")
                || name.contains("rangerover")) {

            return "images/cars/range rover.jpg";

        } else if (name.contains("porsche")) {

            return "images/cars/porsche.jpg";

        } else if (name.contains("mclaren 720")
                || name.contains("720s")) {

            return "images/cars/mclaren.jpg";

        } else if (name.contains("mclaren 765")
                || name.contains("765lt")) {

            return "images/cars/mclaren2.jpg";

        } else if (name.contains("mclaren")) {

            return "images/cars/mclaren_1.jpg";
        }

        /*
         * Agar car name match nahi hua,
         * to ye default image lagegi.
         */
        return "images/cars/bugatti.jpg";
    }
}