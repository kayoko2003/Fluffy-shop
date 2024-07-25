package dal;

import model.Post;
import model.PostCategory;
import model.Staff;

import java.io.PrintWriter;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PostDAO extends DBContext{

    public static void main(String[] args) {
        PostDAO dao = new PostDAO();
        Post p = dao.getPostByID(3);
        System.out.println(p);

    }

    public List<Post> listAllPost(int currentPage, int itemsPerPage, String search, int pcategoryId, int staffId, Boolean isShow, String sortOrder, String sortBy) {
        List<Post> postList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT b.*, bc.cname, s.fullname FROM blog b\n" +
                "JOIN blog_category bc ON b.blog_category_id = bc.blog_category_id\n" +
                "JOIN staff s ON b.id_creater = s.staff_id\n" +
                "WHERE title LIKE ? \n" +
                "AND (bc.blog_category_id = ? OR ? = -1) \n" +
                "AND (s.staff_id = ? OR ? = -1)");
        if (isShow != null) {
            sql.append(" AND isShow = ?");
        }
        sql.append(" ORDER BY ").append(sortBy).append(" ").append(sortOrder)
                .append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            ps.setString(paramIndex++, "%" + search + "%");
            ps.setInt(paramIndex++, pcategoryId);
            ps.setInt(paramIndex++, pcategoryId);
            ps.setInt(paramIndex++, staffId);
            ps.setInt(paramIndex++, staffId);
            if (isShow != null) {
                ps.setBoolean(paramIndex++, isShow);
            }
            ps.setInt(paramIndex++, (currentPage - 1) * itemsPerPage);
            ps.setInt(paramIndex++, itemsPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PostCategory postCategory = new PostCategory(rs.getInt("blog_category_id"), rs.getString("cname"));
                Staff staff = new Staff(rs.getInt("id_creater"), rs.getString("fullname"));
                Post post = new Post(rs.getInt("post_id"),
                        rs.getString("thumbnail"),
                        rs.getString("title"),
                        postCategory,
                        staff,
                        rs.getString("blog_detail"),
                        rs.getString("blog_detail_short"),
                        rs.getBoolean("isShow"),
                        rs.getDate("create_date"),
                        rs.getDate("update_date"));
                postList.add(post);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return postList;
    }

    public boolean updateIsShow(int postId, boolean isShow) {
        String sql = "UPDATE blog SET isShow = ? WHERE post_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, isShow);
            ps.setInt(2, postId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalPostCount(String search, int pcategoryId, int staffId, Boolean isShow) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*)\n" +
                "from blog b\n" +
                "join blog_category bc on b.blog_category_id = bc.blog_category_id\n" +
                "join staff s on b.id_creater = s.staff_id\n" +
                "where title like ? AND (bc.blog_category_id = ? or ? = -1) AND (s.staff_id = ? or ? = -1)");
        if (isShow != null) {
            sql.append(" AND isShow = ?");
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, pcategoryId);
            ps.setInt(3, pcategoryId);
            ps.setInt(4, staffId);
            ps.setInt(5, staffId);
            if (isShow != null) {
                ps.setBoolean(6, isShow);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<PostCategory> getAllPostCategory() {
        List<PostCategory> postCategoryList = new ArrayList<>();
        String sql = "select * from blog_category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int PostCId = rs.getInt("blog_category_id");
                String PostCName = rs.getString("cname");
                PostCategory postCategory = new PostCategory(PostCId, PostCName);
                postCategoryList.add(postCategory);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return postCategoryList;
    }

    //phần Thể
    public List<PostCategory> getAllCategoryB() {
        List<PostCategory> list = new ArrayList<>();
        String sql = "select * from blog_category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PostCategory(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }


    public void insertPost(String thumbnail, String title, int blog_category_id, int id_creater, String blogDetail, boolean  isShow, String short_detail,String create_date, String update_date) {
        String sql = "INSERT INTO blog (thumbnail, title, blog_category_id, id_creater, blog_detail, isShow, blog_detail_short, create_date, update_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,thumbnail);
            ps.setString(2,title);
            ps.setInt(3, blog_category_id);
            ps.setInt(4, id_creater);
            ps.setString(5, blogDetail);
            ps.setBoolean(6, isShow);
            ps.setString(7, short_detail);
            ps.setDate(8, Date.valueOf(create_date));
            ps.setDate(9, Date.valueOf(update_date));

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public Post getPostByID(int id) {
        String sql = "SELECT b.*, bc.cname, s.fullname\n" +
                "FROM blog b\n" +
                "JOIN blog_category bc ON b.blog_category_id = bc.blog_category_id\n" +
                "JOIN staff s ON b.id_creater = s.staff_id\n" +
                "WHERE b.post_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PostCategory postCategory = new PostCategory(rs.getInt("blog_category_id"), rs.getString("cname"));
                Staff staff = new Staff(rs.getInt("id_creater"), rs.getString("fullname"));
                return new Post(
                        rs.getInt("post_id"), // Assuming the column name is post_id
                        rs.getString("thumbnail"), // Assuming the column name is thumbnail
                        rs.getString("title"),
                        postCategory,
                        staff,// Assuming the column name is title
                        rs.getString("blog_detail_short"), // Assuming the column name is blog_detail_short
                        rs.getString("blog_detail"), // Assuming the column name is blog_detail
                        rs.getBoolean("isShow"),
                        rs.getDate("create_date"),
                        rs.getDate("update_date")

                        // Assuming the column name is isShow
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Post> getTopPosts(int postcid) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT TOP (3) b.post_id, b.thumbnail, b.title, b.id_creater, b.update_date, b.blog_detail_short, b.blog_category_id, bc.cname " +
                "FROM blog b " +
                "JOIN blog_category bc ON b.blog_category_id = bc.blog_category_id WHERE b.blog_category_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postcid);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Staff staff = new Staff(rs.getInt("id_creater"));
                Post post = new Post(
                        rs.getInt("post_id"),
                        rs.getString("thumbnail"),
                        rs.getString("title"),
                        staff,
                        rs.getString("blog_detail_short"),
                        rs.getDate("update_date")
                );
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }


    public Post updatePost(int postId, String thumbnail, String title, int blogCId, int staffId, String blog_detail, boolean isShow, String blog_detail_short) {
        String sql;
        if(thumbnail == null) {
            sql = "UPDATE blog SET title = ?, blog_category_id = ?, id_creater = ?, blog_detail = ?, isShow = ?, blog_detail_short = ?, update_date = GETDATE() WHERE post_id = ?";
        }else{
            sql = "UPDATE blog SET thumbnail = ?, title = ?, blog_category_id = ?, id_creater = ?, blog_detail = ?, isShow = ?, blog_detail_short = ?, update_date = GETDATE() WHERE post_id = ?";

        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if(thumbnail != null) {
                ps.setString(1, thumbnail);
                ps.setString(2, title);
                ps.setInt(3, blogCId);
                ps.setInt(4, staffId);
                ps.setString(5, blog_detail);
                ps.setBoolean(6, isShow);
                ps.setString(7, blog_detail_short);
                ps.setInt(8, postId);
            }else{
                ps.setString(1, title);
                ps.setInt(2, blogCId);
                ps.setInt(3, staffId);
                ps.setString(4, blog_detail);
                ps.setBoolean(5, isShow);
                ps.setString(6, blog_detail_short);
                ps.setInt(7, postId);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //hết phần Thể
    public List<Staff> getAllAdmins() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT staff.*\n" +
                "FROM staff\n" +
                "JOIN role ON role.role_id = staff.role_id\n" +
                "WHERE role.role_name = 'Marketing'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Staff(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getDate(8) != null ? rs.getDate(8).toLocalDate() : null,
                        rs.getDate(9) != null ? rs.getDate(9).toLocalDate() : null,
                        rs.getString(10),
                        rs.getBoolean(11),
                        rs.getBoolean(12)
                ));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
