package dal;

import de.svws_nrw.ext.jbcrypt.BCrypt;
import model.Customer;
import model.Post;
import model.ShippingInfor;
import model.Staff;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO extends DBContext{

//    public static void main(String[] args) {
//        CustomerDAO dao = new CustomerDAO();
//        LocalDate dob = LocalDate.parse("2003-01-12");
//       LocalDate createDate = LocalDate.parse("2024-03-04");
//       LocalDate updateDate = LocalDate.parse("2993-03-04");
//
//        Customer c = dao.signup( "tan1@gmail.com", "123", "Tan", "Ha", true, "0912873723", dob, createDate, updateDate, "someRandomToken123", "active", "122");
//        System.out.println(c);
//    }

    public void insertPost(String thumbnail, String title, int blogCId, int staffId, String short_detail, boolean isShow, String blog_detail) {
        String sql = "INSERT INTO blog (thumbnail, title, blog_category_id, id_creater, blog_detail, isShow, blog_detail_short) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, thumbnail);
            ps.setString(2, title);
            ps.setInt(3, blogCId);
            ps.setInt(4, staffId);
            ps.setString(5, blog_detail);
            ps.setBoolean(6, isShow);
            ps.setString(7, short_detail);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Customer checkExistCustomer(String email) {
        String sql = "select * from customer where [email] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(rs.getInt("customer_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getString("address"),
                        rs.getBoolean("gender"),
                        rs.getString("phone_number"),
                        rs.getDate("dob").toLocalDate(),
                        rs.getDate("create_date").toLocalDate(),
                        rs.getDate("update_date").toLocalDate(),
                        rs.getString("token"),
                        rs.getString("status"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkEmailExistInStaff(String email) {
        String sql = "SELECT 1 FROM staff WHERE [email] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExist(String email) {
        return checkExistCustomer(email) != null || checkEmailExistInStaff(email);
    }

    public boolean activateAccount(String token) {
        String sql = "UPDATE customer SET status = 'ACTIVE' WHERE token = ? AND status = 'PENDING'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void saveToken(String email, String token) {
        String sql = "UPDATE customer SET token = ? WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Customer signup(String email, String password, String fullname, String address, Boolean gender, String phoneNumber, LocalDate dob, LocalDate createDate, LocalDate updateDate, String token, String status, String avatar) {
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String sql = "INSERT INTO customer(email, [password], fullname, [address], gender, phone_number, dob, create_date, update_date, token, status, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ps.setString(3, fullname);
            ps.setString(4, address);
            ps.setBoolean(5, gender);
            ps.setString(6, phoneNumber);
            ps.setDate(7, Date.valueOf(dob));
            ps.setDate(8, Date.valueOf(createDate));
            ps.setDate(9, Date.valueOf(updateDate));
            ps.setString(10, token);
            ps.setString(11, status);
            ps.setString(12, avatar);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customer loginCustomer(String email, String password, String status) {
        String sql = "SELECT * FROM customer WHERE email = ? and status = 'ACTIVE'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    return new Customer(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getBoolean(6),
                            rs.getString(7),
                            rs.getDate(8).toLocalDate(),
                            rs.getDate(9).toLocalDate(),
                            rs.getDate(10).toLocalDate(),
                            rs.getString(11),
                            rs.getString(12)
                    );
                }
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Login failed
    }

        public Customer emailcheck( String email) {
        String sql = "select * from customer where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getDate(10).toLocalDate(),
                        rs.getString(11),
                        rs.getString(12)
                );
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

        public String getEmailByToken(String token) {
        String sql = "SELECT email FROM customer WHERE token = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(String email, String newPassword) {
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        String sql = "UPDATE customer SET password = ? WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getDate(10).toLocalDate(),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13)
                );
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Customer> listCustomers(int currentPage, int itemsPerPage, String search, String status, String sortBy, String sortOrder) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customer " +
                "WHERE (fullname LIKE ? OR email LIKE ? OR phone_number LIKE ?) ";

        // Add status condition if it's not empty
        if (!status.isEmpty()) {
            sql += "AND status = ? ";
        }

        sql += "ORDER BY " + sortBy + " " + sortOrder + " " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");

            int paramIndex = 4;
            if (!status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ps.setInt(paramIndex++, (currentPage - 1) * itemsPerPage);
            ps.setInt(paramIndex, itemsPerPage);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Customer(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getBoolean(6),
                            rs.getString(7),
                            rs.getDate(8).toLocalDate(),
                            rs.getDate(9).toLocalDate(),
                            rs.getDate(10).toLocalDate(),
                            rs.getString(11),
                            rs.getString(12),
                            rs.getString(13)
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalCustomerCount(String search) {
        String sql = "SELECT COUNT(*) FROM customer " +
                "WHERE (fullname LIKE ? OR email LIKE ? OR phone_number LIKE ?) ";
        int totalCustomer = 0;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalCustomer = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalCustomer;
    }

    public List<Customer> filterCustomer(String status, int offset, int limit) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customer " +
                "WHERE status LIKE ? " +
                "ORDER BY customer_id " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + status + "%");
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Customer(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getBoolean(6),
                            rs.getString(7),
                            rs.getDate(8).toLocalDate(),
                            rs.getDate(9).toLocalDate(),
                            rs.getDate(10).toLocalDate(),
                            rs.getString(11),
                            rs.getString(12),
                            rs.getString(13))
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception appropriately in a real application
        }
        return list;
    }

    public List<Customer> searchCustomer(String txtSearch, int offset, int limit) {
        List<Customer> list = new ArrayList<>();
        String query = "SELECT *\n" +
                "FROM customer\n" +
                "Where fullname like ?\n" +
                "or email like ?\n" +
                "or phone_number like ?\n" +
                "order by customer_id\n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            ps.setString(2, "%" + txtSearch + "%");
            ps.setString(3, "%" + txtSearch + "%");
            ps.setInt(4, offset);
            ps.setInt(5, limit);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getDate(10).toLocalDate(),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13))
                );
            }
        } catch (Exception e) {

        }
        return list;
    }

    public Customer getCustomerById(String CId) {
        String sql = "select * from customer\n" +
                "where customer_id = ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, CId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getBoolean(6),
                        rs.getString(7),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getDate(10).toLocalDate(),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public Customer updateCustomer(String fullname, String address, boolean gender, String phoneNumber, LocalDate dob, LocalDate updateDate, String status, String img, String log, String customerID) {
        String sql;
        if(img == null) {
            sql = "update customer\n" +
                    "set [fullname] = ?,\n" +
                    "[address] = ?,\n" +
                    "gender = ?,\n" +
                    "phone_number = ?,\n" +
                    "dob = ?,\n" +
                    "update_date = ?,\n" +
                    "[status] = ?,\n" +
                    "log = ?\n" +
                    "where customer_id = ?";
        }else{
            sql = "update customer\n" +
                    "set [fullname] = ?,\n" +
                    "[address] = ?,\n" +
                    "gender = ?,\n" +
                    "phone_number = ?,\n" +
                    "dob = ?,\n" +
                    "update_date = ?,\n" +
                    "[status] = ?,\n" +
                    "avatar = ?,\n" +
                    "log = ?\n" +
                    "where customer_id = ?";
        }

        Customer updatedCustomer = null;
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, fullname);
            ps.setString(2, address);
            ps.setBoolean(3, gender);
            ps.setString(4, phoneNumber);
            ps.setDate(5, Date.valueOf(dob));
            ps.setDate(6, Date.valueOf(updateDate));
            ps.setString(7, status);
            if(img == null) {
                ps.setString(9, log);
                ps.setInt(10, Integer.parseInt(customerID));
            }else{
                ps.setString(8, img);
                ps.setString(9, log);
                ps.setInt(10, Integer.parseInt(customerID));
            }

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Optionally, you can retrieve the updated customer data and return it.
                updatedCustomer = new Customer(Integer.parseInt(customerID), null, null, fullname, address, gender, phoneNumber, dob, null, updateDate, null, "Active", img, log);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return updatedCustomer;
    }



    public List<String> getCustomerLogs(String customerID) {
        String sql = "SELECT [log] FROM customer WHERE customer_id = ?";
        List<String> logs = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, customerID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String log = rs.getString("log");
                    if (log != null && !log.isEmpty()) {
                        String[] logArray = log.split("\n");
                        for (String entry : logArray) {
                            logs.add(entry);
                        }
                    }
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return logs;
    }

    public Customer addCustomer(String email, String password, String fullname, String address, Boolean gender, String phoneNumber, LocalDate dob, LocalDate createDate, LocalDate updateDate, String token, String status, String avatar) {
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String sql = "INSERT INTO customer(email, [password], fullname, [address], gender, phone_number, dob, create_date, update_date, token, status, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ps.setString(3, fullname);
            ps.setString(4, address);
            ps.setBoolean(5, gender);
            ps.setString(6, phoneNumber);
            ps.setDate(7, Date.valueOf(dob));
            ps.setDate(8, Date.valueOf(createDate));
            ps.setDate(9, Date.valueOf(updateDate));
            ps.setString(10, token);
            ps.setString(11, status);
            ps.setString(12, avatar);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ShippingInfor> getShippingInforOfCustomer(int customerID) {
        List<ShippingInfor> shippingInfors = new ArrayList<>();
        String sql = "SELECT * FROM [shipping_info] WHERE customer_id = ?";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                shippingInfors.add(new ShippingInfor(rs.getInt("id"),
                        rs.getInt("customer_id"),
                        rs.getString("full_name"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getBoolean("default")));
            }
        } catch (SQLException e) {

        }
        return shippingInfors;
    }


    public void updateShippingInforOfCus(int customerID, String idAddress, String address, String name, String phone, boolean setDefault) {
        String sql = "UPDATE shipping_info " +
                "SET full_name = ?, phone_number = ?, address = ?, [default] = ?  " +
                "WHERE id = ? AND customer_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setBoolean(4, setDefault);
            ps.setString(5, idAddress);
            ps.setInt(6, customerID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertShippingInforOfCus(int customerID, String address, String name, String phone, boolean setDefault) {
        String sql = "INSERT INTO shipping_info (customer_id, full_name, phone_number, address, [default]) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setString(2, name);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setBoolean(5, setDefault);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public ShippingInfor getShippingInforByID(int id) {
        String sql = "SELECT * FROM shipping_info WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ShippingInfor(
                            rs.getInt("id"),
                            rs.getInt("customer_id"),
                            rs.getString("full_name"),
                            rs.getString("phone_number"),
                            rs.getString("address"),
                            rs.getBoolean("default")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getIdAddressDefault(int customerId) {
        String sql = "SELECT id FROM shipping_info WHERE customer_id = ? AND [default] = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Customer> getNewlyRegisteredCustomers(Date startDate, Date endDate) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT DISTINCT c.* "
                + "FROM customer c "
                + "LEFT JOIN [order] o ON c.customer_id = o.customer_id "
                + "WHERE o.customer_id IS NULL;";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerID(rs.getInt("customer_iD"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setFullname(rs.getString("fullname"));
                customer.setAddress(rs.getString("address"));
                customer.setGender(rs.getBoolean("gender"));
                customer.setPhoneNumber(rs.getString("phone_number"));
                customer.setDob(rs.getDate("dob").toLocalDate());
                customer.setCreateDate(rs.getDate("create_date").toLocalDate());
                customer.setUpdateDate(rs.getDate("update_date").toLocalDate());
                customer.setToken(rs.getString("token"));
                customer.setStatus(rs.getString("status"));
                customer.setImg(rs.getString("avatar"));
                customers.add(customer);
            }
        } catch (Exception e) {
            System.out.println("getNewlyRegisteredCustomers: " + e);
        }
        return customers;
    }

    public void updateCustomer2(int customerID, String name, String email, String phone, String address, Date dob, boolean gender, String img, Date updateDate) {
        String sql;
        if (img == null) {
            sql = "UPDATE customer SET fullname = ?, email = ?, phone_number = ?, [address] = ?, dob = ?, gender = ?, update_date = ? WHERE customer_id = ?";
        } else {
            sql = "UPDATE customer SET fullname = ?, email = ?, phone_number = ?, [address] = ?, dob = ?, gender = ?, avatar = ?, update_date = ? WHERE customer_id = ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setDate(5, dob);
            ps.setBoolean(6, gender);
            if (img == null) {
                ps.setDate(7, updateDate);
                ps.setInt(8, customerID);
            } else {
                ps.setString(7, img);
                ps.setDate(8, updateDate);
                ps.setInt(9, customerID);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customer> getNewlyBoughtCustomers(Date startDate, Date endDate) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT DISTINCT c.* FROM customer c INNER JOIN [order] o ON c.customer_id = o.customer_id";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerID(rs.getInt("customer_id"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setFullname(rs.getString("fullname"));
                customer.setAddress(rs.getString("address"));
                customer.setGender(rs.getBoolean("gender"));
                customer.setPhoneNumber(rs.getString("phone_number"));
                customer.setDob(rs.getDate("dob").toLocalDate());
                customer.setCreateDate(rs.getDate("create_date").toLocalDate());
                customer.setUpdateDate(rs.getDate("update_date").toLocalDate());
                customer.setToken(rs.getString("token"));
                customer.setStatus(rs.getString("status"));
                customer.setImg(rs.getString("avatar"));
                customers.add(customer);
            }
        } catch (Exception e) {
            System.out.println("getNewlyBoughtCustomers: " + e);
        }
        return customers;
    }

}
