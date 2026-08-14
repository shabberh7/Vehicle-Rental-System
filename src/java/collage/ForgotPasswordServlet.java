package collage;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        System.out.println("ForgotPasswordServlet called");

        String email = request.getParameter("email");

        System.out.println("Entered email: " + email);

        // Empty email validation
        if (email == null || email.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp?error=empty"
            );

            return;
        }

        email = email.trim().toLowerCase();

        String sql =
                "SELECT id, name, email "
                + "FROM users WHERE email=?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            // Database connection check
            if (con == null) {

                System.out.println("Database connection is null");

                response.sendRedirect(
                        request.getContextPath()
                        + "/forgot-password.jsp?error=database"
                );

                return;
            }

            System.out.println("Database connected successfully");

            ps = con.prepareStatement(sql);

            ps.setString(1, email);

            rs = ps.executeQuery();

            // Email not found
            if (!rs.next()) {

                System.out.println("Email not found in database");

                response.sendRedirect(
                        request.getContextPath()
                        + "/forgot-password.jsp?error=notfound"
                );

                return;
            }

            int userId = rs.getInt("id");
            String userName = rs.getString("name");
            String userEmail = rs.getString("email");

            System.out.println("User found: " + userName);
            System.out.println("User ID: " + userId);

            // Generate 6-digit OTP
            SecureRandom random = new SecureRandom();

            int otpNumber =
                    100000 + random.nextInt(900000);

            String otp = String.valueOf(otpNumber);

            // OTP validity: 5 minutes
            long otpExpiry =
                    System.currentTimeMillis()
                    + (5 * 60 * 1000);

            HttpSession session = request.getSession(true);

            session.setAttribute(
                    "resetUserId",
                    userId
            );

            session.setAttribute(
                    "resetEmail",
                    userEmail
            );

            session.setAttribute(
                    "resetOtp",
                    otp
            );

            session.setAttribute(
                    "resetOtpExpiry",
                    otpExpiry
            );

            session.setAttribute(
                    "showOtpAlert",
                    true
            );

            System.out.println("OTP generated: " + otp);
            System.out.println("Redirecting to otp.jsp");

            response.sendRedirect(
                    request.getContextPath()
                    + "/otp.jsp"
            );

        } catch (Exception e) {

            System.out.println(
                    "Forgot Password Error: "
                    + e.getMessage()
            );

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp?error=server"
            );

        } finally {

            try {

                if (rs != null) {
                    rs.close();
                }

                if (ps != null) {
                    ps.close();
                }

                if (con != null) {
                    con.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
    }
}