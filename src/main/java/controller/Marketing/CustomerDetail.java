package controller.Marketing;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;


@WebServlet(name = "CustomerDetail", value = "/customerdetail")
public class CustomerDetail extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        String cid = request.getParameter("cid");

        CustomerDAO dao = new CustomerDAO();

        Customer customer = dao.getCustomerById(cid);

        request.setAttribute("ecommerce", "show");
        request.setAttribute("activeCustom", "active");
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("Marketing/CustomerDetail.jsp").forward(request, response);
    }

}
