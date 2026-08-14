package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
        ResultSet rs = null;

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

            /*
             Pickup aur return same date ho to 1 day charge.
             Example:
             29 Aug se 30 Aug = 1 day
             29 Aug se 31 Aug = 2 days
            */
            long totalDays = ChronoUnit.DAYS.between(
                    pickupLocalDate,
                    returnLocalDate
            );

            if (totalDays == 0) {
                totalDays = 1;
            }

            con = DBConnection.getConnection();

            /*
             Vehicle ka price database se niklega.
             Hidden field par depend nahi karenge.
            */
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

            bookingPs =
                    con.prepareStatement(bookingSql);

            bookingPs.setInt(1, userId);
            bookingPs.setInt(2, vehicleId);

            bookingPs.setDate(
                    3,
                    Date.valueOf(pickupLocalDate)
            );

            bookingPs.setDate(
                    4,
                    Date.valueOf(returnLocalDate)
            );

            bookingPs.setString(5, location);
            bookingPs.setString(6, paymentMethod);
            bookingPs.setDouble(7, totalPrice);
            bookingPs.setString(8, "pending");

            int result =
                    bookingPs.executeUpdate();

            if (result > 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/MyBookingsServlet?success=booked"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/book-vehicle.jsp?id="
                        + vehicleId
                        + "&error=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/VehicleServlet?error=booking"
            );

        } finally {

            try {

                if (rs != null) {
                    rs.close();
                }

                if (pricePs != null) {
                    pricePs.close();
                }

                if (bookingPs != null) {
                    bookingPs.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}