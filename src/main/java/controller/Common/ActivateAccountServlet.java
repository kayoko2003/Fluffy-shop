package controller.Common;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "activateAccountServlet", value = "/activate-account")
public class ActivateAccountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        CustomerDAO dao = new CustomerDAO();
        boolean activated = dao.activateAccount(token);
        if (activated) {
            response.getWriter().println("Your account is now active!");
        } else {
            response.getWriter().println("Failed to activate account. Please contact support or try again.");
        }
    }
}