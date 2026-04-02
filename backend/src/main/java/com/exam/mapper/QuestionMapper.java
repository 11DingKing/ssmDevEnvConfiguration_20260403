package com.exam.mapper;

import com.exam.entity.Question;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 题目 Mapper 接口
 */
public interface QuestionMapper {
    List<Question> findAll();
    List<Question> findPage(@Param("offset") int offset, @Param("pageSize") int pageSize);
    int countAll();
    Question findById(Integer id);
    List<Question> findByExamId(Integer examId);
    List<Question> findBySubjectId(Integer subjectId);
    int insert(Question question);
    int update(Question question);
    int deleteById(Integer id);
}
