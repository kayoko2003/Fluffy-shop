package controller;

import java.io.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import dal.CartDAO;
import dal.DAO;
import dal.ProductDAO;

import java.io.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import dal.CartDAO;
//import dal.DAO;
import dal.ProductDAO;
import dal.SliderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        SliderDAO sliderDAO = new SliderDAO();
        DAO dao = new DAO();
        HashSet<String> displayedCategories = new HashSet<>();

        Object account = session.getAttribute("acc");

        if (account instanceof Customer) {
            Customer customer = (Customer) account;
            List<Cart> carts = cartDAO.listCartByCId(customer.getCustomerID());
            request.setAttribute("size", carts.size());
            ListCart listCart = cartDAO.getCartByCustomerId(customer.getCustomerID());
            request.setAttribute("totalMoney", listCart.getTotalMoney());
            request.setAttribute("isCustomer", "true");
        }

        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();
        List<Product> featureProducts = productDAO.getListProductCanBuy(1, 8, "p.number_sold", "", -1, -1, "desc");
        List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
        List<Post> latestPost = dao.getRecentPost();
        List<Slider> slider = sliderDAO.getAllSlider();

        request.setAttribute("displayedCategories", displayedCategories);
        request.setAttribute("latest", latestProducts);
        request.setAttribute("listFeature", featureProducts);
        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("latestPost", latestPost);
        request.setAttribute("slider", slider);
        request.getRequestDispatcher("Home.jsp").forward(request, response);
    }
}
