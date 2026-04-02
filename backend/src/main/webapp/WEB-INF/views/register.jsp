<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>考试系统 - 注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container login-container">
    <h2>用户注册</h2>
    <c:if test="${not empty msg}">
        <p class="error-msg">${msg}</p>
    </c:if>
    <form id="registerForm" action="${pageContext.request.contextPath}/user/register" method="post" novalidate>
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" placeholder="2-20个字符">
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" placeholder="6-50个字符">
        </div>
        <div class="form-group">
            <label for="realName">真实姓名</label>
            <input type="text" id="realName" name="realName" placeholder="请输入真实姓名">
        </div>
        <button type="submit" class="btn btn-primary">注 册</button>
    </form>
    <p class="link-text">
        已有账号？<a href="${pageContext.request.contextPath}/user/loginPage">返回登录</a>
    </p>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
document.getElementById('registerForm').onsubmit = function(e) {
    e.preventDefault();
    var ok = validateForm(this, [
        { name: 'username', label: '用户名', required: true, minLength: 2, maxLength: 20,
          pattern: /^[a-zA-Z0-9_\u4e00-\u9fa5]+$/, message: '用户名只能包含字母、数字、下划线或中文' },
        { name: 'password', label: '密码', required: true, minLength: 6, maxLength: 50 },
        { name: 'realName', label: '真实姓名', required: true, minLength: 2, maxLength: 20 }
    ]);
    if (ok) this.submit();
};
</script>
</body>
</html>
