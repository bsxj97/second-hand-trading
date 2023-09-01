package com.daowen.mapper;
import com.alipay.api.domain.OrderItem;
import com.daowen.entity.Shorder;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.vo.OrderDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ShorderMapper extends SimpleMapper<Shorder> {

    /**
     * 获取购买订单
     * @param map
     * @return
     */
    List<OrderDTO> getEntityPlus(HashMap map);

    /**
     * 获取订单信息
     * @param map
     * @return
     */
    OrderDTO loadPlus(HashMap map);

    List<HashMap<String,Object>> saleStat(Map map);


    OrderItem loadOrderItem(Integer id);



}
