package controller.Marketing;

import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.PostCategory;

import java.io.IOException;
import java.util.List;

public class PostCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PostDAO dao = new PostDAO();
        List<PostCategory> listPC = dao.getAllPostCategory();

        request.setAttribute("listPC", listPC);
    }
}
