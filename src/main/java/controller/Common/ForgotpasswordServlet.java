package controller.Common;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dal.CustomerDAO;
import model.Customer;
import util.EmailService;
import util.IJavaMail;
import util.JwtUtil;

@WebServlet(name = "ForgotpasswordServlet", value = "/forgotpassword")
public class ForgotpasswordServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String isAdmin = request.getParameter("isAdmin");
        if (isAdmin != null && isAdmin.equals("true")) {
            request.getRequestDispatcher("Common/ForgotPasswordByAdmin.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("Common/forgotPassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isAdmin = request.getParameter("isAdmin");
        String email = request.getParameter("email");
        CustomerDAO dao = new CustomerDAO();
        Customer customer = dao.emailcheck(email);

        Boolean staff = dao.checkEmailExistInStaff(email);
        if (customer != null && !isAdmin.equals("isAdmin")) {
            String token = JwtUtil.generateToken(email);
            dao.saveToken(email, token);
            IJavaMail emailService = new EmailService();

            String resetLink = "http://localhost:8080/FluffyShop_war/resetpassword?token=" + token;
            String message = "<h1>Yêu cầu thay đổi mật khẩu</h1>"
                    + "<p>Nhấn vào liên kết dưới đây để thay đổi mật khẩu của bạn:</p>"
                    + "<a href=\"" + resetLink + "\">Thay đổi mật khẩu</a>";

            emailService.send(email, "Reset Password", message);

            request.setAttribute("mess1", "The message has been sent to your email");
            request.getRequestDispatcher("Common/forgotPassword.jsp").forward(request, response);
        } else if (staff == true && "isAdmin".equals(isAdmin)) {
            IJavaMail emailService = new EmailService();
            String resetLink = "http://localhost:8080/FluffyShop_war/resetpassword?email=" + email + "&isadmin=true";
            String message = "<h1>Yêu cầu thay đổi mật khẩu</h1>"
                    + "<p>Nhấn vào liên kết dưới đây để thay đổi mật khẩu của bạn:</p>"
                    + "<a href=\"" + resetLink + "\">Thay đổi mật khẩu</a>";
            emailService.send(email, "Reset Password", message);

            request.setAttribute("mess1", "The message has been sent to your email");
            request.getRequestDispatcher("Common/ForgotPasswordByAdmin.jsp").forward(request, response);

        } else {
            if (customer == null && !isAdmin.equals("isAdmin")) {
                request.setAttribute("mess", "Email does not exist!");
                request.getRequestDispatcher("Common/forgotPassword.jsp").forward(request, response);
            } else if (customer == null) {
                request.setAttribute("mess", "Email does not exist!");
                request.getRequestDispatcher("Common/ForgotPasswordByAdmin.jsp").forward(request, response);
            }
        }

    }
}
