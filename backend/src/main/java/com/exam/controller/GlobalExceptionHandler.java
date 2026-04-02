package com.exam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;

/**
 * 全局异常处理器：捕获所有未处理异常，返回友好错误页面并记录日志
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /** 参数校验异常 */
    @ExceptionHandler(ConstraintViolationException.class)
    public ModelAndView handleValidationException(HttpServletRequest request, ConstraintViolationException ex) {
        log.warn("参数校验异常: URI={}, 错误={}", request.getRequestURI(), ex.getMessage());
        ModelAndView mv = new ModelAndView("error");
        mv.addObject("errorMsg", "输入参数不合法，请检查后重试");
        mv.addObject("url", request.getRequestURI());
        return mv;
    }

    /** 非法参数异常 */
    @ExceptionHandler(IllegalArgumentException.class)
    public ModelAndView handleIllegalArgument(HttpServletRequest request, IllegalArgumentException ex) {
        log.warn("非法参数: URI={}, 错误={}", request.getRequestURI(), ex.getMessage());
        ModelAndView mv = new ModelAndView("error");
        mv.addObject("errorMsg", ex.getMessage());
        mv.addObject("url", request.getRequestURI());
        return mv;
    }

    /** 通用异常兜底 */
    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(HttpServletRequest request, Exception ex) {
        log.error("系统异常: URI={}, 异常类型={}, 消息={}", request.getRequestURI(), ex.getClass().getSimpleName(), ex.getMessage(), ex);
        ModelAndView mv = new ModelAndView("error");
        mv.addObject("errorMsg", "系统繁忙，请稍后再试");
        mv.addObject("url", request.getRequestURI());
        return mv;
    }
}
