package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        /*
         New Admin Login session check
        */
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

        String bookingIdValue =
                request.getParameter("id");

        String status =
                request.getParameter("status");

        int bookingId;

        try {

            bookingId =
                    Integer.parseInt(bookingIdValue);

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-booking.jsp?error=invalidData"
            );

            return;
        }

        if (status == null
                || status.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-booking.jsp?error=invalidData"
            );

            return;
        }

        status =
                status.trim().toLowerCase();

        boolean validStatus =
                status.equals("pending")
                || status.equals("approved")
                || status.equals("rejected")
                || status.equals("completed")
                || status.equals("cancelled");

        if (!validStatus) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-booking.jsp?error=invalidData"
            );

            return;
        }

        String sql =
                "UPDATE bookings "
                + "SET status = ? "
                + "WHERE id = ?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    status
            );

            ps.setInt(
                    2,
                    bookingId
            );

            int rowsUpdated =
                    ps.executeUpdate();

            ps.close();

            if (rowsUpdated > 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-booking.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin-booking.jsp?error=updateFailed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-booking.jsp?error=updateFailed"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        doGet(
                request,
                response
        );
    }
}
