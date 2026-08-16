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
                    + "v.name AS car_name "
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

                String carName =
                        rs.getString("car_name");

                String carImage =
                        VehicleImageUtil.getImage(carName);

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
                        carName
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

                response.sendRedirect(
                        request.getContextPath()
                        + "/MyBookingsServlet"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Invoice load karte samay error aa gaya."
            );

            request.getRequestDispatcher(
                    "/MyBookingsServlet"
            ).forward(request, response);

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
