<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>添加题目</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <h2>添加题目</h2>
    <form id="questionForm" action="${pageContext.request.contextPath}/question/add" method="post" novalidate>
        <div class="form-group">
            <label>科目ID</label>
            <input type="number" name="subjectId" placeholder="请输入科目编号" min="1">
        </div>
        <div class="form-group">
            <label>题型</label>
            <select name="type" id="questionType">
                <option value="1">单选题</option>
                <option value="2">多选题</option>
                <option value="3">判断题</option>
                <option value="4">填空题</option>
                <option value="5">简答题</option>
            </select>
        </div>
        <div class="form-group">
            <label>题目内容</label>
            <textarea name="content" rows="3" placeholder="请输入题目内容"></textarea>
        </div>
        <div id="optionsGroup">
            <div class="form-group">
                <label>选项A</label>
                <input type="text" name="optionA" placeholder="请输入选项A">
            </div>
            <div class="form-group">
                <label>选项B</label>
                <input type="text" name="optionB" placeholder="请输入选项B">
            </div>
            <div class="form-group">
                <label>选项C</label>
                <input type="text" name="optionC" placeholder="请输入选项C">
            </div>
            <div class="form-group">
                <label>选项D</label>
                <input type="text" name="optionD" placeholder="请输入选项D">
            </div>
        </div>
        <div id="judgmentGroup" style="display:none;">
            <div class="form-group">
                <label>判断答案</label>
                <div class="options-inline">
                    <label><input type="radio" name="judgmentAnswer" value="T"> 对（正确）</label>
                    <label><input type="radio" name="judgmentAnswer" value="F"> 错（错误）</label>
                </div>
            </div>
        </div>
        <div class="form-group" id="answerGroup">
            <label>正确答案</label>
            <select name="answerSingle" id="answerSelect" style="display:none;">
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
            </select>
            <div id="answerMultiCheckboxes" style="display:none;">
                <label><input type="checkbox" name="answerMulti" value="A"> A</label>
                <label><input type="checkbox" name="answerMulti" value="B"> B</label>
                <label><input type="checkbox" name="answerMulti" value="C"> C</label>
                <label><input type="checkbox" name="answerMulti" value="D"> D</label>
            </div>
            <input type="text" name="answer" id="answerInput" placeholder="单选填A/B/C/D">
        </div>
        <div class="form-group">
            <label>分值</label>
            <input type="number" name="score" placeholder="如：5" min="1" max="100">
        </div>
        <button type="submit" class="btn btn-primary">保存</button>
        <a href="${pageContext.request.contextPath}/question/list" class="btn">返回</a>
    </form>
</div>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
var typeSelect = document.getElementById('questionType');
var optionsGroup = document.getElementById('optionsGroup');
var judgmentGroup = document.getElementById('judgmentGroup');
var answerGroup = document.getElementById('answerGroup');

function toggleType() {
    var t = parseInt(typeSelect.value);
    optionsGroup.style.display = (t === 1 || t === 2) ? 'block' : 'none';
    judgmentGroup.style.display = (t === 3) ? 'block' : 'none';
    answerGroup.style.display = (t === 3) ? 'none' : 'block';
    
    // 显示对应的答案输入方式
    var answerSelect = document.getElementById('answerSelect');
    var answerMultiCheckboxes = document.getElementById('answerMultiCheckboxes');
    var answerInput = document.getElementById('answerInput');
    
    if (t === 1) { // 单选题
        answerSelect.style.display = 'block';
        answerMultiCheckboxes.style.display = 'none';
        answerInput.style.display = 'none';
    } else if (t === 2) { // 多选题
        answerSelect.style.display = 'none';
        answerMultiCheckboxes.style.display = 'block';
        answerInput.style.display = 'none';
    } else if (t !== 3) { // 填空题、简答题
        answerSelect.style.display = 'none';
        answerMultiCheckboxes.style.display = 'none';
        answerInput.style.display = 'block';
    }
}
typeSelect.onchange = toggleType;
toggleType();

document.getElementById('questionForm').onsubmit = function(e) {
    e.preventDefault();
    var type = parseInt(typeSelect.value);
    var answerInput = document.querySelector('input[name="answer"]');
    
    /* 判断题：将radio选择写入answer隐藏字段 */
    if (type === 3) {
        var checked = document.querySelector('input[name="judgmentAnswer"]:checked');
        if (!checked) { showToast('请选择判断答案（对/错）', 'warning'); return; }
        answerInput.value = checked.value;
    } else if (type === 1) { // 单选题
        var answerSelect = document.getElementById('answerSelect');
        if (answerSelect.value === '') {
            showToast('请选择单选题正确答案', 'warning');
            return;
        }
        answerInput.value = answerSelect.value;
    } else if (type === 2) { // 多选题
        var checkboxes = document.querySelectorAll('input[name="answerMulti"]:checked');
        var selectedOptions = Array.from(checkboxes).map(checkbox => checkbox.value);
        if (selectedOptions.length === 0) {
            showToast('请至少选择一个多选题正确答案', 'warning');
            return;
        }
        // 对选项进行排序，确保答案格式一致（如"ABC"而不是"BAC"）
        selectedOptions.sort();
        answerInput.value = selectedOptions.join('');
    }
    
    var rules = [
        { name: 'subjectId', label: '科目ID', required: true, min: 1 },
        { name: 'content', label: '题目内容', required: true, minLength: 2 },
        { name: 'score', label: '分值', required: true, min: 1, max: 100 }
    ];
    
    if (type !== 3) {
        rules.push({ name: 'answer', label: '正确答案', required: true });
    }
    
    if (type === 1 || type === 2) {
        rules.push({ name: 'optionA', label: '选项A', required: true });
        rules.push({ name: 'optionB', label: '选项B', required: true });
    }
    
    var ok = validateForm(this, rules);
    if (ok) { showToast('正在保存题目...', 'info'); this.submit(); }
};
</script>
</body>
</html>
