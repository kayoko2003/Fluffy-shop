package controller.Warehouse_Staff;

import java.io.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.Staff;

@WebServlet(name = "InventoryManagement ", value = "/inventorymanagement")
public class InventoryManagement extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession();

        Staff staff = (Staff) session.getAttribute("acc");

        ProductDAO dao = new ProductDAO();
        int currentPage = 1;
        int itemsPerPage = 6;
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
        } else sortBy = "p.product_id";

        String search = "";
        if (request.getParameter("txt") != null) {
            search = request.getParameter("txt");
        }

        int brand = request.getParameter("brand") != null ? Integer.parseInt(request.getParameter("brand")) : -1;
        int category = request.getParameter("category") != null ? Integer.parseInt(request.getParameter("category")) : -1;

        String sortOrder = request.getParameter("sortOrder");
        if(sortOrder != null){
            request.setAttribute("sortOrder", sortOrder);
        } else sortOrder = "ASC";

        total = dao.getTotalProductsCount(search, brand, category);

        totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = (currentPage > totalPages) ? Math.max(totalPages, 1) : currentPage;

        List<Product> products = dao.getAllProducts(currentPage, itemsPerPage, sortBy, search, -1, -1, sortOrder);

        String edit = request.getParameter("edit");
        if (edit != null && edit.equals("true")) {
            for (Product product : products) {
                String quantityParam = request.getParameter("quantity_" + product.getId());
                String importPriceParam = request.getParameter("importPrice_" + product.getId());
                String hold = request.getParameter("hold_" + product.getId());
                if (quantityParam != null && importPriceParam != null && !quantityParam.isEmpty() && !importPriceParam.isEmpty() && Integer.parseInt(quantityParam) > Integer.parseInt(hold)) {
                    int quantity = Integer.parseInt(quantityParam);
                    int importPrice = Integer.parseInt(importPriceParam);
                    dao.updateQuantityAndImportPrice(product.getId(),quantity,importPrice,staff.getStaffID());
                }
            }
        }

        products = dao.getAllProducts(currentPage, itemsPerPage, sortBy, search, -1, -1, sortOrder);
        LinkedHashMap<Product, Integer> productWithNumberHold = dao.getListProductWithHoldQuantity(products);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("listProduct", productWithNumberHold);
        request.setAttribute("search", search);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", total);
        request.setAttribute("inventory", "active");
        request.setAttribute("ecommerce_product", "show");
        request.setAttribute("ecommerce", "show");
        request.getRequestDispatcher("Warehouse_Staff/InventoryManagement.jsp").forward(request, response);
    }


    public void destroy() {
    }
}