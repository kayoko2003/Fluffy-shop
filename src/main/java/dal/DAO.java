package dal;

import model.Post;
import model.PostCategory;
import model.Staff;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAO extends DBContext{

    public static void main(String[] args){
        DAO dao = new DAO();
        System.out.println(dao.getTotalPost("", "-1"));
//        List<Post> listPost = dao.getListPost(0, 4, "", bid);
//        System.out.println(list);
    }

    public List<PostCategory> getAllPostCategory(){
        List<PostCategory> postCategoryList = new ArrayList<>();
        String sql = "select * from blog_category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                postCategoryList.add(new PostCategory(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {

        }
        return postCategoryList;
    }

    public List<Post> getRecentPost(){
        List<Post> posts = new ArrayList<Post>();
        DAO dao = new DAO();
        AdminDAO admin = new AdminDAO();
        String sql = "SELECT TOP 3 b.*, c.cname\n" +
                "FROM blog b \n" +
                "JOIN blog_category c ON b.blog_category_id = c.blog_category_id \n" +
                "ORDER BY update_date desc\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(new Post(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        dao.getPostCategoryById(rs.getString(4)),
                        admin.getStaffById(rs.getString(5)),
                        rs.getString(8),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getDate(9),
                        rs.getDate(10)));
            }
        } catch (Exception e) {

        }
        return posts;
    }

    public int getTotalPost(String search, String categoryId){
        String sql = "SELECT COUNT(*)\n" +
                     "FROM blog b\n" +
                     "JOIN blog_category c ON b.blog_category_id = c.blog_category_id \n" +
                     "WHERE b.title LIKE ? AND (b.blog_category_id = ? OR ? = -1)";
        int totalPost = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2,  categoryId);
            ps.setString(3, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalPost = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPost;
    }

    public List<Post> getListPost(int offset, int limit, String search, String categoryId){
        List<Post> posts = new ArrayList<Post>();
        DAO dao = new DAO();
        AdminDAO admin = new AdminDAO();
        String sql = "SELECT b.*, c.cname\n" +
                "FROM blog b \n" +
                "JOIN blog_category c ON b.blog_category_id = c.blog_category_id \n" +
                "WHERE b.title LIKE ? AND (b.blog_category_id = ? OR ? = -1)\n" +
                "ORDER BY update_date desc \n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, categoryId);
            ps.setString(3, categoryId);
            ps.setInt(4, offset);
            ps.setInt(5, limit);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(new Post(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        dao.getPostCategoryById(rs.getString(4)),
                        admin.getStaffById(rs.getString(5)),
                        rs.getString(8),
                        rs.getString(6),
                        rs.getBoolean(7),
                        rs.getDate(9),
                        rs.getDate(10)));
            }
        } catch (Exception e) {

        }

        return posts;
    }

    public PostCategory getPostCategoryById(String postCategoryId){
        String sql = "SELECT * from blog_category WHERE blog_category_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, postCategoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    return new PostCategory(rs.getInt(1),
                            rs.getString(2));
                }
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public Post getPostByID(int id) {
        AdminDAO adminDAO = new AdminDAO();
        DAO dao = new DAO();
        String sql = " SELECT blog.*, blog_category.blog_category_id\n" +
                "FROM blog \n" +
                "JOIN blog_category ON blog.blog_category_id = blog_category.blog_category_id\n" +
                "WHERE blog.post_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PostCategory postCategory =dao.getPostCategoryById(rs.getString("blog_category_id"));
                Staff staff = adminDAO.getStaffById(rs.getString("id_creater"));
                return new Post(
                        rs.getInt("post_id"), // Assuming the column name is post_id
                        rs.getString("thumbnail"), // Assuming the column name is thumbnail
                        rs.getString("title"),
                        postCategory,
                        staff,// Assuming the column name is title
                        rs.getString("blog_detail_short"), // Assuming the column name is blog_detail_short
                        rs.getString("blog_detail"), // Assuming the column name is blog_detail
                        rs.getBoolean("isShow"),
                        rs.getDate(9),
                        rs.getDate(10)

                        // Assuming the column name is isShow
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
