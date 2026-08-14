package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp"
            );

            return;
        }

        Boolean otpVerified =
                (Boolean) session.getAttribute("otpVerified");

        Integer userId =
                (Integer) session.getAttribute("resetUserId");

        if (otpVerified == null
                || !otpVerified
                || userId == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp"
            );

            return;
        }

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (password == null
                || password.trim().isEmpty()
                || confirmPassword == null
                || confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/reset-password.jsp?error=empty"
            );

            return;
        }

        if (password.length() < 6) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/reset-password.jsp?error=weak"
            );

            return;
        }

        if (!password.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/reset-password.jsp?error=mismatch"
            );

            return;
        }

        String selectSql =
                "SELECT password FROM users WHERE id=?";

        String updateSql =
                "UPDATE users SET password=? WHERE id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement selectPs =
                    con.prepareStatement(selectSql)
        ) {

            if (con == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/reset-password.jsp?error=server"
                );

                return;
            }

            selectPs.setInt(1, userId);

            try (ResultSet rs = selectPs.executeQuery()) {

                if (!rs.next()) {

                    clearResetSession(session);

                    response.sendRedirect(
                            request.getContextPath()
                            + "/forgot-password.jsp"
                    );

                    return;
                }

                String storedPassword =
                        rs.getString("password");

                boolean samePassword = false;

                boolean storedPasswordIsHash =
                        storedPassword != null
                        && (
                            storedPassword.startsWith("$2a$")
                            || storedPassword.startsWith("$2b$")
                            || storedPassword.startsWith("$2y$")
                        );

                if (storedPasswordIsHash) {

                    try {

                        samePassword =
                                BCrypt.checkpw(
                                        password,
                                        storedPassword
                                );

                    } catch (Exception e) {

                        samePassword = false;
                    }

                } else {

                    samePassword =
                            password.equals(storedPassword);
                }

                if (samePassword) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/reset-password.jsp?error=same"
                    );

                    return;
                }
            }

            String hashedPassword =
                    BCrypt.hashpw(
                            password,
                            BCrypt.gensalt(12)
                    );

            try (
                PreparedStatement updatePs =
                        con.prepareStatement(updateSql)
            ) {

                updatePs.setString(1, hashedPassword);
                updatePs.setInt(2, userId);

                int result =
                        updatePs.executeUpdate();

                if (result > 0) {

                    clearResetSession(session);

                    response.sendRedirect(
                            request.getContextPath()
                            + "/login.jsp?success=passwordReset"
                    );

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/reset-password.jsp?error=server"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/reset-password.jsp?error=server"
            );
        }
    }

    private void clearResetSession(
            HttpSession session) {

        session.removeAttribute("resetUserId");
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetOtp");
        session.removeAttribute("resetOtpExpiry");
        session.removeAttribute("showOtpAlert");
        session.removeAttribute("otpVerified");
    }
}