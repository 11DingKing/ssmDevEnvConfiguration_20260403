<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>出错了</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container" style="text-align:center; padding-top:80px;">
    <h2 style="color:#ff4d4f;">出错了</h2>
    <p style="font-size:16px; color:#666; margin:20px 0;">${errorMsg}</p>
    <p style="font-size:12px; color:#999;">请求地址：${url}</p>
    <a href="${pageContext.request.contextPath}/exam/list" class="btn btn-primary" style="margin-top:24px;">返回首页</a>
</div>
</body>
</html>
