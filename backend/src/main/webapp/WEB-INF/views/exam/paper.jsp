<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${exam.examName} - 答题</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <div class="paper-header">
        <h2>${exam.examName}</h2>
        <p>考试时长：${exam.duration} 分钟 | 总分：${exam.totalScore} 分</p>
    </div>

    <form id="paperForm" action="${pageContext.request.contextPath}/exam/submit" method="post">
        <input type="hidden" name="examId" value="${exam.id}">
        <input type="hidden" name="questionCount" value="${questions.size()}">

        <c:forEach items="${questions}" var="q" varStatus="s">
            <div class="question-item" data-index="${s.index}">
                <p class="question-title">第${s.index + 1}题（${q.score}分）：${q.content}</p>
                <c:if test="${q.type == 1}">
                    <div class="options">
                        <label><input type="radio" name="answer_${s.index}" value="A"> A. ${q.optionA}</label>
                        <label><input type="radio" name="answer_${s.index}" value="B"> B. ${q.optionB}</label>
                        <label><input type="radio" name="answer_${s.index}" value="C"> C. ${q.optionC}</label>
                        <label><input type="radio" name="answer_${s.index}" value="D"> D. ${q.optionD}</label>
                    </div>
                </c:if>
                <c:if test="${q.type == 2}">
                    <div class="options">
                        <label><input type="checkbox" name="answer_${s.index}" value="A"> A. ${q.optionA}</label>
                        <label><input type="checkbox" name="answer_${s.index}" value="B"> B. ${q.optionB}</label>
                        <label><input type="checkbox" name="answer_${s.index}" value="C"> C. ${q.optionC}</label>
                        <label><input type="checkbox" name="answer_${s.index}" value="D"> D. ${q.optionD}</label>
                    </div>
                </c:if>
                <c:if test="${q.type == 3}">
                    <div class="options">
                        <label><input type="radio" name="answer_${s.index}" value="T"> 正确</label>
                        <label><input type="radio" name="answer_${s.index}" value="F"> 错误</label>
                    </div>
                </c:if>
                <c:if test="${q.type == 4 || q.type == 5}">
                    <textarea name="answer_${s.index}" rows="3" class="form-control" placeholder="请输入答案"></textarea>
                </c:if>
            </div>
        </c:forEach>

        <button type="submit" class="btn btn-primary">提交试卷</button>
    </form>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
document.getElementById('paperForm').onsubmit = function(e) {
    e.preventDefault();
    var form = this;
    var items = document.querySelectorAll('.question-item');
    var unanswered = 0;
    
    // 为每个问题创建隐藏字段，存储答案
    items.forEach(function(item, index) {
        var questionIndex = item.dataset.index;
        var radios = item.querySelectorAll('input[type="radio"]');
        var checkboxes = item.querySelectorAll('input[type="checkbox"]');
        var textarea = item.querySelector('textarea');
        
        // 移除旧的隐藏字段
        var oldHidden = document.querySelector('input[name="answers[' + questionIndex + ']"]');
        if (oldHidden) {
            oldHidden.remove();
        }
        
        if (radios.length > 0) {
            var checked = item.querySelector('input[type="radio"]:checked');
            if (checked) {
                var hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'answers[' + questionIndex + ']';
                hidden.value = checked.value;
                form.appendChild(hidden);
            } else {
                unanswered++;
            }
        } else if (checkboxes.length > 0) {
            var checkedCheckboxes = item.querySelectorAll('input[type="checkbox"]:checked');
            if (checkedCheckboxes.length > 0) {
                var selectedValues = Array.from(checkedCheckboxes).map(cb => cb.value);
                // 对选项进行排序，确保答案格式一致（如"ABC"而不是"BAC"）
                selectedValues.sort();
                var hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'answers[' + questionIndex + ']';
                hidden.value = selectedValues.join('');
                form.appendChild(hidden);
            } else {
                unanswered++;
            }
        } else if (textarea) {
            if (textarea.value.trim() !== '') {
                var hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'answers[' + questionIndex + ']';
                hidden.value = textarea.value.trim();
                form.appendChild(hidden);
            } else {
                unanswered++;
            }
        }
    });
    
    var msg = '确定要提交试卷吗？提交后不可修改。';
    if (unanswered > 0) {
        msg = '您还有 ' + unanswered + ' 道题未作答，确定要提交试卷吗？提交后不可修改。';
    }
    
    showConfirm(msg, function() {
        showToast('正在提交试卷...', 'info');
        form.submit();
    });
};
</script>
</body>
</html>
