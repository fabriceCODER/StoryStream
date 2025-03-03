package com.example.bookstore.dao;

import com.example.bookstore.models.User;

public interface IUserDAO {
    User loginUser(String username, String password);
    boolean registerUser(User user);
    User getUserById(int id);
}
