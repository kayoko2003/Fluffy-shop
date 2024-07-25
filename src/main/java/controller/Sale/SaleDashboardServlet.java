package controller.Sale;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import dal.AdminDAO;
import dal.SaleDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Staff;
import org.json.JSONObject;

@WebServlet(name = "SaleDashboardServletServlet", value = "/saledashboard")
public class SaleDashboardServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession();

        Staff user = (Staff) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        // Calculate default startDate and endDate
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        String endDate = sdf.format(cal.getTime()); // Current date
        cal.add(Calendar.DAY_OF_YEAR, -7); // 7 days ago
        String startDate = sdf.format(cal.getTime());


        // Get parameters, use default if not provided
        String paramStartDate = request.getParameter("startDate");
        String paramEndDate = request.getParameter("endDate");
        String salesPerson = request.getParameter("salesPerson");
        String orderStatus = request.getParameter("orderStatus");

        if (paramStartDate != null && !paramStartDate.isEmpty()) {
            startDate = paramStartDate;
        }
        if (paramEndDate != null && !paramEndDate.isEmpty()) {
            endDate = paramEndDate;
        }

        if (salesPerson == null) {
            salesPerson = "";
        }
        if (orderStatus == null) {
            orderStatus = "";
        }



        AdminDAO dao = new AdminDAO();

        List<Staff> salesPersons = dao.searchStaffByRoleID(3);
        JSONObject orderTrendData = SaleDAO.fetchOrderTrendData(startDate, endDate, salesPerson, orderStatus);
        JSONObject revenueTrendData = SaleDAO.fetchRevenueTrendData(startDate, endDate, salesPerson, orderStatus);

        request.setAttribute("salesPersons", salesPersons);
        request.setAttribute("orderTrendData", orderTrendData.toString());
        request.setAttribute("revenueTrendData", revenueTrendData.toString());
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("salesPerson", salesPerson);
        request.setAttribute("orderStatus", orderStatus);
        request.setAttribute("activeDashboard", "active");
        RequestDispatcher dispatcher = request.getRequestDispatcher("Sale/SaleDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
