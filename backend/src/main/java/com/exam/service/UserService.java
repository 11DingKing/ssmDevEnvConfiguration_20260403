package com.exam.service;

import com.exam.entity.User;
import com.exam.entity.PageResult;
import java.util.List;

public interface UserService {
    User login(String username, String password);
    List<User> findAll();
    PageResult<User> findPage(int pageNum, int pageSize);
    User findById(Integer id);
    boolean register(User user);
    boolean update(User user);
    boolean deleteById(Integer id);
}
