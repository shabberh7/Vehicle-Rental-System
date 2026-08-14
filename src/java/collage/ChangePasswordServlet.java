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

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        String oldPassword =
                request.getParameter("oldPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (oldPassword == null || oldPassword.trim().isEmpty()
                || newPassword == null || newPassword.trim().isEmpty()
                || confirmPassword == null
                || confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/change-password.jsp?error=empty"
            );

            return;
        }

        if (newPassword.length() < 8) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/change-password.jsp?error=weak"
            );

            return;
        }

        if (!newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/change-password.jsp?error=notmatch"
            );

            return;
        }

        int userId = Integer.parseInt(
                session.getAttribute("userId").toString()
        );

        String selectSql =
                "SELECT password FROM users WHERE id=?";

        String updateSql =
                "UPDATE users SET password=? WHERE id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement selectPs =
                    con.prepareStatement(selectSql)
        ) {

            selectPs.setInt(1, userId);

            ResultSet rs = selectPs.executeQuery();

            if (!rs.next()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/change-password.jsp?error=server"
                );

                return;
            }

            String storedPassword =
                    rs.getString("password");

            boolean passwordIsHashed =
                    storedPassword != null
                    && (
                        storedPassword.startsWith("$2a$")
                        || storedPassword.startsWith("$2b$")
                        || storedPassword.startsWith("$2y$")
                    );

            boolean oldPasswordCorrect;

            if (passwordIsHashed) {

                oldPasswordCorrect =
                        BCrypt.checkpw(
                                oldPassword,
                                storedPassword
                        );

            } else {

                oldPasswordCorrect =
                        oldPassword.equals(storedPassword);
            }

            if (!oldPasswordCorrect) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/change-password.jsp?error=wrongold"
                );

                return;
            }

            boolean samePassword;

            if (passwordIsHashed) {

                samePassword =
                        BCrypt.checkpw(
                                newPassword,
                                storedPassword
                        );

            } else {

                samePassword =
                        newPassword.equals(storedPassword);
            }

            if (samePassword) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/change-password.jsp?error=same"
                );

                return;
            }

            String hashedPassword =
                    BCrypt.hashpw(
                            newPassword,
                            BCrypt.gensalt(12)
                    );

            try (
                PreparedStatement updatePs =
                        con.prepareStatement(updateSql)
            ) {

                updatePs.setString(1, hashedPassword);
                updatePs.setInt(2, userId);

                int rowsUpdated =
                        updatePs.executeUpdate();

                if (rowsUpdated > 0) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/change-password.jsp?success=changed"
                    );

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/change-password.jsp?error=server"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/change-password.jsp?error=server"
            );
        }
    }
}