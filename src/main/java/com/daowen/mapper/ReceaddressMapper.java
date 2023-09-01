package com.daowen.mapper;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.entity.Receaddress;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/*
*  收货地址
**/
@Repository
public interface ReceaddressMapper  extends SimpleMapper<Receaddress> {

     List<Receaddress> getEntityPlus(Map map);

     Receaddress  loadPlus(Map map);

}