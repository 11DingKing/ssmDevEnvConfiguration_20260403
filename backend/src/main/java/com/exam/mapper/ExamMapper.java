package com.exam.mapper;

import com.exam.entity.Exam;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 考试 Mapper 接口
 */
public interface ExamMapper {
    List<Exam> findAll();
    List<Exam> findPage(@Param("offset") int offset, @Param("pageSize") int pageSize);
    int countAll();
    Exam findById(Integer id);
    int insert(Exam exam);
    int update(Exam exam);
    int deleteById(Integer id);
    void insertExamQuestion(@Param("examId") Integer examId, @Param("questionId") Integer questionId);
    void deleteExamQuestionsByExamId(Integer examId);
}
