package controller.Common;

import java.io.IOException;


import dal.AdminDAO;
import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import util.JwtUtil;

@WebServlet(name = "ResetPasswordServlet", value = "/resetpassword")
public class ResetPasswordServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String isAdmin = request.getParameter("isadmin");
        if (isAdmin != null && isAdmin.equals("true")) {
            String email = request.getParameter("email");
            request.setAttribute("email", email);
            request.setAttribute("isAdmin", "true");
            request.getRequestDispatcher("Common/AdminRessetPassword.jsp").forward(request, response);
            return;
        }

        String token = request.getParameter("token");
        CustomerDAO dao = new CustomerDAO();
        String email = dao.getEmailByToken(token);

        if (email != null && JwtUtil.validateToken(token, email)) {
            request.setAttribute("email", email);
            request.getRequestDispatcher("Common/reset-password.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String isAdmin = request.getParameter("isadmin");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        CustomerDAO dao = new CustomerDAO();

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("email", email);
            request.setAttribute("error", "Passwords do not match!");
            if (isAdmin != null && isAdmin.equals("true")) {
                request.getRequestDispatcher("Common/AdminRessetPassword.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("Common/reset-password.jsp").forward(request, response);
            }
        } else {
            if (isAdmin != null && isAdmin.equals("true")) {
                AdminDAO adminDAO = new AdminDAO();
                adminDAO.changePass(newPassword, email);
            } else {
                dao.updatePassword(email, newPassword);
            }
        }
        if(isAdmin != null && isAdmin.equals("true")){
            request.setAttribute("mess_password_resetSuccess", "Password has been successfully reset. You can now log in with your new password.");
            request.getRequestDispatcher("Common/LoginStaff.jsp").forward(request, response);
        }
        else {
            request.setAttribute("mess_password_resetSuccess", "Password has been successfully reset. You can now log in with your new password.");
            request.getRequestDispatcher("Common/Login.jsp").forward(request, response);
        }


    }
}
