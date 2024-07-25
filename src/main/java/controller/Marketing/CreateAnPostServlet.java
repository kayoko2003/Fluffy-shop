
package controller.Marketing;

import dal.AdminDAO;

import dal.MarketingDAO;
import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Post;
import model.PostCategory;
import model.Staff;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "CreateAnPostServlet", value = "/createanpost")
public class CreateAnPostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostDAO dao = new PostDAO();
        List<PostCategory> listCB = dao.getAllCategoryB();
        List<Staff> listA = dao.getAllAdmins();

        request.setAttribute("listA", listA);
        request.setAttribute("listCateB", listCB);
//        PrintWriter out = response.getWriter();
//        for (int i = 0; i < listA.size(); i++) {
//            out.println(listA.get(i).toString());
//        }
        request.setAttribute("createpost", "active");
        request.setAttribute("post", "show");
        request.setAttribute("ecommerce", "show");
        request.getRequestDispatcher("Marketing/CreateAnPost.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String thumbnail = request.getParameter("thumbnail");
            String title = request.getParameter("title");
            String short_detail = request.getParameter("short_detail");
            String blog_detail = request.getParameter("detail");
            int blog_category_id = Integer.parseInt(request.getParameter("categoryB"));
            int id_creater = Integer.parseInt(request.getParameter("adminID"));
            boolean isShow = Boolean.parseBoolean(request.getParameter("isShow"));
            String create_date = request.getParameter("create_date");
            String update_date = request.getParameter("update_date");

            // Ensure the dates are in the correct format
            if (create_date != null && !create_date.isEmpty() && update_date != null && !update_date.isEmpty()) {
                PostDAO dao = new PostDAO();
                dao.insertPost(thumbnail, title, blog_category_id, id_creater, short_detail, isShow, blog_detail, create_date, update_date);

                request.setAttribute("success", "Add Post success.");
            } else {
                request.setAttribute("error", "Create date and Update date cannot be empty.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error adding post: " + e.getMessage());
        }
        request.getRequestDispatcher("Manager.jsp").forward(request, response);
    }
}