package controller;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Staff;

@WebServlet(name = "erro", value = "/erro")
public class ErroPage extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Object account = session.getAttribute("acc");
        if (account instanceof Staff) {
            request.getRequestDispatcher("AdminErroPage.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("ShopErroPage.jsp").forward(request, response);
        }
    }

    public void destroy() {
    }
}