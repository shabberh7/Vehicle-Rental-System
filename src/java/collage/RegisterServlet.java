package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || mobile == null || mobile.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=empty"
            );

            return;
        }

        name = name.trim();
        email = email.trim().toLowerCase();
        mobile = mobile.trim();

        if (address == null) {
            address = "";
        } else {
            address = address.trim();
        }

        if (!name.matches("[a-zA-Z ]+")) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=invalidName"
            );

            return;
        }

        if (!mobile.matches("[0-9]{10}")) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=invalidMobile"
            );

            return;
        }

        if (password.length() < 6) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=weakPassword"
            );

            return;
        }

        if (!password.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=passwordMismatch"
            );

            return;
        }

        String sql =
                "INSERT INTO users "
                + "(name, email, mobile, password, address) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            if (con == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/register.jsp?error=database"
                );

                return;
            }

            String hashedPassword =
                    BCrypt.hashpw(
                            password,
                            BCrypt.gensalt(12)
                    );

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, hashedPassword);
            ps.setString(5, address);

            int result = ps.executeUpdate();

            if (result > 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?success=registered"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/register.jsp?error=failed"
                );
            }

        } catch (SQLIntegrityConstraintViolationException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=emailExists"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=server"
            );
        }
    }
}