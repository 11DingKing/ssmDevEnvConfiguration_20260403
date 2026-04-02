<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>题库管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <div class="header">
        <h2>题库管理</h2>
        <div>
            <a href="${pageContext.request.contextPath}/question/addPage" class="btn btn-success">添加题目</a>
            <a href="${pageContext.request.contextPath}/exam/list" class="btn">返回</a>
        </div>
    </div>

    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>题型</th>
                <th>题目内容</th>
                <th>正确答案</th>
                <th>分值</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="q">
                <tr>
                    <td>${q.id}</td>
                    <td>
                        <c:choose>
                            <c:when test="${q.type==1}">单选</c:when>
                            <c:when test="${q.type==2}">多选</c:when>
                            <c:when test="${q.type==3}">判断</c:when>
                            <c:when test="${q.type==4}">填空</c:when>
                            <c:otherwise>简答</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${q.content}</td>
                    <td>
                        <c:choose>
                            <c:when test="${q.type==3 && q.answer=='T'}">正确</c:when>
                            <c:when test="${q.type==3 && q.answer=='F'}">错误</c:when>
                            <c:otherwise>${q.answer}</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${q.score}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/question/editPage/${q.id}" class="btn btn-sm">编辑</a>
                        <a href="javascript:void(0)" class="btn btn-sm btn-danger"
                           data-delete-url="${pageContext.request.contextPath}/question/delete/${q.id}"
                           data-delete-name="第${q.id}题">删除</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty page.list}">
                <tr><td colspan="6" style="color:#999; padding:24px;">暂无题目数据</td></tr>
            </c:if>
        </tbody>
    </table>

    <c:if test="${page.totalPages > 1}">
    <div class="pagination">
        <c:choose>
            <c:when test="${page.hasPrev}"><a href="${pageContext.request.contextPath}/question/list?pageNum=${page.pageNum - 1}">上一页</a></c:when>
            <c:otherwise><span class="page-disabled">上一页</span></c:otherwise>
        </c:choose>
        <c:forEach begin="1" end="${page.totalPages}" var="i">
            <c:choose>
                <c:when test="${i == page.pageNum}"><span class="page-current">${i}</span></c:when>
                <c:otherwise><a href="${pageContext.request.contextPath}/question/list?pageNum=${i}">${i}</a></c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${page.hasNext}"><a href="${pageContext.request.contextPath}/question/list?pageNum=${page.pageNum + 1}">下一页</a></c:when>
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
        showConfirm('确定要删除「' + name + '」吗？删除后无法恢复。', function() {
            window.location.href = url;
        });
    };
});
</script>
</body>
</html>
