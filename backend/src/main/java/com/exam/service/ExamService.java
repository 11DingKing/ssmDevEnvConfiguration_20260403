package com.exam.service;

import com.exam.entity.Exam;
import com.exam.entity.PageResult;
import java.util.List;

public interface ExamService {
    List<Exam> findAll();
    PageResult<Exam> findPage(int pageNum, int pageSize);
    Exam findById(Integer id);
    boolean add(Exam exam);
    boolean addWithQuestions(Exam exam, Integer[] questionIds);
    boolean update(Exam exam);
    boolean deleteById(Integer id);
}
