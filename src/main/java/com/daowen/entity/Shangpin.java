package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

@Entity
public class Shangpin {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	private Double jiage;

	public Double getJiage() {
		return jiage;
	}

	public void setJiage(Double jiage) {
		this.jiage = jiage;
	}


	private int tuijian;

	public int getTuijian() {
		return tuijian;
	}

	public void setTuijian(int tuijian) {
		this.tuijian = tuijian;
	}

	private String tupian;

	public String getTupian() {
		return tupian;
	}

	public void setTupian(String tupian) {
		this.tupian = tupian;
	}

	private String jieshao;

	public String getJieshao() {
		return jieshao;
	}

	public void setJieshao(String jieshao) {
		this.jieshao = jieshao;
	}

	private double hyjia;

	public double getHyjia() {
		return hyjia;
	}

	public void setHyjia(double hyjia) {
		this.hyjia = hyjia;
	}


	private Date pubtime;

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}


	public int getKucun() {
		return kucun;
	}

	public void setKucun(int kucun) {
		this.kucun = kucun;
	}

	public String getDanwei() {
		return danwei;
	}

	public void setDanwei(String danwei) {
		this.danwei = danwei;
	}

	private int kucun;

	private String danwei;

	private int state;

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtile) {
		this.subtitle = subtile;
	}

	private String subtitle;

	private int subtypeid;

	public int getSubtypeid() {
		return subtypeid;
	}

	public void setSubtypeid(int subtypeid) {
		this.subtypeid = subtypeid;
	}

	private int tagid;

	public int getTagid() {
		return tagid;
	}

	public void setTagid(int tagid) {
		this.tagid = tagid;
	}


	private int typeid;

	public int getTypeid() {
		return typeid;
	}

	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}

	private int spstate;

	public int getSpstate() {
		return spstate;
	}

	public void setSpstate(int spstate) {
		this.spstate = spstate;
	}

	private int pubren;

	public int getPubren() {
		return pubren;
	}

	public void setPubren(int pubren) {
		this.pubren = pubren;
	}



	private int couponid;

	public int getCouponid() {
		return couponid;
	}

	public void setCouponid(int couponid) {
		this.couponid = couponid;
	}

	private String chandi;

	public String getChandi() {
		return chandi;
	}

	public void setChandi(String chandi) {
		this.chandi = chandi;
	}

	private int clickcount;

	public int getClickcount() {
		return clickcount;
	}

	public void setClickcount(int clickcount) {
		this.clickcount = clickcount;
	}
}
