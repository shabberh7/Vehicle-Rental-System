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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=empty"
            );

            return;
        }

        email = email.trim().toLowerCase();

        String sql =
                "SELECT id, name, email, password, role "
                + "FROM users WHERE email=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/login.jsp?error=invalid"
                    );

                    return;
                }

                String storedPassword =
                        rs.getString("password");

                // BCrypt hashed password check
                boolean passwordCorrect =
                        BCrypt.checkpw(
                                password,
                                storedPassword
                        );

                if (!passwordCorrect) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/login.jsp?error=invalid"
                    );

                    return;
                }

                String role = rs.getString("role");

                if (role == null || role.trim().isEmpty()) {
                    role = "user";
                }

                HttpSession oldSession =
                        request.getSession(false);

                if (oldSession != null) {
                    oldSession.invalidate();
                }

                HttpSession session =
                        request.getSession(true);

                session.setAttribute(
                        "userId",
                        rs.getInt("id")
                );

                session.setAttribute(
                        "userName",
                        rs.getString("name")
                );

                session.setAttribute(
                        "userEmail",
                        rs.getString("email")
                );

                session.setAttribute(
                        "userRole",
                        role
                );

                session.setMaxInactiveInterval(30 * 60);

                if ("admin".equalsIgnoreCase(role)) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/admin-dashboard.jsp"
                    );

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/Deshboard.jsp"
                    );
                }
            }

        } catch (IllegalArgumentException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=server"
            );
        }
    }
}