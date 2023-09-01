package com.daowen.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daowen.service.ISiteSearch;
import com.daowen.util.BeansUtil;
import com.daowen.util.JsonResult;
import com.daowen.vo.SearchVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.entity.Xinxi;
import com.daowen.service.XinxiService;
import com.daowen.ssm.simplecrud.SimpleController;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SitesearchController  {

    @ResponseBody
    @RequestMapping("/admin/search")
    private JsonResult find() {
        String title = request.getParameter("title");
        Map<String, ISiteSearch> searchMap= BeansUtil.getBeanOfType(ISiteSearch.class);
        List<SearchVo> listSearch=new ArrayList<>();
        if (title != null) {
            if(searchMap!=null&&searchMap.size()>0){
                for (Map.Entry<String, ISiteSearch> entry : searchMap.entrySet()) {
                    if(entry.getValue()!=null) {
                        List<SearchVo> list = entry.getValue().search(title);
                        if(list!=null&&list.size()>0)
                            listSearch.addAll(list);
                    }
                }

            }
        }
        return JsonResult.success(1,"成功",listSearch);
    }

    @Autowired
    private XinxiService xinxiSrv = null;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private HttpServletResponse response;

}
