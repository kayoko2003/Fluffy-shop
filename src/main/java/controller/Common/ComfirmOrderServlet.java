package controller.Common;

import java.io.*;
import java.net.URLEncoder;
import java.nio.file.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;

@WebServlet(name = "ComfirmOrderServlet", value = "/comfirmorder")
@MultipartConfig
public class ComfirmOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("acc");
        String productIdsParam = request.getParameter("productIds");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String ratingStr = request.getParameter("rating");
        String feedback = request.getParameter("feedback");
        int order_id = Integer.parseInt(request.getParameter("orderId"));
//        String create_date = request.getParameter("create_date");

        int staff_id = Integer.parseInt(request.getParameter("staffId"));

        if (productIdsParam == null || productIdsParam.isEmpty() || ratingStr == null || ratingStr.isEmpty()) {
            out.println("Required parameters are missing.");
            return;
        }

        int rating = Integer.parseInt(ratingStr);
        Part filePart = request.getPart("image");
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = "";

        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = originalFileName.substring(dotIndex);
            originalFileName = originalFileName.substring(0, dotIndex);
        }

        // Thêm timestamp vào tên tệp để tạo tên tệp duy nhất
        String timeStamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String fileName = originalFileName + "_" + timeStamp + fileExtension;

        String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        String filePath = uploadDir + File.separator + fileName;

        // Kiểm tra kích thước tệp
        long fileSize = filePart.getSize();
        if (fileSize > 10 * 1024 * 1024) { // Giới hạn kích thước tệp là 10 MB
            out.println("Kích thước tệp quá lớn.");
            return;
        }

        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            out.println("Lỗi khi tải lên tệp: " + e.getMessage());
            e.printStackTrace();
            return;
        }
        LocalDate currenDate = java.time.LocalDate.now();
        String date = currenDate.toString();

        // Tách chuỗi productIdsParam thành mảng các productId
        String[] productIds = productIdsParam.split(",");
        OrderDAO dao = new OrderDAO();
        for (String productId : productIds) {
            dao.insertFeedback(customer.getCustomerID(), Integer.parseInt(productId.trim()), feedback, rating, filePath, order_id, date, staff_id);
        }
        String feedbacksuccess = "Sản phẩm bạn đã được đánh giá";
        response.sendRedirect("orders?feedbacksuccess=" + URLEncoder.encode(feedbacksuccess, "UTF-8"));
    }
}
