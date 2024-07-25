package controller.Common;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Staff;

import java.io.IOException;

@WebServlet(name = "loginStaff", value = "/loginstaff")
public class LoginStaff extends HttpServlet {
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
        request.getRequestDispatcher("Common/LoginStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String remember = request.getParameter("remember");
        AdminDAO dao = new AdminDAO();
        Staff staff = dao.loginStaff(email, password);

        if (staff != null) {
            HttpSession session = request.getSession();
            session.setAttribute("acc", staff);
            Cookie u = new Cookie("emailC", email);
            Cookie p = new Cookie("passC", password);
            u.setMaxAge(60 * 60 * 24);

            if (remember != null) {
                p.setMaxAge(60);
            } else {
                p.setMaxAge(0);
            }
            response.addCookie(u);
            response.addCookie(p);

            if (staff.getRoleName().equals("Admin")) {
                response.sendRedirect("dashboard");
            } else if (staff.getRoleName().equals("Marketer")) {
                response.sendRedirect("marketingdashboard");
            } else if (staff.getRoleName().equals("Warehouse Staff")) {
                response.sendRedirect("orderlist");
            } else {
                response.sendRedirect("saledashboard");
            }
        } else {
            request.setAttribute("mess", "Wrong email or password");
            request.getRequestDispatcher("Common/LoginStaff.jsp").forward(request, response);
        }
    }
}
