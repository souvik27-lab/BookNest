package com.booknest.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con;

    public static Connection getConnection() {
        try {

            if (con == null || con.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db = System.getenv("MYSQLDATABASE");
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                String url = "jdbc:mysql://" + host + ":" + port + "/" + db +
                        "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

                con = DriverManager.getConnection(url, user, pass);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
