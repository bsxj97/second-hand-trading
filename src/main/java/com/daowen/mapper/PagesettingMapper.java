package com.daowen.mapper;

import com.daowen.entity.Pagesetting;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.vo.PageSettingVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PagesettingMapper extends SimpleMapper<Pagesetting> {

    /**
     * 获取页面视图
     * @param pageId
     * @return
     */
     PageSettingVo getPageColumn(int pageId);

     List<HashMap<String,Object>> getColumnState(Map map);


}
