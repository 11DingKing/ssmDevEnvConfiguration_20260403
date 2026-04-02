<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Shanghai"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${isTeacher}">学生成绩</c:when><c:otherwise>我的成绩</c:otherwise></c:choose></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <h2><c:choose><c:when test="${isTeacher}">学生成绩记录</c:when><c:otherwise>我的成绩记录</c:otherwise></c:choose></h2>
    <table class="data-table">
        <thead>
            <tr>
                <th>序号</th>
                <c:if test="${isTeacher}"><th>学生姓名</th></c:if>
                <th>考试ID</th>
                <th>得分</th>
                <th>提交时间 (北京时间)</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="r" varStatus="s">
                <tr>
                    <td>${(page.pageNum - 1) * page.pageSize + s.index + 1}</td>
                    <c:if test="${isTeacher}"><td>${r.studentName}</td></c:if>
                    <td>${r.examId}</td>
                    <td>${r.score}</td>
                    <td><fmt:formatDate value="${r.submitTime}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="Asia/Shanghai"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty page.list}">
                <tr><td colspan="${isTeacher ? 5 : 4}" style="color:#999; padding:24px;">暂无考试记录</td></tr>
            </c:if>
        </tbody>
    </table>

    <c:if test="${page.totalPages > 1}">
    <div class="pagination">
        <c:choose>
            <c:when test="${page.hasPrev}"><a href="${pageContext.request.contextPath}/exam/records?pageNum=${page.pageNum - 1}">上一页</a></c:when>
            <c:otherwise><span class="page-disabled">上一页</span></c:otherwise>
        </c:choose>
        <c:forEach begin="1" end="${page.totalPages}" var="i">
            <c:choose>
                <c:when test="${i == page.pageNum}"><span class="page-current">${i}</span></c:when>
                <c:otherwise><a href="${pageContext.request.contextPath}/exam/records?pageNum=${i}">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${page.hasNext}"><a href="${pageContext.request.contextPath}/exam/records?pageNum=${page.pageNum + 1}">下一页</a></c:when>
            <c:otherwise><span class="page-disabled">下一页</span></c:otherwise>
        </c:choose>
        <span class="page-info">共 ${page.total} 条</span>
    </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/exam/list" class="btn" style="margin-top:16px;">返回考试列表</a>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
</body>
</html>
