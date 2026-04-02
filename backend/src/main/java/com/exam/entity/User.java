package com.exam.entity;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * 用户实体类（学生/教师/管理员）
 */
public class User implements Serializable {
    private Integer id;

    @NotBlank(message = "用户名不能为空")
    @Size(min = 2, max = 20, message = "用户名长度需在2-20个字符之间")
    private String username;

    @NotBlank(message = "密码不能为空")
    @Size(min = 3, max = 50, message = "密码长度需在3-50个字符之间")
    private String password;

    @NotBlank(message = "真实姓名不能为空")
    @Size(min = 2, max = 20, message = "真实姓名长度需在2-20个字符之间")
    private String realName;

    private Integer role; // 0-管理员 1-教师 2-学生
    private Date createTime;

    public User() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }

    public Integer getRole() { return role; }
    public void setRole(Integer role) { this.role = role; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', realName='" + realName + "', role=" + role + "}";
    }
}
