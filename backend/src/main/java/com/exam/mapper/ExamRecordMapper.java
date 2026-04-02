package com.exam.mapper;

import com.exam.entity.ExamRecord;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 考试记录 Mapper 接口
 */
public interface ExamRecordMapper {
    List<ExamRecord> findByStudentId(Integer studentId);
    List<ExamRecord> findByExamId(Integer examId);
    List<ExamRecord> findAll();
    List<ExamRecord> findAllPage(@Param("offset") int offset, @Param("pageSize") int pageSize);
    int countAll();
    List<ExamRecord> findByStudentIdPage(@Param("studentId") Integer studentId, @Param("offset") int offset, @Param("pageSize") int pageSize);
    int countByStudentId(Integer studentId);
    ExamRecord findByExamIdAndStudentId(@Param("examId") Integer examId,
                                        @Param("studentId") Integer studentId);
    int insert(ExamRecord record);
}
