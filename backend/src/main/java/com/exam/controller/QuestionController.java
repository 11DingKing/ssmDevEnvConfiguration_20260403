package com.exam.controller;

import com.exam.entity.Question;
import com.exam.entity.PageResult;
import com.exam.service.QuestionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * 题目管理控制器（教师/管理员）
 */
@Controller
@RequestMapping("/question")
public class QuestionController {

    private static final Logger log = LoggerFactory.getLogger(QuestionController.class);

    @Autowired
    private QuestionService questionService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum, Model model) {
        log.debug("查询题目列表: page={}", pageNum);
        PageResult<Question> page = questionService.findPage(pageNum, 10);
        model.addAttribute("page", page);
        return "question/list";
    }

    @GetMapping("/addPage")
    public String addPage() {
        return "question/add";
    }

    @PostMapping("/add")
    public String add(@Valid Question question, BindingResult result, Model model) {
        if (result.hasErrors()) {
            String errorMsg = result.getFieldError().getDefaultMessage();
            log.warn("添加题目参数校验失败: {}", errorMsg);
            model.addAttribute("msg", errorMsg);
            return "question/add";
        }
        // 自动转大写
        if (question.getAnswer() != null) {
            question.setAnswer(question.getAnswer().toUpperCase());
        }
        questionService.add(question);
        log.info("添加题目成功: {}", question);
        return "redirect:/question/list";
    }

    @GetMapping("/editPage/{id}")
    public String editPage(@PathVariable Integer id, Model model) {
        Question question = questionService.findById(id);
        if (question == null) {
            log.warn("题目不存在: id={}", id);
            model.addAttribute("errorMsg", "题目不存在");
            return "error";
        }
        model.addAttribute("question", question);
        return "question/edit";
    }

    @PostMapping("/update")
    public String update(@Valid Question question, BindingResult result, Model model) {
        if (result.hasErrors()) {
            String errorMsg = result.getFieldError().getDefaultMessage();
            log.warn("更新题目参数校验失败: {}", errorMsg);
            model.addAttribute("msg", errorMsg);
            model.addAttribute("question", question);
            return "question/edit";
        }
        if (question.getAnswer() != null) {
            question.setAnswer(question.getAnswer().toUpperCase());
        }
        questionService.update(question);
        log.info("更新题目成功: id={}", question.getId());
        return "redirect:/question/list";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        log.info("删除题目: id={}", id);
        questionService.deleteById(id);
        return "redirect:/question/list";
    }
}
