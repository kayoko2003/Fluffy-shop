package controller.Common;

import java.io.IOException;
import java.util.List;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Feedback;



@WebServlet(name = "FeedbackDetailsServlet", value = "/feedbackDetails")
public class FeedbackDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String productId = request.getParameter("productId");

        if (orderId != null && productId != null) {
            Feedback feedback = OrderDAO.getFeedbackByOrderAndProduct(Integer.parseInt(orderId), Integer.parseInt(productId));
            request.setAttribute("feedback", feedback);
            request.setAttribute("orderId", orderId);
            request.setAttribute("productId", productId);
            request.getRequestDispatcher("Common/OrderFeedbackDetails.jsp").forward(request, response);
        } else if (orderId != null) {
            List<Feedback> feedbackList = OrderDAO.getFeedbackByOrder(Integer.parseInt(orderId));
            request.setAttribute("feedbackList", feedbackList);
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("Common/OrderFeedbackDetails.jsp").forward(request, response);
        } else {
            response.sendRedirect("orders");
        }
    }
}
