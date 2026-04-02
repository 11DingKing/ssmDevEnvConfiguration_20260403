package com.exam.mapper;

import com.exam.entity.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 用户 Mapper 接口
 */
public interface UserMapper {
    /** 根据用户名和密码查询用户（登录） */
    User findByUsernameAndPassword(@Param("username") String username,
                                   @Param("password") String password);

    /** 查询所有用户 */
    List<User> findAll();
    List<User> findPage(@Param("offset") int offset, @Param("pageSize") int pageSize);
    int countAll();

    /** 根据 ID 查询用户 */
    User findById(Integer id);

    /** 新增用户 */
    int insert(User user);

    /** 更新用户 */
    int update(User user);

    /** 删除用户 */
    int deleteById(Integer id);
}
