package com.exam.service;

import com.exam.entity.ExamRecord;
import com.exam.entity.PageResult;
import java.util.List;

public interface ExamRecordService {
    List<ExamRecord> findByStudentId(Integer studentId);
    PageResult<ExamRecord> findByStudentIdPage(Integer studentId, int pageNum, int pageSize);
    List<ExamRecord> findByExamId(Integer examId);
    List<ExamRecord> findAll();
    PageResult<ExamRecord> findAllPage(int pageNum, int pageSize);
    boolean submitExam(ExamRecord record);
}
