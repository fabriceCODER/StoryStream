package com.example.bookstore.daoImpl;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.models.User;
import com.example.bookstore.utils.DbConnection;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class UserDAOImpl implements IUserDAO {

    @Override
    public User loginUser(String username, String password) {
        User user = findByUsername(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
            pstmt.setString(3, user.getRole());
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                System.out.println("User registered successfully: " + user.getUsername());
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User getUserByUsername(String username) {
        return findByUsername(username);
    }

    @Override
    public User authenticate(String username, String password) {
        User user = findByUsername(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error finding user by username: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void save(User user) {
        if (findByUsername(user.getUsername()) != null) {
            // Update existing user
            String sql = "UPDATE users SET password = ?, role = ? WHERE username = ?";
            try (Connection conn = DbConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
                pstmt.setString(2, user.getRole());
                pstmt.setString(3, user.getUsername());
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("Error updating user: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            // Insert new user
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            try (Connection conn = DbConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, user.getUsername());
                pstmt.setString(2, BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
                pstmt.setString(3, user.getRole());
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("Error saving new user: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    @Override
    public long getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total users: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        return user;
    }
}
