package controller.Marketing;

import java.io.*;
import java.time.LocalDate;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;

@WebServlet(name = "AddCustomer", value = "/addcustomer")
public class AddCustomer extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("Marketing/AddCustomer.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String genderStr = request.getParameter("gender");
        Boolean gender = "male".equalsIgnoreCase(genderStr);
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String password = request.getParameter("password");
        String repass = request.getParameter("repass");

        if (!password.equals(repass)) {
            request.setAttribute("mess", "Passwords do not match");
            request.getRequestDispatcher("Marketing/AddCustomer.jsp").forward(request, response);
            return;
        }

        LocalDate dateOfBirth = LocalDate.parse(dob);
        LocalDate createDate = LocalDate.now();
        LocalDate updateDate = LocalDate.now();
        String avatar = "https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png";
        String token = "";

        CustomerDAO dao = new CustomerDAO();
        Customer customer = dao.checkExistCustomer(email);
        if(customer == null) {
            dao.addCustomer(email, password, fullname, address, gender, phone, dateOfBirth, createDate, updateDate, token, "ACTIVE", avatar);
            request.setAttribute("mess1", "Account created!");
            request.getRequestDispatcher("Marketing/AddCustomer.jsp").forward(request, response); // Redirect to the customer list page
        }else{
            request.setAttribute("mess", "Customer already exists");
            request.getRequestDispatcher("Marketing/AddCustomer.jsp").forward(request, response); // Forward to the add customer page
        }
    }

}

