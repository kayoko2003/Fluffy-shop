package dal;

import model.*;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import java.sql.*;
import java.util.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static java.lang.System.out;

public class SaleDAO extends DBContext {

    private static final Logger log = Logger.getLogger(SaleDAO.class);

    public static void main(String[] args) throws SQLException {
        SaleDAO dao = new SaleDAO();
        List<OrderDetail> pc = dao.getOrderDetailById(3);

        dao.updateOrderStatus(5, 4);
        // StatusOrder pc = dao.getStatusOrderById(1);
        //  PaymentMethod pc = dao.getPaymentById(2);
//       List<Order>  order = dao.getOrdersByStatusesAndCustomerId(2,1,2);
//         List<StatusOrder> statusOrder = dao.getListStatus();
//
//        System.out.println(order);
        JSONObject js = SaleDAO.fetchOrderTrendData("2024-06-14", "2024-07-14", "", "");
        System.out.println(js.toString(7));

    }

    //sale dashboard
    public static List<String> fetchSalesPersons() {
        List<String> salesPersons = new ArrayList<>();
        try (
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT DISTINCT sale_id FROM dbo.order")) {
            while (rs.next()) {
                salesPersons.add(rs.getString("sale_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesPersons;
    }

    public static JSONObject fetchOrderTrendData(String startDate, String endDate, String salesPerson, String orderStatus) {
        JSONObject data = new JSONObject();
        List<String> labels = new ArrayList<>();
        List<Integer> successOrders = new ArrayList<>();
        List<Integer> processingOrders = new ArrayList<>();
        List<Integer> cancelledOrders = new ArrayList<>();

        String query = "SELECT create_date as date, " +
                " SUM(CASE WHEN status_id = 6 THEN 1 ELSE 0 END) as success_orders, " + // Assuming 1 is the ID for success status
                " SUM(CASE WHEN status_id = 3 THEN 1 ELSE 0 END) as processing_orders, " + // Assuming 2 is the ID for processing status
                " SUM(CASE WHEN status_id = 7 THEN 1 ELSE 0 END) as cancelled_orders " + // Assuming 3 is the ID for cancelled status
                "FROM [order] WHERE create_date BETWEEN ? AND ? " +
                (salesPerson.equals("") ? "" : "AND sale_id = ? ") +
                (orderStatus.equals("") ? "" : "AND status_id = ? ") +
                "GROUP BY create_date ORDER BY create_date";
        try (
                PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            int index = 3;
            if (!salesPerson.equals("")) {
                ps.setString(index++, salesPerson);
            }
            if (!orderStatus.equals("")) {
                ps.setString(index, orderStatus);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    labels.add(rs.getString("date"));
                    successOrders.add(rs.getInt("success_orders"));
                    processingOrders.add(rs.getInt("processing_orders"));
                    cancelledOrders.add(rs.getInt("cancelled_orders"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        data.put("labels", labels);
        data.put("successOrders", successOrders);
        data.put("processingOrders", processingOrders);
        data.put("cancelledOrders", cancelledOrders);
        return data;
    }

    public static JSONObject fetchRevenueTrendData(String startDate, String endDate, String salesPerson, String orderStatus) {
        JSONObject data = new JSONObject();
        List<String> labels = new ArrayList<>();
        List<Integer> revenue = new ArrayList<>();

        String query = "SELECT create_date as date, SUM(total_price) as revenue " +
                "FROM [order] WHERE create_date BETWEEN ? AND ? " +
                (salesPerson.equals("") ? "" : "AND sale_id = ? ") +
                (orderStatus.equals("") ? "" : "AND status_id = ? ") +
                "GROUP BY create_date ORDER BY create_date";
        try (
                PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            int index = 3;
            if (!salesPerson.equals("")) {
                ps.setString(index++, salesPerson);
            }
            if (!orderStatus.equals("")) {
                ps.setString(index, orderStatus);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    labels.add(rs.getString("date"));
                    revenue.add(rs.getInt("revenue"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        data.put("labels", labels);
        data.put("revenue", revenue);
        return data;
    }
    //end sale dashboard

    public List<Order> getOrdersByCustomerId(int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.customer_id, o.payment_id, o.note, o.status_id, o.create_date, o.update_date, o.full_name, o.email, o.address, o.phone_number, o.total_price, o.sale_note, o.sale_id, "
                + "od.order_id as od_order_id, od.quantity, od.price, "
                + "p.product_id, p.product_name, p.image ,p.description "
                + "FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "JOIN product p ON od.product_id = p.product_id "
                + "WHERE o.customer_id = ? "
                + "ORDER BY o.create_date DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Order> orderMap = new HashMap<>(); // To track existing orders

            while (rs.next()) {
                int currentOrderId = rs.getInt("order_id");
                Order order = orderMap.get(currentOrderId);

                if (order == null) {
                    order = new Order();
                    AdminDAO dao = new AdminDAO();
                    Staff staff = dao.getStaffById(rs.getString("sale_id"));
                    StatusOrder status = getStatusOrderById(rs.getInt("status_id"));
                    PaymentMethod payment = getPaymentById(rs.getInt("payment_id"));

                    order.setId(currentOrderId);
                    order.setCustomerId(rs.getInt("customer_id"));
                    order.setPaymentMethod(payment);
                    order.setNote(rs.getString("note"));
                    order.setStatus(status);
                    order.setFullName(rs.getString("full_name"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setPhone(rs.getString("phone_number"));
                    order.setSaleNote(rs.getString("sale_note"));
                    order.setStaff(staff);
                    order.setCreatedDate(rs.getTimestamp("create_date"));
                    order.setUpdatedDate(rs.getTimestamp("update_date"));

                    // Initialize the list of OrderDetails
                    order.setOrderDetails(new ArrayList<>());

                    orderMap.put(currentOrderId, order);
                    orders.add(order);
                }

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getDouble("price"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                orderDetail.setProduct(product);

                order.getOrderDetails().add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersByStatusAndCustomerId(int statusId, int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.customer_id, o.payment_id, o.note, o.status_id, o.create_date, o.update_date, o.full_name, o.email, o.address, o.phone_number, o.total_price, o.sale_note, o.sale_id, "
                + "od.order_id as od_order_id, od.quantity, od.price, "
                + "p.product_id, p.product_name, p.image, p.description "
                + "FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "JOIN product p ON od.product_id = p.product_id "
                + "WHERE o.status_id = ? AND o.customer_id = ? " +
                "ORDER BY o.update_date desc ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, statusId);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Order> orderMap = new HashMap<>(); // To track existing orders

            while (rs.next()) {
                int currentOrderId = rs.getInt("order_id");
                Order order = orderMap.get(currentOrderId);

                if (order == null) {
                    order = new Order();
                    AdminDAO dao = new AdminDAO();
                    Staff staff = dao.getStaffById(rs.getString("sale_id"));
                    StatusOrder status = getStatusOrderById(rs.getInt("status_id"));
                    PaymentMethod payment = getPaymentById(rs.getInt("payment_id"));

                    order.setId(currentOrderId);
                    order.setCustomerId(rs.getInt("customer_id"));
                    order.setPaymentMethod(payment);
                    order.setNote(rs.getString("note"));
                    order.setStatus(status);
                    order.setFullName(rs.getString("full_name"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setPhone(rs.getString("phone_number"));
                    order.setSaleNote(rs.getString("sale_note"));
                    order.setStaff(staff);
                    order.setCreatedDate(rs.getTimestamp("create_date"));
                    order.setUpdatedDate(rs.getTimestamp("update_date"));

                    // Initialize the list of OrderDetails
                    order.setOrderDetails(new ArrayList<>());

                    orderMap.put(currentOrderId, order);
                    orders.add(order);
                }

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getDouble("price"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                orderDetail.setProduct(product);

                order.getOrderDetails().add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersByStatusesAndCustomerId(int statusId1, int statusId2, int statusId3, int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.customer_id, o.payment_id, o.note, o.status_id, o.create_date, o.update_date, o.full_name, o.email, o.address, o.phone_number, o.total_price, o.sale_note, o.sale_id, "
                + "od.order_id as od_order_id, od.quantity, od.price, "
                + "p.product_id, p.product_name, p.image, p.description "
                + "FROM [order] o "
                + "JOIN orderdetail od ON o.order_id = od.order_id "
                + "JOIN product p ON od.product_id = p.product_id "
                + "WHERE (o.status_id = ? OR o.status_id = ? OR o.status_id = ?) AND o.customer_id = ? " +
                "ORDER BY o.update_date desc ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, statusId1);
            ps.setInt(2, statusId1);
            ps.setInt(3, statusId3);
            ps.setInt(4, customerId);
            ResultSet rs = ps.executeQuery();

            Map<Integer, Order> orderMap = new HashMap<>(); // To track existing orders

            while (rs.next()) {
                int currentOrderId = rs.getInt("order_id");
                Order order = orderMap.get(currentOrderId);

                if (order == null) {
                    order = new Order();
                    AdminDAO dao = new AdminDAO();
                    Staff staff = dao.getStaffById(rs.getString("sale_id"));
                    StatusOrder status = getStatusOrderById(rs.getInt("status_id"));
                    PaymentMethod payment = getPaymentById(rs.getInt("payment_id"));

                    order.setId(currentOrderId);
                    order.setCustomerId(rs.getInt("customer_id"));
                    order.setPaymentMethod(payment);
                    order.setNote(rs.getString("note"));
                    order.setStatus(status);
                    order.setFullName(rs.getString("full_name"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setPhone(rs.getString("phone_number"));
                    order.setSaleNote(rs.getString("sale_note"));
                    order.setStaff(staff);
                    order.setCreatedDate(rs.getTimestamp("create_date"));
                    order.setUpdatedDate(rs.getTimestamp("update_date"));

                    // Initialize the list of OrderDetails
                    order.setOrderDetails(new ArrayList<>());

                    orderMap.put(currentOrderId, order);
                    orders.add(order);
                }

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setPrice(rs.getDouble("price"));

                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setImg(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                orderDetail.setProduct(product);

                order.getOrderDetails().add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public List<OrderDetail> getOrderDetailById(int id) throws SQLException {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT o.order_id, o.full_name, o.email, o.phone_number, o.address, o.create_date, o.status_id, p.image, p.product_name, p.cid, p.price, od.quantity \n" +
                "                FROM orderdetail od \n" +
                "                JOIN [order] o ON o.order_id = od.order_id\n" +
                "                JOIN product p ON od.product_id = p.product_id \n" +
                "                WHERE od.order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDAO dao = new ProductDAO();
                Category category = dao.getCategoryById(rs.getInt("cid"));

                SaleDAO dao2 = new SaleDAO();
                StatusOrder status = dao2.getStatusOrderById(rs.getInt("status_id"));

                Order od = new Order(rs.getInt("order_id"), rs.getString("full_name"), rs.getString("email"), rs.getString("phone_number"), rs.getString("address"), rs.getTimestamp("create_date"), status);
                Product p = new Product(rs.getString("image"), rs.getString("product_name"), category, rs.getDouble("price"));
//                orderDetails.add(new od, p, rs.getInt("quantity"), rs.getDouble("price"));
                orderDetails.add(new OrderDetail(od, p, rs.getInt("quantity"), rs.getDouble("price")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public StatusOrder getStatusOrderById(int id) throws SQLException {
        String query = "select * from status_order where id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, id);

        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            StatusOrder status = new StatusOrder(resultSet.getInt("id"), resultSet.getString("status"));

            return status;
        }
        return null; // Category not found
    }

    public PaymentMethod getPaymentById(int id) throws SQLException {
        String query = "select * from payment_method where id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, id);

        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            PaymentMethod payment = new PaymentMethod(resultSet.getInt("id"), resultSet.getString("payment"));

            return payment;
        }
        return null; // Category not found
    }


    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT o.order_id, o.customer_id, o.payment_id, o.note, o.status_id, o.create_date, o.update_date, o.full_name, o.email, o.address, o.phone_number, o.sale_note, o.sale_id, "
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
                    AdminDAO dao = new AdminDAO();
                    Staff staff = dao.getStaffById(rs.getString("sale_id"));
                    StatusOrder status = getStatusOrderById(rs.getInt("status_id"));
                    PaymentMethod payment = getPaymentById(rs.getInt("payment_id"));
                    order.setId(rs.getInt("order_id"));
                    order.setCustomerId(rs.getInt("customer_id"));
                    order.setPaymentMethod(payment);
                    order.setNote(rs.getString("note"));
                    order.setStatus(status);
                    order.setFullName(rs.getString("full_name"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setPhone(rs.getString("phone_number"));
                    order.setSaleNote(rs.getString("sale_note"));
                    order.setStaff(staff);
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

    public StatusOrder getStatusById(int statusID) throws SQLException {
        String query = "SELECT * FROM status_order WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, statusID);

        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            Category category = new Category();
            StatusOrder status = new StatusOrder(resultSet.getInt("id"), resultSet.getString("status"));
            return status;
        }
        return null; // Category not found
    }

    public List<StatusOrder> getListStatus() throws SQLException {
        List<StatusOrder> list = new ArrayList<>();
        String query = "SELECT * FROM status_order";
        PreparedStatement statement = connection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            StatusOrder statusOrder = new StatusOrder();
            statusOrder.setId(resultSet.getInt("id"));
            statusOrder.setStatus(resultSet.getString("status"));
            list.add(statusOrder);
        }
        return list; // Category not found
    }

    public static boolean updateOrderBySaleManager(int oid, String status, int saleID, String salenote) {
        String query = "UPDATE [order] SET status_id = ?, sale_id = ?, sale_note = ? WHERE order_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, status);
            statement.setInt(2, saleID);
            statement.setString(3, salenote);
            statement.setInt(4, oid);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {

        }
        return false;
    }


    public static boolean updateOrderStatus(int status_id, int order_id) throws SQLException {
        String query = "UPDATE [order] SET status_id = ? WHERE order_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, status_id);
            statement.setInt(2, order_id);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        }


    }

//    public static boolean updateOrderSale(int saleId, int orderId) throws SQLException {
//        String query = "UPDATE [order] SET sale_id = ? WHERE order_id = ?";
//        try (Connection connection = getConnection();
//             PreparedStatement statement = connection.prepareStatement(query)) {
//            statement.setInt(1, saleId);
//            statement.setInt(2, orderId);
//            int rowsUpdated = statement.executeUpdate();
//            return rowsUpdated > 0;
//        }
//    }
//
//    public static boolean updateOrderNote(String salenote, int orderId) throws SQLException {
//        String query = "UPDATE [order] SET sale_note = ? WHERE order_id = ?";
//        try (Connection connection = getConnection();
//             PreparedStatement statement = connection.prepareStatement(query)) {
//            statement.setString(1, salenote);
//            statement.setInt(2, orderId);
//            int rowsUpdated = statement.executeUpdate();
//            return rowsUpdated > 0;
//        }
//    }

}







