package com.exam.entity;

import org.junit.BeforeClass;
import org.junit.Test;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.Set;

import static org.junit.Assert.*;

/**
 * 实体类 Validation 注解测试
 */
public class ValidationTest {

    private static Validator validator;

    @BeforeClass
    public static void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    public void testUserValid() {
        User user = new User();
        user.setUsername("testuser");
        user.setPassword("123456");
        user.setRealName("测试用户");

        Set<ConstraintViolation<User>> violations = validator.validate(user);
        assertTrue("合法用户应无校验错误", violations.isEmpty());
    }

    @Test
    public void testUserBlankUsername() {
        User user = new User();
        user.setUsername("");
        user.setPassword("123456");
        user.setRealName("测试");

        Set<ConstraintViolation<User>> violations = validator.validate(user);
        assertFalse("空用户名应有校验错误", violations.isEmpty());
    }

    @Test
    public void testUserShortPassword() {
        User user = new User();
        user.setUsername("testuser");
        user.setPassword("ab");
        user.setRealName("测试");

        Set<ConstraintViolation<User>> violations = validator.validate(user);
        assertFalse("过短密码应有校验错误", violations.isEmpty());
    }

    @Test
    public void testExamValid() {
        Exam exam = new Exam();
        exam.setExamName("Java期中测试");
        exam.setSubjectId(1);
        exam.setDuration(60);
        exam.setTotalScore(100);

        Set<ConstraintViolation<Exam>> violations = validator.validate(exam);
        assertTrue("合法考试应无校验错误", violations.isEmpty());
    }

    @Test
    public void testExamBlankName() {
        Exam exam = new Exam();
        exam.setExamName("");
        exam.setSubjectId(1);
        exam.setDuration(60);
        exam.setTotalScore(100);

        Set<ConstraintViolation<Exam>> violations = validator.validate(exam);
        assertFalse("空考试名称应有校验错误", violations.isEmpty());
    }

    @Test
    public void testExamInvalidDuration() {
        Exam exam = new Exam();
        exam.setExamName("测试考试");
        exam.setSubjectId(1);
        exam.setDuration(0);
        exam.setTotalScore(100);

        Set<ConstraintViolation<Exam>> violations = validator.validate(exam);
        assertFalse("时长为0应有校验错误", violations.isEmpty());
    }

    @Test
    public void testQuestionValid() {
        Question q = new Question();
        q.setSubjectId(1);
        q.setType(1);
        q.setContent("Java中哪个关键字用于定义类？");
        q.setAnswer("A");
        q.setScore(5);

        Set<ConstraintViolation<Question>> violations = validator.validate(q);
        assertTrue("合法题目应无校验错误", violations.isEmpty());
    }

    @Test
    public void testQuestionBlankContent() {
        Question q = new Question();
        q.setSubjectId(1);
        q.setType(1);
        q.setContent("");
        q.setAnswer("A");
        q.setScore(5);

        Set<ConstraintViolation<Question>> violations = validator.validate(q);
        assertFalse("空题目内容应有校验错误", violations.isEmpty());
    }
}
