package controller.Sale;

import java.io.*;
import java.util.*;

import dal.AdminDAO;
import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import model.Order;
import model.Staff;

@WebServlet(name = "OrderList", value = "/orderlist")
public class OrderList extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        OrderDAO dao = new OrderDAO();
        AdminDAO adminDAO = new AdminDAO();
        HttpSession session = request.getSession();

        Staff user = (Staff) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int currentPage = 1;
        int itemsPerPage = 8;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int setTrue = 1;
        String orderDateFrom = request.getParameter("orderDateFrom");
        String orderDateTo = request.getParameter("orderDateTo");
        if (orderDateFrom == null || orderDateTo == null || orderDateFrom.isEmpty() || orderDateTo.isEmpty()) {
            setTrue = -1;
            orderDateFrom = "";
            orderDateTo = "";
        } else {
            request.setAttribute("orderDateFrom", orderDateFrom);
            request.setAttribute("orderDateTo", orderDateTo);
        }

        String status = request.getParameter("status");

        if (user.getRoleName().equals("Warehouse Staff") && status == null) {
            status = "3";
            request.setAttribute("button", "Shipping");
        } else if (user.getRoleName().equals("Sale") && status == null) {
            status = "2";
        } else if (status == null || status.isEmpty()) {
            status = "";
        }

        request.setAttribute("status", status);

        if (status.equals("4")) {
            request.setAttribute("button", "Delivered");
        }else if (status.equals("1")) {
            request.setAttribute("button", "Confirm");
        }

        String sale_id = request.getParameter("sale_id");
        if (user.getRoleName().equals("Sale")) {
            sale_id = String.valueOf(user.getStaffID());
            request.setAttribute("isSale", "true");
        } else if (sale_id == null || sale_id.isEmpty()) {
            sale_id = "-1";
        }
        request.setAttribute("sale_id", sale_id);


        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null) {
            sortOrder = "DESC";
        }
        request.setAttribute("sortOrder", sortOrder);

        String sortBy = request.getParameter("sortBy");
        if (sortBy == null) {
            sortBy = "o.update_date";
        }
        request.setAttribute("sortBy", sortBy);

        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }

        request.setAttribute("search", search);

        int totalOrders = dao.getTotalOrders(search, status, orderDateFrom, orderDateTo, Integer.parseInt(sale_id), setTrue);
        int totalPages = (int) Math.ceil((double) totalOrders / itemsPerPage);

        int offset = (currentPage - 1) * itemsPerPage;

        List<Order> listOrder = dao.getListOrders(offset, itemsPerPage, search, sortBy, sortOrder, status, orderDateFrom, orderDateTo, sale_id, setTrue);
        List<Staff> listStaff = adminDAO.filterStaff("", "3", "activate", 0, 100);

        request.setAttribute("listStaff", listStaff);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listorder", "active");
        request.setAttribute("ecommerce_order", "show");
        request.setAttribute("ecommerce", "show");
        request.setAttribute("statusOrder", dao.getListStatusOrders());
        request.setAttribute("listOrder", listOrder);
        request.getRequestDispatcher("Sale/OrderList.jsp").forward(request, response);
    }

    public void destroy() {
    }
}