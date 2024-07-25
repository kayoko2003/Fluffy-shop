package dal;

import model.Brand;
import model.Category;
import model.Post;
import model.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ProductDAO extends DBContext {
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getListProductCanBuy(1, 14, "p.update_date", "", -1, -1, "DESC");
        for (Product product : products) {
            System.out.println(product);
        }
    }

    public Category getCategoryById(int categoryId) throws SQLException {
        String query = "SELECT * FROM category WHERE cid = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, categoryId);

        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            Category category = new Category();
            category.setId(resultSet.getInt("cid"));
            category.setName(resultSet.getString("cname"));
            return category;
        }
        return null; // Category not found
    }

    public int getTotalProductsCount(String search, int brandId, int categoryId) {
        String sql = "SELECT COUNT(*) " +
                "FROM product p " +
                "JOIN category c ON p.cid = c.cid " +
                "JOIN brand b ON p.brand_id = b.brand_id " +
                "WHERE p.product_name LIKE ? AND (c.cid = ? OR ? = -1) AND (b.brand_id = ? OR ? = -1)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, brandId);
            ps.setInt(5, brandId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalProductsCountCanBuy(String search, int brandId, int categoryId) {
        String sql = "SELECT COUNT(*) AS total_products " +
                "FROM product p " +
                "LEFT JOIN ( " +
                "    SELECT product_id, SUM(quantity) AS total_quantity " +
                "    FROM orderdetail " +
                "    WHERE order_id IN (SELECT order_id FROM [order] WHERE status_id IN (1, 2, 3, 8)) " +
                "    GROUP BY product_id " +
                ") od ON p.product_id = od.product_id " +
                "WHERE p.product_name LIKE ? " +
                "  AND (p.cid = ? OR ? = -1) " +
                "  AND (p.brand_id = ? OR ? = -1) " +
                "  AND (p.stock_quantity - ISNULL(od.total_quantity, 0)) > 0 " +
                "  AND p.is_delete = 0;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, brandId);
            ps.setInt(5, brandId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_products");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalProductsCountOutOfStock(String search, int brandId, int categoryId) {
        String sql = "SELECT COUNT(*) AS total_products " +
                "FROM product p " +
                "LEFT JOIN ( " +
                "    SELECT product_id, SUM(quantity) AS total_quantity " +
                "    FROM orderdetail " +
                "    WHERE order_id IN (SELECT order_id FROM [order] WHERE status_id IN (1, 2, 3, 8)) " +
                "    GROUP BY product_id " +
                ") od ON p.product_id = od.product_id " +
                "WHERE p.product_name LIKE ? " +
                "  AND (p.cid = ? OR ? = -1) " +
                "  AND (p.brand_id = ? OR ? = -1) " +
                "  AND (p.stock_quantity - ISNULL(od.total_quantity, 0)) = 0 " +
                "  AND p.is_delete = 0;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, brandId);
            ps.setInt(5, brandId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    public List<Product> getProductOutOfStock(int offset, int itemsPerPage, String sortBy, String search, int brandId, int categoryId, String sortOrder) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cname, b.name_brand " +
                "FROM product p " +
                "JOIN category c ON p.cid = c.cid " +
                "JOIN brand b ON p.brand_id = b.brand_id " +
                "LEFT JOIN ( " +
                "    SELECT product_id, SUM(quantity) AS total_quantity " +
                "    FROM orderdetail " +
                "    WHERE order_id IN (SELECT order_id FROM [order] WHERE status_id IN (1, 2, 3, 8)) " +
                "    GROUP BY product_id " +
                ") od ON p.product_id = od.product_id " +
                "WHERE p.product_name LIKE ? " +
                "  AND (c.cid = ? OR ? = -1) " +
                "  AND (b.brand_id = ? OR ? = -1) " +
                "  AND (p.stock_quantity - ISNULL(od.total_quantity, 0)) = 0 " +
                "  AND p.is_delete = 0 " +
                "ORDER BY " + sortBy + " " + sortOrder + " " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, brandId);
            ps.setInt(5, brandId);
            ps.setInt(6, offset);
            ps.setInt(7, itemsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category categories = new Category(rs.getInt("cid"), rs.getString("cname"));
                Brand brands = new Brand(rs.getInt("brand_id"), rs.getString("name_brand"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        categories,
                        brands,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("number_sold"),
                        rs.getDate("create_date"),
                        rs.getDate("update_date"),
                        rs.getString("create_by"),
                        rs.getString("update_by"),
                        rs.getDate("delete_date"),
                        rs.getString("delete_by"),
                        rs.getBoolean("is_delete"),
                        rs.getInt("import_price")
                );
                products.add(product);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getListProductCanBuy(int currentPage, int itemsPerPage, String sortBy, String search, int brandId, int categoryId, String sortOrder) {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT p.*, c.cname, b.name_brand " +
                "FROM product p " +
                "JOIN category c ON p.cid = c.cid " +
                "JOIN brand b ON p.brand_id = b.brand_id " +
                "LEFT JOIN ( " +
                "    SELECT product_id, SUM(quantity) AS total_quantity " +
                "    FROM orderdetail " +
                "    WHERE order_id IN (SELECT order_id FROM [order] WHERE status_id IN (1, 2, 3, 8)) " +
                "    GROUP BY product_id " +
                ") od ON p.product_id = od.product_id " +
                "WHERE p.product_name LIKE ? " +
                "  AND (c.cid = ? OR ? = -1) " +
                "  AND (b.brand_id = ? OR ? = -1) " +
                "  AND (p.stock_quantity - ISNULL(od.total_quantity, 0)) > 0 " +
                "  AND p.is_delete = 0 " +
                "ORDER BY " + sortBy + " " + sortOrder + " " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, brandId);
            ps.setInt(5, brandId);
            ps.setInt(6, (currentPage - 1) * itemsPerPage);
            ps.setInt(7, itemsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category categories = new Category(rs.getInt("cid"), rs.getString("cname"));
                Brand brands = new Brand(rs.getInt("brand_id"), rs.getString("name_brand"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        categories,
                        brands,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("number_sold"),
                        rs.getDate("create_date"),
                        rs.getDate("update_date"),
                        rs.getString("create_by"),
                        rs.getString("update_by"),
                        rs.getDate("delete_date"),
                        rs.getString("delete_by"),
                        rs.getBoolean("is_delete"),
                        rs.getInt("import_price")
                );
                products.add(product);

            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getAllProducts(int currentPage, int itemsPerPage, String sortBy, String search, int brandId, int categoryId, String sortOrder) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.cname, b.name_brand " +
                "FROM product p " +
                "JOIN category c ON p.cid = c.cid " +
                "JOIN brand b ON p.brand_id = b.brand_id  " +
                "WHERE p.product_name LIKE ? AND (c.cid = ? OR ? = -1) AND (b.brand_id = ? OR ? = -1)" +
                "ORDER BY " + sortBy + " " + sortOrder + " " +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, categoryId);
            ps.setInt(3, categoryId);
            ps.setInt(4, brandId);
            ps.setInt(5, brandId);
            ps.setInt(6, (currentPage - 1) * itemsPerPage);
            ps.setInt(7, itemsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category categories = new Category(rs.getInt("cid"), rs.getString("cname"));
                Brand brands = new Brand(rs.getInt("brand_id"), rs.getString("name_brand"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        categories,
                        brands,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("number_sold"),
                        rs.getDate("create_date"),
                        rs.getDate("update_date"),
                        rs.getString("create_by"),
                        rs.getString("update_by"),
                        rs.getDate("delete_date"),
                        rs.getString("delete_by"),
                        rs.getBoolean("is_delete"),
                        rs.getInt("import_price")
                );
                products.add(product);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public LinkedHashMap<Product, Integer> getListProductWithHoldQuantity(List<Product> product) {
        LinkedHashMap<Product, Integer> listProductWithHoldQuantity = new LinkedHashMap<>();
        for (Product p : product) {
            String sql = "SELECT product_id, SUM(quantity) AS total_quantity\n" +
                    "FROM orderdetail\n" +
                    "WHERE order_id IN (SELECT order_id FROM [order] WHERE status_id IN (1, 2, 3, 8)) and product_id = ?\n" +
                    "GROUP BY product_id;";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, p.getId());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    listProductWithHoldQuantity.put(p, rs.getInt("total_quantity"));
                } else {
                    listProductWithHoldQuantity.put(p, 0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return listProductWithHoldQuantity;
    }


    public Set<Category> getCategories() {
        Set<Category> categories = new HashSet<>();
        String sql = "SELECT * FROM category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new Category(rs.getInt("cid"), rs.getString("cname")));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public Set<Brand> getBrands() {
        Set<Brand> brands = new HashSet<>();
        String sql = "SELECT * FROM brand";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                brands.add(new Brand(rs.getInt("brand_id"), rs.getString("name_brand")));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    public void addProduct(String name, int category, int brand, double price, String description, String img, int quantity, String status, int createBy) {
        String sql = "INSERT INTO product(product_name, cid, brand_id, price, description, image, stock_quantity, status, create_date,  is_delete, number_sold, create_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 0, 0, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, category);
            ps.setInt(3, brand);
            ps.setDouble(4, price);
            ps.setString(5, description);
            ps.setString(6, img);
            ps.setInt(7, quantity);
            ps.setString(8, status);
            ps.setInt(9, createBy);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getHoldNumberProduct(int productId) {
        String sql = "SELECT product_id, SUM(quantity) AS total_quantity\n" +
                "FROM orderdetail\n" +
                "WHERE order_id IN (SELECT order_id FROM [order] WHERE status_id IN (1, 2, 3, 8)) and product_id = ?\n" +
                "GROUP BY product_id;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_quantity");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public Product getProductById(int parseInt) {
        String sql = "SELECT p.*, c.cname, b.name_brand " +
                "FROM product p " +
                "JOIN category c ON p.cid = c.cid " +
                "JOIN brand b ON p.brand_id = b.brand_id " +
                "WHERE p.product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, parseInt);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category categories = new Category(rs.getInt("cid"), rs.getString("cname"));
                Brand brands = new Brand(rs.getInt("brand_id"), rs.getString("name_brand"));
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        categories,
                        brands,
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getInt("stock_quantity"),
                        rs.getInt("number_sold"),
                        rs.getDate("create_date"),
                        rs.getDate("update_date"),
                        rs.getString("create_by"),
                        rs.getString("update_by"),
                        rs.getDate("delete_date"),
                        rs.getString("delete_by"),
                        rs.getBoolean("is_delete"),
                        rs.getInt("import_price")
                );
                return product;
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateAfterBuy(int number_purchase, int pid) {
        String sql = "UPDATE product " +
                "SET stock_quantity = stock_quantity - ?" +
                " WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, number_purchase);
            ps.setInt(2, pid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateAfterCompletion(int number_purchase, int pid) {
        String sql = "UPDATE product " +
                "SET number_sold = number_sold + ? " +
                " WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, number_purchase);
            ps.setInt(2, pid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void cancelOrder(int orderId) {
        // Lấy chi tiết đơn hàng
        String query = "SELECT product_id, quantity FROM orderdetail WHERE order_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderId);
            ResultSet rs = statement.executeQuery();

            // Cập nhật lại số lượng sản phẩm trong kho
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                restoreProductStock(productId, quantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void restoreProductStock(int productId, int quantity) {
        String sql = "UPDATE product SET stock_quantity = stock_quantity + ? WHERE product_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void updateProduct(int id, String name, int category, int brand, double price, String description, String img, int quantity, String status, int updateBy) {
        String sql;
        if (img == null) {
            sql = "UPDATE product SET product_name = ?, cid = ?, brand_id = ?, price = ?, description = ?, stock_quantity = ?, status = ?, update_date = GETDATE(), update_by = ? WHERE product_id = ?";
        } else {
            sql = "UPDATE product SET product_name = ?, cid = ?, brand_id = ?, price = ?, description = ?, image = ?, stock_quantity = ?, status = ?, update_date = GETDATE(), update_by = ? WHERE product_id = ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, category);
            ps.setInt(3, brand);
            ps.setDouble(4, price);
            ps.setString(5, description);
            if (img != null) {
                ps.setString(6, img);
                ps.setInt(7, quantity);
                ps.setString(8, status);
                ps.setInt(9, updateBy);
                ps.setInt(10, id);

            } else {
                ps.setInt(6, quantity);
                ps.setString(7, status);
                ps.setInt(8, updateBy);
                ps.setInt(9, id);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getStockQuantity(int productId) {
        int stockQuantity = 0;
        String sql = "SELECT stock_quantity FROM Product WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stockQuantity = rs.getInt("stock_quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockQuantity;
    }

    public void deleteProduct(int parseInt, int deleteBy) {
        String sql = "UPDATE product SET is_delete = 1, delete_date = GETDATE(), delete_by = ? WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, deleteBy);
            ps.setInt(2, parseInt);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantityAndImportPrice(int productId, int quantity, int importPrice, int updateBy) {
        String sql = "UPDATE product SET stock_quantity = ?, import_price = ?, update_date = GETDATE(), update_by = ? WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, importPrice);
            ps.setInt(3, updateBy);
            ps.setInt(4, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void restoreProduct(int parseInt, int updateBy) {
        String sql = "UPDATE product SET is_delete = 0, update_date = GETDATE(), update_by = ? WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, updateBy);
            ps.setInt(2, parseInt);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
