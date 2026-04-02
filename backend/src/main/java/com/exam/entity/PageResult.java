package com.exam.entity;

import java.io.Serializable;
import java.util.List;

/**
 * 通用分页结果
 */
public class PageResult<T> implements Serializable {
    private List<T> list;
    private int pageNum;
    private int pageSize;
    private int total;
    private int totalPages;

    public PageResult(List<T> list, int pageNum, int pageSize, int total) {
        this.list = list;
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.total = total;
        this.totalPages = (total + pageSize - 1) / pageSize;
    }

    public List<T> getList() { return list; }
    public int getPageNum() { return pageNum; }
    public int getPageSize() { return pageSize; }
    public int getTotal() { return total; }
    public int getTotalPages() { return totalPages; }
    public boolean getHasPrev() { return pageNum > 1; }
    public boolean getHasNext() { return pageNum < totalPages; }
}
