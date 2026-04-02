<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>新建考试 - 组卷</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <h2>新建考试（组卷）</h2>
    <c:if test="${not empty msg}">
        <p class="error-msg">${msg}</p>
    </c:if>
    <form id="examForm" action="${pageContext.request.contextPath}/exam/add" method="post" novalidate>
        <div class="form-group">
            <label>考试名称</label>
            <input type="text" name="examName" placeholder="请输入考试名称">
        </div>
        <div class="form-group">
            <label>科目ID</label>
            <input type="number" name="subjectId" placeholder="请输入科目编号" min="1">
        </div>
        <div class="form-group">
            <label>考试时长(分钟)</label>
            <input type="number" name="duration" placeholder="如：60、90、120" min="1" max="600">
        </div>

        <div class="form-group">
            <label>选择题目（勾选要加入考试的题目）</label>
            <div class="question-select-summary">
                已选 <span id="selectedCount">0</span> 题，总分：<span id="totalScore">0</span> 分
            </div>
            <table class="data-table" id="questionTable">
                <thead>
                    <tr>
                        <th style="width:50px;"><input type="checkbox" id="selectAll"></th>
                        <th>ID</th>
                        <th>题型</th>
                        <th>题目内容</th>
                        <th>答案</th>
                        <th>分值</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${questions}" var="q">
                        <tr>
                            <td><input type="checkbox" name="questionIds" value="${q.id}" data-score="${q.score}"></td>
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
                            <td style="text-align:left;">${q.content}</td>
                            <td>${q.answer}</td>
                            <td>${q.score}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty questions}">
                        <tr><td colspan="6" style="color:#999; padding:24px;">暂无题目，请先到题库添加题目</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <button type="submit" class="btn btn-primary">创建考试</button>
        <a href="${pageContext.request.contextPath}/exam/list" class="btn">返回</a>
    </form>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
var selectAll = document.getElementById('selectAll');
var checkboxes = document.querySelectorAll('input[name="questionIds"]');
selectAll.onchange = function() {
    checkboxes.forEach(function(cb) { cb.checked = selectAll.checked; });
    updateSummary();
};
checkboxes.forEach(function(cb) { cb.onchange = updateSummary; });
function updateSummary() {
    var count = 0, total = 0;
    checkboxes.forEach(function(cb) {
        if (cb.checked) { count++; total += parseInt(cb.getAttribute('data-score')) || 0; }
    });
    document.getElementById('selectedCount').textContent = count;
    document.getElementById('totalScore').textContent = total;
}
document.getElementById('examForm').onsubmit = function(e) {
    e.preventDefault();
    var ok = validateForm(this, [
        { name: 'examName', label: '考试名称', required: true, minLength: 2, maxLength: 100 },
        { name: 'subjectId', label: '科目ID', required: true, min: 1 },
        { name: 'duration', label: '考试时长', required: true, min: 1, max: 600 }
    ]);
    if (!ok) return;
    var selected = document.querySelectorAll('input[name="questionIds"]:checked');
    if (selected.length === 0) { showToast('请至少选择一道题目', 'warning'); return; }
    showToast('正在创建考试...', 'info');
    this.submit();
};
</script>
</body>
</html>
