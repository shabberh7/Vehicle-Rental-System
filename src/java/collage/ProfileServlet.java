package collage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        int userId = Integer.parseInt(
                session.getAttribute("userId").toString()
        );

        String sql =
                "SELECT id, name, mobile, email, address, created_at "
                + "FROM users "
                + "WHERE id = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    request.setAttribute(
                            "profileId",
                            rs.getInt("id")
                    );

                    request.setAttribute(
                            "profileName",
                            rs.getString("name")
                    );

                    request.setAttribute(
                            "profileMobile",
                            rs.getString("mobile")
                    );

                    request.setAttribute(
                            "profileEmail",
                            rs.getString("email")
                    );

                    request.setAttribute(
                            "profileAddress",
                            rs.getString("address")
                    );

                    request.setAttribute(
                            "createdAt",
                            rs.getTimestamp("created_at")
                    );

                    String page = request.getParameter("page");

                    if ("edit".equals(page)) {

                        request.getRequestDispatcher(
                                "/edit-profile.jsp"
                        ).forward(request, response);

                    } else {

                        request.getRequestDispatcher(
                                "/profile.jsp"
                        ).forward(request, response);
                    }

                } else {

                    response.sendRedirect(
                            request.getContextPath() + "/login.jsp"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Profile load nahi ho paayi: "
                    + e.getMessage()
            );

            request.getRequestDispatcher(
                    "/profile.jsp"
            ).forward(request, response);
        }
    }
}