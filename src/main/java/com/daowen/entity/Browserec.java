package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

/**
 * 浏览记录
 */
@Entity
public class Browserec {


    //编码

    @Id
    private int id;


    //备注

    private int hyid;


    //目标id

    private int targetid;


    //类型

    private String type;

    private int count;

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHyid() {
        return hyid;
    }

    public void setHyid(int hyid) {
        this.hyid = hyid;
    }

    public int getTargetid() {
        return targetid;
    }

    public void setTargetid(int targetid) {
        this.targetid = targetid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}