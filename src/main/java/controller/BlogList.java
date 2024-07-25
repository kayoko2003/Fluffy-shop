package controller;

import java.io.*;
import java.util.List;

import dal.AdminDAO;
import dal.CartDAO;
import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "BlogList", value = "/bloglist")
public class BlogList extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        CartDAO cartDAO = new CartDAO();
        String search = request.getParameter("search");
        String categoryId = request.getParameter("categoryId");

        DAO dao = new DAO();

        int currentPage = 1;
        int itemsPerPage = 2;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }
        if(search != null) {
            request.setAttribute("search", search);
        }else{
            search = "";
        }

        if(categoryId != null) {
            request.setAttribute("categoryId", categoryId);
        }else {
            categoryId = "-1";
        }

        int totalBlog= dao.getTotalPost(search, categoryId);
        int totalPages = (int) Math.ceil((double) totalBlog / itemsPerPage);

        int offset = (currentPage - 1) * itemsPerPage;

        List<Post> listPost = dao.getListPost(offset, itemsPerPage, search, categoryId);
        List<Post> recentPost = dao.getRecentPost();

        Object account = session.getAttribute("acc");

        if (account instanceof Customer){
            Customer customer = (Customer) account;
            List<Cart> carts = cartDAO.listCartByCId(customer.getCustomerID());
            request.setAttribute("size", carts.size());
            ListCart listCart = cartDAO.getCartByCustomerId(customer.getCustomerID());
            request.setAttribute("totalMoney", listCart.getTotalMoney());
            request.setAttribute("isCustomer", "true");
        }

        request.setAttribute("postCategory", dao.getAllPostCategory());
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("recentPost", recentPost);
        request.setAttribute("listPost", listPost);
        request.getRequestDispatcher("BlogList.jsp").forward(request, response);
    }

    public void destroy() {
    }
}