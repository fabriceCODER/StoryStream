package com.example.bookstore.models;

public class User {
    private int id;
    private String username;
    private String password;
    private String role;

    public User() {
        this.role = "user"; // Default role
    }

    public User(int id, String username, String password, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        setRole(role); // Use setter for validation
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
        this.role = "user"; // Default role
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username cannot be empty");
        }
        this.username = username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        if (role == null || role.trim().isEmpty()) {
            this.role = "user"; // Default to user if role is empty
        } else {
            // Normalize role to lowercase
            String normalizedRole = role.trim().toLowerCase();
            if (normalizedRole.equals("admin") || normalizedRole.equals("user")) {
                this.role = normalizedRole;
            } else {
                this.role = "user"; // Default to user for invalid roles
            }
        }
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", role='" + role + '\'' +
                '}';
    }

    public void setEmail(String email) {

    }
}
