package com.exam.service.impl;

import com.exam.entity.ExamRecord;
import com.exam.entity.PageResult;
import com.exam.mapper.ExamRecordMapper;
import com.exam.service.ExamRecordService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ExamRecordServiceImpl implements ExamRecordService {

    private static final Logger log = LoggerFactory.getLogger(ExamRecordServiceImpl.class);

    @Autowired
    private ExamRecordMapper examRecordMapper;

    @Override
    public List<ExamRecord> findByStudentId(Integer studentId) {
        log.debug("查询学生考试记录: studentId={}", studentId);
        return examRecordMapper.findByStudentId(studentId);
    }

    @Override
    public List<ExamRecord> findByExamId(Integer examId) {
        log.debug("查询考试记录: examId={}", examId);
        return examRecordMapper.findByExamId(examId);
    }

    @Override
    public List<ExamRecord> findAll() {
        log.debug("查询所有考试记录");
        return examRecordMapper.findAll();
    }

    @Override
    public PageResult<ExamRecord> findAllPage(int pageNum, int pageSize) {
        int total = examRecordMapper.countAll();
        int offset = (pageNum - 1) * pageSize;
        List<ExamRecord> list = examRecordMapper.findAllPage(offset, pageSize);
        return new PageResult<>(list, pageNum, pageSize, total);
    }

    @Override
    public PageResult<ExamRecord> findByStudentIdPage(Integer studentId, int pageNum, int pageSize) {
        int total = examRecordMapper.countByStudentId(studentId);
        int offset = (pageNum - 1) * pageSize;
        List<ExamRecord> list = examRecordMapper.findByStudentIdPage(studentId, offset, pageSize);
        return new PageResult<>(list, pageNum, pageSize, total);
    }

    @Override
    public boolean submitExam(ExamRecord record) {
        log.info("提交考试: examId={}, studentId={}, score={}", record.getExamId(), record.getStudentId(), record.getScore());
        ExamRecord existing = examRecordMapper.findByExamIdAndStudentId(record.getExamId(), record.getStudentId());
        if (existing != null) {
            log.warn("重复提交被拒绝: examId={}, studentId={}", record.getExamId(), record.getStudentId());
            return false;
        }
        return examRecordMapper.insert(record) > 0;
    }
}
