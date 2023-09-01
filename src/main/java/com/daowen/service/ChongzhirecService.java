package com.daowen.service;
import com.daowen.entity.*;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
@Service
public   class  ChongzhirecService extends  SimpleBizservice<ChongzhirecMapper>{

      @Autowired
      private  ChongzhirecMapper  chongzhirecMapper;



          public  List<Chongzhirec>   getEntityPlus(HashMap map){
               return  chongzhirecMapper.getEntityPlus(map);
          }
          
          public  Chongzhirec   loadPlus(HashMap map){
              return chongzhirecMapper.loadPlus(map);
          }
          
           public  Chongzhirec   loadPlus(int id){
                 HashMap map = new HashMap();
	         map.put("id",id);
	        return this.loadPlus(map);
          }
     
}