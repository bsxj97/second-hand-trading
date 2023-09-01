package com.daowen.service;
import org.springframework.stereotype.Service;
import com.daowen.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.daowen.ssm.simplecrud.SimpleBizservice;
@Service
public   class  FansService extends  SimpleBizservice<FansMapper>{

      @Autowired
      private  FansMapper  fansMapper;


     
}