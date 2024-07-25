package controller.Marketing;

import java.io.IOException;
import java.util.List;

import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;
import model.PostCategory;
import model.Staff;

/**
 *
 * @author tanpr
 */
@WebServlet(name="editpostServlet", urlPatterns={"/editpost"})
public class EditPostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostDAO dao = new PostDAO();

        int pid = Integer.parseInt(request.getParameter("postId"));
        Post post = dao.getPostByID(pid);

        List<PostCategory> listCB= dao.getAllCategoryB();
        List<Staff> listA = dao.getAllAdmins();

        request.setAttribute("listCB", listCB);
        request.setAttribute("listA", listA);
        request.setAttribute("p", post);
        request.setAttribute("postlist", "active");
        request.setAttribute("post", "show");
        request.setAttribute("ecommerce", "show");

        request.getRequestDispatcher("Marketing/EditPost.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String thumbnail = request.getParameter("thumbnail");
            String title = request.getParameter("title");
            String short_detail = request.getParameter("short_detail");
            String blog_detail = request.getParameter("detail");
            int blog_category_id = Integer.parseInt(request.getParameter("categoryB"));
            int idCreater = Integer.parseInt(request.getParameter("adminID"));
            boolean isShow = Boolean.parseBoolean(request.getParameter("isShow"));


            // Ensure the dates are in the correct format

                PostDAO dao = new PostDAO();
                dao.updatePost(id, thumbnail, title, blog_category_id, idCreater, blog_detail, isShow, short_detail);
                request.setAttribute("success", "Add Post success.");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating post: " + e.getMessage());
        }
        request.getRequestDispatcher("listpost").forward(request, response);
    }
}

