package controller.Common;

import java.io.*;
import java.util.List;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Role;
import model.Staff;

@WebServlet(name = "StaffProfile", value = "/staffprofile")
public class StaffProfile extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("acc");
        AdminDAO dao = new AdminDAO();

        staff = dao.getStaffById(String.valueOf(staff.getStaffID()));
        List<Role> listRole = dao.getAllRole();

        request.setAttribute("staff", staff);
        request.setAttribute("listRole", listRole);
        request.setAttribute("user", "show");
        request.setAttribute("userdetail", "active");
        request.getRequestDispatcher("Common/StaffProfile.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("acc");
        AdminDAO dao = new AdminDAO();
        String phoneNumber = request.getParameter("phone");
        String address = request.getParameter("address");
        dao.updateProfile(address,phoneNumber,staff.getStaffID());
        response.sendRedirect("staffprofile");
    }

    public void destroy() {
    }
}