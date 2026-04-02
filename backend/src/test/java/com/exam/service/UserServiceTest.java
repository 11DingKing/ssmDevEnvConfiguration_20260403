package com.exam.service;

import com.exam.entity.User;
import com.exam.mapper.UserMapper;
import com.exam.service.impl.UserServiceImpl;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

/**
 * UserService 单元测试
 */
public class UserServiceTest {

    @Mock
    private UserMapper userMapper;

    @InjectMocks
    private UserServiceImpl userService;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testLoginSuccess() {
        User mockUser = new User();
        mockUser.setId(1);
        mockUser.setUsername("admin");
        mockUser.setRole(0);
        when(userMapper.findByUsernameAndPassword("admin", "admin123")).thenReturn(mockUser);

        User result = userService.login("admin", "admin123");
        assertNotNull("登录成功应返回用户对象", result);
        assertEquals("admin", result.getUsername());
        verify(userMapper, times(1)).findByUsernameAndPassword("admin", "admin123");
    }

    @Test
    public void testLoginFail() {
        when(userMapper.findByUsernameAndPassword("wrong", "wrong")).thenReturn(null);

        User result = userService.login("wrong", "wrong");
        assertNull("登录失败应返回null", result);
    }

    @Test
    public void testFindAll() {
        User u1 = new User(); u1.setId(1); u1.setUsername("admin");
        User u2 = new User(); u2.setId(2); u2.setUsername("teacher");
        when(userMapper.findAll()).thenReturn(Arrays.asList(u1, u2));

        List<User> users = userService.findAll();
        assertEquals("应返回2个用户", 2, users.size());
    }

    @Test
    public void testRegisterSuccess() {
        User user = new User();
        user.setUsername("newuser");
        user.setPassword("123456");
        user.setRealName("新用户");
        when(userMapper.insert(user)).thenReturn(1);

        boolean result = userService.register(user);
        assertTrue("注册应成功", result);
    }

    @Test
    public void testRegisterDuplicate() {
        User user = new User();
        user.setUsername("admin");
        when(userMapper.insert(user)).thenThrow(new RuntimeException("Duplicate entry"));

        boolean result = userService.register(user);
        assertFalse("重复用户名注册应失败", result);
    }

    @Test
    public void testDeleteById() {
        when(userMapper.deleteById(1)).thenReturn(1);
        assertTrue(userService.deleteById(1));

        when(userMapper.deleteById(999)).thenReturn(0);
        assertFalse(userService.deleteById(999));
    }
}
