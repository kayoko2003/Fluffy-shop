package controller.Common;

import java.io.*;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import dal.CartDAO;
import dal.CustomerDAO;
import dal.OrderDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "CartContactServletServlet", value = "/cartcontact")
public class CartContactServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer a = (Customer) session.getAttribute("acc");
        if (a != null) {
            CartDAO cartDAO = new CartDAO();
            CustomerDAO customerDAO = new CustomerDAO();
            ProductDAO productDAO = new ProductDAO();
            List<Cart> listC = new ArrayList<>();
            if (request.getParameterValues("checkoutpid") != null) {
                String[] pid = request.getParameterValues("checkoutpid");
                listC = cartDAO.getCartProductsByProductIdsAndCustomerId(pid, a.getCustomerID());
            }

            // Tính tổng tiền của tất cả các sản phẩm
            double totalOrderAmount = 0;
            for (Cart c : listC) {
                totalOrderAmount += c.getProduct().getPrice() * c.getQuantity();
            }

            if (request.getParameter("checkoutagain") != null && request.getParameter("checkoutagain").equals("true")) {
                OrderDAO orderDAO = new OrderDAO();
                Order order = orderDAO.getOrderById(Integer.parseInt(request.getParameter("oid")));
                LocalDateTime currenTime = LocalDateTime.now();
                Duration duration = Duration.between(order.getCreatedDate().toLocalDateTime(), currenTime);
                if(duration.toHours() > 24){
                    response.sendRedirect("orders");
                }
                totalOrderAmount = 0;
                for (OrderDetail orderDetail : order.getOrderDetails()) {
                    orderDetail.getProduct().setPrice(orderDetail.getPrice());
                    listC.add(new Cart(orderDetail.getQuantity(), orderDetail.getProduct(), a));
                    totalOrderAmount += orderDetail.getPrice() * orderDetail.getQuantity();
                }
                request.setAttribute("oid", order.getId());
            }

            List<PaymentMethod> listPM = cartDAO.getListPayment();

            Set<Category> categories = productDAO.getCategories();
            Set<Brand> brands = productDAO.getBrands();
            List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
            List<ShippingInfor> shippingInfors = customerDAO.getShippingInforOfCustomer(a.getCustomerID());
            double totalMoney = cartDAO.getCartByCustomerId(a.getCustomerID()).getTotalMoney();

            String showAddresss = request.getParameter("showAddress");

            int idAddress = customerDAO.getIdAddressDefault(a.getCustomerID());
            String otherAddress = request.getParameter("address");
            if (otherAddress != null) {
                idAddress = Integer.parseInt(otherAddress);
            }

            ShippingInfor shippingInfor = customerDAO.getShippingInforByID(idAddress);

            request.setAttribute("shippingInfor", shippingInfor);
            request.setAttribute("showAddress", showAddresss);
            request.setAttribute("listC", categories);
            request.setAttribute("listP", listC);
            request.setAttribute("size", cartDAO.listCartByCId(a.getCustomerID()).size());
            request.setAttribute("totalMoney", totalMoney);
            request.setAttribute("listB", brands);
            request.setAttribute("listPM", listPM);
            request.setAttribute("isCustomer", "true");
            request.setAttribute("shippingInfors", shippingInfors);
            request.setAttribute("latestProduct", latestProducts);
            request.setAttribute("totalOrderAmount", totalOrderAmount);
            request.getRequestDispatcher("Common/CartContacts.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void destroy() {
    }
}