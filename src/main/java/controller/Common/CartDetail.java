package controller.Common;

import dal.CartDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet(name = "CartDetail", value = "/cartdetail")
public class CartDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        CartDAO dao = new CartDAO();
        Customer c = (Customer) session.getAttribute("acc");
        if (c != null) {
            List<Cart> carts = dao.listCartByCId(c.getCustomerID());
            if (carts != null) {
                request.setAttribute("carts", carts);
            }
            ProductDAO productDAO = new ProductDAO();
            Set<Category> categories = productDAO.getCategories();
            Set<Brand> brands = productDAO.getBrands();
            List<Product> latestProducts = productDAO.getListProductCanBuy(1, 6, "p.update_date", "", -1, -1, "desc");
            double totalMoney = dao.getCartByCustomerId(c.getCustomerID()).getTotalMoney();
            request.setAttribute("listC", categories);
            request.setAttribute("listB", brands);
            request.setAttribute("size", carts.size());
            request.setAttribute("latestProduct", latestProducts);
            request.setAttribute("totalMoney", totalMoney);
            request.setAttribute("isCustomer", "true");
        } else {
            request.getRequestDispatcher("login").forward(request, response);
            return;
        }

        request.getRequestDispatcher("Common/CartDetail.jsp").forward(request, response);
    }
}
