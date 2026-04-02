<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Shanghai"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h2>用户管理</h2>
        <div>
            <a href="${pageContext.request.contextPath}/exam/list" class="btn">返回</a>
        </div>
    </div>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>真实姓名</th>
                <th>角色</th>
                <th>注册时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="u">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.realName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.role==0}">管理员</c:when>
                            <c:when test="${u.role==1}">教师</c:when>
                            <c:otherwise>学生</c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="Asia/Shanghai"/></td>
                    <td>
                        <a href="javascript:void(0)" class="btn btn-sm btn-danger"
                           data-delete-url="${pageContext.request.contextPath}/user/delete/${u.id}"
                           data-delete-name="${u.realName}">删除</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty page.list}">
                <tr><td colspan="6" style="color:#999;padding:24px;">暂无用户数据</td></tr>
            </c:if>
        </tbody>
    </table>
    <c:if test="${page.totalPages > 1}">
    <div class="pagination">
        <c:choose>
            <c:when test="${page.hasPrev}"><a href="${pageContext.request.contextPath}/user/list?pageNum=${page.pageNum - 1}">上一页</a></c:when>
            <c:otherwise><span class="page-disabled">上一页</span></c:otherwise>
        </c:choose>
        <c:forEach begin="1" end="${page.totalPages}" var="i">
            <c:choose>
                <c:when test="${i == page.pageNum}"><span class="page-current">${i}</span></c:when>
                <c:otherwise><a href="${pageContext.request.contextPath}/user/list?pageNum=${i}">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${page.hasNext}"><a href="${pageContext.request.contextPath}/user/list?pageNum=${page.pageNum + 1}">下一页</a></c:when>
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
        showConfirm('确定要删除用户「' + name + '」吗？删除后无法恢复。', function() {
            window.location.href = url;
        });
    };
});
</script>
</body>
</html>
