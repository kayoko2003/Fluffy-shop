package controller.Common;

import java.io.*;
import java.sql.SQLException;

import dal.OrderDAO;
import dal.ProductDAO;
import dal.SaleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Order;
import model.OrderDetail;

@WebServlet(name = "UpdateOrderStatusServlet", value = "/updateOrderStatus")
public class UpdateOrderStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));
        ProductDAO pdao = new ProductDAO();
        OrderDAO odao = new OrderDAO();
        boolean isUpdated = false;
        try {
            isUpdated = SaleDAO.updateOrderStatus(statusId, orderId);
            Order order = odao.getOrderById(orderId);
            for(OrderDetail o: order.getOrderDetails()){
                pdao.updateAfterCompletion(o.getQuantity(), o.getProduct().getId());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("error: " + e.getMessage());
            return;
        }

        response.setContentType("text/plain");
        response.getWriter().write(isUpdated ? "success" : "failure");
    }
}
