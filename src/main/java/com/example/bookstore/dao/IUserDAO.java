package com.example.bookstore.dao;

import com.example.bookstore.models.User;

public interface IUserDAO {
    User loginUser(String username, String password);
    boolean registerUser(User user);
    User getUserById(int id);
    User getUserByUsername(String username);
    User authenticate(String username, String password);
    User findByUsername(String username);
    void save(User user);
    long getTotalUsers();
}
