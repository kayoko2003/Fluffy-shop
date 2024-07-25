package controller.Sale;

import java.io.*;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import dal.AdminDAO;
import dal.CustomerDAO;
import dal.OrderDAO;
import dal.SaleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "OrderDetailSaleServlet", value = "/orderdetailsale")
public class OrderDetailSale extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("acc");
        CustomerDAO cus = new CustomerDAO();

        if (staff != null) {
            SaleDAO dao = new SaleDAO();
            AdminDAO addao = new AdminDAO();
            OrderDAO orderDAO = new OrderDAO();
            List<Staff> listSale = addao.searchStaffByRoleID(3);

            HashMap<Integer, Integer> saleWithTotalOrder = new HashMap<>();

            for (Staff s : listSale) {
                saleWithTotalOrder.put(s.getStaffID(), orderDAO.getTotalOrderProcessingBySaleID(s.getStaffID()));
            }

            request.setAttribute("saleWithTotalOrder", saleWithTotalOrder);

            int oid = Integer.parseInt(request.getParameter("oid"));

            Order od = dao.getOrderById(oid);
            Customer customer = cus.getCustomerById(od.getCustomerId());

            List<OrderDetail> Listodd;
            try {
                Listodd = dao.getOrderDetailById(oid);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            double total = 0.0;
            for (OrderDetail detail : Listodd) {
                total += detail.getQuantity() * detail.getPrice();
            }

            request.setAttribute("listSale", listSale);
            request.setAttribute("staff", staff);
            request.setAttribute("customer", customer);
            request.setAttribute("total", total);
            request.setAttribute("od", od);
            request.setAttribute("oid", oid);
            request.setAttribute("listodd", Listodd);
            request.setAttribute("orderdetail", "active");
            request.setAttribute("ecommerce_order", "show");
            request.setAttribute("ecommerce", "show");
            request.getRequestDispatcher("Sale/OrderDetailSale.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("Common/Login.jsp").forward(request, response);
        }
    }


    public void destroy() {
    }
}