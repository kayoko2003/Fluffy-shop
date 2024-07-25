package controller.Admin;

import java.io.*;
import java.util.List;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Role;
import model.Staff;

@WebServlet(name = "FilterStaff", value = "/filterstaff")
public class FilterStaff extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        AdminDAO dao = new AdminDAO();
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        int currentPage = 1;
        int itemsPerPage = 3;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int totalStaff= dao.getTotalStaffCount("", gender, status, role);
        int totalPages = (int) Math.ceil((double) totalStaff / itemsPerPage);

        int offset = (currentPage - 1) * itemsPerPage;

        List<Staff> listStaff = dao.filterStaff(gender,role,status, offset, itemsPerPage);
        List<Role> listRole = dao.getAllRole();

        request.setAttribute("baseUrl", "filterstaff");
        request.setAttribute("gender", gender);
        request.setAttribute("status", status);
        request.setAttribute("role", role);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listRole", listRole);
        request.setAttribute("listStaff", listStaff);
        request.setAttribute("showStaff", "show");
        request.setAttribute("detail", "active");
        request.getRequestDispatcher("Admin/ListStaff.jsp").forward(request, response);
    }

    public void destroy() {
    }
}