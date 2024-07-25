package controller.Common;

import dal.CartDAO;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet(name = "ProcessCart", value = "/process")
public class ProcessCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        CartDAO dao = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        Customer c = (Customer) session.getAttribute("acc");
        String delete = request.getParameter("delete");
        String update = request.getParameter("update");
        boolean quantityExceeded = false;

        if (delete != null) {
            String pid = request.getParameter("pid");
            dao.removeItemFromCart(pid, c.getCustomerID());
        }

        List<Cart> carts = dao.listCartByCId(c.getCustomerID());

        if (update != null) {
            for (Cart cart : carts) {
                String quantityStr = request.getParameter("pid" + cart.getProduct().getId());
                int requestedQuantity = Integer.parseInt(quantityStr);
                int stockQuantity = productDAO.getStockQuantity(cart.getProduct().getId());

                // Ensure the requested quantity does not exceed stock quantity
                if (requestedQuantity > stockQuantity - productDAO.getHoldNumberProduct(cart.getProduct().getId())) {
                    requestedQuantity = stockQuantity - productDAO.getHoldNumberProduct(cart.getProduct().getId());
                    quantityExceeded = true;
                }

                dao.updateToCart(c.getCustomerID(), String.valueOf(cart.getProduct().getId()), requestedQuantity);
            }
        }

        for (Cart cart : dao.listCartByCId(c.getCustomerID())) {
            if (cart.getQuantity() == 0) {
                dao.removeItemFromCart(String.valueOf(cart.getProduct().getId()), c.getCustomerID());
            }
        }

        if (quantityExceeded) {
            session.setAttribute("message", "One or more items had quantities exceeding stock. They have been adjusted.");
        } else {
            session.removeAttribute("message");
        }
        response.sendRedirect("cartdetail");

    }
}
