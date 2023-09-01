package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

/**
 * 充值
 */
@Entity
public class Chongzhirec {


    //编码

    @Id
    private int id;


    //订单号

    private String ddno;


    //账户编号

    private int hyid;


    //金额（元）

    private int amount;


    //创建时间

    private Date createtime;


    //状态

    private int state;


    //支付方式

    private int paytype;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDdno() {
        return ddno;
    }

    public void setDdno(String ddno) {
        this.ddno = ddno;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getPaytype() {
        return paytype;
    }

    public void setPaytype(int paytype) {
        this.paytype = paytype;
    }

}