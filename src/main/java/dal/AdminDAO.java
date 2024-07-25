package dal;

import de.svws_nrw.ext.jbcrypt.BCrypt;
import model.Role;
import model.Staff;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO extends DBContext {
    public static void main(String[] args) {
        AdminDAO dao = new AdminDAO();
        List<Role> roles = dao.getAllRole();
//        System.out.println(dao.getTotalStaffCount("", "", "activate", ""));
        List<Staff> list = dao.searchStaffByRoleID(3);
        System.out.println(list);
    }

    public void updateProfile(String address, String phone, int id){
        String sql = "update staff set address=?, phone=? where id=?";
        String query = "update staff\n"
                + "set address = ?,\n"
                + "phone_number = ?\n"
                + "where staff_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, address);
            ps.setString(2, phone);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getTotalStaffCount(String txtSearch, String genderPara, String statusPara, String role) {
        String sql = "SELECT COUNT(*) \n" +
                "FROM staff a\n" +
                "JOIN role r ON a.role_id = r.role_id\n" +
                "Where (a.fullname like ?\n" +
                "or email like ?\n" +
                "or a.phone_number like ?\n)" +
                "AND a.gender like ?\n" +
                "AND a.status like ?\n" +
                "AND r.role_name like ?";
        String gender = "";
        if (!genderPara.equals("")) {
            gender = genderPara.equals("male") ? "1" : "0";
        }
        String status = "";
        if (!statusPara.equals("")) {
            status = statusPara.equals("activate") ? "1" : "0";
        }
        int totalStaff = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + txtSearch + "%");
            ps.setString(2, "%" + txtSearch + "%");
            ps.setString(3, "%" + txtSearch + "%");
            ps.setString(4, "%" + gender + "%");
            ps.setString(5, "%" + status + "%");
            ps.setString(6, "%" + role + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalStaff = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalStaff;
    }

    public void updateStaff(String role, String status, String sid) {
        AdminDAO dao = new AdminDAO();
        String query = "update staff\n"
                + "set status = ?,\n"
                + "role_id = ?\n"
                + "where staff_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, status.equals("activate") ? "1" : "0");
            ps.setInt(2, dao.getRollid(role));
            ps.setString(3, sid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Staff> filterStaff(String genderPara, String role_id, String statusPara, int offset, int limit) {
        List<Staff> list = new ArrayList<>();
        String query = "SELECT a.*, r.role_name\n" +
                "FROM staff a \n" +
                "JOIN role r ON a.role_id = r.role_id\n" +
                "Where a.gender like ?\n" +
                "AND a.status like ?\n" +
                "AND r.role_id like ?\n" +
                "order by a.staff_id\n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        String gender = "";
        if (!genderPara.equals("")) {
            gender = genderPara.equals("male") ? "1" : "0";
        }
        String status = "";
        if (!statusPara.equals("")) {
            status = statusPara.equals("activate") ? "1" : "0";
        }
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + gender + "%");
            ps.setString(2, "%" + status + "%");
            ps.setString(3, "%" + role_id + "%");
            ps.setInt(4, offset);
            ps.setInt(5, limit);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(13),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getString(10),
                        rs.getBoolean(11),
                        rs.getBoolean(12))
                );
            }
        } catch (Exception e) {
        }
        if (list.isEmpty()) {
            return null;
        }
        return list;
    }

    public Staff getStaffById(String sId) {
        String sql = "SELECT a.*, r.role_name "
                + "FROM staff a "
                + "JOIN role r ON a.role_id = r.role_id "
                + "WHERE staff_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, sId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    return new Staff(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getString(6),
                            rs.getString(13),
                            rs.getDate(8).toLocalDate(),
                            rs.getDate(9).toLocalDate(),
                            rs.getString(10),
                            rs.getBoolean(11),
                            rs.getBoolean(12)
                    );
                }
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Staff> searchStaff(String txtSearch, int offset, int limit) {
        List<Staff> list = new ArrayList<>();
        String query = "SELECT a.*, r.role_name \n" +
                "FROM staff a \n" +
                "JOIN role r ON a.role_id = r.role_id\n" +
                "Where a.fullname like ?\n" +
                "or a.email like ?\n" +
                "or a.phone_number like ?\n" +
                "order by a.staff_id\n" +
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
                list.add(new Staff(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(13),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getString(10),
                        rs.getBoolean(11),
                        rs.getBoolean(12))
                );
            }
        } catch (Exception e) {

        }
        if (list.isEmpty()) {
            return null;
        }
        return list;
    }
    public List<Staff> searchStaffByRoleID(int roleID) {
        List<Staff> list = new ArrayList<>();
        String query = "SELECT a.*, r.role_name \n" +
                "                FROM staff a \n" +
                "                JOIN role r ON a.role_id = r.role_id\n" +
                "                WHERE a.role_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, roleID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(13),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getString(10),
                        rs.getBoolean(11),
                        rs.getBoolean(12))
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list.isEmpty() ? null : list;
    }


    public boolean addStaff(String email, String fullName, boolean gender, String role, String phoneNumber, String address, String password) {
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String query = "INSERT INTO staff\n"
                + "           ([email]\n"
                + "           ,[password]\n"
                + "           ,[fullname]\n"
                + "           ,[address]\n"
                + "           ,[phone_number]\n"
                + "           ,[role_id]\n"
                + "           ,[create_date]\n"
                + "           ,[update_date]\n"
                + "           ,[status]\n"
                + "           ,[gender]\n"
                + "           ,[avatar])\n"
                + "     VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        java.util.Date currentDate = new java.util.Date();
        SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = date.format(currentDate);
        AdminDAO dao = new AdminDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        if (customerDAO.checkEmailExist(email)) {
            return false;
        } else {
            try {
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, email);
                ps.setString(2, hashedPassword);
                ps.setString(3, fullName);
                ps.setString(4, address);
                ps.setString(5, phoneNumber);
                ps.setInt(6, dao.getRollid(role));
                ps.setString(7, dateString);
                ps.setString(8, dateString);
                ps.setInt(9, 1);
                ps.setBoolean(10, gender);
                ps.setString(11, "Static_access_manager\\assets\\img\\Avatar\\None_avatar.jpg");
                ps.executeUpdate();
            } catch (Exception e) {
            }
            return true;
        }
    }

    public boolean checkExistStaff(String email) {
        String query = "SELECT *\n"
                + "FROM staff\n"
                + "where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {

        }
        return false;
    }

    public int getRollid(String roleName) {
        AdminDAO dao = new AdminDAO();
        List<Role> list = dao.getAllRole();
        for (Role role : list) {
            if (role.getrName().equals(roleName)) {
                return role.getrID();
            }
        }
        return 0;
    }

    public List<Role> getAllRole() {
        List<Role> list = new ArrayList<>();
        String query = "SELECT *"
                + "FROM role";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Role(rs.getInt(1),
                        rs.getString(2))
                );
            }
        } catch (Exception e) {

        }
        return list;
    }

    public List<Staff> listStaff(int offset, int limit) {
        List<Staff> list = new ArrayList<>();
        String query = "SELECT a.*, r.role_name \n" +
                "FROM staff a \n" +
                "JOIN role r ON a.role_id = r.role_id\n" +
                "order by a.staff_id\n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Staff(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(13),
                        rs.getDate(8).toLocalDate(),
                        rs.getDate(9).toLocalDate(),
                        rs.getString(10),
                        rs.getBoolean(11),
                        rs.getBoolean(12))
                );
            }
        } catch (Exception e) {

        }
        if (list.isEmpty()) {
            return null;
        }
        return list;
    }

    public void changePass(String pass, String email) {
        String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
        String query = "update staff\n"
                + "set password = ?\n"
                + "where email =?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public String getPass(String email) {
        String query = "select *\n"
                + "from staff\n"
                + "where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(3);
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Staff loginStaff(String email, String password) {
        String sql = "SELECT a.*, r.role_name "
                + "FROM staff a "
                + "JOIN role r ON a.role_id = r.role_id "
                + "WHERE a.email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    return new Staff(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getString(5),
                            rs.getString(6),
                            rs.getString(13),
                            rs.getDate(8).toLocalDate(),
                            rs.getDate(9).toLocalDate(),
                            rs.getString(10),
                            rs.getBoolean(11),
                            rs.getBoolean(12)
                    );
                }
            }
        } catch (
                SQLException e) {
        }
        return null;
    }

}
