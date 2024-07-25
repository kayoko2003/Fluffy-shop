package controller.Sale;

import java.io.*;
import java.util.List;
import java.util.stream.Collectors;

import dal.OrderDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Order;
import model.OrderDetail;
import org.json.JSONObject;

@WebServlet(name = "ProcessOrder", value = "/processorder")
public class ProcessOrder extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        String[] oid = request.getParameterValues("checkbox");
        for (int i = 0; i < oid.length; i++) {
            Order order = orderDAO.getOrderById(Integer.parseInt(oid[i]));
            if (order.getStatus().getId() == 1) {
                orderDAO.updateStatusOrder(oid[i], 3);
            } else {
                orderDAO.updateStatusOrder(oid[i], order.getStatus().getId() + 1);
            }
            order = orderDAO.getOrderById(Integer.parseInt(oid[i]));
            if (order.getStatus().getId() == 4) {
                for (OrderDetail o : order.getOrderDetails()) {
                    productDAO.updateAfterBuy(o.getQuantity(), o.getProduct().getId());
                }
            }
        }
        response.sendRedirect("orderlist");

    }


    public void destroy() {
    }
}