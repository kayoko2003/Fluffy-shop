package controller.Sale;

import java.io.*;
import java.sql.SQLException;
import java.util.List;

import dal.AdminDAO;
import dal.CustomerDAO;
import dal.ProductDAO;
import dal.SaleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import util.EmailService;
import util.IJavaMail;
import util.JwtUtil;

@WebServlet(name = "UpdateOrderDetailBySaleManagerServlet", value = "/updateorderdetailbysalemanager")
public class UpdateOrderDetailBySaleManager extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("acc");
        ProductDAO dao1 = new ProductDAO();
        // lấy gtri status, sale, note để cập nhat
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        String salenote = request.getParameter("salenote");


        SaleDAO dao = new SaleDAO();
        Order od = dao.getOrderById(orderId);
        CustomerDAO cus = new CustomerDAO();
        Customer customer = cus.getCustomerById(od.getCustomerId());
        CustomerDAO customerDAO = new CustomerDAO();

        int saleId = 1;
        if (request.getParameter("salemanager") != null) {
            saleId = Integer.parseInt(request.getParameter("salemanager"));
        }

        String statusId = String.valueOf(od.getStatus().getId());
        if (request.getParameter("status") != null) {
            statusId = request.getParameter("status");
        }

        if(statusId.equals("7") && od.getStatus().getId() != 1 && od.getStatus().getId() != 2) {
            dao1.cancelOrder(orderId);
        }

        //gui email neu statusId = 3;
        if (statusId.equals("5") && staff.getRoleName().equals("Sale")) {
            String token = JwtUtil.generateToken(customer.getEmail());
            customerDAO.saveToken(customer.getEmail(), token);
            IJavaMail emailService = new EmailService();

            String resetLink = "http://localhost:8080/FluffyShop_war/resetpassword?token=";
            String message = "<h1>Xác nhận đơn hàng</h1>"
                    + "<p>Nhấn vào liên kết dưới đây để xác nhận đã nhận đơn hàng của bạn:</p>"
                    + "<a href=\"" + resetLink + "\">Xác nhận thành công</a>";
            emailService.send(customer.getEmail(), "Xác nhận giao hàng thành công", message);
        }

        if(statusId.equals("4")) {
            for(OrderDetail o: od.getOrderDetails()) {
                dao1.updateAfterBuy(o.getQuantity(), o.getProduct().getId());
            }
        }

        SaleDAO.updateOrderBySaleManager(orderId, statusId, saleId, salenote);

        // Đặt các thuộc tính cần thiết vào request
        response.sendRedirect("orderdetailsale?oid=" + orderId);
    }

    public void destroy() {
    }
}