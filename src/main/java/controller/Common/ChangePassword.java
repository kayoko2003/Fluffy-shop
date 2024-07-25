package controller.Common;

import java.io.*;

import dal.AdminDAO;
import dal.CustomerDAO;
import de.svws_nrw.ext.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import model.Staff;

import javax.mail.Session;

@WebServlet(name = "ChangePassword", value = "/changepassword")
public class ChangePassword extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("Common/ChangePassword.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String oldPassword = request.getParameter("oldpassword");
        String newPassword = request.getParameter("newpassword");

        Object account = session.getAttribute("acc");
        if (account instanceof Staff) {
            Staff staff = (Staff) account;
            AdminDAO dao = new AdminDAO();
            if (BCrypt.checkpw(oldPassword, staff.getPassword())) {
                dao.changePass(newPassword, staff.getEmail());
                request.setAttribute("message", "Change password successfully");
                request.getRequestDispatcher("Common/ChangePassword.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Change password unsuccessfully");
                request.getRequestDispatcher("Common/ChangePassword.jsp").forward(request, response);
            }
        } else if (account instanceof Customer) {
            Customer customer = (Customer) account;
            CustomerDAO customerDAO = new CustomerDAO();
            if (BCrypt.checkpw(oldPassword, customer.getPassword())) {
                customerDAO.updatePassword(customer.getEmail(), newPassword);
                request.setAttribute("message", "Change password successfully");
                request.getRequestDispatcher("Common/ChangePassword.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Change password unsuccessfully");
                request.getRequestDispatcher("Common/ChangePassword.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login");
        }
    }

    public void destroy() {
    }
}