package controller;

import java.io.*;
import java.util.*;

import dal.CartDAO;
import dal.DAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "ProductDetail", value = "/productdetail")
public class ProductDetail extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();

        String pid = request.getParameter("pid");
        Product product = productDAO.getProductById(Integer.parseInt(pid));
        List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");

        List<Product> relateCategoryProducts = productDAO.getListProductCanBuy(1, 5, "p.update_date", "", -1, product.getCategory().getId(), "desc");
        List<Product> relateBrandProducts = productDAO.getListProductCanBuy(1, 5, "p.update_date", "", product.getBrand().getId(), -1, "desc");

        Set<Integer> productIds = new LinkedHashSet<>();
        List<Product> relateProducts = new ArrayList<>();

        for (Product p : relateCategoryProducts) {
            if (productIds.add(p.getId())) {
                relateProducts.add(p);
            }
        }

        for (Product p : relateBrandProducts) {
            if (productIds.add(p.getId())) {
                relateProducts.add(p);
            }
        }
        if (index(product.getId(), relateProducts) != -1)
            relateProducts.remove(index(product.getId(), relateProducts));

        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();

        Object account = session.getAttribute("acc");

        if (account instanceof Customer) {
            Customer customer = (Customer) account;
            List<Cart> carts = cartDAO.listCartByCId(customer.getCustomerID());
            request.setAttribute("size", carts.size());
            ListCart listCart = cartDAO.getCartByCustomerId(customer.getCustomerID());
            request.setAttribute("totalMoney", listCart.getTotalMoney());
            request.setAttribute("isCustomer", "true");
        }

        request.setAttribute("relateProduct", relateProducts);
        request.setAttribute("holdNumber", productDAO.getHoldNumberProduct(product.getId()));
        request.setAttribute("product", product);
        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("latestProduct", latestProducts);
        request.getRequestDispatcher("ProductDetail.jsp").forward(request, response);
    }

    public int index(int pid, List<Product> listRelate) {
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(pid);

        for (int i = 0; i < listRelate.size(); i++) {
            if (listRelate.get(i).getId() == pid) {
                return i;
            }
        }
        return -1;
    }

    public void destroy() {
    }
}