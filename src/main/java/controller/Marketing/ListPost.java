package controller.Marketing;

import dal.PostDAO;
import dal.SliderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Post;
import model.Slider;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="ListPost", value = "/listpost")
public class ListPost extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ListPost.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PostDAO dao = new PostDAO();
        String action = request.getParameter("action");

        if (action == null) {
            listPosts(request, response, dao);
        } else {
            switch (action) {
                case "view":
                case "edit":
                    viewOrEditPost(request, response, dao, action);
                    break;
                case "toggle":
                    togglePostStatus(request, response, dao);
                    break;
                default:
                    listPosts(request, response, dao);
                    break;
            }
        }
    }
    private void listPosts(HttpServletRequest request, HttpServletResponse response, PostDAO dao) throws ServletException, IOException {
        int currentPage = 1;
        int itemsPerPage = 10;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }
        if (request.getParameter("itemsPerPage") != null) {
            itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
        }

        int total = 0;
        int totalPages = 0;
        if (currentPage < 1) {
            currentPage = 1;
        }

        String sortBy = request.getParameter("sortBy");
        if (sortBy != null) {
            request.setAttribute("sortBy", sortBy);
        } else sortBy = "b.post_id";

        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder != null) {
            request.setAttribute("sortOrder", sortOrder);
        } else sortOrder = "ASC";

        // Get search parameters
        String search = "";
        if (request.getParameter("txt") != null) {
            search = request.getParameter("txt");
        }

        int postCategory = -1;
        String pcategoryParam = request.getParameter("pcategory");
        if (pcategoryParam != null && !pcategoryParam.isEmpty()) {
            try {
                postCategory = Integer.parseInt(pcategoryParam);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid pcategory parameter: " + pcategoryParam, e);
            }
        }

        int staff = -1;
        String staffParam = request.getParameter("staff");
        if (staffParam != null && !staffParam.isEmpty()) {
            try {
                staff = Integer.parseInt(staffParam);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid staff parameter: " + staffParam, e);
            }
        }

        Boolean isShow = null;
        if (request.getParameter("isShow") != null && !request.getParameter("isShow").isEmpty()) {
            isShow = Boolean.parseBoolean(request.getParameter("isShow"));
        }

        total = dao.getTotalPostCount(search, postCategory, staff, isShow);

        totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = (currentPage > totalPages) ? Math.max(totalPages, 1) : currentPage;

        List<Post> postList = dao.listAllPost(currentPage, itemsPerPage, search, postCategory, staff, isShow, sortOrder, sortBy);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("listpost", postList);
        request.setAttribute("search", search);
        request.setAttribute("pcategory", postCategory);
        request.setAttribute("staff", staff);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("total", total);
        request.setAttribute("postlist", "active");
        request.setAttribute("post", "show");
        request.setAttribute("ecommerce", "show");
        request.getRequestDispatcher("Marketing/Postlist.jsp").forward(request, response);
    }

    private void viewOrEditPost(HttpServletRequest request, HttpServletResponse response, PostDAO dao, String action) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("postId"));
        Post post = dao.getPostByID(id);
        List<Post> postCate = dao.getTopPosts(post.getPcategory().getPostCId());
        if(post == null) {
            LOGGER.log(Level.SEVERE, "Slider with ID {0} not found", id);
            response.sendRedirect("listpost");
            return;
        }
        request.setAttribute("p", post);
        request.setAttribute("listpc", postCate);
        request.setAttribute("action", action);
        request.setAttribute("postlist", "active");
        request.setAttribute("post", "show");
        request.setAttribute("ecommerce", "show");
        request.getRequestDispatcher("Marketing/PostDetail.jsp").forward(request, response);
    }



    private void togglePostStatus(HttpServletRequest request, HttpServletResponse response, PostDAO dao) throws IOException {
        int id = Integer.parseInt(request.getParameter("postId"));
        Post post = dao.getPostByID(id);
        if (post == null) {
            LOGGER.log(Level.SEVERE, "Post with ID {0} not found", id);
            response.sendRedirect("listpost");
            return;
        }
        post.setShow(!post.isShow());
        dao.updatePost(post.getPostId(), post.getThumbnail(), post.getTitle(), post.getPcategory().getPostCId(), post.getStaff().getStaffID(), post.getBlogDetail(), post.isShow(), post.getShortDetail());
        response.sendRedirect("listpost");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        PostDAO dao = new PostDAO();

        if (action == null) {
            response.sendRedirect("listpost");
            return;
        }

        if ("update".equals(action)) {
            updatePost(request, response, dao);
        } else {
            response.sendRedirect("listpost");
        }
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response, PostDAO dao) throws IOException, ServletException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        String title = request.getParameter("title");
        int blogCId = Integer.parseInt(request.getParameter("blogCId"));
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String blog_detail = request.getParameter("blog_detail");
        boolean isShow = Boolean.parseBoolean(request.getParameter("isShow"));
        String blog_detail_short = request.getParameter("blog_detail_short");

        Part filePart = request.getPart("thumbnail");
        String fileName = getFileName(filePart);
        String thumbnail = null;

        if (fileName != null && !fileName.isEmpty()) {
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + "uploads";

            File uploadFolder = new File(uploadFilePath);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            filePart.write(uploadFilePath + File.separator + fileName);
            thumbnail = "uploads/" + fileName;
        }

        dao.updatePost(postId, thumbnail, title, blogCId, staffId, blog_detail, isShow, blog_detail_short);

        response.sendRedirect("listpost");
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}
