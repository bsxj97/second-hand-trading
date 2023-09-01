package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

/**
 * 粉丝
 */

public class Fans {


    //编码
    private int id;

    //目标编号
    private int targetid;

    //关注人
    private int actionid;

    //关注时间
    private Date createtime;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }


    public int getTargetid() {
        return targetid;
    }

    public void setTargetid(int targetid) {
        this.targetid = targetid;
    }

    public int getActionid() {
        return actionid;
    }

    public void setActionid(int actionid) {
        this.actionid = actionid;
    }
}