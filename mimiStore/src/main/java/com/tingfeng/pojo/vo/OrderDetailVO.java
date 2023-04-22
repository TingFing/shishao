package com.tingfeng.pojo.vo;

public class OrderDetailVO {
    private Integer uid;

    private String uname;

    private String oid;

    private String address;

    private Integer pnumber;

    private Double ptotal;

    public OrderDetailVO() {
    }

    public OrderDetailVO(Integer uid, String uname, String oid, String address, Integer pnumber, Double ptotal) {
        this.uid = uid;
        this.uname = uname;
        this.oid = oid;
        this.address = address;
        this.pnumber = pnumber;
        this.ptotal = ptotal;
    }

    @Override
    public String toString() {
        return "OrderDetailVO{" +
                "uid=" + uid +
                ", uname='" + uname + '\'' +
                ", oid='" + oid + '\'' +
                ", address='" + address + '\'' +
                ", pnumber=" + pnumber +
                ", ptotal=" + ptotal +
                '}';
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getPnumber() {
        return pnumber;
    }

    public void setPnumber(Integer pnumber) {
        this.pnumber = pnumber;
    }

    public Double getPtotal() {
        return ptotal;
    }

    public void setPtotal(Double ptotal) {
        this.ptotal = ptotal;
    }
}
