package dal;


import model.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MarketingDAO extends DBContext{

    public static void main(String[] args) {
        MarketingDAO dao = new MarketingDAO();
        String startDate = "2024-01-01";
        String endDate = "2024-12-31";
        List<OrderDetail> trends = dao.getTrendsofCustomers(startDate, endDate);

        for (OrderDetail orderDetail : trends) {
            System.out.println(orderDetail);
        }
    }
    public List<Post> getPosts(String startDate, String endDate) {
        List<Post> posts = new ArrayList<>();
        String sql = "select * from blog\n" +
                "where create_date between ? and ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post post = new Post(rs.getInt("post_id"),
                        rs.getString("thumbnail"),
                        rs.getString("title"));
                posts.add(post);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Product> getProducts(String startDate, String endDate) {
        List<Product> products = new ArrayList<>();
        String sql = "select * from product\n" +
                "where create_date between ? and ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(rs.getInt("product_id"),
                        rs.getDouble("price"),
                        rs.getString("product_name"),
                        rs.getString("image"));
                products.add(product);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Customer> getCustomers(String startDate, String endDate) {
        List<Customer> customers = new ArrayList<>();
        String sql = "select * from customer\n" +
                "where create_date between ? and ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer(rs.getInt("customer_id"),
                        rs.getString("email"),
                        rs.getString("fullname"));
                customers.add(customer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public List<Feedback> getFeedbacks(String startDate, String endDate) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "select * from feedback\n" +
                "where create_date between ? and ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback(rs.getInt(1));
                feedbacks.add(feedback);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public List<OrderDetail> getTrendsofCustomers(String startDate, String endDate) {
        List<OrderDetail> trends = new ArrayList<>();
        String sql = "SELECT TOP 5 p.product_id, p.product_name,\n" +
                "SUM(od.quantity) AS total_quantity\n" +
                "FROM orderdetail od\n" +
                "JOIN product p ON od.product_id = p.product_id\n" +
                "JOIN [order] o ON o.order_id = od.order_id\n" +
                "WHERE o.create_date BETWEEN ? AND ?\n" +
                "GROUP BY p.product_id, p.product_name\n" +
                "ORDER BY total_quantity DESC";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    String productName = rs.getString("product_name");
                    int totalQuantity = rs.getInt("total_quantity");

                    Product product = new Product(productId, productName);
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setProduct(product);
                    orderDetail.setQuantity(totalQuantity);

                    trends.add(orderDetail);
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return trends;
    }
}
