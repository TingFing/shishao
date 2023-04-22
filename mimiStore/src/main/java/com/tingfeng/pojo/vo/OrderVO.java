package com.tingfeng.pojo.vo;

public class OrderVO {

    private String oid;
    private int status;
    private Integer page = 1;

    public OrderVO() {
    }

    public OrderVO(String oid, int status,Integer page) {
        this.oid = oid;
        this.status = status;
        this.page = page;
    }

    @Override
    public String toString() {
        return "OrderVO{" +
                "oid='" + oid + '\'' +
                ", status=" + status +
                ", page=" + page +
                '}';
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }
}
