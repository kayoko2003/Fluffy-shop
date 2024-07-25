package controller.Marketing;

import dal.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import model.Product;
import model.Staff;

import javax.mail.Session;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductListServlet", value = "/products")
public class ProductListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//
//        Staff user = (Staff) session.getAttribute("acc");
//
//        if (user == null) {
//            response.sendRedirect("login");
//            return;
//        }
        ProductDAO dao = new ProductDAO();
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
        } else sortBy = "p.product_id";

        // Get search parameters
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

        List<Product> products = dao.getAllProducts(currentPage, itemsPerPage, sortBy, search, brand, category, sortOrder);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("productList", products);
        request.setAttribute("search", search);
        request.setAttribute("brand", brand);
        request.setAttribute("category", category);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", total);
        request.setAttribute("listproduct", "active");
        request.setAttribute("ecommerce_product", "show");
        request.setAttribute("ecommerce", "show");
        request.getRequestDispatcher("Marketing/ProductList.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("productId");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Staff user = (Staff) session.getAttribute("acc");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if (id != null && !id.isEmpty() && action != null && !action.isEmpty()) {
            ProductDAO dao = new ProductDAO();
            if (action.equals("delete")) {
                dao.deleteProduct(Integer.parseInt(id), user.getStaffID());
            } else if (action.equals("restore")) {
                dao.restoreProduct(Integer.parseInt(id), user.getStaffID());
//            } else if (action.equals("unblock")) {
//                dao.unblockProduct(Integer.parseInt(id));
//            }
            }

        }
        response.sendRedirect("products");
    }
}
