package dal;

import model.*;


import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO extends DBContext {

    public static void main(String[] args) {
        SaleDAO dao = new SaleDAO();
        List<Order> pendingAndconfirm = dao.getOrdersByStatusesAndCustomerId(2, 3, 8, 2);

        OrderDAO orderDAO = new OrderDAO();
        for (Order order : pendingAndconfirm) {
            System.out.println(order);
            if (order.getStatus().getId() == 8) {
                LocalDateTime currenTime = LocalDateTime.now();
                Duration duration = Duration.between(order.getCreatedDate().toLocalDateTime(), currenTime);
                if (duration.toHours() > 24) {
                    orderDAO.updateStatusOrder(String.valueOf(order.getId()), 7);
                }
                System.out.println(duration.toHours());
            }
        }
    }

    //Feedback
    public void insertFeedback(int customerID, int productID, String content, int rating, String image, int order_id, String create_date, int staff_id) {
        String sql = "INSERT INTO Feedback (customer_id, product_id, content, rating, imagePath, order_id, create_date, sale_id)\n" +
                "VALUES (?, ?, ?, ?, ?, ?, ?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            ps.setString(3, content);
            ps.setInt(4, rating);
            ps.setString(5, image);
            ps.setInt(6, order_id);
            ps.setString(7, create_date);
            ps.setInt(8, staff_id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static boolean hasFeedback(int customerId, int productId, int orderId) {
        String query = "SELECT COUNT(*) FROM Feedback WHERE customer_id = ? AND product_id = ? AND order_id = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.setInt(3, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static Feedback getFeedbackByOrderAndProduct(int orderId, int productId) {
        Feedback fb = null;
        String query = "SELECT f.Feedback_id, f.order_id, f.product_id, f.rating, f.content, p.product_name, p.image FROM Feedback f JOIN product p ON f.product_id = p.product_id  WHERE f.order_id = ? AND f.product_id = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                fb = new Feedback();
                Order od = new Order(rs.getInt("order_id"));
                fb.setFeedbackId(rs.getInt("Feedback_id"));
                fb.setOrderId(od);
                fb.setRating(rs.getInt("rating"));
                fb.setContent(rs.getString("content"));
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                fb.setProduct(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fb;
    }

    public static List<Feedback> getFeedbackByOrder(int orderId) {
        List<Feedback> FeedbackList = new ArrayList<>();
        String query = "SELECT f.Feedback_id, f.order_id, f.product_id, f.rating, f.content, p.product_name, p.image FROM Feedback f JOIN product p ON f.product_id = p.product_id  WHERE f.order_id = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                Order od = new Order(rs.getInt("order_id"));
                fb.setFeedbackId(rs.getInt("Feedback_id"));
                fb.setOrderId(od);

                fb.setRating(rs.getInt("rating"));
                fb.setContent(rs.getString("content"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                fb.setProduct(product);

                FeedbackList.add(fb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return FeedbackList;
    }

    //endFeedback

    public void updateStatusOrder(String order_id, int status_id) {
        LocalDateTime currenDate = LocalDateTime.now();
        String sql = "update [order]\n" +
                "set status_id = ?,\n" +
                "update_date = ?\n" +
                "where order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status_id);
            ps.setObject(2, currenDate);
            ps.setString(3, order_id);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<StatusOrder> getListStatusOrders() {
        String sql = "SELECT * FROM status_order " +
                "order by id ASC " +
                "OFFSET 0 ROWS FETCH NEXT 7 ROWS ONLY";
        List<StatusOrder> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new StatusOrder(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
        }
        return list;
    }


    public int getTotalOrders(String search, String status_id, String startDate, String endDate, int staff_id, int setTrue) {
        String sql = "select count(*)\n" +
                "from [order] o\n" +
                "where (o.status_id like ? and (o.sale_id = ? or ? = -1) and (o.create_date between ? and ? or ? = -1))\n" +
                "and (o.full_name like ? or o.order_id like ?) and o.status_id <> 8 \n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + status_id + "%");
            ps.setInt(2, staff_id);
            ps.setInt(3, staff_id);
            ps.setString(4, startDate);
            ps.setString(5, endDate);
            ps.setInt(6, setTrue);
            ps.setString(7, "%" + search + "%");
            ps.setString(8, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public int getIdSaleHaveLestOrder() {
        String sql = "SELECT o.sale_id, COUNT(o.sale_id) AS sale_count\n" +
                "FROM [order] o\n" +
                "JOIN staff s ON s.staff_id = o.sale_id\n" +
                "WHERE s.status = 1 AND o.status_id IN (1, 2, 4, 5)\n" +
                "GROUP BY o.sale_id\n" +
                "HAVING COUNT(o.sale_id) = (\n" +
                "    SELECT MIN(sale_count)\n" +
                "    FROM (\n" +
                "        SELECT COUNT(sale_id) AS sale_count\n" +
                "        FROM [order]\n" +
                "        JOIN staff ON staff.staff_id = [order].sale_id\n" +
                "        WHERE staff.status = 1 AND [order].status_id IN (1, 2, 4, 5)\n" +
                "        GROUP BY sale_id\n" +
                "    ) AS sale_counts\n" +
                ");\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public List<Order> getListOrders(int offset, int limit, String search, String sortBy, String sortOrder, String status_id, String startDate, String endDate, String staff_id, int setTrue) {
        List<Order> orders = new ArrayList<>();

        AdminDAO adminDAO = new AdminDAO();
        OrderDAO orderDAO = new OrderDAO();
        String sql = "select *\n" +
                "from [order] o\n" +
                "where (o.status_id like ? and (o.sale_id like ? or ? = -1) and (o.create_date between ? and ? or ? = -1))\n" +
                "and (o.full_name like ? or o.order_id like ?) and o.status_id <> 8 \n" +
                "ORDER BY " + sortBy + " " + sortOrder + " " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + status_id + "%");
            ps.setString(2, "%" + staff_id + "%");
            ps.setString(3, staff_id);
            ps.setString(4, startDate);
            ps.setString(5, endDate);
            ps.setInt(6, setTrue);
            ps.setString(7, "%" + search + "%");
            ps.setString(8, "%" + search + "%");
            ps.setInt(9, offset);
            ps.setInt(10, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(new Order(rs.getInt("order_id"),
                        rs.getInt("customer_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("phone_number"),
                        orderDAO.getPaymentMethodById(rs.getInt("payment_id")),
                        rs.getString("note"),
                        orderDAO.getStatusOrderById(rs.getInt("status_id")),
                        rs.getTimestamp("create_date"),
                        rs.getTimestamp("update_date"),
                        adminDAO.getStaffById(rs.getString("sale_id")),
                        orderDAO.getListOrderDetails(rs.getInt("order_id"))));
            }
        } catch (SQLException e) {
        }
        if (orders.isEmpty()) {
            return null;
        }
        return orders;
    }

    public List<OrderDetail> getListOrderDetails(int order_id) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        SaleDAO saleDAO = new SaleDAO();
        String sql = "Select *\n" +
                "from orderdetail o\n" +
                "where o.order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, order_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderDetails.add(new OrderDetail(saleDAO.getOrderById(rs.getInt("order_id")),
                        productDAO.getProductById(rs.getInt("product_id")),
                        rs.getInt("quantity"),
                        rs.getDouble("price")));
            }
        } catch (SQLException e) {
        }
        return orderDetails;
    }

    public List<Order> getOrdersByCustomerId(int customerId, int currentPage, int itemsPerPage, String sortBy, String sortOrder) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.customer_id, pm.payment, o.note, so.status, o.create_date, o.update_date, o.full_name, o.email, o.address, o.phone_number, "
                + "od.order_id as od_order_id, od.quantity, od.price, "
                + "p.product_id, p.product_name, p.image "
                + "FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "JOIN product p ON od.product_id = p.product_id "
                + "JOIN Status_Order so ON o.status_id = so.id "
                + "JOIN Payment_Method pm ON o.payment_id = pm.id "
                + "WHERE o.customer_id = ? "
                + "ORDER BY " + sortBy + " " + sortOrder + " "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setInt(2, (currentPage - 1) * itemsPerPage);
            ps.setInt(3, itemsPerPage);
            ResultSet rs = ps.executeQuery();
            Order order = null;
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                if (order == null || order.getId() != orderId) {
                    order = new Order();
                    order.setId(orderId);
                    int customerIdCheck = rs.getInt("customer_id");
                    if (!rs.wasNull()) {
                        order.setCustomerId(customerIdCheck);
                    }

                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setMethod(rs.getString("payment"));
                    order.setPaymentMethod(paymentMethod);

                    StatusOrder statusOrder = new StatusOrder();
                    statusOrder.setStatus(rs.getString("status"));
                    order.setStatus(statusOrder);

                    order.setNote(rs.getString("note"));
                    order.setFullName(rs.getString("full_name"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setPhone(rs.getString("phone_number"));
                    order.setCreatedDate(rs.getTimestamp("create_date"));
                    order.setUpdatedDate(rs.getTimestamp("update_date"));
                    orders.add(order);
                }

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getDouble("price"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                orderDetail.setProduct(product);

                order.getOrderDetails().add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }


    public PaymentMethod getPaymentMethodById(int id) {
        String sql = "Select * from [payment_method] where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PaymentMethod(rs.getInt("id"), rs.getString("payment"));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public StatusOrder getStatusOrderById(int id) {
        String sql = "Select * from [status_order] where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new StatusOrder(rs.getInt("id"), rs.getString("status"));
            }
        } catch (SQLException e) {

        }
        return null;
    }


    public int getTotalOrdersCount(int customerId) {
        String sql = "SELECT COUNT(*) as total FROM [order] WHERE customer_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public Order getOrderById(int orderId) {
        Order order = null;
        OrderDAO orderDAO = new OrderDAO();
        String sql = "SELECT o.order_id, o.customer_id, o.payment_id, o.note, o.status_id, o.create_date, o.update_date, o.full_name, o.email, o.address, o.phone_number, "
                + "od.order_id as od_order_id, od.quantity, od.price, "
                + "p.product_id, p.product_name, p.image "
                + "FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "JOIN product p ON od.product_id = p.product_id "
                + "WHERE o.order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (order == null) {
                    order = new Order();
                    order.setId(rs.getInt("order_id"));
                    order.setCustomerId(rs.getInt("customer_id"));
                    order.setPaymentMethod(orderDAO.getPaymentMethodById(rs.getInt("payment_id")));
                    order.setNote(rs.getString("note"));
                    order.setStatus(orderDAO.getStatusOrderById(rs.getInt("status_id")));
                    order.setFullName(rs.getString("full_name"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setPhone(rs.getString("phone_number"));
                    order.setCreatedDate(rs.getTimestamp("create_date"));
                    order.setUpdatedDate(rs.getTimestamp("update_date"));
                }

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getDouble("price"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                orderDetail.setProduct(product);

                order.getOrderDetails().add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public int getTotalOrderProcessingBySaleID(int saleId) {
        String sql = "SELECT COUNT(*)\n" +
                "FROM [order]\n" +
                "WHERE sale_id = ? AND status_id IN (1, 2, 4, 5);\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, saleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public List<Order> getOrdersByStatus(String status, Date startDate, Date endDate) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM [order] o "
                + "JOIN status_order s ON o.status_id = s.id "
                + "WHERE s.status = ? AND o.create_date BETWEEN ? AND ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setDate(2, startDate);
            statement.setDate(3, endDate);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setFullName(rs.getString("full_name"));
                order.setEmail(rs.getString("email"));
                order.setAddress(rs.getString("address"));
                order.setPhone(rs.getString("phone_number"));
                PaymentMethod p = new PaymentMethod(rs.getInt("payment_id"), "");
                order.setPaymentMethod(p);
                order.setNote(rs.getString("note"));
                StatusOrder statusOrder = new StatusOrder(rs.getInt("status_id"), null);
                order.setStatus(statusOrder);
                order.setCreatedDate(rs.getTimestamp("create_date"));
                order.setUpdatedDate(rs.getTimestamp("update_date"));
                orders.add(order);
            }
        } catch (Exception e) {
            System.out.println("getOrdersByStatus: " + e);
        }
        return orders;
    }

    public double getTotalRevenue(Date startDate, Date endDate) {
        double totalRevenue = 0;
        String sql = "SELECT SUM(od.price * od.quantity) as totalRevenue FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "WHERE o.create_date BETWEEN ? AND ? and o.status_id=4";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, startDate);
            statement.setDate(2, endDate);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                totalRevenue = rs.getDouble("totalRevenue");
            }
        } catch (Exception e) {
            System.out.println("getTotalRevenue: " + e);
        }
        return totalRevenue;
    }

    public double getRevenueByCategory(int categoryId, Date startDate, Date endDate) {
        double revenue = 0;
        String sql = "SELECT SUM(od.price * od.quantity) as categoryRevenue FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "JOIN product p ON od.product_id = p.product_id "
                + "WHERE p.cid = ? AND o.create_date BETWEEN ? AND ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            statement.setDate(2, startDate);
            statement.setDate(3, endDate);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("categoryRevenue");
            }
        } catch (Exception e) {
            System.out.println("getRevenueByCategory: " + e);
        }
        return revenue;
    }

    public Map<Date, Integer> getSuccessfulOrderCountsByDay(Date startDate, Date endDate) {
        Map<Date, Integer> orderTrend = new HashMap<>();
        String sql = "SELECT CAST(create_date AS DATE) AS orderDate, COUNT(*) AS orderCount "
                + "FROM [order] "
                + "WHERE create_date BETWEEN ? AND ? AND status_id = (SELECT id FROM status_order WHERE status = 'Completed') "
                + "GROUP BY CAST(create_date AS DATE)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, startDate);
            statement.setDate(2, endDate);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                orderTrend.put(rs.getDate("orderDate"), rs.getInt("orderCount"));
            }
        } catch (Exception e) {
            System.out.println("getSuccessfulOrderCountsByDay: " + e);
        }
        return orderTrend;
    }

}
