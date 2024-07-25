package controller.Marketing;

import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;
import model.PostCategory;
import model.Staff;

import javax.swing.text.html.parser.Parser;
import java.io.IOException;
import java.util.List;

@WebServlet(name="loadpostServlet", urlPatterns={"/loadpost"})
public class LoadPostServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int postId = Integer.parseInt(request.getParameter("postId"));
        PostDAO dao = new PostDAO();
        Post p = dao.getPostByID(postId);
        List<PostCategory> listCB= dao.getAllCategoryB();
        List<Staff> listA = dao.getAllAdmins();

        request.setAttribute("listCB", listCB);
        request.setAttribute("listA", listA);
        request.setAttribute("list", p);
        request.getRequestDispatcher("Marketing/EditPost.jsp").forward(request, response);
    }
}
