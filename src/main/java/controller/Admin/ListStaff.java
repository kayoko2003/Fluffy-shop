package controller.Admin;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.List;
import model.*;

@WebServlet(name = "ListStaff", value = "/liststaff")
public class ListStaff extends HttpServlet {

    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        Staff user = (Staff) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        AdminDAO dao = new AdminDAO();

        int currentPage = 1;
        int itemsPerPage = 3;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int totalStaff= dao.getTotalStaffCount("", "", "", "");
        int totalPages = (int) Math.ceil((double) totalStaff / itemsPerPage);

        int offset = (currentPage - 1) * itemsPerPage;

        List<Staff> listStaff = dao.listStaff(offset, itemsPerPage);
        List<Role> listRole = dao.getAllRole();

        request.setAttribute("baseUrl", "liststaff");
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listRole", listRole);
        request.setAttribute("listStaff", listStaff);
        request.setAttribute("showStaff", "show");
        request.setAttribute("liststaff", "active");
        request.getRequestDispatcher("Admin/ListStaff.jsp").forward(request, response);
    }

    public void destroy() {
    }
}