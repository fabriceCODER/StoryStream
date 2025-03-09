package com.example.bookstore.utils;

//import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
//    private static final Dotenv dotenv = Dotenv.load();

    private static final String URL = "jdbc:postgresql://localhost:5432/online_bookstore";
    private static final String USER = "postgres";
    private static final String PASSWORD = "root";

    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Database connection failed.");
        }
    }
}
