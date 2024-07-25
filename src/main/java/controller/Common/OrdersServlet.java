package controller.Common;

import java.io.*;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import dal.CartDAO;
import dal.OrderDAO;
import dal.ProductDAO;
import dal.SaleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "OrdersServlet", value = "/orders")
public class OrdersServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession();
        Customer a = (Customer) session.getAttribute("acc");
        if (a == null) {
            response.sendRedirect("login.jsp");
        }

        SaleDAO dao = new SaleDAO();
        // Lấy danh sách đơn hàng bằng phương thức DAO
        List<Order> allOrders = dao.getOrdersByCustomerId(a.getCustomerID());
        Map<Integer, Map<Integer, Boolean>> feedbackMap = new HashMap<>();
        Map<Integer, Boolean> orderFeedbackStatusMap = new HashMap<>();
        double total = 0.0;

        for (Order order : allOrders) {
            Map<Integer, Boolean> orderFeedbackMap = new HashMap<>();
            boolean allFeedbackGiven = true;
            for (OrderDetail orderDetail : order.getOrderDetails()) {
                Boolean hasFeedback = OrderDAO.hasFeedback(a.getCustomerID(), orderDetail.getProduct().getId(), order.getId());
                orderFeedbackMap.put(orderDetail.getProduct().getId(), hasFeedback);
                total += orderDetail.getPrice() * orderDetail.getQuantity();
                if (!hasFeedback) {
                    allFeedbackGiven = false;
                }
            }
            feedbackMap.put(order.getId(), orderFeedbackMap);
            orderFeedbackStatusMap.put(order.getId(), allFeedbackGiven);
        }

        List<Order> pendingAndconfirm = dao.getOrdersByStatusesAndCustomerId(2, 3, 8, a.getCustomerID());
        OrderDAO orderDAO = new OrderDAO();
        for (Order order : pendingAndconfirm) {
            if (order.getStatus().getId() == 8) {
                LocalDateTime currenTime = LocalDateTime.now();
                Duration duration = Duration.between(order.getCreatedDate().toLocalDateTime(), currenTime);
                if (duration.toHours() > 24) {
                    orderDAO.updateStatusOrder(String.valueOf(order.getId()), 7);
                }
            }
        }
        
        List<Order> Shipping = dao.getOrdersByStatusAndCustomerId(4, a.getCustomerID());
        List<Order> Delivered = dao.getOrdersByStatusAndCustomerId(5, a.getCustomerID());
        List<Order> Completed = dao.getOrdersByStatusAndCustomerId(6, a.getCustomerID());

        for (Order order : Completed) {
            if (order.getStatus().getId() == 6) {
                LocalDateTime currenTime = LocalDateTime.now();
                Duration duration = Duration.between(order.getUpdatedDate().toLocalDateTime(), currenTime);

                if (duration.toHours() > 168) {
                    orderDAO.updateStatusOrder(String.valueOf(order.getId()), 6);
                }
            }
        }

        List<Order> Cancel = dao.getOrdersByStatusAndCustomerId(7, a.getCustomerID());

        ProductDAO productDAO = new ProductDAO();
        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();
        List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
        CartDAO cartDAO = new CartDAO();
        double totalMoney = cartDAO.getCartByCustomerId(a.getCustomerID()).getTotalMoney();
        List<Cart> carts = cartDAO.listCartByCId(a.getCustomerID());
        // Thiết lập các đơn hàng làm thuộc tính yêu cầu

        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("size", carts.size());
        request.setAttribute("totalMoney", totalMoney);
        request.setAttribute("latestProduct", latestProducts);
        request.setAttribute("isCustomer", "true");
        request.setAttribute("allOrders", allOrders);
        request.setAttribute("total", total);
        request.setAttribute("feedbackMap", feedbackMap);
        request.setAttribute("orderFeedbackStatusMap", orderFeedbackStatusMap);
        request.setAttribute("pendingAndconfirm", pendingAndconfirm);
        request.setAttribute("shipping", Shipping);
        request.setAttribute("delivered", Delivered);
        request.setAttribute("completed", Completed);
        request.setAttribute("cancel", Cancel);

        // Chuyển tiếp đến trang JSP để hiển thị các đơn hàng
        request.getRequestDispatcher("Common/Orders.jsp").forward(request, response);
    }

    public void destroy() {
    }
}
