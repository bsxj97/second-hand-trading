package com.daowen.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.daowen.entity.Users;
import com.daowen.ssm.simplecrud.SimpleMapper;
@Mapper
public interface UsersMapper extends SimpleMapper<Users> {

	List<Users> getEntityPlus(Map map);

	Users  loadPlus(Map map);


}
