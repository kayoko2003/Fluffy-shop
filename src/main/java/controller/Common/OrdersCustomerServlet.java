package controller.Common;

import dal.CartDAO;
import dal.OrderDAO;
import dal.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet(name = "OrdersCustomerServlet", value = "/my-orders")
public class OrdersCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        Customer customer = (Customer) session.getAttribute("acc");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        CartDAO dao = new CartDAO();

        int customerId = customer.getCustomerID();

        OrderDAO orderDAO = new OrderDAO();
        int currentPage = 1;
        int itemsPerPage = 5;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }
        if (request.getParameter("itemsPerPage") != null) {
            itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
        }

        int total = 0;
        int totalPages = 0;
        if (currentPage < 1) {
            currentPage = 1;
        }

        String sortBy = request.getParameter("sortBy");
        if (sortBy != null) {
            request.setAttribute("sortBy", sortBy);
        } else sortBy = "o.order_id";
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder != null) {
            request.setAttribute("sortOrder", sortOrder);
        } else sortOrder = "ASC";

        total = orderDAO.getTotalOrdersCount(customerId);

        totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = (currentPage > totalPages) ? Math.max(totalPages, 1) : currentPage;
        List<Order> orders = orderDAO.getOrdersByCustomerId(customerId, currentPage, itemsPerPage, sortBy, sortOrder);

        ProductDAO productDAO = new ProductDAO();
        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();
        List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
        double totalMoney = dao.getCartByCustomerId(customer.getCustomerID()).getTotalMoney();
        List<Cart> carts = dao.listCartByCId(customer.getCustomerID());

        request.setAttribute("orders", orders);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("total", total);
        request.setAttribute("customerId", customerId);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);

        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("size", carts.size());
        request.setAttribute("latestProduct", latestProducts);
        request.setAttribute("totalMoney", totalMoney);
        request.getRequestDispatcher("/Common/OrdersCustomer.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
