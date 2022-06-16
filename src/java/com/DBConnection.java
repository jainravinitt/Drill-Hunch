package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    static final String URL = "jdbc:mysql://localhost:3306/";
    static final String DATABASE_NAME = "mydb";
    static final String USERNAME = "root";
    static final String PASSWORD = "root";
    static Connection con = null;
        
    public static Connection getConnection() {
        try {
           Class.forName("com.mysql.jdbc.Driver");
           con = DriverManager.getConnection(URL + DATABASE_NAME, USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
    public static void closeConnection() throws SQLException{
        con.close();
    }
}
