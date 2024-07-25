package controller.Common;

import dal.AdminDAO;
import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] arr = request.getCookies();
        if (arr != null) {
            for (Cookie o : arr) {
                if (o.getName().equals("emailC")) {
                    request.setAttribute("email", o.getValue());
                }
                if (o.getName().equals("passC")) {
                    request.setAttribute("password", o.getValue());
                }
            }
        }
        request.setAttribute("logo", "Static_access_manager/assets/img/logos/logo_fluffy.png");
        request.getRequestDispatcher("Common/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String remember = request.getParameter("remember");
        CustomerDAO cusomterDAO = new CustomerDAO();
        Customer customer = cusomterDAO.loginCustomer(email, password, "ACTIVE");

        if(customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("acc", customer);

            // Thiết lập cookie nếu cần
            Cookie u = new Cookie("emailC", email);
            Cookie p = new Cookie("passC", password);
            u.setMaxAge(60 * 60 * 24);

            if (remember != null) {
                p.setMaxAge(60 * 60 * 24);
            } else {
                p.setMaxAge(0);
            }
            response.addCookie(u);
            response.addCookie(p);

            response.sendRedirect("home");
        }else {
            request.setAttribute("mess", "Wrong email or password");
            request.getRequestDispatcher("Common/Login.jsp").forward(request, response);
        }
    }
}