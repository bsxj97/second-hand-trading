package com.daowen.entity;

import java.util.Date;
import javax.persistence.*;

@Entity
public class Shoucang {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private int targetid;


	private String targetname;


	private String tupian;


	private int hyid;

    private String xtype;

	private Date sctime;


	private String href;


	public int getTargetid() {
		return targetid;
	}

	public void setTargetid(int targetid) {
		this.targetid = targetid;
	}

	public String getTargetname() {
		return targetname;
	}

	public void setTargetname(String targetname) {
		this.targetname = targetname;
	}

	public String getTupian() {
		return tupian;
	}

	public void setTupian(String tupian) {
		this.tupian = tupian;
	}

	public int getHyid() {
		return hyid;
	}

	public void setHyid(int hyid) {
		this.hyid = hyid;
	}

	public String getXtype() {
		return xtype;
	}

	public void setXtype(String xtype) {
		this.xtype = xtype;
	}

	public Date getSctime() {
		return sctime;
	}

	public void setSctime(Date sctime) {
		this.sctime = sctime;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}
}
