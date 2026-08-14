package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VehicleDetailsServlet")
public class VehicleDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("VehicleServlet");
            return;
        }

        String sql = "SELECT * FROM vehicles WHERE id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, Integer.parseInt(id));

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute(
                        "id",
                        rs.getInt("id")
                );

                request.setAttribute(
                        "carName",
                        rs.getString("car_name")
                );

                request.setAttribute(
                        "image",
                        VehicleImageUtil.getImage(rs.getString("car_name"))
                );

                request.setAttribute(
                        "price",
                        rs.getString("price")
                );

                request.setAttribute(
                        "engine",
                        rs.getString("engine")
                );

                request.setAttribute(
                        "power",
                        rs.getString("power")
                );

                request.setAttribute(
                        "speed",
                        rs.getString("speed")
                );

                request.setAttribute(
                        "fuel",
                        rs.getString("fuel")
                );

                request.setAttribute(
                        "seats",
                        rs.getString("seats")
                );

                request.setAttribute(
                        "transmission",
                        rs.getString("transmission")
                );

                request.setAttribute(
                        "category",
                        rs.getString("category")
                );

                request.setAttribute(
                        "description",
                        rs.getString("description")
                );

                request.setAttribute(
                        "status",
                        rs.getString("status")
                );

                RequestDispatcher rd =
        request.getRequestDispatcher("/vehicledetail.jsp");
                        

                rd.forward(request, response);

            } else {

                response.sendRedirect("VehicleServlet");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (NumberFormatException e) {

            response.sendRedirect("VehicleServlet");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "VehicleServlet?error=details"
            );
        }
    }
}