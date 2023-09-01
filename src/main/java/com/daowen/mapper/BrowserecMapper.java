package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  浏览记录
**/
@Repository
public interface BrowserecMapper  extends SimpleMapper<Browserec> {

          List<Browserec>   getEntityPlus(HashMap map);
          
           Browserec   loadPlus(HashMap map);

}