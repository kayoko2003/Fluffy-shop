package dal;

import model.Slider;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO extends DBContext {
    public List<Slider> listAllSlider(int currentPage, int itemsPerPage, String search, Boolean status) {
        List<Slider> sliders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM slider WHERE (title LIKE ? OR backlink LIKE ?)");
        if (status != null) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            int paramIndex = 3;
            if (status != null) {
                ps.setBoolean(paramIndex++, status);
            }
            ps.setInt(paramIndex++, (currentPage - 1) * itemsPerPage);
            ps.setInt(paramIndex, itemsPerPage);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setId(rs.getInt("id"));
                slider.setTitle(rs.getString("title"));
                slider.setBacklink(rs.getString("backlink"));
                slider.setImage(rs.getString("image"));
                slider.setStatus(rs.getBoolean("status"));
                slider.setNote(rs.getString("notes"));
                sliders.add(slider);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public int getTotalSliderCount(String search, Boolean status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM slider WHERE (title LIKE ? OR backlink LIKE ?)");
        if (status != null) {
            sql.append(" AND status = ?");
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            if (status != null) {
                ps.setBoolean(3, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Slider getSliderById(int id) {
        Slider slider = null;
        try {
            String sql = "SELECT * FROM slider WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                slider = new Slider(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("backlink"),
                        rs.getBoolean("status"),
                        rs.getString("notes")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return slider;
    }

    public void updateSlider(Slider slider) {
            String sql;
            if(slider.getImage() == null) {
                sql = "UPDATE slider SET title = ?, backlink = ?, status = ?, notes = ? WHERE id = ?";
            }else{
                sql = "UPDATE slider SET title = ?, image = ?, backlink = ?, status = ?, notes = ? WHERE id = ?";
            }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, slider.getTitle());
            if(slider.getImage() != null) {
                ps.setString(2, slider.getImage());
                ps.setString(3, slider.getBacklink());
                ps.setBoolean(4, slider.isStatus());
                ps.setString(5, slider.getNote());
                ps.setInt(6, slider.getId());
            }else {
                ps.setString(2, slider.getBacklink());
                ps.setBoolean(3, slider.isStatus());
                ps.setString(4, slider.getNote());
                ps.setInt(5, slider.getId());
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Slider> getAllSlider() {
        List<Slider> sliders = new ArrayList<>();
        String sql = "SELECT * FROM slider";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("image"),
                        rs.getString("backlink"),
                        rs.getBoolean("status"),
                        rs.getString("notes"));
                sliders.add(slider);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return sliders;
    }

    public static void main(String[] args) {
        SliderDAO dao = new SliderDAO();
        List<Slider> sliders = dao.listAllSlider(1, 5, "hihi",  true);
        System.out.printf(sliders.toString());
    }
}
