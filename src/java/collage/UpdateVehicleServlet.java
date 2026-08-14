package collage;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
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

@WebServlet("/UpdateVehicleServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class UpdateVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || session.getAttribute("userRole") == null
                || !"admin".equalsIgnoreCase(
                        session.getAttribute("userRole").toString()
                )) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        String vehicleIdValue =
                request.getParameter("vehicleId");

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

        String oldImage =
                request.getParameter("oldImage");

        int vehicleId;
        int seats;
        double price;

        try {

            vehicleId =
                    Integer.parseInt(vehicleIdValue);

            seats =
                    Integer.parseInt(seatsValue);

            price =
                    Double.parseDouble(priceValue);

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/edit-vehicle.jsp?id="
                    + vehicleIdValue
                    + "&error=invalidData"
            );

            return;
        }

        if (carName == null || carName.trim().isEmpty()
                || engine == null || engine.trim().isEmpty()
                || power == null || power.trim().isEmpty()
                || speed == null || speed.trim().isEmpty()
                || fuel == null || fuel.trim().isEmpty()
                || transmission == null
                || transmission.trim().isEmpty()
                || category == null || category.trim().isEmpty()
                || description == null
                || description.trim().isEmpty()
                || price <= 0
                || seats <= 0) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/edit-vehicle.jsp?id="
                    + vehicleId
                    + "&error=invalidData"
            );

            return;
        }

        String finalImage = oldImage;

        try {

            Part imagePart =
                    request.getPart("image");

            if (imagePart != null
                    && imagePart.getSize() > 0) {

                String submittedFileName =
                        Paths.get(
                                imagePart.getSubmittedFileName()
                        ).getFileName().toString();

                String extension = "";

                int dotIndex =
                        submittedFileName.lastIndexOf(".");

                if (dotIndex >= 0) {

                    extension =
                            submittedFileName.substring(dotIndex);
                }

                String newFileName =
                        "vehicle_"
                        + vehicleId
                        + "_"
                        + System.currentTimeMillis()
                        + extension;

                String uploadFolder =
                        getServletContext()
                        .getRealPath("/uploads/vehicles");

                File uploadDirectory =
                        new File(uploadFolder);

                if (!uploadDirectory.exists()) {

                    uploadDirectory.mkdirs();
                }

                String completeFilePath =
                        uploadFolder
                        + File.separator
                        + newFileName;

                imagePart.write(completeFilePath);

                finalImage =
                        "uploads/vehicles/"
                        + newFileName;
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/edit-vehicle.jsp?id="
                    + vehicleId
                    + "&error=updateFailed"
            );

            return;
        }

        String sql =
                "UPDATE vehicles SET "
                + "car_name = ?, "
                + "image = ?, "
                + "price = ?, "
                + "engine = ?, "
                + "power = ?, "
                + "speed = ?, "
                + "fuel = ?, "
                + "seats = ?, "
                + "transmission = ?, "
                + "category = ?, "
                + "description = ? "
                + "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    carName.trim()
            );

            ps.setString(
                    2,
                    finalImage
            );

            ps.setDouble(
                    3,
                    price
            );

            ps.setString(
                    4,
                    engine.trim()
            );

            ps.setString(
                    5,
                    power.trim()
            );

            ps.setString(
                    6,
                    speed.trim()
            );

            ps.setString(
                    7,
                    fuel.trim()
            );

            ps.setInt(
                    8,
                    seats
            );

            ps.setString(
                    9,
                    transmission.trim()
            );

            ps.setString(
                    10,
                    category.trim()
            );

            ps.setString(
                    11,
                    description.trim()
            );

            ps.setInt(
                    12,
                    vehicleId
            );

            int rowsUpdated =
                    ps.executeUpdate();

            ps.close();

            if (rowsUpdated > 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/manage-vehicles.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/edit-vehicle.jsp?id="
                        + vehicleId
                        + "&error=updateFailed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/edit-vehicle.jsp?id="
                    + vehicleId
                    + "&error=updateFailed"
            );
        }
    }
}