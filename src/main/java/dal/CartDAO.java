package dal;

import model.*;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CartDAO extends DBContext{



    public static void main(String[] args) throws SQLException {
        CartDAO dao = new CartDAO();
       // List<Cart> pc = dao.getCartByIDOfCus(2);
       // List<PaymentMethod> pcs = dao.getListPayment();
        OrderDAO orderDAO = new OrderDAO();

    }
    public List<PaymentMethod> getListPayment() {
        List<PaymentMethod> payments = new ArrayList<>();
        String query = "select * from payment_method";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                PaymentMethod payment = new PaymentMethod(resultSet.getInt("id"), resultSet.getString("payment"));
                payments.add(payment);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }

        return payments;
    }


    public Order getLatestOrder(int customer_id) {
        Order order = null;
        String sql = "SELECT TOP 1 order_id FROM [order]" +
                "where customer_id = ?" +
                " ORDER BY order_id DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customer_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("order_id"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return order;
    }


    public ListCart getCartByCustomerId(int id) {
        ListCart cart = new ListCart(listCartByCId(id));
        return cart;
    }
    public void removeItemFromCart(String pid, int cid) {
        String query = "delete from cart\n" +
                "where product_id = ? and customer_id= ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, pid);
            ps.setInt(2, cid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void AddOrderDetail(int orderId, int productId, double price, int quantity) {
        // Tạo đối tượng Order và Product với các giá trị truyền vào
        Order order = new Order(orderId);
        Product product = new Product(productId);

        // Tạo đối tượng OrderDetail và gán các giá trị cho nó
        OrderDetail orderDetail = new OrderDetail(order, product, quantity, price);

        String query = "INSERT INTO orderdetail (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderDetail.getOrderId().getId());
            statement.setInt(2, orderDetail.getProduct().getId());
            statement.setDouble(3, orderDetail.getPrice());
            statement.setInt(4, orderDetail.getQuantity());

            statement.executeUpdate();
        } catch (SQLException e) {

        }
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


    public void addToCart(String pid, int cid, int quantity) {
        try {
            String sql = "insert into cart\n" +
                    "values(?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setString(2, pid);
            ps.setInt(3, cid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addToOrder(int cusID, String fullName, String email, String address, String phone, int payment, String note, int status, int total, int sale_id){
        LocalDateTime currenDate = LocalDateTime.now();
        String sql = "INSERT INTO [order] (customer_id, full_name, email, address, phone_number, payment_id, note, create_date, update_date, status_id, total_price, sale_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, cusID);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setString(5, phone);
            ps.setInt(6, payment);
            ps.setString(7, note);
            ps.setObject(8, currenDate);
            ps.setObject(9, currenDate);
            ps.setInt(10, status);
            ps.setInt(11, total);
            ps.setInt(12, sale_id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public double getTotalPriceByOrderId(int orderId) throws SQLException {
        String query = "SELECT SUM(price * quantity) AS total_price FROM orderdetail WHERE order_id = ?";
        double totalPrice = 0.0;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalPrice = rs.getDouble("total_price");
            }
        }

        return totalPrice;
    }


    public void updateToCart(int cid, String pid, int quantity) {
        try {
            String sql = "update cart\n" +
                    "set quantity = ?\n" +
                    "where customer_id = ? and product_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, cid);
            ps.setString(3, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Cart> getCartByIDOfCus(int idCus) throws SQLException {
        List<Cart> carts = new ArrayList<Cart>();
        String sql = "SELECT cart.quantity, p.product_id, p.product_name, p.price, p.image, c.fullname, c.gender, c.email, c.phone_number, c.address  \n" +
                "FROM cart cart\n" +
                "JOIN customer c ON cart.customer_id = c.customer_id\n" +
                "JOIN product p ON p.product_id= cart.product_id\n" +
                "where cart.customer_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, idCus);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(rs.getInt("product_id"), rs.getDouble("price"), rs.getString("product_name"), rs.getString("image"));
                Customer c = new Customer(rs.getString("fullname"), rs.getBoolean("gender"), rs.getString("email"), rs.getString("phone_number"), rs.getString("address"));

                carts.add(new Cart(rs.getInt("quantity"),
                        p,
                        c
                        ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return carts;
    }

    public List<Cart> getCartProductsByProductIdsAndCustomerId(String[] productIds, int customerId) {
        List<Cart> carts = new ArrayList<>();
        String joinedProductIds = String.join(", ", productIds);
        ProductDAO productDao = new ProductDAO();
        CustomerDAO customerDao = new CustomerDAO();
        String sql = "SELECT * FROM [cart] WHERE product_id IN ("+ joinedProductIds +") AND customer_id = ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, joinedProductIds);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                carts.add(new Cart(rs.getInt("quantity"),
                        productDao.getProductById(rs.getInt("product_id")),
                        customerDao.getCustomerById(rs.getInt("customer_id")))
                );
            }
        } catch (Exception e) {
        }
        return carts;
    }

    public List<Cart> listCartByCId(int id) {
        List<Cart> carts = new ArrayList<>();
        String sql = "SELECT c.product_id , SUM(c.quantity) AS total_quantity, p.price, p.product_name, p.[image]\n" +
                "FROM [Cart] c \n" +
                "JOIN product p ON p.product_id = c.product_id\n" +
                "WHERE c.customer_id = ? \n" +
                "GROUP BY c.product_id, p.price, p.product_name, p.[image]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getDouble("price"),
                        rs.getString("product_name"),
                        rs.getString("image")
                );
                Customer customer = new Customer();
                carts.add(new Cart(rs.getInt("total_quantity"), product, customer));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return carts;
    }




}