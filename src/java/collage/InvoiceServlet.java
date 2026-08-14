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
import jakarta.servlet.http.HttpSession;

@WebServlet("/InvoiceServlet")
public class InvoiceServlet extends HttpServlet {

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
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            int userId = Integer.parseInt(
                    session.getAttribute("userId").toString()
            );

            String bookingIdValue =
                    request.getParameter("id");

            if (bookingIdValue == null
                    || bookingIdValue.trim().isEmpty()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/MyBookingsServlet"
                );

                return;
            }

            int bookingId =
                    Integer.parseInt(bookingIdValue);

            con = DBConnection.getConnection();

            String sql =
                    "SELECT "
                    + "b.id AS booking_id, "
                    + "b.vehicle_id, "
                    + "b.pickup_date, "
                    + "b.return_date, "
                    + "b.location, "
                    + "b.payment_method, "
                    + "b.total_price, "
                    + "b.status, "
                    + "u.name AS customer_name, "
                    + "u.email AS customer_email, "
                    + "u.mobile AS customer_mobile, "
                    + "v.car_name "
                    + "FROM bookings b "
                    + "INNER JOIN users u "
                    + "ON b.user_id = u.id "
                    + "INNER JOIN vehicles v "
                    + "ON b.vehicle_id = v.id "
                    + "WHERE b.id = ? "
                    + "AND b.user_id = ?";

            ps = con.prepareStatement(sql);

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            rs = ps.executeQuery();

            if (rs.next()) {

                int vehicleId =
                        rs.getInt("vehicle_id");

                String carImage =
                        VehicleImageUtil.getImage(rs.getString("car_name"));

                request.setAttribute(
                        "bookingId",
                        rs.getInt("booking_id")
                );

                request.setAttribute(
                        "customerName",
                        rs.getString("customer_name")
                );

                request.setAttribute(
                        "customerEmail",
                        rs.getString("customer_email")
                );

                request.setAttribute(
                        "customerMobile",
                        rs.getString("customer_mobile")
                );

                request.setAttribute(
                        "carName",
                        rs.getString("car_name")
                );

                request.setAttribute(
                        "carImage",
                        carImage
                );

                request.setAttribute(
                        "pickupDate",
                        rs.getDate("pickup_date")
                );

                request.setAttribute(
                        "returnDate",
                        rs.getDate("return_date")
                );

                request.setAttribute(
                        "location",
                        rs.getString("location")
                );

                request.setAttribute(
                        "paymentMethod",
                        rs.getString("payment_method")
                );

                request.setAttribute(
                        "totalPrice",
                        rs.getDouble("total_price")
                );

                request.setAttribute(
                        "bookingStatus",
                        rs.getString("status")
                );

                RequestDispatcher rd =
                        request.getRequestDispatcher(
                                "/invoice.jsp"
                        );

                rd.forward(request, response);

            } else {

                request.setAttribute(
                        "errorMessage",
                        "Invoice or booking not found."
                );

                RequestDispatcher rd =
                        request.getRequestDispatcher(
                                "/MyBookingsServlet"
                        );

                rd.forward(request, response);
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/MyBookingsServlet"
            );

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Invoice load karte samay error aa gaya."
            );

            RequestDispatcher rd =
                    request.getRequestDispatcher(
                            "/MyBookingsServlet"
                    );

            rd.forward(request, response);

        } finally {

            try {

                if (rs != null) {
                    rs.close();
                }

                if (ps != null) {
                    ps.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}