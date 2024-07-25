package controller.Marketing;

import dal.SliderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Slider;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(name = "ListSlider", value = "/listslider")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ListSlider extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ListSlider.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        SliderDAO dao = new SliderDAO();

        if (action == null) {
            listSliders(request, response, dao);
        } else {
            switch (action) {
                case "view":
                case "edit":
                    viewOrEditSlider(request, response, dao, action);
                    break;
                case "toggle":
                    toggleSliderStatus(request, response, dao);
                    break;
                default:
                    listSliders(request, response, dao);
                    break;
            }
        }
    }

    private void listSliders(HttpServletRequest request, HttpServletResponse response, SliderDAO dao) throws ServletException, IOException {
        int currentPage = 1;
        int itemsPerPage = 3;

        try {
            if (request.getParameter("currentPage") != null) {
                currentPage = Integer.parseInt(request.getParameter("currentPage"));
            }
            if (request.getParameter("itemsPerPage") != null) {
                itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid number format for pagination parameters", e);
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        String search = request.getParameter("txt") != null ? request.getParameter("txt") : "";

        Boolean status = null;
        if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
            status = Boolean.parseBoolean(request.getParameter("status"));
        }

        int total = dao.getTotalSliderCount(search, status);
        int totalPages = (int) Math.ceil((double) total / itemsPerPage);
        currentPage = Math.min(currentPage, totalPages);

        List<Slider> sliders = dao.listAllSlider(currentPage, itemsPerPage, search, status);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("listsliders", sliders);
        request.setAttribute("total", total);
        request.setAttribute("activeSlider", "active");
        request.setAttribute("ecommerce", "show");

        request.getRequestDispatcher("Marketing/ListSlider.jsp").forward(request, response);
    }

    private void viewOrEditSlider(HttpServletRequest request, HttpServletResponse response, SliderDAO dao, String action) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Slider slider = dao.getSliderById(id);
        if (slider == null) {
            LOGGER.log(Level.SEVERE, "Slider with ID {0} not found", id);
            response.sendRedirect("listslider");
            return;
        }
        request.setAttribute("slider", slider);
        request.setAttribute("action", action);
        request.getRequestDispatcher("Marketing/SliderDetail.jsp").forward(request, response);
    }

    private void toggleSliderStatus(HttpServletRequest request, HttpServletResponse response, SliderDAO dao) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Slider slider = dao.getSliderById(id);
        if (slider == null) {
            LOGGER.log(Level.SEVERE, "Slider with ID {0} not found", id);
            response.sendRedirect("listslider");
            return;
        }
        slider.setStatus(!slider.isStatus());
        dao.updateSlider(slider);
        response.sendRedirect("listslider");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        SliderDAO dao = new SliderDAO();

        if (action == null) {
            response.sendRedirect("listslider");
            return;
        }

        if ("update".equals(action)) {
            updateSlider(request, response, dao);
        } else {
            response.sendRedirect("listslider");
        }
    }

    private void updateSlider(HttpServletRequest request, HttpServletResponse response, SliderDAO dao) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        String note = request.getParameter("note");

        String image = null;
        Part part = request.getPart("sliderImage");
        if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
            String basePath = getServletContext().getRealPath("/Static_access_manager/assets/img/sliders/");
            String fileName = part.getSubmittedFileName();
            File directory = new File(basePath);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            try {
                part.write(basePath + fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
            image = "Static_access_manager/assets/img/sliders/" + fileName;
        }

        Slider slider = new Slider(id, title, image, backlink, status, note);
        dao.updateSlider(slider);

        response.sendRedirect("listslider");
    }
}
