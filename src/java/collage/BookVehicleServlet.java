package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookVehicleServlet")
public class BookVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );
            return;
        }

        Connection con = null;
        PreparedStatement pricePs = null;
        PreparedStatement bookingPs = null;
        PreparedStatement detailPs = null;
        ResultSet rs = null;
        ResultSet keyRs = null;
        ResultSet detailRs = null;

        try {

            int userId = Integer.parseInt(
                    session.getAttribute("userId").toString()
            );

            int vehicleId = Integer.parseInt(
                    request.getParameter("vehicleId")
            );

            String pickupDate =
                    request.getParameter("pickupDate");

            String returnDate =
                    request.getParameter("returnDate");

            String location =
                    request.getParameter("location");

            String paymentMethod =
                    request.getParameter("paymentMethod");

            if (pickupDate == null
                    || returnDate == null
                    || location == null
                    || paymentMethod == null
                    || pickupDate.trim().isEmpty()
                    || returnDate.trim().isEmpty()
                    || location.trim().isEmpty()
                    || paymentMethod.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/book-vehicle.jsp?id="
                        + vehicleId
                        + "&error=empty"
                );
                return;
            }

            LocalDate pickupLocalDate =
                    LocalDate.parse(pickupDate);

            LocalDate returnLocalDate =
                    LocalDate.parse(returnDate);

            LocalDate today =
                    LocalDate.now();

            if (pickupLocalDate.isBefore(today)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/book-vehicle.jsp?id="
                        + vehicleId
                        + "&error=pastdate"
                );
                return;
            }

            if (returnLocalDate.isBefore(pickupLocalDate)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/book-vehicle.jsp?id="
                        + vehicleId
                        + "&error=date"
                );
                return;
            }

            long totalDays = ChronoUnit.DAYS.between(
                    pickupLocalDate,
                    returnLocalDate
            );

            if (totalDays == 0) {
                totalDays = 1;
            }

            con = DBConnection.getConnection();

            String priceSql =
                    "SELECT price FROM vehicles WHERE id = ?";

            pricePs = con.prepareStatement(priceSql);
            pricePs.setInt(1, vehicleId);

            rs = pricePs.executeQuery();

            if (!rs.next()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/VehicleServlet?error=invalidVehicle"
                );
                return;
            }

            double pricePerDay =
                    rs.getDouble("price");

            double totalPrice =
                    pricePerDay * totalDays;

            String bookingSql =
                    "INSERT INTO bookings "
                    + "(user_id, vehicle_id, pickup_date, "
                    + "return_date, location, payment_method, "
                    + "total_price, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            bookingPs = con.prepareStatement(
                    bookingSql,
                    Statement.RETURN_GENERATED_KEYS
            );

            bookingPs.setInt(1, userId);
            bookingPs.setInt(2, vehicleId);
            bookingPs.setDate(3, Date.valueOf(pickupLocalDate));
            bookingPs.setDate(4, Date.valueOf(returnLocalDate));
            bookingPs.setString(5, location);
            bookingPs.setString(6, paymentMethod);
            bookingPs.setDouble(7, totalPrice);
            bookingPs.setString(8, "pending");

            int result = bookingPs.executeUpdate();

            if (result > 0) {

                keyRs = bookingPs.getGeneratedKeys();

                int bookingId = 0;

                if (keyRs.next()) {
                    bookingId = keyRs.getInt(1);
                }

                String detailSql =
                        "SELECT "
                        + "u.name AS customer_name, "
                        + "u.email AS customer_email, "
                        + "u.mobile AS customer_mobile, "
                        + "v.name AS car_name, "
                        + "v.image AS car_image "
                        + "FROM users u, vehicles v "
                        + "WHERE u.id = ? AND v.id = ?";

                detailPs = con.prepareStatement(detailSql);

                detailPs.setInt(1, userId);
                detailPs.setInt(2, vehicleId);

                detailRs = detailPs.executeQuery();

                if (detailRs.next()) {

                    request.setAttribute(
                            "bookingId",
                            bookingId
                    );

                    request.setAttribute(
                            "customerName",
                            detailRs.getString("customer_name")
                    );

                    request.setAttribute(
                            "customerEmail",
                            detailRs.getString("customer_email")
                    );

                    request.setAttribute(
                            "customerMobile",
                            detailRs.getString("customer_mobile")
                    );

                    request.setAttribute(
                            "carName",
                            detailRs.getString("car_name")
                    );

                    request.setAttribute(
                            "carImage",
                            detailRs.getString("car_image")
                    );

                    request.setAttribute(
                            "pickupDate",
                            Date.valueOf(pickupLocalDate)
                    );

                    request.setAttribute(
                            "returnDate",
                            Date.valueOf(returnLocalDate)
                    );

                    request.setAttribute(
                            "location",
                            location
                    );

                    request.setAttribute(
                            "paymentMethod",
                            paymentMethod
                    );

                    request.setAttribute(
                            "totalPrice",
                            totalPrice
                    );

                    request.setAttribute(
                            "bookingStatus",
                            "pending"
                    );

                    request.getRequestDispatcher(
                            "/invoice.jsp"
                    ).forward(request, response);

                    return;
                }
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/book-vehicle.jsp?id="
                    + vehicleId
                    + "&error=failed"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/VehicleServlet?error=booking"
            );

        } finally {

            try {
                if (detailRs != null) detailRs.close();
                if (keyRs != null) keyRs.close();
                if (rs != null) rs.close();
                if (detailPs != null) detailPs.close();
                if (pricePs != null) pricePs.close();
                if (bookingPs != null) bookingPs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
