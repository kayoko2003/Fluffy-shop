package Filter;

import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import model.Staff;

@WebFilter(filterName = "Authentication")
public class Authentication implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }


    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        HttpSession session = req.getSession(false);
        Object account = null;
        if (session != null) {
            account = session.getAttribute("acc");
        }
        if (uri.endsWith(".jsp")) {
            res.sendRedirect("erro");
        } else if (account == null) {
            if (!(uri.endsWith("home") || uri.endsWith("login") || uri.endsWith("forgotpassword") || uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith("logout") || uri.endsWith("loginstaff")
                    || uri.endsWith("signup") || uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith("shopping") || uri.endsWith("productdetail")
                    || uri.endsWith("bloglist") || uri.contains(".woff") || uri.endsWith("blogdetail") || uri.endsWith("erro") || uri.equals(req.getContextPath() + "/")
                    || uri.endsWith("cartdetail") || uri.endsWith("resetpassword") || uri.endsWith("payment-method") || uri.endsWith("status-order"))) {
                res.sendRedirect("erro");
            } else {
                chain.doFilter(request, response);
            }
        } else {
            if (account instanceof Staff && !(uri.endsWith("addtocart") || uri.endsWith("cartcompletion") || uri.endsWith("cartcontact")
                    || uri.endsWith("cartdetail") || uri.endsWith("comfirmorder") || uri.endsWith("feedbackDetails")
                    || uri.endsWith("order") || uri.endsWith("orders") || uri.endsWith("process") || uri.endsWith("activate-account")
                    || uri.endsWith("processaddress") || uri.endsWith("updateOrderStatus") || uri.endsWith("profile"))) {
                Staff staff = (Staff) account;

                if ((staff.getRoleName().equals("Sale") || staff.getRoleName().equals("Manager Sale") || staff.getRoleName().equals("Warehouse Staff")) && (uri.endsWith("addstaff") || uri.endsWith("dashboard") || uri.endsWith("filterstaff")
                        || uri.endsWith("liststaff") || uri.endsWith("searchstaff") || uri.endsWith("staffdetail") || uri.endsWith("updatestaff")
                        || uri.endsWith("addcustomer") || uri.endsWith("createanpost") || uri.endsWith("customerdetail") || uri.endsWith("editpost")
                        || uri.endsWith("feedback") || uri.endsWith("feedback-list") || uri.endsWith("filterpost") || uri.endsWith("listcustomer")
                        || uri.endsWith("listpost") || uri.endsWith("listslider") || uri.endsWith("loadpost") || uri.endsWith("marketingdashboard")
                        || uri.endsWith("postdetail") || uri.endsWith("postlist") || uri.endsWith("add-product") || uri.endsWith("product")
                        || uri.endsWith("products") || uri.endsWith("updatecustomer") || uri.endsWith("inventorymanagement"))) {
                    if (uri.endsWith("saledashboard")) {
                        chain.doFilter(request, response);
                        return;
                    }
                    if (staff.getRoleName().equals("Warehouse Staff") && (uri.endsWith("inventorymanagement") || uri.endsWith("products") || uri.endsWith("product"))) {
                        chain.doFilter(request, response);
                        return;
                    }

                    res.sendRedirect("erro");

                } else if (staff.getRoleName().equals("Marketer") && (uri.endsWith("addstaff") || uri.endsWith("dashboard") || uri.endsWith("filterstaff")
                        || uri.endsWith("liststaff") || uri.endsWith("searchstaff") || uri.endsWith("staffdetail") || uri.endsWith("updatestaff")
                        || uri.endsWith("orderdetailsale") || uri.endsWith("orderlist") || uri.endsWith("processorder")
                        || uri.endsWith("saledashboard") || uri.endsWith("updateorderdetailbysalemanager"))) {
                    if (uri.endsWith("marketingdashboard")) {
                        chain.doFilter(request, response);
                        return;
                    }
                    res.sendRedirect("erro");

                } else if (staff.getRoleName().equals("Admin") && (uri.endsWith("addcustomer") || uri.endsWith("createanpost") || uri.endsWith("customerdetail") || uri.endsWith("editpost")
                        || uri.endsWith("feedback") || uri.endsWith("feedback-list") || uri.endsWith("filterpost") || uri.endsWith("listcustomer")
                        || uri.endsWith("listpost") || uri.endsWith("listslider") || uri.endsWith("loadpost") || uri.endsWith("marketingdashboard")
                        || uri.endsWith("postdetail") || uri.endsWith("postlist") || uri.endsWith("add-product") || uri.endsWith("product")
                        || uri.endsWith("products") || uri.endsWith("updatecustomer") || uri.endsWith("orderdetailsale") || uri.endsWith("orderlist") || uri.endsWith("processorder")
                        || uri.endsWith("saledashboard") || uri.endsWith("updateorderdetailbysalemanager") || uri.endsWith("inventorymanagement")
                )) {

                    res.sendRedirect("erro");

                } else {
                    if(uri.endsWith("login") || uri.endsWith("loginstaff")) {
                        switch (staff.getRoleName()) {
                            case "Admin":
                                res.sendRedirect("dashboard");
                                break;
                            case "Marketer":
                                res.sendRedirect("marketingdashboard");
                                break;
                            default:
                                res.sendRedirect("saledashboard");
                        }
                        return;
                    }
                    chain.doFilter(request, response);
                }
            } else if (account instanceof Customer && (uri.endsWith("addcustomer") || uri.endsWith("createanpost") || uri.endsWith("customerdetail") || uri.endsWith("editpost")
                    || uri.endsWith("feedback") || uri.endsWith("feedback-list") || uri.endsWith("filterpost") || uri.endsWith("listcustomer")
                    || uri.endsWith("listpost") || uri.endsWith("listslider") || uri.endsWith("loadpost") || uri.endsWith("postdetail") || uri.endsWith("postlist") || uri.endsWith("add-product") || uri.endsWith("product")
                    || uri.endsWith("products") || uri.endsWith("updatecustomer") || uri.endsWith("orderdetailsale") || uri.endsWith("orderlist") || uri.endsWith("processorder")
                    || uri.endsWith("updateorderdetailbysalemanager") || uri.endsWith("addstaff") || uri.endsWith("dashboard") || uri.endsWith("filterstaff")
                    || uri.endsWith("liststaff") || uri.endsWith("searchstaff") || uri.endsWith("staffdetail") || uri.endsWith("updatestaff") || uri.endsWith("inventorymanagement")
            )) {
                res.sendRedirect("erro");
            } else {
                if (account instanceof Customer && (uri.endsWith("login") || uri.endsWith("loginstaff"))) {
                    res.sendRedirect("home");
                    return;
                }
                chain.doFilter(request, response);
            }
        }
    }
}
 
