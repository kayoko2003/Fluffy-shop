/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.StatusOrder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class StatusOrderDAO extends DBContext {

    public List<StatusOrder> listAllStatusOrders() {
        List<StatusOrder> listStatusOrder = new ArrayList<>();
        String sql = "SELECT * FROM Status_order";
        try {
            Connection connection = StatusOrderDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String status = resultSet.getString("status");
                StatusOrder statusOrder = new StatusOrder(id, status);
                listStatusOrder.add(statusOrder);
            }
        } catch (Exception e) {
            System.out.println("Get all status order: " + e);
        }
        return listStatusOrder;
    }

    public void insertStatusOrder(StatusOrder statusOrder) {
        String sql = "INSERT INTO Status_order (status) VALUES (?)";
        try {
            Connection connection = StatusOrderDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, statusOrder.getStatus());
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStatusOrder(StatusOrder statusOrder) {
        String sql = "UPDATE Status_order SET status = ? WHERE id = ?";
        try {
            Connection connection = StatusOrderDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, statusOrder.getStatus());
            statement.setInt(2, statusOrder.getId());
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteStatusOrder(int id) {
        String sql = "DELETE FROM Status_order WHERE id = ?";
        try {
            Connection connection = StatusOrderDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public StatusOrder getStatusOrder(int id) {
        StatusOrder statusOrder = null;
        String sql = "SELECT * FROM Status_order WHERE id = ?";
        try {
            Connection connection = StatusOrderDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String status = resultSet.getString("status");
                statusOrder = new StatusOrder(id, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return statusOrder;
    }
}
