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

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FilterPost", value = "/filterpost")
public class FilterPost extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        PostDAO dao = new PostDAO();
        String category = request.getParameter("category");
        String author = request.getParameter("author");
        String status = request.getParameter("status");

        //List<Post> listPost = dao.filterPost(category, author, status);
        List<PostCategory> listCB= dao.getAllCategoryB();
        List<Staff> listA = dao.getAllAdmins();

       // request.setAttribute("listPost", listPost);
        request.setAttribute("listCB", listCB);
        request.setAttribute("listA", listA);
        request.getRequestDispatcher("Marketing/Postlist.jsp").forward(request, response);
    }
}
