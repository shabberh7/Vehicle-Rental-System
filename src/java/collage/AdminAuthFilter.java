package collage;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
    "/admin-dashboard.jsp",
    "/add-vehicle.jsp",
    "/manage-vehicles.jsp",
    "/manage-bookings.jsp",
    "/manage-users.jsp",
    "/reports.jsp",
    "/edit-vehicle.jsp",
    "/AddVehicleServlet",
    "/DeleteVehicleServlet"
})
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {
    }

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        HttpSession session =
                req.getSession(false);

        if (session != null
                && Boolean.TRUE.equals(
                        session.getAttribute("adminLoggedIn")
                )) {

            chain.doFilter(request, response);

        } else {

            res.sendRedirect(
                    req.getContextPath()
                    + "/admin-login.jsp"
            );
        }
    }

    @Override
    public void destroy() {
    }
}
