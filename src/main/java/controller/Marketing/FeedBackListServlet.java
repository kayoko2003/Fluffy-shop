package controller.Marketing;

import dal.FeedbackDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Feedback;
import model.Product;
import model.Staff;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FeedBackListServlet", value = "/feedback-list")
public class FeedBackListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Staff user = (Staff) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        FeedbackDAO dao = new FeedbackDAO();
        String action = request.getParameter("action");
        if(action != null && action.equals("delete")){
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteFeedback(id, user.getStaffID());
        } else if (action != null && action.equals("restore")){
            int id = Integer.parseInt(request.getParameter("id"));
            dao.restoreFeedback(id, user.getStaffID());
        }
        int currentPage = 1;
        int itemsPerPage = 4;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }
        if (request.getParameter("itemsPerPage") != null) {
            itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
        }

        int total = 0;
        int totalPages = 0;
        if (currentPage < 1) {
            currentPage = 1;
        }

        String sortBy = request.getParameter("sortBy");
        if(sortBy != null){
            request.setAttribute("sortBy", sortBy);
        } else sortBy = "f.feedback_id";

        // Get search parameters
        String search = "";
        if (request.getParameter("search") != null) {
            search = request.getParameter("search");
        }

        String sortOrder = request.getParameter("sortOrder");
        if(sortOrder != null){
            request.setAttribute("sortOrder", sortOrder);
        } else sortOrder = "DESC";

        int product = request.getParameter("product") != null ? Integer.parseInt(request.getParameter("product")) : -1;
        int customer = request.getParameter("customer") != null ? Integer.parseInt(request.getParameter("customer")) : -1;
        int rating = request.getParameter("rating") != null ? Integer.parseInt(request.getParameter("rating")) : -1;

        total = dao.getTotalFeedBack(search, product, customer, rating);
        totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = (currentPage > totalPages) ? Math.max(totalPages, 1) : currentPage;

        List<Feedback> feedbacks = dao.getAllFeedback(currentPage, itemsPerPage, sortBy, search, product, customer, rating, sortOrder);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("feedbackList", feedbacks);
        request.setAttribute("search", search);
        request.setAttribute("product", product);
        request.setAttribute("customer", customer);
        request.setAttribute("rating", rating);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", total);
        request.setAttribute("activeFeedback", "active");
        request.setAttribute("ecommerce", "show");
        request.getRequestDispatcher("Marketing/FeedbackList.jsp").forward(request, response);



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
