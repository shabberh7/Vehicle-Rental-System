package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int bookingId = Integer.parseInt(
                    request.getParameter("id")
            );

            Connection con = DBConnection.getConnection();

            // Correct column name = status
            String sql =
                    "UPDATE bookings SET status='Cancelled' WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, bookingId);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect(
                    request.getContextPath()
                    + "/MyBookingsServlet"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    e.getMessage()
            );
        }
    }
}
