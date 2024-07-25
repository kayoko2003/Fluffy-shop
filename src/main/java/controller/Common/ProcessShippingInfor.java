package controller.Common;

import java.io.*;

import dal.CustomerDAO;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;

@WebServlet(name = "ProcessShippingInfor", value = "/processaddress")
public class ProcessShippingInfor extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Customer c = (Customer) session.getAttribute("acc");
        String addNewAddress = request.getParameter("addNewAddress");
        String[] pid = request.getParameterValues("checkoutpid");
        CustomerDAO customerDAO = new CustomerDAO();

        StringBuilder formattedString = new StringBuilder();

        for (int i = 0; i < pid.length; i++) {
            formattedString.append("checkoutpid=").append(pid[i]);
            if (i < pid.length - 1) {
                formattedString.append("&");
            }
        }

        String listPID = formattedString.toString();
        String isDefault = request.getParameter("default");
        String idAddress = request.getParameter("idAddress");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if(isDefault == null){
            isDefault = "false";
        }
        boolean setDefault = isDefault.equals("true");

        if (idAddress.equals("0")) {
            customerDAO.insertShippingInforOfCus(c.getCustomerID(), address, name, phone, setDefault);
        } else {
            customerDAO.updateShippingInforOfCus(c.getCustomerID(), idAddress, address, name, phone, setDefault);
        }

        response.sendRedirect("cartcontact?" + listPID + "&showAddress=true");
    }

    public void destroy() {
    }
}