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

        // Admin session check
        if (session == null
                || session.getAttribute("adminLoggedIn") == null
                || !Boolean.TRUE.equals(
                        session.getAttribute("adminLoggedIn")
                )) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-login.jsp"
            );

            return;
        }

        try {

            String carName =
                    request.getParameter("carName");

            String priceValue =
                    request.getParameter("price");

            String engine =
                    request.getParameter("engine");

            String category =
                    request.getParameter("category");

            if (carName == null
                    || carName.trim().isEmpty()
                    || priceValue == null
                    || priceValue.trim().isEmpty()
                    || category == null
                    || category.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/add-vehicle.jsp?error=1"
                );

                return;
            }

            double price =
                    Double.parseDouble(priceValue);

            Part imagePart =
                    request.getPart("image");

            String imagePath = "";

            if (imagePart != null
                    && imagePart.getSize() > 0) {

                String originalFileName =
                        imagePart.getSubmittedFileName();

                originalFileName =
                        new File(
                                originalFileName
                        ).getName();

                String extension = "";

                int dotIndex =
                        originalFileName.lastIndexOf(".");

                if (dotIndex > 0) {

                    extension =
                            originalFileName.substring(
                                    dotIndex
                            );
                }

                String imageName =
                        System.currentTimeMillis()
                        + extension;

                String uploadPath =
                        getServletContext()
                        .getRealPath(
                                "/images/vehicles"
                        );

                File uploadFolder =
                        new File(uploadPath);

                if (!uploadFolder.exists()) {

                    uploadFolder.mkdirs();
                }

                imagePart.write(
                        uploadPath
                        + File.separator
                        + imageName
                );

                imagePath =
                        "images/vehicles/"
                        + imageName;
            }

            String sql =
                    "INSERT INTO vehicles "
                    + "(name, brand, type, price, image, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            try (
                    Connection con =
                            DBConnection.getConnection();

                    PreparedStatement ps =
                            con.prepareStatement(sql)
            ) {

                ps.setString(
                        1,
                        carName.trim()
                );

                ps.setString(
                        2,
                        engine == null
                                ? ""
                                : engine.trim()
                );

                ps.setString(
                        3,
                        category.trim()
                );

                ps.setDouble(
                        4,
                        price
                );

                ps.setString(
                        5,
                        imagePath
                );

                ps.setString(
                        6,
                        "Available"
                );

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

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-vehicle.jsp?error=1"
            );
        }
    }
}
