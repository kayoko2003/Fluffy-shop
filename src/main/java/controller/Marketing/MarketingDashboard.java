package controller.Marketing;

import com.google.gson.Gson;
import com.oracle.wls.shaded.org.apache.xpath.operations.Or;
import dal.MarketingDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Calendar;
import java.util.List;

@WebServlet(value = "/marketingdashboard")
public class MarketingDashboard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//
//        Staff user = (Staff) session.getAttribute("acc");
//
//        if (user == null) {
//            response.sendRedirect("login");
//            return;
//        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        String endDate = sdf.format(cal.getTime()); // Current date
        cal.add(Calendar.DAY_OF_YEAR, -7); // 7 days ago
        String startDate = sdf.format(cal.getTime());

        MarketingDAO dao = new MarketingDAO();
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        if (startDateStr != null && !startDateStr.isEmpty()) {
            startDate = startDateStr;
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            endDate = endDateStr;
        }

        List<Post> posts = dao.getPosts(startDate, endDate);
        List<Product> products = dao.getProducts(startDate, endDate);
        List<Customer> customers = dao.getCustomers(startDate, endDate);
        List<Feedback> feedbacks = dao.getFeedbacks(startDate, endDate);
        List<OrderDetail> trends = dao.getTrendsofCustomers(startDate, endDate);

        request.setAttribute("posts", posts != null ? posts : List.of());
        request.setAttribute("products", products != null ? products : List.of());
        request.setAttribute("customers", customers != null ? customers : List.of());
        request.setAttribute("feedbacks", feedbacks != null ? feedbacks : List.of());
        request.setAttribute("trends", trends != null ? trends : List.of());
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("activeDashboard", "active");
        request.getRequestDispatcher("/Marketing/MarketingDashboard.jsp").forward(request, response);
    }
}
