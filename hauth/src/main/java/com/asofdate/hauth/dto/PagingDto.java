package com.asofdate.hauth.dto;

public class PagingDto<T> {
    public T rows;
    public Integer total;

    public PagingDto() {
    }

    public PagingDto(Integer total, T rows) {
        this.rows = rows;
        this.total = total;
    }

    public T getRows() {
        return rows;
    }

    public void setRows(T rows) {
        this.rows = rows;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "PageDto [rows=" + rows + ", total=" + total + "]";
    }

}
