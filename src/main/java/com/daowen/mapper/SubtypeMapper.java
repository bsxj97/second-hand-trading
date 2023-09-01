package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  子板块
**/
@Repository
public interface SubtypeMapper  extends SimpleMapper<Subtype> {

          List<Subtype>   getEntityPlus(HashMap map);
          
           Subtype   loadPlus(HashMap map);

}