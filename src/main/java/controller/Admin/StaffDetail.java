package controller.Admin;

import dal.AdminDAO;
import jakarta.servlet.ServletException;
import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.List;
import model.Role;
import model.Staff;

@WebServlet(name = "StaffDetail", value = "/staffdetail")
public class StaffDetail extends HttpServlet {

    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        String sid = request.getParameter("sid");

        AdminDAO dao = new AdminDAO();

        Staff staff = dao.getStaffById(sid);
        List<Role> listRole = dao.getAllRole();

        request.setAttribute("sid", sid);
        request.setAttribute("listRole", listRole);
        request.setAttribute("staff", staff);
        request.setAttribute("showStaff", "show");
        request.setAttribute("detail", "active");
        request.getRequestDispatcher("Admin/StaffDetail.jsp").forward(request, response);
    }

    public void destroy() {
    }
}
