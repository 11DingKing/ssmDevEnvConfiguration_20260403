package com.exam.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 考试记录实体类（学生答卷记录）
 */
public class ExamRecord implements Serializable {
    private Integer id;
    private Integer examId;
    private Integer studentId;
    private Integer score;
    private Date submitTime;
    private String studentName; // 非数据库字段，用于关联查询显示

    public ExamRecord() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getExamId() { return examId; }
    public void setExamId(Integer examId) { this.examId = examId; }

    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }

    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }

    public Date getSubmitTime() { return submitTime; }
    public void setSubmitTime(Date submitTime) { this.submitTime = submitTime; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
}
