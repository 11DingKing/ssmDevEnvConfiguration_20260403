<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Shanghai"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>考试列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h2>考试列表</h2>
        <div class="nav">
            <span>欢迎，${sessionScope.loginUser.realName}</span>
            <a href="${pageContext.request.contextPath}/exam/list">考试列表</a>
            <c:if test="${sessionScope.loginUser.role == 2}">
                <a href="${pageContext.request.contextPath}/exam/records">我的成绩</a>
            </c:if>
            <c:if test="${sessionScope.loginUser.role <= 1}">
                <a href="${pageContext.request.contextPath}/exam/records">学生成绩</a>
                <a href="${pageContext.request.contextPath}/question/list">题库管理</a>
            </c:if>
            <c:if test="${sessionScope.loginUser.role == 0}">
                <a href="${pageContext.request.contextPath}/user/list">用户管理</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/user/logout">退出</a>
        </div>
    </div>

    <c:if test="${sessionScope.loginUser.role <= 1}">
        <a href="${pageContext.request.contextPath}/exam/addPage" class="btn btn-success">新建考试</a>
    </c:if>

    <table class="data-table">
        <thead>
            <tr>
                <th>序号</th>
                <th>考试名称</th>
                <th>考试时长(分钟)</th>
                <th>总分</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="exam" varStatus="s">
                <tr>
                    <td>${(page.pageNum - 1) * page.pageSize + s.index + 1}</td>
                    <td>${exam.examName}</td>
                    <td>${exam.duration}</td>
                    <td>${exam.totalScore}</td>
                    <td>
                        <c:if test="${sessionScope.loginUser.role == 2}">
                            <a href="${pageContext.request.contextPath}/exam/start/${exam.id}" class="btn btn-sm btn-primary">参加考试</a>
                        </c:if>
                        <c:if test="${sessionScope.loginUser.role <= 1}">
                            <a href="javascript:void(0)" class="btn btn-sm btn-danger"
                               data-delete-url="${pageContext.request.contextPath}/exam/delete/${exam.id}"
                               data-delete-name="${exam.examName}">删除</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${page.totalPages > 1}">
    <div class="pagination">
        <c:choose>
            <c:when test="${page.hasPrev}"><a href="${pageContext.request.contextPath}/exam/list?pageNum=${page.pageNum - 1}">上一页</a></c:when>
            <c:otherwise><span class="page-disabled">上一页</span></c:otherwise>
        </c:choose>
        <c:forEach begin="1" end="${page.totalPages}" var="i">
            <c:choose>
                <c:when test="${i == page.pageNum}"><span class="page-current">${i}</span></c:when>
                <c:otherwise><a href="${pageContext.request.contextPath}/exam/list?pageNum=${i}">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${page.hasNext}"><a href="${pageContext.request.contextPath}/exam/list?pageNum=${page.pageNum + 1}">下一页</a></c:when>
            <c:otherwise><span class="page-disabled">下一页</span></c:otherwise>
        </c:choose>
        <span class="page-info">共 ${page.total} 条</span>
    </div>
    </c:if>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
document.querySelectorAll('[data-delete-url]').forEach(function(btn) {
    btn.onclick = function() {
        var name = this.getAttribute('data-delete-name');
        var url = this.getAttribute('data-delete-url');
        showConfirm('确定要删除考试「' + name + '」吗？删除后无法恢复。', function() {
            window.location.href = url;
        });
    };
});
</script>
</body>
</html>
