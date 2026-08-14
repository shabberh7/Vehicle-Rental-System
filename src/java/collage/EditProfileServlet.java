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

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {

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

        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");

        if (name == null || name.trim().isEmpty()
                || mobile == null || mobile.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProfileServlet?page=edit&error=empty"
            );

            return;
        }

        name = name.trim();
        mobile = mobile.trim();
        address = address.trim();

        if (!name.matches("[A-Za-z ]+")) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProfileServlet?page=edit&error=name"
            );

            return;
        }

        if (!mobile.matches("[0-9]{10}")) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProfileServlet?page=edit&error=mobile"
            );

            return;
        }

        int userId = Integer.parseInt(
                session.getAttribute("userId").toString()
        );

        String sql =
                "UPDATE users "
                + "SET name=?, mobile=?, address=? "
                + "WHERE id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, name);
            ps.setString(2, mobile);
            ps.setString(3, address);
            ps.setInt(4, userId);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {

                session.setAttribute("userName", name);

                response.sendRedirect(
                        request.getContextPath()
                        + "/ProfileServlet?success=updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/ProfileServlet?page=edit&error=notupdated"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProfileServlet?page=edit&error=server"
            );
        }
    }
}