/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBContext {
    public static Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://" + serverName + ":" + portNumber +
                    ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, userID, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private final String serverName = "localhost\\SQLEXPRESS";
    private final String dbName = "Fluffy_Shop";
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "kayokocute2003";
}