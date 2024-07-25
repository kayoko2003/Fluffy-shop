package controller.Marketing;

import dal.FeedbackDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Staff;

import java.io.IOException;

@WebServlet(name = "FeedBackDetailServlet", value = "/feedback")
public class FeedBackDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Staff user = (Staff) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            FeedbackDAO dao = new FeedbackDAO();
            request.setAttribute("feedback", dao.getFeedbackById(Integer.parseInt(id)));
            request.setAttribute("activeFeedback", "active");
            request.setAttribute("ecommerce", "show");
            request.getRequestDispatcher("Marketing/FeedBackDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/feedback-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
