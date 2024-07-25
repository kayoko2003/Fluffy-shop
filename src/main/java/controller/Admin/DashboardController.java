/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import com.google.gson.Gson;
import dal.CategoryDAO;
import dal.CustomerDAO;
import dal.FeedbackDAO;
import dal.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Customer;
import model.Order;

import java.io.IOException;
import java.sql.Date;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        LocalDate endDate = LocalDate.now();
        LocalDate startDate = endDate.minusDays(7);


        if (startDateStr != null && !startDateStr.isEmpty()) {
            try {
                startDate = LocalDate.parse(startDateStr);
                request.setAttribute("startDate", startDate);
            } catch (DateTimeParseException e) {
                request.setAttribute("error", "Invalid start date format. Please use YYYY-MM-DD.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
                return;
            }
        }


        if (endDateStr != null && !endDateStr.isEmpty()) {
            try {
                endDate = LocalDate.parse(endDateStr);
                request.setAttribute("endDate", endDate);
            } catch (DateTimeParseException e) {
                request.setAttribute("error", "Invalid end date format. Please use YYYY-MM-DD.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
                return;
            }
        }

        CategoryDAO categoryDAO = new CategoryDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        OrderDAO orderDAO = new OrderDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        List<Order> pendingOrders = orderDAO.getOrdersByStatus("Pending", Date.valueOf(startDate), Date.valueOf(endDate));
        List<Order> holdOrders = orderDAO.getOrdersByStatus("On hold", Date.valueOf(startDate), Date.valueOf(endDate));
        List<Order> completedOrders = orderDAO.getOrdersByStatus("Completed", Date.valueOf(startDate), Date.valueOf(endDate));
        List<Order> processingOrders = orderDAO.getOrdersByStatus("Processing", Date.valueOf(startDate), Date.valueOf(endDate));

        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("holdOrders", holdOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("processingOrders", processingOrders);

        double totalRevenue = orderDAO.getTotalRevenue(Date.valueOf(startDate), Date.valueOf(endDate));
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        request.setAttribute("totalRevenue", parseCurrencyStringToDouble(currencyFormat.format(totalRevenue)));

        List<Category> categories = categoryDAO.getAllCategories();
        Map<String, Double> revenueByCategory = new HashMap<>();
        for (Category category : categories) {
            double revenue = orderDAO.getRevenueByCategory(category.getId(), Date.valueOf(startDate), Date.valueOf(endDate));
            String revenueStr = currencyFormat.format(revenue);
            double revenueNumber = parseCurrencyStringToDouble(revenueStr);
            revenueByCategory.put(category.getName(), revenueNumber);
        }
        request.setAttribute("revenueByCategory", revenueByCategory);

        List<Customer> newlyRegisteredCustomers = customerDAO.getNewlyRegisteredCustomers(Date.valueOf(startDate), Date.valueOf(endDate));
        List<Customer> newlyBoughtCustomers = customerDAO.getNewlyBoughtCustomers(Date.valueOf(startDate), Date.valueOf(endDate));

        request.setAttribute("newlyRegisteredCustomers", newlyRegisteredCustomers);
        request.setAttribute("newlyBoughtCustomers", newlyBoughtCustomers);

        double averageRating = feedbackDAO.getAverageRating();
        request.setAttribute("averageRating", averageRating);

        Map<String, Double> averageRatingByCategory = new HashMap<>();
        for (Category category : categories) {
            double avgRating = feedbackDAO.getAverageRatingByCategory(category.getId());
            averageRatingByCategory.put(category.getName(), avgRating);
        }
        request.setAttribute("averageRatingByCategory", averageRatingByCategory);

        Map<Date, Integer> orderTrend = orderDAO.getSuccessfulOrderCountsByDay(Date.valueOf(startDate), Date.valueOf(endDate));
        String orderTrendJson = new Gson().toJson(orderTrend);
        request.setAttribute("orderTrendJson", orderTrendJson);
        request.setAttribute("activeDashboard", "active");
        RequestDispatcher dispatcher = request.getRequestDispatcher("./Admin/DashBoard.jsp");
        dispatcher.forward(request, response);
    }

    private double parseCurrencyStringToDouble(String currencyString) {
        String trimmedString = currencyString.trim();
        String cleanedString = trimmedString.replaceAll(",", "");
        cleanedString = cleanedString.replaceAll("\\s+", " ");
        cleanedString = cleanedString.replaceAll("[^\\d.]", "");
        cleanedString = cleanedString.replaceAll("\\.(?=.*\\.)", "");
        double number = Double.parseDouble(cleanedString);
        return number;
    }

}
