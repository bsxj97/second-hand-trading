package com.daowen.mapper;
import com.daowen.entity.Lanmu;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.vo.LanmuVo;

import java.util.List;
import java.util.Map;

public interface LanmuMapper extends SimpleMapper<Lanmu> {

    List<LanmuVo> getEntityPlus(Map map);


    LanmuVo loadPlus(Map map);

}
