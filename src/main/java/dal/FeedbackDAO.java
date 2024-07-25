package dal;

import model.Customer;
import model.Feedback;
import model.Product;
import model.Staff;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {

    public int getTotalFeedBack(String search, int product, int customer, int rating) {
        String sql = "SELECT COUNT(*) FROM feedback f " +
                "JOIN customer c ON f.customer_id = c.customer_id " +
                "JOIN product p ON f.product_id = p.product_id " +
                "WHERE (f.product_id = ? OR ? = -1) AND (f.customer_id = ? OR ? = -1) AND (f.rating = ? OR ? = -1) AND (c.fullname LIKE ? OR p.product_name LIKE ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, product);
            ps.setInt(2, product);
            ps.setInt(3, customer);
            ps.setInt(4, customer);
            ps.setInt(5, rating);
            ps.setInt(6, rating);
            ps.setString(7, "%" + search + "%");
            ps.setString(8, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Feedback> getAllFeedback(int currentPage, int itemsPerPage, String sortBy, String search, int product, int customer, int rating, String sortOrder) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT f.feedback_id, f.content, f.rating, f.create_date, f.delete_date, f.is_delete, f.imagePath, " +
                "c.fullname AS customer_fullname, c.avatar AS customer_avatar, c.customer_id, " +
                "p.product_id, p.image AS product_image, p.product_name, " +
                "s.staff_id AS sale_staff_id, s.fullname AS sale_fullname, s.avatar AS sale_avatar, " +
                "d.staff_id AS delete_staff_id, d.fullname AS delete_fullname, d.avatar AS delete_avatar " +
                "FROM feedback f " +
                "JOIN customer c ON f.customer_id = c.customer_id " +
                "JOIN product p ON f.product_id = p.product_id " +
                "JOIN staff s ON f.sale_id = s.staff_id " +
                "LEFT JOIN staff d ON f.delete_by = d.staff_id " +
                "WHERE (f.product_id = ? OR ? = -1) AND (f.customer_id = ? OR ? = -1) AND (f.rating = ? OR ? = -1) AND (c.fullname LIKE ? OR p.product_name LIKE ?) " +
                "ORDER BY " + sortBy + " " + sortOrder + " " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, product);
            ps.setInt(2, product);
            ps.setInt(3, customer);
            ps.setInt(4, customer);
            ps.setInt(5, rating);
            ps.setInt(6, rating);
            ps.setString(7, "%" + search + "%");
            ps.setString(8, "%" + search + "%");
            ps.setInt(9, (currentPage - 1) * itemsPerPage);
            ps.setInt(10, itemsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setCreatedDate(rs.getDate("create_date"));
                feedback.setDeletedDate(rs.getDate("delete_date"));
                feedback.setDeleted(rs.getBoolean("is_delete"));
                feedback.setImagePath(rs.getString("imagePath"));

                Customer customerObj = new Customer();
                customerObj.setCustomerID(rs.getInt("customer_id"));
                customerObj.setFullname(rs.getString("customer_fullname"));
                customerObj.setImg(rs.getString("customer_avatar"));
                feedback.setCustomer(customerObj);

                Product productObj = new Product();
                productObj.setId(rs.getInt("product_id"));
                productObj.setImg(rs.getString("product_image"));
                productObj.setName(rs.getString("product_name"));
                feedback.setProduct(productObj);

                Staff staffObj = new Staff();
                staffObj.setStaffID(rs.getInt("sale_staff_id"));
                staffObj.setFullname(rs.getString("sale_fullname"));
                staffObj.setAvatar(rs.getString("sale_avatar"));
                feedback.setSale(staffObj);

                Staff deletedByObj = new Staff();
                if (rs.getString("delete_staff_id") != null) {
                    deletedByObj.setStaffID(rs.getInt("delete_staff_id"));
                    deletedByObj.setFullname(rs.getString("delete_fullname"));
                    deletedByObj.setAvatar(rs.getString("delete_avatar"));
                    feedback.setDeletedBy(deletedByObj);
                }

                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }


    public void deleteFeedback(int id, int staffID) {
        String sql = "UPDATE feedback SET is_delete = 1, delete_by = ? WHERE feedback_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, staffID);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void restoreFeedback(int id, int staffID) {
        String sql = "UPDATE feedback SET is_delete = 0, delete_by = NULL WHERE feedback_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Feedback getFeedbackById(int parseInt) {
        String sql = "SELECT f.feedback_id, f.content, f.rating, f.create_date, f.delete_date, f.is_delete, f.content, f.imagePath, " +
                "c.fullname AS customer_fullname, c.avatar AS customer_avatar, c.customer_id, c.email AS customer_email, c.phone_number AS customer_phone, c.address AS customer_address, c.email AS customer_email, c.gender AS customer_gender, c.dob AS customer_birthday, " +
                "p.product_id, p.image AS product_image, p.product_name, " +
                "s.staff_id AS sale_staff_id, s.fullname AS sale_fullname, s.avatar AS sale_avatar, " +
                "d.staff_id AS delete_staff_id, d.fullname AS delete_fullname, d.avatar AS delete_avatar " +
                "FROM feedback f " +
                "JOIN customer c ON f.customer_id = c.customer_id " +
                "JOIN product p ON f.product_id = p.product_id " +
                "JOIN staff s ON f.sale_id = s.staff_id " +
                "LEFT JOIN staff d ON f.delete_by = d.staff_id " +
                "WHERE f.feedback_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, parseInt);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setCreatedDate(rs.getDate("create_date"));
                feedback.setDeletedDate(rs.getDate("delete_date"));
                feedback.setDeleted(rs.getBoolean("is_delete"));
                feedback.setContent(rs.getString("content"));
                feedback.setImagePath(rs.getString("imagePath"));

                Customer customerObj = new Customer();
                customerObj.setCustomerID(rs.getInt("customer_id"));
                customerObj.setFullname(rs.getString("customer_fullname"));
                customerObj.setImg(rs.getString("customer_avatar"));
                customerObj.setEmail(rs.getString("customer_email"));
                customerObj.setPhoneNumber(rs.getString("customer_phone"));
                customerObj.setAddress(rs.getString("customer_address"));
                customerObj.setGender(rs.getBoolean("customer_gender"));
                customerObj.setDob(rs.getDate("customer_birthday").toLocalDate());
                feedback.setCustomer(customerObj);

                Product productObj = new Product();
                productObj.setId(rs.getInt("product_id"));
                productObj.setImg(rs.getString("product_image"));
                productObj.setName(rs.getString("product_name"));
                feedback.setProduct(productObj);

                Staff staffObj = new Staff();
                staffObj.setStaffID(rs.getInt("sale_staff_id"));
                staffObj.setFullname(rs.getString("sale_fullname"));
                staffObj.setAvatar(rs.getString("sale_avatar"));
                feedback.setSale(staffObj);

                Staff deletedByObj = new Staff();
                if (rs.getString("delete_staff_id") != null) {
                    deletedByObj.setStaffID(rs.getInt("delete_staff_id"));
                    deletedByObj.setFullname(rs.getString("delete_fullname"));
                    deletedByObj.setAvatar(rs.getString("delete_avatar"));
                    feedback.setDeletedBy(deletedByObj);
                }
                return feedback;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public double getAverageRating() {
        double averageRating = 0;
        String sql = "SELECT AVG(1) as avgRating FROM feedback WHERE is_delete = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                averageRating = rs.getDouble("avgRating");
            }
        } catch (Exception e) {
            System.out.println("getAverageRating: " + e);
        }
        return averageRating;
    }

    public double getAverageRatingByCategory(int categoryId) {
        double averageRating = 0;
        String sql = "SELECT AVG(1) as avgRating FROM feedback f JOIN product p ON f.product_id = p.product_id WHERE p.cid = ? AND f.is_delete = 0";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                averageRating = rs.getDouble("avgRating");
            }
        } catch (Exception e) {
            System.out.println("getAverageRatingByCategory: " + e);
        }
        return averageRating;
    }

}
