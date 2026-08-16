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

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // New admin session check
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

        String userIdValue =
                request.getParameter("id");

        int userId;

        try {

            userId =
                    Integer.parseInt(userIdValue);

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/manage-users.jsp?error=invalidUser"
            );

            return;
        }

        Connection con = null;

        PreparedStatement deleteBookingsPs = null;

        PreparedStatement deleteUserPs = null;

        try {

            con =
                    DBConnection.getConnection();

            con.setAutoCommit(false);

            /*
             Pehle user ki bookings delete hongi
            */
            String deleteBookingsSql =
                    "DELETE FROM bookings "
                    + "WHERE user_id = ?";

            deleteBookingsPs =
                    con.prepareStatement(
                            deleteBookingsSql
                    );

            deleteBookingsPs.setInt(
                    1,
                    userId
            );

            deleteBookingsPs.executeUpdate();

            /*
             Ab user delete hoga
            */
            String deleteUserSql =
                    "DELETE FROM users "
                    + "WHERE id = ? "
                    + "AND LOWER(role) = 'user'";

            deleteUserPs =
                    con.prepareStatement(
                            deleteUserSql
                    );

            deleteUserPs.setInt(
                    1,
                    userId
            );

            int deletedRows =
                    deleteUserPs.executeUpdate();

            if (deletedRows > 0) {

                con.commit();

                response.sendRedirect(
                        request.getContextPath()
                        + "/manage-users.jsp?success=deleted"
                );

            } else {

                con.rollback();

                response.sendRedirect(
                        request.getContextPath()
                        + "/manage-users.jsp?error=deleteFailed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception rollbackError) {

                rollbackError.printStackTrace();
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/manage-users.jsp?error=deleteFailed"
            );

        } finally {

            try {

                if (deleteBookingsPs != null) {
                    deleteBookingsPs.close();
                }

                if (deleteUserPs != null) {
                    deleteUserPs.close();
                }

                if (con != null) {
                    con.setAutoCommit(true);
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
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
