package com.exam.service.impl;

import com.exam.entity.Exam;
import com.exam.entity.PageResult;
import com.exam.mapper.ExamMapper;
import com.exam.service.ExamService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ExamServiceImpl implements ExamService {

    private static final Logger log = LoggerFactory.getLogger(ExamServiceImpl.class);

    @Autowired
    private ExamMapper examMapper;

    @Override
    public List<Exam> findAll() {
        log.debug("查询所有考试");
        return examMapper.findAll();
    }

    @Override
    public PageResult<Exam> findPage(int pageNum, int pageSize) {
        int total = examMapper.countAll();
        int offset = (pageNum - 1) * pageSize;
        List<Exam> list = examMapper.findPage(offset, pageSize);
        return new PageResult<>(list, pageNum, pageSize, total);
    }

    @Override
    public Exam findById(Integer id) {
        log.debug("根据ID查询考试: id={}", id);
        return examMapper.findById(id);
    }

    @Override
    public boolean add(Exam exam) {
        log.info("创建考试: examName={}, duration={}, totalScore={}", exam.getExamName(), exam.getDuration(), exam.getTotalScore());
        return examMapper.insert(exam) > 0;
    }

    @Override
    public boolean addWithQuestions(Exam exam, Integer[] questionIds) {
        log.info("创建考试(组卷): examName={}, 题目数={}", exam.getExamName(), questionIds.length);
        examMapper.insert(exam);
        for (Integer qid : questionIds) {
            examMapper.insertExamQuestion(exam.getId(), qid);
        }
        return true;
    }

    @Override
    public boolean update(Exam exam) {
        log.info("更新考试: id={}", exam.getId());
        return examMapper.update(exam) > 0;
    }

    @Override
    public boolean deleteById(Integer id) {
        log.info("删除考试: id={}", id);
        examMapper.deleteExamQuestionsByExamId(id);
        return examMapper.deleteById(id) > 0;
    }
}
