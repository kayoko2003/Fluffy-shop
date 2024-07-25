package controller.Marketing;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.List;
import model.*;

@WebServlet(name = "ListCustomer", value = "/listcustomer")
public class ListCustomer extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        CustomerDAO dao = new CustomerDAO();

        int currentPage = 1;
        int itemsPerPage = 10;

        try {
            if (request.getParameter("currentPage") != null) {
                currentPage = Integer.parseInt(request.getParameter("currentPage"));
            }
            if (request.getParameter("itemsPerPage") != null) {
                itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
            }
        } catch (NumberFormatException e) {
            out.println("Invalid page or items per page value.");
            return;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }
        if (itemsPerPage < 1) {
            itemsPerPage = 10; // Default to 10 items per page if invalid
        }

        String search = request.getParameter("txt") != null ? request.getParameter("txt") : "";
        String status = request.getParameter("status") != null ? request.getParameter("status") : "";

        String sortBy = request.getParameter("sortBy");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "customer_id"; // Default sort column
        }
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC"; // Default sort order
        }

        int total = dao.getTotalCustomerCount(search);
        int totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = Math.min(currentPage, totalPages);
        List<Customer> listCustomers = dao.listCustomers(currentPage, itemsPerPage, search, status, sortBy, sortOrder);

        // Set attributes and forward to JSP
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("listCustomer", listCustomers);
        request.setAttribute("search", search);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", total);
        request.setAttribute("activeCustom", "active");
        request.setAttribute("ecommerce", "show");

        request.getRequestDispatcher("Marketing/ListCustomer.jsp").forward(request, response);
    }
}
