package com.exam.service;

import com.exam.entity.Exam;
import com.exam.mapper.ExamMapper;
import com.exam.service.impl.ExamServiceImpl;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

/**
 * ExamService 单元测试
 */
public class ExamServiceTest {

    @Mock
    private ExamMapper examMapper;

    @InjectMocks
    private ExamServiceImpl examService;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testFindAll() {
        Exam e1 = new Exam(); e1.setId(1); e1.setExamName("Java期中测试");
        Exam e2 = new Exam(); e2.setId(2); e2.setExamName("数据库期末考试");
        when(examMapper.findAll()).thenReturn(Arrays.asList(e1, e2));

        List<Exam> exams = examService.findAll();
        assertEquals(2, exams.size());
        assertEquals("Java期中测试", exams.get(0).getExamName());
    }

    @Test
    public void testFindById() {
        Exam exam = new Exam(); exam.setId(1); exam.setExamName("Java期中测试");
        when(examMapper.findById(1)).thenReturn(exam);

        Exam result = examService.findById(1);
        assertNotNull(result);
        assertEquals("Java期中测试", result.getExamName());
    }

    @Test
    public void testFindByIdNotFound() {
        when(examMapper.findById(999)).thenReturn(null);
        assertNull(examService.findById(999));
    }

    @Test
    public void testAdd() {
        Exam exam = new Exam();
        exam.setExamName("新考试");
        exam.setDuration(60);
        exam.setTotalScore(100);
        when(examMapper.insert(exam)).thenReturn(1);

        assertTrue(examService.add(exam));
        verify(examMapper).insert(exam);
    }

    @Test
    public void testDelete() {
        when(examMapper.deleteById(1)).thenReturn(1);
        assertTrue(examService.deleteById(1));
    }
}
