/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import dal.PaymentMethodDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PaymentMethod;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP
 */
@WebServlet(name = "PaymentMethodController", urlPatterns = {"/payment-method"})
public class PaymentMethodController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaymentMethodController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentMethodController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action.trim() : "";
        PaymentMethodDAO paymentMethodDao = new PaymentMethodDAO();
        switch (action) {
            case "add":
                request.getRequestDispatcher("/Admin/addPaymentMethod.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                PaymentMethod existingPaymentMethod = paymentMethodDao.getPaymentMethod(id);
                request.setAttribute("paymentMethod", existingPaymentMethod);
                request.getRequestDispatcher("/Admin/addPaymentMethod.jsp").forward(request, response);
                break;
            case "delete":
                int idTer = Integer.parseInt(request.getParameter("id"));
                paymentMethodDao.deletePaymentMethod(idTer);
                response.sendRedirect("payment-method");
                break;
            default:
                List<PaymentMethod> paymentMethods = paymentMethodDao.listAllPaymentMethods();
                request.setAttribute("paymentMethods", paymentMethods);
                request.getRequestDispatcher("/Admin/PaymentMethod.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action.trim() : "";
        PaymentMethodDAO paymentMethodDao = new PaymentMethodDAO();
        String method = request.getParameter("method");
        PaymentMethod paymentMethod = new PaymentMethod();
        switch (action) {
            case "add":
                if (method == null || method.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Method cannot be empty.");
                    request.getRequestDispatcher("/Admin/addPaymentMethod.jsp").forward(request, response);
                    return;
                }
                paymentMethod.setMethod(method);
                paymentMethodDao.insertPaymentMethod(paymentMethod);
                response.sendRedirect("payment-method");
                break;
            case "edit":
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Invalid request.");
                    request.getRequestDispatcher("/Admin/PaymentMethod.jsp").forward(request, response);
                    return;
                }
                int id = Integer.parseInt(idParam);
                paymentMethod.setId(id);
                paymentMethod.setMethod(method);

                if (method == null || method.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Method cannot be empty.");
                    request.setAttribute("paymentMethod", paymentMethod);
                    request.getRequestDispatcher("/Admin/addPaymentMethod.jsp").forward(request, response);
                    return;
                }

                paymentMethodDao.updatePaymentMethod(paymentMethod);
                response.sendRedirect("payment-method");
                break;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
