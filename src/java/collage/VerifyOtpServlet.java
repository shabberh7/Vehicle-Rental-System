package collage;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp =
                request.getParameter("otp");

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp"
            );

            return;
        }

        String savedOtp =
                (String) session.getAttribute("resetOtp");

        Long otpExpiry =
                (Long) session.getAttribute("resetOtpExpiry");

        if (savedOtp == null || otpExpiry == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/forgot-password.jsp"
            );

            return;
        }

        if (System.currentTimeMillis() > otpExpiry) {

            session.removeAttribute("resetOtp");
            session.removeAttribute("resetOtpExpiry");
            session.removeAttribute("showOtpAlert");

            response.sendRedirect(
                    request.getContextPath()
                    + "/otp.jsp?error=expired"
            );

            return;
        }

        if (enteredOtp == null
                || !savedOtp.equals(enteredOtp.trim())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/otp.jsp?error=invalid"
            );

            return;
        }

        session.setAttribute("otpVerified", true);

        session.removeAttribute("resetOtp");
        session.removeAttribute("resetOtpExpiry");
        session.removeAttribute("showOtpAlert");

        response.sendRedirect(
                request.getContextPath()
                + "/reset-password.jsp"
        );
    }
}