package collage;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if ("admin@gmail.com".equals(email)
                && "admin123".equals(password)) {

            HttpSession session = request.getSession();

            session.setAttribute("adminLoggedIn", true);

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-dashboard.jsp"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-login.jsp?error=invalid"
            );
        }
    }
}
