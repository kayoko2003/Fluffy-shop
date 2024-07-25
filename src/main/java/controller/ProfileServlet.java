package controller;

import dal.CustomerDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("acc");
        String editMode = request.getParameter("editMode");

        if (customer == null) {
            // Chuyển hướng người dùng đến trang đăng nhập nếu họ chưa đăng nhập
            response.sendRedirect("login");
            return;
        }

        CustomerDAO dao = new CustomerDAO();
        Customer c = dao.getCustomerById(customer.getCustomerID());
        request.setAttribute("customer", c);
        request.setAttribute("editMode", editMode);
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("acc");
        if (customer == null) {
            response.sendRedirect("login");
            return;
        }
        String img = "";
        Part part = request.getPart("imageUpload");
        if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()){
            String fileName = part.getSubmittedFileName();
            String basePath = getServletContext().getRealPath("/") + "Static_access_shop/img/";
            File directory = new File(basePath);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            part.write(basePath + fileName);
            img = "Static_access_shop/img/" + fileName;
        }
        String name = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        Date dob = Date.valueOf(request.getParameter("dob"));
        String genderStr = request.getParameter("gender");
        boolean gender = false;
        if(genderStr != null && genderStr.equals("Male")){
            gender = true;
        }
        Date updateDate = new Date(System.currentTimeMillis());

        CustomerDAO dao = new CustomerDAO();
        dao.updateCustomer2(customer.getCustomerID(), name, email, phone, address, dob, gender, img, updateDate);
        response.sendRedirect("profile");


    }
}
