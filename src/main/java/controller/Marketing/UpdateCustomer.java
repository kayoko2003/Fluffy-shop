package controller.Marketing;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Customer;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "UpdateCustomer", value = "/updatecustomer")
public class UpdateCustomer extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UpdateCustomer.class);
    private static final Gson gson = new Gson();

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        String cid = request.getParameter("cid");
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String genderStr = request.getParameter("gender");
        Boolean gender = "male".equalsIgnoreCase(genderStr);
        String phoneNumber = request.getParameter("phoneNumber");
        String dob = request.getParameter("dob");

//        String img = "https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png";
        String img = null;
        Part part = request.getPart("customerImage");
        if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()){
            String basePath = getServletContext().getRealPath("/Static_access_manager/assets/img/customers/");
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
            img = "Static_access_manager/assets/img/customers/" + fileName;
        }

        LocalDate dateOfBirth = null;
        if (dob != null && !dob.isEmpty()) {
            try {
                dateOfBirth = LocalDate.parse(dob);
            } catch (DateTimeParseException e) {
                request.setAttribute("error", "Invalid date format for date of birth");
                request.getRequestDispatcher("Marketing/CustomerDetail.jsp").forward(request, response);
                return;
            }
        }

        LocalDate updateDate = LocalDate.now();
        String status = "Active";

        CustomerDAO dao = new CustomerDAO();
        Customer oldCustomer = dao.getCustomerById(cid);
        if (oldCustomer == null) {
            request.setAttribute("error", "Customer not found");
            request.getRequestDispatcher("Marketing/CustomerDetail.jsp").forward(request, response);
            return;
        }

        Customer newCustomer = new Customer(
                oldCustomer.getCustomerID(), oldCustomer.getEmail(), oldCustomer.getPassword(), fullname, address,
                gender, phoneNumber, dateOfBirth, oldCustomer.getCreateDate(), updateDate, oldCustomer.getToken(), status, img, oldCustomer.getLog()
        );

        String newChangesLog = logChanges(oldCustomer, newCustomer, updateDate);

        if (newChangesLog != null) {
            Type listType = new TypeToken<List<Map<String, String>>>() {}.getType();
            List<Map<String, String>> existingLog;

            try {
                existingLog = gson.fromJson(oldCustomer.getLog(), listType);
            } catch (JsonSyntaxException e) {
                Map<String, String> singleLog = gson.fromJson(oldCustomer.getLog(), new TypeToken<Map<String, String>>() {}.getType());
                existingLog = new ArrayList<>();
                existingLog.add(singleLog);
            }

            if (existingLog == null) {
                existingLog = new ArrayList<>();
            }

            List<Map<String, String>> newLogEntries = gson.fromJson(newChangesLog, listType);
            existingLog.addAll(newLogEntries);

            String updatedLog = gson.toJson(existingLog);
            newCustomer.setLog(updatedLog);
            dao.updateCustomer(fullname, address, gender, phoneNumber, dateOfBirth, updateDate, status, img, updatedLog, cid);
        }

        List<String> logs = dao.getCustomerLogs(cid);
        request.setAttribute("customer", newCustomer);
        request.setAttribute("logs", logs);
        request.setAttribute("ecommerce", "show");
        request.setAttribute("activeCustom", "active");
        request.getRequestDispatcher("Marketing/CustomerDetail.jsp").forward(request, response);
    }

    private String logChanges(Customer oldCustomer, Customer newCustomer, LocalDate updateDate) {
        List<Map<String, String>> changes = new ArrayList<>();

        if (!oldCustomer.getFullname().equals(newCustomer.getFullname())) {
            Map<String, String> change = new HashMap<>();
            change.put("field", "fullname");
            change.put("old", oldCustomer.getFullname());
            change.put("new", newCustomer.getFullname());
            change.put("updateTime", updateDate.toString());
            changes.add(change);
        }
        if (!oldCustomer.getAddress().equals(newCustomer.getAddress())) {
            Map<String, String> change = new HashMap<>();
            change.put("field", "address");
            change.put("old", oldCustomer.getAddress());
            change.put("new", newCustomer.getAddress());
            change.put("updateTime", updateDate.toString());
            changes.add(change);
        }
        if (oldCustomer.getGender() != newCustomer.getGender()) {
            Map<String, String> change = new HashMap<>();
            change.put("field", "gender");
            change.put("old", oldCustomer.isGender() ? "Male" : "Female");
            change.put("new", newCustomer.isGender() ? "Male" : "Female");
            change.put("updateTime", updateDate.toString());
            changes.add(change);
        }
        if (!oldCustomer.getPhoneNumber().equals(newCustomer.getPhoneNumber())) {
            Map<String, String> change = new HashMap<>();
            change.put("field", "phoneNumber");
            change.put("old", oldCustomer.getPhoneNumber());
            change.put("new", newCustomer.getPhoneNumber());
            change.put("updateTime", updateDate.toString());
            changes.add(change);
        }
        if (!oldCustomer.getDob().equals(newCustomer.getDob())) {
            Map<String, String> change = new HashMap<>();
            change.put("field", "dob");
            change.put("old", oldCustomer.getDob().toString());
            change.put("new", newCustomer.getDob().toString());
            change.put("updateTime", updateDate.toString());
            changes.add(change);
        }
        if (oldCustomer.getImg() != null && !oldCustomer.getImg().equals(newCustomer.getImg())) {
            Map<String, String> change = new HashMap<>();
            change.put("field", "img");
            change.put("message", "Update image");
            change.put("updateTime", updateDate.toString());
            changes.add(change);
        }

        return gson.toJson(changes);
    }
}
