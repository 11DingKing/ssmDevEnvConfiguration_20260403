package com.exam.entity;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 题目实体类
 */
public class Question implements Serializable {
    private Integer id;

    @NotNull(message = "科目ID不能为空")
    @Min(value = 1, message = "科目ID必须大于0")
    private Integer subjectId;

    @NotNull(message = "题型不能为空")
    private Integer type; // 1-单选 2-多选 3-判断 4-填空 5-简答

    @NotBlank(message = "题目内容不能为空")
    private String content;

    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;

    @NotBlank(message = "正确答案不能为空")
    private String answer;

    @NotNull(message = "分值不能为空")
    @Min(value = 1, message = "分值必须大于0")
    private Integer score;

    public Question() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getSubjectId() { return subjectId; }
    public void setSubjectId(Integer subjectId) { this.subjectId = subjectId; }

    public Integer getType() { return type; }
    public void setType(Integer type) { this.type = type; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getOptionA() { return optionA; }
    public void setOptionA(String optionA) { this.optionA = optionA; }

    public String getOptionB() { return optionB; }
    public void setOptionB(String optionB) { this.optionB = optionB; }

    public String getOptionC() { return optionC; }
    public void setOptionC(String optionC) { this.optionC = optionC; }

    public String getOptionD() { return optionD; }
    public void setOptionD(String optionD) { this.optionD = optionD; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }

    @Override
    public String toString() {
        return "Question{id=" + id + ", type=" + type + ", content='" + content + "'}";
    }
}
