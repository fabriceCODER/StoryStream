package com.example.bookstore.servicesImpl;

import com.example.bookstore.dao.IUserDAO;
import com.example.bookstore.daoImpl.UserDAOImpl;
import com.example.bookstore.models.User;
import com.example.bookstore.services.IUserService;


public class UserServiceImpl implements IUserService {
    private final IUserDAO userDAO = new UserDAOImpl();

    @Override
    public User loginUser(String username, String password) {
        return userDAO.loginUser(username, password);
    }

    @Override
    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    @Override
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }
}
