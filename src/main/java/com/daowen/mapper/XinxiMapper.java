package com.daowen.mapper;

import com.daowen.entity.Xinxi;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.vo.XinxiVo;

import java.util.List;
import java.util.Map;

public interface XinxiMapper extends SimpleMapper<Xinxi>{


    List<XinxiVo> getEntityPlus(Map map);

    XinxiVo  loadPlus(Map map);
}
