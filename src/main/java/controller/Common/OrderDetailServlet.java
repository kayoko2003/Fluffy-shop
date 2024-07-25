package controller.Common;

import dal.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "OrderDetailServlet", value = "/order")
public class OrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        int orderId = 0;
        if(orderIdStr != null && !orderIdStr.isEmpty()) {
            orderId = Integer.parseInt(orderIdStr);
        }
        OrderDAO orderDAO = new OrderDAO();
        request.setAttribute("order", orderDAO.getOrderById(orderId));
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("/Common/OrdersCustomerDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
