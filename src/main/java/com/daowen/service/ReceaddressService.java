package com.daowen.service;

import com.daowen.ssm.simplecrud.SimpleBizservice;
import com.daowen.entity.Receaddress;
import com.daowen.mapper.ReceaddressMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReceaddressService extends SimpleBizservice<ReceaddressMapper>{

    @Autowired
    private ReceaddressMapper receaddressMapper;

    public List<Receaddress> getEnityPlus(Map map){
        return receaddressMapper.getEntityPlus(map);
    }

    public Receaddress  loadPlus(Map map ){
        return receaddressMapper.loadPlus(map);
    }

    public Receaddress loadPlus(int id){
        HashMap map = new HashMap();
        map.put("id",id);
        return this.loadPlus(map);
    }
}
