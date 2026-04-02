package com.exam.controller;

import com.exam.entity.User;
import com.exam.entity.PageResult;
import com.exam.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

/**
 * 用户控制器：登录、注册、用户管理
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @GetMapping("/loginPage")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        HttpSession session, Model model) {
        log.info("用户登录请求: username={}", username);

        if (username == null || username.trim().isEmpty()) {
            model.addAttribute("msg", "用户名不能为空");
            return "login";
        }
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("msg", "密码不能为空");
            return "login";
        }

        User user = userService.login(username.trim(), password);
        if (user != null) {
            session.setAttribute("loginUser", user);
            log.info("用户登录成功: {}", user);
            return "redirect:/exam/list";
        }

        log.warn("用户登录失败: username={}", username);
        model.addAttribute("msg", "用户名或密码错误，请重新输入");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        Object user = session.getAttribute("loginUser");
        log.info("用户注销: {}", user);
        session.invalidate();
        return "redirect:/user/loginPage";
    }

    @GetMapping("/registerPage")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@Valid User user, BindingResult result, Model model) {
        log.info("用户注册请求: username={}", user.getUsername());

        if (result.hasErrors()) {
            String errorMsg = result.getFieldError().getDefaultMessage();
            log.warn("注册参数校验失败: {}", errorMsg);
            model.addAttribute("msg", errorMsg);
            return "register";
        }

        user.setRole(2); // 默认注册为学生
        if (userService.register(user)) {
            log.info("用户注册成功: {}", user.getUsername());
            return "redirect:/user/loginPage";
        }

        log.error("用户注册失败: {}", user.getUsername());
        model.addAttribute("msg", "注册失败，用户名可能已存在");
        return "register";
    }

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum, Model model) {
        log.debug("查询用户列表: page={}", pageNum);
        PageResult<User> page = userService.findPage(pageNum, 10);
        model.addAttribute("page", page);
        return "user/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        log.info("删除用户: id={}", id);
        userService.deleteById(id);
        return "redirect:/user/list";
    }
}
