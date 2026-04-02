<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>考试系统 - 登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container login-container">
    <h2>在线考试系统</h2>
    <c:if test="${not empty msg}">
        <p class="error-msg">${msg}</p>
    </c:if>
    <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="post" novalidate>
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" placeholder="请输入用户名">
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" placeholder="请输入密码">
        </div>
        <button type="submit" class="btn btn-primary">登 录</button>
    </form>
    <p class="link-text">
        没有账号？<a href="${pageContext.request.contextPath}/user/registerPage">立即注册</a>
    </p>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
document.getElementById('loginForm').onsubmit = function(e) {
    e.preventDefault();
    var ok = validateForm(this, [
        { name: 'username', label: '用户名', required: true, minLength: 2, maxLength: 20 },
        { name: 'password', label: '密码', required: true, minLength: 3, maxLength: 50 }
    ]);
    if (ok) this.submit();
};
</script>
</body>
</html>
