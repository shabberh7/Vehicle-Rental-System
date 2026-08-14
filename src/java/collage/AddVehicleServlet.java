package collage;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddVehicleServlet")

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)

public class AddVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        /*
         Admin security check
        */
        if (session == null
                || session.getAttribute("userId") == null
                || !"admin".equalsIgnoreCase(
                        String.valueOf(
                                session.getAttribute("userRole")
                        )
                )) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        try {

            /*
             Form data receive karna
            */
            String carName =
                    request.getParameter("carName");

            String priceValue =
                    request.getParameter("price");

            String engine =
                    request.getParameter("engine");

            String power =
                    request.getParameter("power");

            String speed =
                    request.getParameter("speed");

            String fuel =
                    request.getParameter("fuel");

            String seatsValue =
                    request.getParameter("seats");

            String transmission =
                    request.getParameter("transmission");

            String category =
                    request.getParameter("category");

            String description =
                    request.getParameter("description");

            /*
             Empty validation
            */
            if (carName == null || carName.trim().isEmpty()
                    || priceValue == null || priceValue.trim().isEmpty()
                    || engine == null || engine.trim().isEmpty()
                    || power == null || power.trim().isEmpty()
                    || speed == null || speed.trim().isEmpty()
                    || fuel == null || fuel.trim().isEmpty()
                    || seatsValue == null || seatsValue.trim().isEmpty()
                    || transmission == null
                    || transmission.trim().isEmpty()
                    || category == null || category.trim().isEmpty()
                    || description == null
                    || description.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/add-vehicle.jsp?error=1"
                );

                return;
            }

            double price =
                    Double.parseDouble(priceValue);

            int seats =
                    Integer.parseInt(seatsValue);

            /*
             Image receive karna
            */
            Part imagePart =
                    request.getPart("image");

            if (imagePart == null
                    || imagePart.getSize() == 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/add-vehicle.jsp?error=1"
                );

                return;
            }

            String originalFileName =
                    imagePart.getSubmittedFileName();

            /*
             File name safe banana
            */
            originalFileName =
                    new File(originalFileName).getName();

            String extension = "";

            int dotIndex =
                    originalFileName.lastIndexOf(".");

            if (dotIndex > 0) {

                extension =
                        originalFileName.substring(dotIndex);

            }

            String imageName =
                    System.currentTimeMillis() + extension;

            /*
             images/vehicles folder banana
            */
            String uploadPath =
                    getServletContext().getRealPath(
                            "/images/vehicles"
                    );

            File uploadFolder =
                    new File(uploadPath);

            if (!uploadFolder.exists()) {

                uploadFolder.mkdirs();

            }

            /*
             Image save karna
            */
            imagePart.write(
                    uploadPath
                    + File.separator
                    + imageName
            );

            /*
             Database insert query
            */
            String sql =
                    "INSERT INTO vehicles "
                    + "(car_name, image, price, engine, "
                    + "power, speed, fuel, seats, "
                    + "transmission, category, description) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (
                    Connection con =
                            DBConnection.getConnection();

                    PreparedStatement ps =
                            con.prepareStatement(sql)
            ) {

                ps.setString(1, carName.trim());

                /*
                 Database me image ka relative path save hoga
                */
                ps.setString(
                        2,
                        "images/vehicles/" + imageName
                );

                ps.setDouble(3, price);
                ps.setString(4, engine.trim());
                ps.setString(5, power.trim());
                ps.setString(6, speed.trim());
                ps.setString(7, fuel);
                ps.setInt(8, seats);
                ps.setString(9, transmission);
                ps.setString(10, category);
                ps.setString(11, description.trim());

                int rows =
                        ps.executeUpdate();

                if (rows > 0) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/add-vehicle.jsp?success=1"
                    );

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/add-vehicle.jsp?error=1"
                    );

                }

            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-vehicle.jsp?error=1"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-vehicle.jsp?error=1"
            );

        }

    }

}