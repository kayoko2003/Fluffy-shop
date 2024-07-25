package controller.Admin;

import dal.AdminDAO;
import jakarta.servlet.ServletException;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.util.List;

import model.Role;
import model.Staff;

@WebServlet(name = "UpdateStaff", value = "/updatestaff")
public class UpdateStaff extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        String sid = request.getParameter("sid");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        AdminDAO dao = new AdminDAO();

        dao.updateStaff(role, status, sid);
        Staff staff = dao.getStaffById(sid);
        List<Role> listRole = dao.getAllRole();

        request.setAttribute("listRole", listRole);
        request.setAttribute("staff", staff);
        request.setAttribute("showStaff", "show");
        request.setAttribute("detail", "active");
        request.setAttribute("sid", sid);
        request.getRequestDispatcher("Admin/StaffDetail.jsp").forward(request, response);
    }

    public void destroy() {
    }
}