package controller.Marketing;

import dal.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.Staff;

import java.io.File;
import java.io.IOException;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "ProductDetailServlet", value = "/product")
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if(id != null && !id.isEmpty()) {
            ProductDAO dao = new ProductDAO();
            request.setAttribute("product", dao.getProductById(Integer.parseInt(id)));
            request.setAttribute("categories", dao.getCategories());
            request.setAttribute("brands", dao.getBrands());
            request.setAttribute("productdetail", "active");
            request.setAttribute("ecommerce_product", "show");
            request.setAttribute("ecommerce", "show");

            request.getRequestDispatcher("Marketing/ProductDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/products");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Staff user = (Staff) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("productName");
        int category = Integer.parseInt(request.getParameter("productCategory"));
        String categoryName = request.getParameter("productCategoryName").replace(" ", "_");
        int brand = Integer.parseInt(request.getParameter("productBrand"));
        double price = Double.parseDouble(request.getParameter("productPrice"));
        String description = request.getParameter("productDescription");
        int quantity = Integer.parseInt(request.getParameter("productQuantity"));
        String status = request.getParameter("productStatus");

        ProductDAO dao = new ProductDAO();

        String img = null;
        Part part = request.getPart("productImage");
        if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()){
            String fileName = part.getSubmittedFileName();
            String basePath = getServletContext().getRealPath("/") + "/Static_access_manager/assets/img/products/" + categoryName + "/";
            File directory = new File(basePath);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            part.write(basePath + fileName);
            img = "Static_access_manager/assets/img/products/" + categoryName + "/" + fileName;
        }

        dao.updateProduct(id, name, category, brand, price, description, img, quantity, status, user.getStaffID());
        response.sendRedirect("products");
    }


}
