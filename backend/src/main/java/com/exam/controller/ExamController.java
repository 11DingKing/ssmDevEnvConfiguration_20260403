package com.exam.controller;

import com.exam.entity.Exam;
import com.exam.entity.ExamRecord;
import com.exam.entity.Question;
import com.exam.entity.PageResult;
import com.exam.entity.Subject;
import com.exam.entity.User;
import com.exam.service.ExamRecordService;
import com.exam.service.ExamService;
import com.exam.service.QuestionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

/**
 * 考试控制器：考试管理、答题、成绩查看
 */
@Controller
@RequestMapping("/exam")
public class ExamController {

    private static final Logger log = LoggerFactory.getLogger(ExamController.class);

    @Autowired
    private ExamService examService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private ExamRecordService examRecordService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum, Model model) {
        log.debug("查询考试列表: page={}", pageNum);
        PageResult<Exam> page = examService.findPage(pageNum, 10);
        model.addAttribute("page", page);
        return "exam/list";
    }

    @GetMapping("/addPage")
    public String addPage(Model model) {
        List<Question> questions = questionService.findAll();
        model.addAttribute("questions", questions);
        return "exam/add";
    }

    @PostMapping("/add")
    public String add(@Valid Exam exam, BindingResult result,
                      @RequestParam(value = "questionIds", required = false) Integer[] questionIds,
                      HttpSession session, Model model) {
        if (result.hasErrors()) {
            String errorMsg = result.getFieldError().getDefaultMessage();
            log.warn("创建考试参数校验失败: {}", errorMsg);
            model.addAttribute("msg", errorMsg);
            model.addAttribute("questions", questionService.findAll());
            return "exam/add";
        }

        if (questionIds == null || questionIds.length == 0) {
            log.warn("创建考试未选择题目");
            model.addAttribute("msg", "请至少选择一道题目");
            model.addAttribute("questions", questionService.findAll());
            return "exam/add";
        }

        // 计算总分
        int totalScore = 0;
        for (Integer qid : questionIds) {
            Question q = questionService.findById(qid);
            if (q != null) {
                totalScore += q.getScore();
            }
        }
        exam.setTotalScore(totalScore);

        User user = (User) session.getAttribute("loginUser");
        exam.setCreatorId(user.getId());
        exam.setStatus(0);
        examService.addWithQuestions(exam, questionIds);
        log.info("创建考试成功: {} (题目数: {}, 总分: {}, 创建人: {})",
                exam.getExamName(), questionIds.length, totalScore, user.getUsername());
        return "redirect:/exam/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        log.info("删除考试: id={}", id);
        examService.deleteById(id);
        return "redirect:/exam/list";
    }

    @GetMapping("/start/{id}")
    public String startExam(@PathVariable Integer id, Model model) {
        log.info("学生进入考试: examId={}", id);
        Exam exam = examService.findById(id);
        if (exam == null) {
            log.warn("考试不存在: id={}", id);
            model.addAttribute("errorMsg", "考试不存在");
            return "error";
        }
        List<Question> questions = questionService.findByExamId(id);
        model.addAttribute("exam", exam);
        model.addAttribute("questions", questions);
        return "exam/paper";
    }

    @PostMapping("/submit")
    public String submitExam(@RequestParam Integer examId,
                             @RequestParam(value = "questionCount", defaultValue = "0") int questionCount,
                             HttpServletRequest request,
                             HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        log.info("学生提交考试: examId={}, studentId={}", examId, user.getId());

        List<Question> questions = questionService.findByExamId(examId);

        // 自动判分（客观题）- 按索引读取每道题的答案
        int score = 0;
        for (int i = 0; i < questions.size(); i++) {
            String answer = request.getParameter("answers[" + i + "]");
            if (answer != null && answer.equals(questions.get(i).getAnswer())) {
                score += questions.get(i).getScore();
            }
        }

        ExamRecord record = new ExamRecord();
        record.setExamId(examId);
        record.setStudentId(user.getId());
        record.setScore(score);

        boolean submitted = examRecordService.submitExam(record);
        if (!submitted) {
            log.warn("重复提交考试: examId={}, studentId={}", examId, user.getId());
        }

        log.info("考试判分完成: examId={}, studentId={}, score={}", examId, user.getId(), score);
        model.addAttribute("score", score);
        return "exam/result";
    }

    @GetMapping("/records")
    public String records(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user.getRole() <= 1) {
            log.debug("教师/管理员查询所有成绩记录: page={}", pageNum);
            PageResult<ExamRecord> page = examRecordService.findAllPage(pageNum, 10);
            model.addAttribute("page", page);
            model.addAttribute("isTeacher", true);
        } else {
            log.debug("查询学生成绩记录: studentId={}, page={}", user.getId(), pageNum);
            PageResult<ExamRecord> page = examRecordService.findByStudentIdPage(user.getId(), pageNum, 10);
            model.addAttribute("page", page);
            model.addAttribute("isTeacher", false);
        }
        return "exam/records";
    }
}
