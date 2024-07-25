package controller;

import java.io.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import dal.CartDAO;
import dal.DAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "ShopServlet", value = "/shopping")
public class ShopServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        ProductDAO productDAO = new ProductDAO();

        CartDAO cartDAO = new CartDAO();
        ProductDAO dao = new ProductDAO();
        int currentPage = 1;
        int itemsPerPage = 9;
        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        int totalProductCanBuy = 0;
        int totalProductOutStock = 0;
        int total = 0;
        int totalPages = 0;
        if (currentPage < 1) {
            currentPage = 1;
        }

        String sortBy = request.getParameter("sortBy");
        if(sortBy != null){
            request.setAttribute("sortBy", sortBy);
        } else sortBy = "p.update_date";

        // Get search parameters
        String search = "";
        if (request.getParameter("search") != null) {
            search = request.getParameter("search");
        }

        int brand = request.getParameter("brand") != null ? Integer.parseInt(request.getParameter("brand")) : -1;
        int category = request.getParameter("category") != null ? Integer.parseInt(request.getParameter("category")) : -1;

        String sortOrder = request.getParameter("sortOrder");
        if(sortOrder != null){
            request.setAttribute("sortOrder", sortOrder);
        } else sortOrder = "DESC";

        totalProductCanBuy = dao.getTotalProductsCountCanBuy(search, brand, category);
        totalProductOutStock = dao.getTotalProductsCountOutOfStock(search, brand, category);
        total = totalProductCanBuy + totalProductOutStock;

        if(totalProductCanBuy == 0){
            totalProductCanBuy = 1;
        }

        int totalPagesHaveProductCanBuy = (int) Math.ceil((double) totalProductCanBuy / itemsPerPage);

        totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = (currentPage > totalPages) ? Math.max(totalPages, 1) : currentPage;

        int current = currentPage - totalPagesHaveProductCanBuy;
        int offset = current * itemsPerPage;
        List<Product> products = null;

        if(currentPage == totalPagesHaveProductCanBuy){
            List<Product> productCanBuy = dao.getListProductCanBuy(currentPage, itemsPerPage, sortBy, search, brand, category, sortOrder);
            List<Product> productOutStock = dao.getProductOutOfStock(offset, itemsPerPage - productCanBuy.size(), sortBy, search, brand, category, sortOrder);
            products = new ArrayList<>(productCanBuy);
            products.addAll(productOutStock);
        }else if(currentPage > totalPagesHaveProductCanBuy){
            offset = (current - 1)* itemsPerPage + itemsPerPage - dao.getListProductCanBuy(totalPagesHaveProductCanBuy, itemsPerPage, sortBy, search, brand, category, sortOrder).size();
            products = dao.getProductOutOfStock(offset, itemsPerPage, sortBy, search, brand, category, sortOrder);
        }else {
            products = dao.getListProductCanBuy(currentPage, itemsPerPage, sortBy, search, brand, category, sortOrder);
        }
        List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
        List<Product> saleProducts = productDAO.getListProductCanBuy(1, 6, "p.price", "", -1, -1, "desc");
        Set<Category> categories = productDAO.getCategories();
        Set<Brand> brands = productDAO.getBrands();

        Object account = session.getAttribute("acc");

        LinkedHashMap<Product, Integer> productWithNumberHold = dao.getListProductWithHoldQuantity(products);

        if (account instanceof Customer){
            Customer customer = (Customer) account;
            List<Cart> carts = cartDAO.listCartByCId(customer.getCustomerID());
            request.setAttribute("size", carts.size());
            ListCart listCart = cartDAO.getCartByCustomerId(customer.getCustomerID());
            request.setAttribute("totalMoney", listCart.getTotalMoney());
            request.setAttribute("isCustomer", "true");
        }

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("productList", productWithNumberHold);
        request.setAttribute("search", search);
        request.setAttribute("brand", brand);
        request.setAttribute("category", category);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", total);
        request.setAttribute("isShopping", 1);
        request.setAttribute("listC", categories);
        request.setAttribute("listB", brands);
        request.setAttribute("saleProducts", saleProducts);
        request.setAttribute("latestProduct", latestProducts);
        request.getRequestDispatcher("Shopping.jsp").forward(request, response);
    }

    public void destroy() {
    }
}