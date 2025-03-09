package com.example.bookstore.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.github.cdimascio.dotenv.Dotenv;

import java.sql.Connection;
import java.sql.SQLException;

public class DbConnection {
    private static HikariDataSource dataSource;

    static {
        try {
            Dotenv dotenv = Dotenv.load();
            
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(dotenv.get("DB_URL", "jdbc:postgresql://localhost:5432/online_bookstore"));
            config.setUsername(dotenv.get("DB_USERNAME", "postgres"));
            config.setPassword(dotenv.get("DB_PASSWORD", "root"));
            
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
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to initialize database connection pool: " + e.getMessage(), e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            Connection connection = dataSource.getConnection();
            if (connection == null || !connection.isValid(1)) {
                throw new SQLException("Failed to obtain valid database connection");
            }
            return connection;
        } catch (SQLException e) {
            throw new SQLException("Database connection failed: " + e.getMessage(), e);
        }
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                // Log the error but don't throw
                e.printStackTrace();
            }
        }
    }

    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}
