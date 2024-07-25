package dal;

import model.PaymentMethod;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentMethodDAO extends DBContext {

    public List<PaymentMethod> listAllPaymentMethods() {
        List<PaymentMethod> listPaymentMethod = new ArrayList<>();
        String sql = "SELECT * FROM Payment_method";
        try {
            Connection connection = PaymentMethodDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String method = resultSet.getString("payment");
                PaymentMethod paymentMethod = new PaymentMethod(id, method);
                listPaymentMethod.add(paymentMethod);
            }
        } catch (Exception e) {
            System.out.println("Get all payment methods: " + e);
        }
        return listPaymentMethod;
    }

    public void insertPaymentMethod(PaymentMethod paymentMethod) {
        String sql = "INSERT INTO Payment_method (payment) VALUES (?)";
        try {
            Connection connection = PaymentMethodDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, paymentMethod.getMethod());
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updatePaymentMethod(PaymentMethod paymentMethod) {
        String sql = "UPDATE Payment_method SET payment = ? WHERE id = ?";
        try {
            Connection connection = PaymentMethodDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, paymentMethod.getMethod());
            statement.setInt(2, paymentMethod.getId());
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePaymentMethod(int id) {
        String sql = "DELETE FROM Payment_method WHERE id = ?";
        try {
            Connection connection = PaymentMethodDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public PaymentMethod getPaymentMethod(int id) {
        PaymentMethod paymentMethod = null;
        String sql = "SELECT * FROM Payment_method WHERE id = ?";
        try {
            Connection connection = PaymentMethodDAO.connection;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String method = resultSet.getString("payment");
                paymentMethod = new PaymentMethod(id, method);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return paymentMethod;
    }
}
