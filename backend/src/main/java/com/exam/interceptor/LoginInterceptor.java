package com.exam.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截器：未登录用户重定向到登录页
 */
public class LoginInterceptor implements HandlerInterceptor {

    private static final Logger log = LoggerFactory.getLogger(LoginInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("loginUser");
        if (user != null) {
            return true;
        }
        log.warn("未登录访问被拦截: {} {}", request.getMethod(), request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/user/loginPage");
        return false;
    }
}
