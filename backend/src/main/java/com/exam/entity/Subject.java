package com.exam.entity;

import java.io.Serializable;

/**
 * 科目实体类
 */
public class Subject implements Serializable {
    private Integer id;
    private String subjectName;

    public Subject() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
}
