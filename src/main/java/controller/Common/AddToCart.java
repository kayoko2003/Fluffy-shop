package controller.Common;

import java.io.*;
import java.net.URLEncoder;
import java.util.List;
import java.util.Set;

import dal.CartDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;

@WebServlet(name = "AddToCart", value = "/addtocart")
public class AddToCart extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(true);
        CartDAO dao = new CartDAO();
        ProductDAO pdao = new ProductDAO();
        Customer c = (Customer) session.getAttribute("acc");

        if (c != null) {
            int quantity = 1;
            if(request.getParameter("quantity") != null) {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
            String pid = request.getParameter("pid");

            List<Cart> carts = dao.listCartByCId(c.getCustomerID());

            int productQuantityCart = checkExistProductInCart(Integer.parseInt(pid), carts);

            if(productQuantityCart > 0 || quantity > pdao.getProductById(Integer.parseInt(pid)).getSockQuantity()){
                int total = productQuantityCart + quantity;
                if (total > (pdao.getProductById(Integer.parseInt(pid)).getSockQuantity() - pdao.getHoldNumberProduct(Integer.parseInt(pid)))) {
                    String erro = "Sorry, " + pdao.getProductById(Integer.parseInt(pid)).getName() + " not enough quantity";
                    if (request.getParameter("home") != null) {
                        response.sendRedirect("home?outStockQuantity=" + URLEncoder.encode(erro, "UTF-8"));
                        return;
                    } else if (request.getParameter("shop") != null) {
                        response.sendRedirect("shopping?outStockQuantity=" + URLEncoder.encode(erro, "UTF-8"));
                        return;
                    }
                    quantity = pdao.getProductById(Integer.parseInt(pid)).getSockQuantity() - productQuantityCart;
                    session.setAttribute("num", quantity);
                    response.sendRedirect("productdetail?pid=" + pid + "&outStockQuantity=" + URLEncoder.encode(erro, "UTF-8"));
                    return;
                }
                dao.updateToCart(c.getCustomerID(), pid, total);
            }else{
                dao.addToCart(pid, c.getCustomerID(), quantity);
            }

            if(request.getParameter("home") != null) {
                response.sendRedirect("home");
                return;
            } else if(request.getParameter("shop") != null) {
                response.sendRedirect("shopping");
                return;
            }
            response.sendRedirect("productdetail?pid=" + pid);
        } else {
            response.sendRedirect("login");
        }
    }

    public int checkExistProductInCart(int productID, List<Cart> carts) {
        for (Cart cart : carts) {
            if(cart.getProduct().getId() == productID) {
                return cart.getQuantity();
            }
        }
        return 0;
    }

    public void destroy() {
    }
}