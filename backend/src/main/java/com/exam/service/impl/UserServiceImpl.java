package com.exam.service.impl;

import com.exam.entity.User;
import com.exam.entity.PageResult;
import com.exam.mapper.UserMapper;
import com.exam.service.UserService;
import com.exam.util.MD5Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String username, String password) {
        log.debug("执行登录查询: username={}", username);
        String encryptedPassword = MD5Util.md5(password);
        return userMapper.findByUsernameAndPassword(username, encryptedPassword);
    }

    @Override
    public List<User> findAll() {
        log.debug("查询所有用户");
        return userMapper.findAll();
    }

    @Override
    public PageResult<User> findPage(int pageNum, int pageSize) {
        int total = userMapper.countAll();
        int offset = (pageNum - 1) * pageSize;
        List<User> list = userMapper.findPage(offset, pageSize);
        return new PageResult<>(list, pageNum, pageSize, total);
    }

    @Override
    public User findById(Integer id) {
        log.debug("根据ID查询用户: id={}", id);
        return userMapper.findById(id);
    }

    @Override
    public boolean register(User user) {
        log.info("注册新用户: username={}, realName={}", user.getUsername(), user.getRealName());
        try {
            user.setPassword(MD5Util.md5(user.getPassword()));
            return userMapper.insert(user) > 0;
        } catch (Exception e) {
            log.error("注册用户失败: username={}, 原因={}", user.getUsername(), e.getMessage());
            return false;
        }
    }

    @Override
    public boolean update(User user) {
        log.info("更新用户信息: id={}", user.getId());
        return userMapper.update(user) > 0;
    }

    @Override
    public boolean deleteById(Integer id) {
        log.info("删除用户: id={}", id);
        return userMapper.deleteById(id) > 0;
    }
}
