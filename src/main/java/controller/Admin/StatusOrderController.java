/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import dal.StatusOrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.StatusOrder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP
 */
@WebServlet(name = "UpdateStaff", value = "/status-order")
public class StatusOrderController extends HttpServlet {

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
            out.println("<title>Servlet StatusOrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StatusOrderController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action.trim() : "";
        StatusOrderDAO statusOrderDao = new StatusOrderDAO();
        switch (action) {
            case "add":
                request.getRequestDispatcher("/Admin/addStatusOrder.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                StatusOrder existingStatusOrder = statusOrderDao.getStatusOrder(id);
                request.setAttribute("statusOrder", existingStatusOrder);
                request.getRequestDispatcher("/Admin/addStatusOrder.jsp").forward(request, response);
                break;
            case "delete":
                int idTer = Integer.parseInt(request.getParameter("id"));
                statusOrderDao.deleteStatusOrder(idTer);
                response.sendRedirect("status-order");
                break;
            default:
                List<StatusOrder> statusOrders = statusOrderDao.listAllStatusOrders();
                request.setAttribute("statusOrders", statusOrders);
                request.getRequestDispatcher("/Admin/StatusOrder.jsp").forward(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action.trim() : "";
        StatusOrderDAO statusOrderDao = new StatusOrderDAO();
        String status = request.getParameter("status");
        StatusOrder statusOrder = new StatusOrder();
        switch (action) {
            case "add":
                if (status == null || status.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Status cannot be empty.");
                    request.getRequestDispatcher("/Admin/addStatusOrder.jsp").forward(request, response);
                    return;
                }
                statusOrder.setStatus(status);
                statusOrderDao.insertStatusOrder(statusOrder);
                response.sendRedirect("status-order");
                break;
            case "edit":
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Invalid request.");
                    request.getRequestDispatcher("/Admin/StatusOrder.jsp").forward(request, response);
                    return;
                }
                int id = Integer.parseInt(idParam);
                statusOrder.setId(id);
                statusOrder.setStatus(status);

                if (status == null || status.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Status cannot be empty.");
                    request.setAttribute("StatusOrder", statusOrder);
                    request.getRequestDispatcher("/Admin/addPaymentMethod.jsp").forward(request, response);
                    return;
                }
                statusOrderDao.updateStatusOrder(statusOrder);
                response.sendRedirect("status-order");
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
