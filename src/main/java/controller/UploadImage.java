package controller;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "UploadImage", value = "/uploadimage")
@MultipartConfig
public class UploadImage extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "src/main/webapp/Static_access_manager/assets/img";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Part filePart = request.getPart("coverImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Get the absolute path to the specified folder
        String uploadsFolderPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploads = new File(UPLOAD_DIRECTORY);
        if (!uploads.exists()) {
            uploads.mkdirs();
        }
        File file = new File(uploads, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath());
        }

        // Construct the image URL to be used in the application
        String imageUrl = request.getContextPath() + "/" + UPLOAD_DIRECTORY + "/" + fileName;
        request.setAttribute("imageUrl", imageUrl);

        request.getRequestDispatcher("Admin/StaffDetail.jsp").forward(request, response);
    }
}