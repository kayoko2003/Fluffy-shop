package controller.Common;

import java.io.*;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import util.EmailService;
import util.IJavaMail;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

@WebServlet(name = "CartCompletion", value = "/cartcompletion")
public class CartCompletion extends HttpServlet {

    private String bankName;
    private String bankAccountName;
    private String bankAccountNumber;
    private String qrPayment;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.xml");
            if (input == null) {
                throw new ServletException("Không tìm thấy file cấu hình");
            }

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(input);

            Element bankAccountElement = (Element) doc.getElementsByTagName("bankAccount").item(0);
            bankName = bankAccountElement.getElementsByTagName("bankName").item(0).getTextContent();
            bankAccountName = bankAccountElement.getElementsByTagName("accountName").item(0).getTextContent();
            bankAccountNumber = bankAccountElement.getElementsByTagName("number").item(0).getTextContent();
            qrPayment = bankAccountElement.getElementsByTagName("qrPayment").item(0).getTextContent();
        } catch (Exception e) {
            throw new ServletException("Không thể tải các thuộc tính cấu hình", e);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        OrderDAO orderDAO = new OrderDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        Customer c = (Customer) session.getAttribute("acc");
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
        int status = 0;
        Order orderID = null;
        int sale_id = orderDAO.getIdSaleHaveLestOrder();
        int totalOrderAmount = 0;

        //case payment method vnpay
        if (vnp_TransactionStatus != null) {
            status = 1;
            //check if payment not success
            if (!vnp_TransactionStatus.equals("00")) {
                request.setAttribute("paymentFail", "Thanh toán không thành công");
                status = 8;
            }
            totalOrderAmount = Integer.parseInt(request.getParameter("vnp_Amount")) / 100;

            if (session.getAttribute("saveOrder") != null) {
                Order newOrder = (Order) session.getAttribute("saveOrder");
                cartDAO.addToOrder(c.getCustomerID(), newOrder.getFullName(), c.getEmail(), newOrder.getAddress(), newOrder.getPhone(), 2, newOrder.getNote(), status, totalOrderAmount, sale_id);
                orderID = cartDAO.getLatestOrder(c.getCustomerID());
                for (OrderDetail orderDetail : newOrder.getOrderDetails()) {
                    cartDAO.AddOrderDetail(orderID.getId(), orderDetail.getProduct().getId(), orderDetail.getPrice(), orderDetail.getQuantity());
                    cartDAO.removeItemFromCart(String.valueOf(orderDetail.getProduct().getId()), c.getCustomerID());
                    productDAO.updateAfterBuy(orderDetail.getQuantity(), orderDetail.getProduct().getId());
                }
                session.removeAttribute("saveOrder");
            } else {
                orderID = orderDAO.getOrderById(Integer.parseInt(session.getAttribute("oid").toString()));
                orderDAO.updateStatusOrder(session.getAttribute("oid").toString(), status);
                session.removeAttribute("oid");
            }
        }
        //case payment method cod or transfer bank
        else {
            request.setAttribute("bankName", bankName);
            request.setAttribute("bankAccountNumber", bankAccountNumber);
            request.setAttribute("bankAccountName", bankAccountName);
            request.setAttribute("qrPayment", qrPayment);
            status = 2;

            int payment = Integer.parseInt(request.getParameter("paymentMethod"));

            int cusID = c.getCustomerID();
            int idAddress = Integer.parseInt(request.getParameter("idAddress"));
            String note = request.getParameter("note");
            ShippingInfor shippingInfor = customerDAO.getShippingInforByID(idAddress);
            totalOrderAmount = (int) Double.parseDouble(request.getParameter("total").trim());
            if (request.getParameter("oid") != null && request.getParameter("oid") != "") {
                orderID = orderDAO.getOrderById(Integer.parseInt(request.getParameter("oid")));
                orderDAO.updateStatusOrder(request.getParameter("oid"), status);
            }
            //add order detail
            else {
                cartDAO.addToOrder(cusID, shippingInfor.getFullName(), c.getEmail(), shippingInfor.getAddress(), shippingInfor.getPhone(), payment, note, status, totalOrderAmount, sale_id);
                String[] productIds = request.getParameterValues("pid");
                String[] quantities = request.getParameterValues("quantity");
                String[] prices = request.getParameterValues("price");
                orderID = cartDAO.getLatestOrder(cusID);
                if (productIds != null && productIds.length > 0) {
                    for (int i = 0; i < productIds.length; i++) {
                        int pid = Integer.parseInt(productIds[i]);
                        int qty = Integer.parseInt(quantities[i]);
                        double price = Double.parseDouble(prices[i]);
                        cartDAO.AddOrderDetail(orderID.getId(), pid, price, qty);
                        cartDAO.removeItemFromCart(productIds[i], cusID);
                    }
                }
            }
        }

        Order order = orderDAO.getOrderById(orderID.getId());
        request.setAttribute("order", order);

        List<OrderDetail> orderDetails = orderDAO.getListOrderDetails(orderID.getId());
        request.setAttribute("myOrder", orderDetails);
        if (order.getStatus().getId() != 8) {
            IJavaMail emailService = new EmailService();
            String message = formMail(order);
            emailService.send(c.getEmail(), "Invoice bill #" + order.getId(), message);
        }

        int myOrderSize = orderDetails.size();
        int endValue = (int) Math.ceil(myOrderSize / 3.0);
        request.setAttribute("endValue", endValue);
        request.setAttribute("totalOrderAmount", totalOrderAmount);


        List<Cart> carts = cartDAO.listCartByCId(c.getCustomerID());
        List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
        double totalMoney = cartDAO.getCartByCustomerId(c.getCustomerID()).getTotalMoney();
        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();


        request.setAttribute("size", carts.size());
        request.setAttribute("latestProduct", latestProducts);
        request.setAttribute("totalMoney", totalMoney);
        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("isCustomer", "true");
        request.getRequestDispatcher("Common/CartCompletion.jsp").forward(request, response);


    }

    public String formMail(Order order) {
        StringBuilder message = new StringBuilder();
        message.append("<div style='width: 50%; margin: 0 auto; font-family: Arial, sans-serif;'>")
                .append("<h1 style='text-align: center;'>Thank you for shopping at my store</h1>")
                .append("<h2 style='text-align: center;'>Here are your invoice:</h2>")
                .append("<table style='border: 1px solid black; border-collapse: collapse; width: 100%; margin-bottom: 20px;'>")
                .append("<tr><td style='border: 1px solid black; padding: 8px; text-align: left;'>Full Name</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                .append(order.getFullName())
                .append("</td></tr>")
                .append("<tr><td style='border: 1px solid black; padding: 8px; text-align: left;'>Phone</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                .append(order.getPhone())
                .append("</td></tr>")
                .append("<tr><td style='border: 1px solid black; padding: 8px; text-align: left;'>Address</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                .append(order.getAddress())
                .append("</td></tr>")
                .append("<tr><td style='border: 1px solid black; padding: 8px; text-align: left;'>Order notes</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                .append(order.getNote())
                .append("</td></tr>")
                .append("<tr><td style='border: 1px solid black; padding: 8px; text-align: left;'>Payment method</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                .append(order.getPaymentMethod().getMethod())
                .append("</td></tr>")
                .append("</table>")
                .append("<h2 style='text-align: center;'>Order Details</h2>")
                .append("<table style='border: 1px solid black; border-collapse: collapse; width: 100%;'>")
                .append("<tr><th style='border: 1px solid black; padding: 8px; text-align: left;'>Product Name</th><th style='border: 1px solid black; padding: 8px; text-align: left;'>Price</th><th style='border: 1px solid black; padding: 8px; text-align: left;'>Quantity</th></tr>");

        for (OrderDetail detail : order.getOrderDetails()) {
            Product product = detail.getProduct();
            message.append("<tr><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                    .append(product.getName())
                    .append("</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                    .append(detail.getPrice())
                    .append("</td><td style='border: 1px solid black; padding: 8px; text-align: left;'>")
                    .append(detail.getQuantity())
                    .append("</td></tr>");
        }

        message.append("</table>")
                .append("</div>");

        return message.toString();
    }

    public void destroy() {
    }
}