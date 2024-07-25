package controller.Admin;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.List;

import model.Role;
import model.Staff;

@WebServlet(name = "SearchStaff", value = "/searchstaff")
public class SearchStaff extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        AdminDAO dao = new AdminDAO();

        String txtSearch = request.getParameter("txt");

        int currentPage = 1;
        int itemsPerPage = 3;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int totalStaff= dao.getTotalStaffCount(txtSearch, "", "", "");
        int totalPages = (int) Math.ceil((double) totalStaff / itemsPerPage);

        int offset = (currentPage - 1) * itemsPerPage;


        List<Staff> listStaff = dao.searchStaff(txtSearch, offset, itemsPerPage);
        List<Role> listRole = dao.getAllRole();

        request.setAttribute("txt", txtSearch);
        request.setAttribute("baseUrl", "searchstaff");
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