package com.exam.service;

import com.exam.entity.Question;
import com.exam.entity.PageResult;
import java.util.List;

public interface QuestionService {
    List<Question> findAll();
    PageResult<Question> findPage(int pageNum, int pageSize);
    Question findById(Integer id);
    List<Question> findByExamId(Integer examId);
    boolean add(Question question);
    boolean update(Question question);
    boolean deleteById(Integer id);
}
