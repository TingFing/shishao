package com.tingfeng.pojo.vo;

public class UserVo {
    private String uname;
    private String ustatus;
    private Integer lprice;
    private Integer hprice;
    private Integer page = 1;

    public UserVo() {
    }

    @Override
    public String toString() {
        return "UserVo{" +
                "uName='" + uname + '\'' +
                ", typeid='" + ustatus + '\'' +
                ", lprice=" + lprice +
                ", hprice=" + hprice +
                ", page=" + page +
                '}';
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUstatus() {
        return ustatus;
    }

    public void setUstatus(String ustatus) {
        this.ustatus = ustatus;
    }

    public Integer getLprice() {
        return lprice;
    }

    public void setLprice(Integer lprice) {
        this.lprice = lprice;
    }

    public Integer getHprice() {
        return hprice;
    }

    public void setHprice(Integer hprice) {
        this.hprice = hprice;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public UserVo(String uName, String typeid, Integer lprice, Integer hprice, Integer page) {
        this.uname = uName;
        this.ustatus = typeid;
        this.lprice = lprice;
        this.hprice = hprice;
        this.page = page;
    }
}
