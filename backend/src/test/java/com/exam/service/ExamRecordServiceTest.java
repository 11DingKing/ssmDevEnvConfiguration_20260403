package com.exam.service;

import com.exam.entity.ExamRecord;
import com.exam.mapper.ExamRecordMapper;
import com.exam.service.impl.ExamRecordServiceImpl;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

/**
 * ExamRecordService 单元测试
 */
public class ExamRecordServiceTest {

    @Mock
    private ExamRecordMapper examRecordMapper;

    @InjectMocks
    private ExamRecordServiceImpl examRecordService;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testSubmitExamSuccess() {
        ExamRecord record = new ExamRecord();
        record.setExamId(1);
        record.setStudentId(3);
        record.setScore(80);

        when(examRecordMapper.findByExamIdAndStudentId(1, 3)).thenReturn(null);
        when(examRecordMapper.insert(record)).thenReturn(1);

        assertTrue("首次提交应成功", examRecordService.submitExam(record));
    }

    @Test
    public void testSubmitExamDuplicate() {
        ExamRecord existing = new ExamRecord();
        existing.setId(1);

        ExamRecord record = new ExamRecord();
        record.setExamId(1);
        record.setStudentId(3);

        when(examRecordMapper.findByExamIdAndStudentId(1, 3)).thenReturn(existing);

        assertFalse("重复提交应失败", examRecordService.submitExam(record));
        verify(examRecordMapper, never()).insert(any());
    }
}
