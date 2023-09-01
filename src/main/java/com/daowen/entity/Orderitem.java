package com.daowen.entity;
import javax.persistence.*;
@Entity
public class Orderitem
{
@Id
@GeneratedValue(strategy =GenerationType.AUTO)
   private int id ;
   public int getId() 
   {
      return id;
  }
   public void setId(int id) 
   {
      this.id= id;
  }
   private int spid ;
   public int  getSpid()
   {
      return spid;
  }
   public void setSpid(int spid)
   {
      this.spid= spid;
  }
   private int count ;
   public int getCount() 
   {
      return count;
  }
   public void setCount(int count) 
   {
      this.count= count;
  }
   private Double price ;
   public Double getPrice() 
   {
      return price;
  }
   public void setPrice(Double price) 
   {
      this.price= price;
  }
   private Double totalprice ;
   public Double getTotalprice() 
   {
      return totalprice;
  }
   public void setTotalprice(Double totalprice) 
   {
      this.totalprice= totalprice;
  }
   private int orderid ;
   public int getOrderid() 
   {
      return orderid;
  }
   public void setOrderid(int orderid) 
   {
      this.orderid= orderid;
  }
   private int state;

    public String getWlno() {
        return wlno;
    }

    public void setWlno(String wlno) {
        this.wlno = wlno;
    }

    private String wlno;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
