package controller;

import java.io.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import dal.CartDAO;
import dal.DAO;
import dal.PostDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "BlogDetail", value = "/blogdetail")
public class BlogDetail extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        DAO dao = new DAO();

        String bid = request.getParameter("bid");

        Post post = dao.getPostByID(Integer.parseInt(bid));

        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();

        List<Post> recentPost = dao.getRecentPost();
        List<Post> listPost = dao.getListPost(0, 4, "", Integer.toString(post.getPcategory().getPostCId()));
        listPost.remove(index(Integer.parseInt(bid), listPost));

        Object account = session.getAttribute("acc");

        if (account instanceof Customer){
            Customer customer = (Customer) account;
            List<Cart> carts = cartDAO.listCartByCId(customer.getCustomerID());
            request.setAttribute("size", carts.size());
            ListCart listCart = cartDAO.getCartByCustomerId(customer.getCustomerID());
            request.setAttribute("totalMoney", listCart.getTotalMoney());
            request.setAttribute("isCustomer", "true");
        }

        request.setAttribute("blog", post);
        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("postCategory", dao.getAllPostCategory());
        request.setAttribute("recentPost", recentPost);
        request.setAttribute("listPost", listPost);
        request.getRequestDispatcher("BlogDetail.jsp").forward(request, response);
    }

    public int index(int bid, List<Post> listPost) {
        DAO dao = new DAO();
        Post post = dao.getPostByID(bid);

        for (int i = 0; i < listPost.size(); i++) {
            if (listPost.get(i).getPostId() == bid) {
                return i;
            }
        }
        return -1;
    }

    public void destroy() {
    }
}