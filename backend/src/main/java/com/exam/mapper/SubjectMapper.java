package com.exam.mapper;

import com.exam.entity.Subject;
import java.util.List;

/**
 * 科目 Mapper 接口
 */
public interface SubjectMapper {
    List<Subject> findAll();
    Subject findById(Integer id);
    int insert(Subject subject);
    int deleteById(Integer id);
}
