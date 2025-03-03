package com.example.bookstore.services;

import com.example.bookstore.models.User;

public interface IUserService {
    User loginUser(String username, String password);
    boolean registerUser(User user);
    User getUserById(int id);
}
