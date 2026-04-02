package com.exam.service.impl;

import com.exam.entity.Question;
import com.exam.entity.PageResult;
import com.exam.mapper.QuestionMapper;
import com.exam.service.QuestionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class QuestionServiceImpl implements QuestionService {

    private static final Logger log = LoggerFactory.getLogger(QuestionServiceImpl.class);

    @Autowired
    private QuestionMapper questionMapper;

    @Override
    public List<Question> findAll() {
        log.debug("查询所有题目");
        return questionMapper.findAll();
    }

    @Override
    public PageResult<Question> findPage(int pageNum, int pageSize) {
        int total = questionMapper.countAll();
        int offset = (pageNum - 1) * pageSize;
        List<Question> list = questionMapper.findPage(offset, pageSize);
        return new PageResult<>(list, pageNum, pageSize, total);
    }

    @Override
    public Question findById(Integer id) {
        log.debug("根据ID查询题目: id={}", id);
        return questionMapper.findById(id);
    }

    @Override
    public List<Question> findByExamId(Integer examId) {
        log.debug("根据考试ID查询题目: examId={}", examId);
        return questionMapper.findByExamId(examId);
    }

    @Override
    public boolean add(Question question) {
        log.info("添加题目: type={}, content={}", question.getType(), question.getContent());
        return questionMapper.insert(question) > 0;
    }

    @Override
    public boolean update(Question question) {
        log.info("更新题目: id={}", question.getId());
        return questionMapper.update(question) > 0;
    }

    @Override
    public boolean deleteById(Integer id) {
        log.info("删除题目: id={}", id);
        return questionMapper.deleteById(id) > 0;
    }
}
