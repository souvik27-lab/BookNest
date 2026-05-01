package com.booknest.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/bookstore_db?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true",
"root",
"root123"

            );
            System.out.println("DB Connected!");
            return con;
        } catch (Exception e) {
            System.out.println("DB Error: " + e.getMessage());
            return null;
        }
    }
}