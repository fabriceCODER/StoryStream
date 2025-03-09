package com.example.bookstore.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.github.cdimascio.dotenv.Dotenv;

import java.sql.Connection;
import java.sql.SQLException;

public class DbConnection {
    private static HikariDataSource dataSource;
    private static final String DEFAULT_DB_URL = "jdbc:postgresql://localhost:5432/online_bookstore";
    private static final String DEFAULT_DB_USER = "postgres";
    private static final String DEFAULT_DB_PASSWORD = "root";

    static {
        try {
            String dbUrl;
            String dbUser;
            String dbPassword;

            try {
                // Try to load from .env file
                Dotenv dotenv = Dotenv.configure()
                        .directory("src/main/resources")
                        .ignoreIfMissing()
                        .load();
                
                // Get values from .env or use defaults
                dbUrl = dotenv.get("DB_URL", DEFAULT_DB_URL);
                dbUser = dotenv.get("DB_USERNAME", DEFAULT_DB_USER);
                dbPassword = dotenv.get("DB_PASSWORD", DEFAULT_DB_PASSWORD);
                
                System.out.println("Using database configuration from .env file");
            } catch (Exception e) {
                // If .env file is not found or any other error, use default values
                System.out.println("No .env file found or error reading it, using default database configuration");
                System.out.println("Error details: " + e.getMessage());
                dbUrl = DEFAULT_DB_URL;
                dbUser = DEFAULT_DB_USER;
                dbPassword = DEFAULT_DB_PASSWORD;
            }

            System.out.println("Attempting to connect to database with URL: " + dbUrl);
            
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(dbUrl);
            config.setUsername(dbUser);
            config.setPassword(dbPassword);
            
            // Connection pool settings
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(5);
            config.setIdleTimeout(300000);
            config.setConnectionTimeout(20000);
            
            // PostgreSQL specific settings
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            
            dataSource = new HikariDataSource(config);
            
            // Test the connection
            try (Connection conn = dataSource.getConnection()) {
                if (!conn.isValid(1)) {
                    throw new SQLException("Failed to validate database connection");
                }
                System.out.println("Database connection test successful");
            }
        } catch (SQLException e) {
            String errorMessage = "Failed to initialize database connection pool: " + e.getMessage();
            System.err.println(errorMessage);
            e.printStackTrace();
            throw new RuntimeException(errorMessage, e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("Database connection pool has not been initialized");
        }
        
        try {
            Connection connection = dataSource.getConnection();
            if (connection == null || !connection.isValid(1)) {
                throw new SQLException("Failed to obtain valid database connection");
            }
            return connection;
        } catch (SQLException e) {
            String errorMessage = "Database connection failed: " + e.getMessage();
            System.err.println(errorMessage);
            e.printStackTrace();
            throw new SQLException(errorMessage, e);
        }
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("Database connection pool has been shut down");
        }
    }
}
