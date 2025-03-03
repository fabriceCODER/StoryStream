package com.example.bookstore.utils;

import java.sql.Connection;

public class DbConnection {
    public static Connection getConnection() {
        System.out.println("Connecting to database...");
    }
}
