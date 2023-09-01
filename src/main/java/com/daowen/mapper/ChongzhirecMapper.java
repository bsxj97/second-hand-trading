package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  充值
**/
@Repository
public interface ChongzhirecMapper  extends SimpleMapper<Chongzhirec> {

          List<Chongzhirec>   getEntityPlus(HashMap map);
          
           Chongzhirec   loadPlus(HashMap map);

}