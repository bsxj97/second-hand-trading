package com.daowen.service;
import com.daowen.entity.Stag;
import com.daowen.mapper.StagMapper;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;
import java.util.*;

@Service
public   class  StagService extends  SimpleBizservice<StagMapper>{

      @Autowired
      private  StagMapper  stagMapper;


       public List<Stag> getEntityPlus(Map map){
          return  stagMapper.getEntityPlus(map);
      }

      public  Stag   loadPlus(Map map ){
            return  stagMapper.loadPlus(map);
      }
      
     public  Stag   loadPlus(int id ){
             HashMap map=new HashMap();
             map.put("id",id);
            return  stagMapper.loadPlus(map);
      }


     
}