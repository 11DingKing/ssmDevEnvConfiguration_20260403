package com.exam.entity;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * 考试实体类
 */
public class Exam implements Serializable {
    private Integer id;

    @NotBlank(message = "考试名称不能为空")
    @Size(min = 2, max = 100, message = "考试名称长度需在2-100个字符之间")
    private String examName;

    @NotNull(message = "科目ID不能为空")
    @Min(value = 1, message = "科目ID必须大于0")
    private Integer subjectId;

    private Date startTime;
    private Date endTime;

    @NotNull(message = "考试时长不能为空")
    @Min(value = 1, message = "考试时长必须大于0")
    private Integer duration;

    private Integer totalScore;

    private Integer creatorId;
    private Integer status; // 0-未开始 1-进行中 2-已结束

    public Exam() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getExamName() { return examName; }
    public void setExamName(String examName) { this.examName = examName; }

    public Integer getSubjectId() { return subjectId; }
    public void setSubjectId(Integer subjectId) { this.subjectId = subjectId; }

    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }

    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }

    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) { this.duration = duration; }

    public Integer getTotalScore() { return totalScore; }
    public void setTotalScore(Integer totalScore) { this.totalScore = totalScore; }

    public Integer getCreatorId() { return creatorId; }
    public void setCreatorId(Integer creatorId) { this.creatorId = creatorId; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    @Override
    public String toString() {
        return "Exam{id=" + id + ", examName='" + examName + "', duration=" + duration + ", totalScore=" + totalScore + "}";
    }
}
