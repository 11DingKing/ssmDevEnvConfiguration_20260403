/**
 * 公共 JS 工具：自定义 Toast 提示、确认弹窗、表单验证
 * 替代所有原生 alert / confirm
 */

/* ========== Toast 提示 ========== */
function showToast(msg, type) {
    type = type || 'info';
    var existing = document.querySelectorAll('.toast-msg');
    existing.forEach(function(el) { el.remove(); });

    var toast = document.createElement('div');
    toast.className = 'toast-msg toast-' + type;
    var icon = '';
    if (type === 'success') icon = '✓ ';
    else if (type === 'error') icon = '✕ ';
    else if (type === 'warning') icon = '⚠ ';
    else icon = 'ℹ ';
    toast.innerHTML = '<span class="toast-icon">' + icon + '</span><span>' + msg + '</span>';
    document.body.appendChild(toast);

    setTimeout(function() { toast.classList.add('toast-show'); }, 10);
    setTimeout(function() {
        toast.classList.remove('toast-show');
        setTimeout(function() { toast.remove(); }, 300);
    }, 3000);
}

/* ========== 自定义确认弹窗（替代 confirm） ========== */
function showConfirm(msg, onConfirm) {
    var overlay = document.createElement('div');
    overlay.className = 'modal-overlay';

    var modal = document.createElement('div');
    modal.className = 'modal-box';
    modal.innerHTML =
        '<div class="modal-header">操作确认</div>' +
        '<div class="modal-body">' + msg + '</div>' +
        '<div class="modal-footer">' +
            '<button class="btn modal-cancel">取消</button>' +
            '<button class="btn btn-danger modal-confirm">确认</button>' +
        '</div>';

    overlay.appendChild(modal);
    document.body.appendChild(overlay);

    setTimeout(function() { overlay.classList.add('modal-show'); }, 10);

    function close() {
        overlay.classList.remove('modal-show');
        setTimeout(function() { overlay.remove(); }, 200);
    }

    modal.querySelector('.modal-cancel').onclick = close;
    overlay.onclick = function(e) { if (e.target === overlay) close(); };
    modal.querySelector('.modal-confirm').onclick = function() {
        close();
        if (onConfirm) onConfirm();
    };
}

/* ========== 表单验证工具 ========== */
function validateForm(formEl, rules) {
    clearFormErrors(formEl);
    var valid = true;

    for (var i = 0; i < rules.length; i++) {
        var rule = rules[i];
        var input = formEl.querySelector('[name="' + rule.name + '"]');
        if (!input) continue;

        var val = input.value.trim();
        var errMsg = '';

        if (rule.required && val === '') {
            errMsg = rule.label + '不能为空';
        } else if (rule.minLength && val.length < rule.minLength) {
            errMsg = rule.label + '长度不能少于' + rule.minLength + '个字符';
        } else if (rule.maxLength && val.length > rule.maxLength) {
            errMsg = rule.label + '长度不能超过' + rule.maxLength + '个字符';
        } else if (rule.min !== undefined && Number(val) < rule.min) {
            errMsg = rule.label + '不能小于' + rule.min;
        } else if (rule.max !== undefined && Number(val) > rule.max) {
            errMsg = rule.label + '不能大于' + rule.max;
        } else if (rule.pattern && !rule.pattern.test(val)) {
            errMsg = rule.message || (rule.label + '格式不正确');
        } else if (rule.custom && val !== '') {
            errMsg = rule.custom(val);
        }

        if (errMsg) {
            showFieldError(input, errMsg);
            valid = false;
        }
    }
    return valid;
}

function showFieldError(input, msg) {
    input.classList.add('input-error');
    var err = document.createElement('span');
    err.className = 'field-error';
    err.textContent = msg;
    input.parentNode.appendChild(err);
}

function clearFormErrors(formEl) {
    var errors = formEl.querySelectorAll('.field-error');
    errors.forEach(function(el) { el.remove(); });
    var inputs = formEl.querySelectorAll('.input-error');
    inputs.forEach(function(el) { el.classList.remove('input-error'); });
}

/* 实时清除单个字段错误 */
document.addEventListener('input', function(e) {
    if (e.target.classList.contains('input-error')) {
        e.target.classList.remove('input-error');
        var err = e.target.parentNode.querySelector('.field-error');
        if (err) err.remove();
    }
});

/* ========== 北京时间格式化 ========== */
function formatBeijingTime(dateStr) {
    if (!dateStr) return '-';
    var d = new Date(dateStr);
    if (isNaN(d.getTime())) return dateStr;
    return d.toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai', hour12: false }) + ' (北京时间)';
}

/* 页面加载后自动格式化所有带 data-time 属性的元素 */
document.addEventListener('DOMContentLoaded', function() {
    var timeEls = document.querySelectorAll('[data-time]');
    timeEls.forEach(function(el) {
        var raw = el.getAttribute('data-time');
        if (raw) el.textContent = formatBeijingTime(raw);
    });
});
