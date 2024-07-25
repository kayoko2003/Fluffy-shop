package controller.Common;

import java.io.*;
import java.time.LocalDate;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import util.EmailService;
import util.IJavaMail;
import util.JwtUtil;

@WebServlet(name = "signupServlet", value = "/signup")
public class SignupServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("Common/Signup.jsp").forward(request, response);
    }

    @Override
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
            request.getRequestDispatcher("Common/Signup.jsp").forward(request, response);
            return;
        }

        LocalDate dateOfBirth = LocalDate.parse(dob);
        LocalDate createDate = LocalDate.now();
        LocalDate updateDate = LocalDate.now();
        String avatar = "https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png";


        CustomerDAO customerDAO = new CustomerDAO();
        if (!customerDAO.checkEmailExist(email)) {
            String token = JwtUtil.generateToken(email);
            customerDAO.saveToken(email, token);
            customerDAO.signup(email, password, fullname, address, gender, phone, dateOfBirth, createDate, updateDate, token, "PENDING", avatar);
            String verificationLink = request.getRequestURL().toString().replace(request.getServletPath(), "") + "/activate-account?token=" + token;
            String message = "<h1>Verify Account</h1>"
                    + "<p>Click here to <a href=\"" + verificationLink + "\">Verify Account</a></p>";
            IJavaMail emailService = new EmailService();
            emailService.send(email, "Verify Account", message);
            request.setAttribute("mess1", "The email to verify account has been sent to your email. Activate to login!");
            request.getRequestDispatcher("Common/Signup.jsp").forward(request, response);
        } else {
            request.setAttribute("mess", "Email already exists!");
            request.getRequestDispatcher("Common/Signup.jsp").forward(request, response);
        }
    }
}
