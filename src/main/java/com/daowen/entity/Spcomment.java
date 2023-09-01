package com.daowen.entity;

import java.util.Date;

/**
 * 商品评价
 */

public class Spcomment {


    //编码
    private int id;

    //评价结果
    private int cresult;

    //描述
    private String des;

    //商品编号
    private int spid;

    //订单编号
    private int orderid;

    //评价时间
    private Date createtime;


    private int appraiserid;

    public int getAppraiserid() {
        return appraiserid;
    }

    public void setAppraiserid(int appraiserid) {
        this.appraiserid = appraiserid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCresult() {
        return cresult;
    }

    public void setCresult(int cresult) {
        this.cresult = cresult;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public int getSpid() {
        return spid;
    }

    public void setSpid(int spid) {
        this.spid = spid;
    }

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

}