package controller.Admin;

import java.io.*;
import java.util.List;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Role;
import util.EmailService;
import util.IJavaMail;

@WebServlet(name = "AddStaff", value = "/addstaff")
public class AddStaff extends HttpServlet {

    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        AdminDAO dao = new AdminDAO();
        List<Role> listRole = dao.getAllRole();
        request.setAttribute("listRole", listRole);
        request.setAttribute("showStaff", "show");
        request.setAttribute("activeAdd", "active");
        request.getRequestDispatcher("Admin/AddStaffs.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PasswordGenerator gen = new PasswordGenerator();

        String email = request.getParameter("email");
        String fullName = request.getParameter("fullname");
        String genderParam = request.getParameter("gender");
        String role = request.getParameter("role");
        String phoneNumber = request.getParameter("phone");
        String address = request.getParameter("address");

        String password = gen.generatePassword(8);
        
        boolean gender = "male".equals(genderParam);

        AdminDAO dao = new AdminDAO();

        if(dao.addStaff(email, fullName, gender, role, phoneNumber, address, password)){
            IJavaMail emailService = new EmailService();
            String message = "<h1>Welcome to big family Fluffy</h1>"
                    + "<p>Here are your account:</p>"
                    + "<p>Email: " + email + " </p>" +
                    "<p>Password: " + password + " </p>";

            emailService.send(email, "Welcome to fluffy shop", message);

            response.sendRedirect("liststaff");
        }else{
            request.setAttribute("mess", "Email is used");
            request.setAttribute("showStaff", "show");
            request.setAttribute("activeAdd", "active");
            request.setAttribute("listRole", dao.getAllRole());
            request.getRequestDispatcher("Admin/AddStaffs.jsp").forward(request, response);
        }
    }

    public void destroy() {
    }
}
