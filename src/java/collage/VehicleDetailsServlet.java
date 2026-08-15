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
            response.sendRedirect(
                    request.getContextPath() + "/VehicleServlet"
            );
            return;
        }

        String sql =
                "SELECT id, name, brand, type, price, image, status "
                + "FROM vehicles WHERE id = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(
                    1,
                    Integer.parseInt(id)
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                String carName =
                        rs.getString("name");

                String image =
                        rs.getString("image");

                if (image == null
                        || image.trim().isEmpty()) {

                    image =
                            VehicleImageUtil.getImage(
                                    carName
                            );
                }

                request.setAttribute(
                        "id",
                        rs.getInt("id")
                );

                request.setAttribute(
                        "carName",
                        carName
                );

                request.setAttribute(
                        "image",
                        image
                );

                request.setAttribute(
                        "price",
                        rs.getString("price")
                );

                request.setAttribute(
                        "engine",
                        rs.getString("brand")
                );

                request.setAttribute(
                        "power",
                        "Premium Performance"
                );

                request.setAttribute(
                        "speed",
                        "High Performance"
                );

                request.setAttribute(
                        "fuel",
                        "Petrol"
                );

                request.setAttribute(
                        "seats",
                        "5"
                );

                request.setAttribute(
                        "transmission",
                        "Automatic"
                );

                request.setAttribute(
                        "category",
                        rs.getString("type")
                );

                request.setAttribute(
                        "description",
                        "Premium luxury vehicle available for rental."
                );

                request.setAttribute(
                        "status",
                        rs.getString("status")
                );

                RequestDispatcher rd =
                        request.getRequestDispatcher(
                                "/vehicledetail.jsp"
                        );

                rd.forward(
                        request,
                        response
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/VehicleServlet"
                );
            }

            rs.close();
            ps.close();

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/VehicleServlet"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/VehicleServlet?error=details"
            );
        }
    }
}
