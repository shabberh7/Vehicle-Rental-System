package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {

    private String getVehicleImage(int vehicleId) {

        switch (vehicleId) {

            case 1:
                return "images/cars/bugatti.jpg";

            case 2:
                return "images/cars/ferrari.jpg";

            case 3:
                return "images/cars/lamborghini.jpg";

            case 4:
                return "images/cars/rollsroyce.jpg";

            case 5:
                return "images/cars/bentley.jpg";

            case 6:
                return "images/cars/mclaren2.jpg";

            case 7:
                return "images/cars/porsche.jpg";

            case 8:
                return "images/cars/mclaren.jpg";

            case 9:
                return "images/cars/astonmartin.jpg";

            case 10:
                return "images/cars/range rover.jpg";

            case 11:
                return "images/cars/bmwm8.jpg";

            case 12:
                return "images/cars/audir8.jpg";

            default:
                return "images/cars/bugatti.jpg";
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        int userId = Integer.parseInt(
                session.getAttribute("userId").toString()
        );

        ArrayList<Booking> bookingList =
                new ArrayList<>();

        String sql =
                "SELECT b.id AS booking_id, "
                + "b.vehicle_id, "
                + "b.pickup_date, "
                + "b.return_date, "
                + "b.location, "
                + "b.payment_method, "
                + "b.total_price, "
                + "b.status, "
                + "v.car_name "
                + "FROM bookings b "
                + "INNER JOIN vehicles v "
                + "ON b.vehicle_id = v.id "
                + "WHERE b.user_id = ? "
                + "ORDER BY b.id DESC";

        try (
            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (
                ResultSet rs =
                        ps.executeQuery()
            ) {

                while (rs.next()) {

                    Booking booking =
                            new Booking();

                    int vehicleId =
                            rs.getInt("vehicle_id");

                    booking.setBookingId(
                            rs.getInt("booking_id")
                    );

                    booking.setVehicleId(
                            vehicleId
                    );

                    booking.setCarName(
                            rs.getString("car_name")
                    );

                    booking.setImage(
                            VehicleImageUtil.getImage(rs.getString("car_name"))
                    );

                    booking.setPickupDate(
                            rs.getDate("pickup_date")
                    );

                    booking.setReturnDate(
                            rs.getDate("return_date")
                    );

                    booking.setLocation(
                            rs.getString("location")
                    );

                    booking.setPaymentMethod(
                            rs.getString("payment_method")
                    );

                    booking.setTotalPrice(
                            rs.getDouble("total_price")
                    );

                    booking.setBookingStatus(
                            rs.getString("status")
                    );

                    bookingList.add(booking);
                }
            }

            request.setAttribute(
                    "bookingList",
                    bookingList
            );

            request.getRequestDispatcher(
                    "/my-bookings.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Bookings load nahi ho paayi: "
                    + e.getMessage()
            );

            request.getRequestDispatcher(
                    "/my-bookings.jsp"
            ).forward(request, response);
        }
    }
}