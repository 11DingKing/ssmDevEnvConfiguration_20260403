<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Shanghai"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>考试结果</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container" style="text-align:center; padding-top:80px;">
    <h2>考试提交成功</h2>
    <p class="score-display">您的得分：<span>${score}</span> 分</p>
    <p style="color:#999; margin-bottom:24px;">
        提交时间：<jsp:useBean id="now" class="java.util.Date"/>
        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="Asia/Shanghai"/> (北京时间)
    </p>
    <a href="${pageContext.request.contextPath}/exam/list" class="btn btn-primary">返回考试列表</a>
    <a href="${pageContext.request.contextPath}/exam/records" class="btn">查看成绩记录</a>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
    showToast('试卷提交成功，得分：${score} 分', 'success');
</script>
</body>
</html>
