package com.daowen.mapper;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.entity.Leaveword;
import com.daowen.vo.LeavewordVo;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  留言
**/
@Repository
public interface LeavewordMapper  extends SimpleMapper<Leaveword> {

          List<LeavewordVo>   getEntityPlus(Map map);
          
          LeavewordVo  loadPlus(Map map);
          
          

}