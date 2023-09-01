package com.daowen.controller;

import java.io.*;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daowen.util.JsonResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.daowen.entity.*;
import com.daowen.service.*;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.webcontrol.PagerMetal;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

//##{{import}}
@RestController
public class SubtypeController extends SimpleController {

    @Autowired
    private SubtypeService subtypeSrv = null;

    @Autowired
    private LanmuService lanmuSrv=null;


    @PostMapping("/admin/subtype/list")
    public JsonResult list(){
        String filter="where 1=1 ";
        String parentid=request.getParameter("parentid");
        if(parentid!=null)
            filter+=" and parentid="+parentid;
        List<Subtype> listSubtype=subtypeSrv.getEntity(filter);
        return JsonResult.success(1,"获取栏信息",listSubtype);
    }


    @PostMapping("/admin/subtype/delete")
    public JsonResult delete(){
        String id=request.getParameter("id");
        if(id==null||id=="")
            return JsonResult.error(-1,"参数异常");
        subtypeSrv.delete("where id="+id);
        return JsonResult.success(1,"删除成功");
    }


    @PostMapping("/admin/subtype/save")
    public JsonResult save() {


        String name = request.getParameter("name");


        String parentid = request.getParameter("parentid");

        SimpleDateFormat sdfsubtype = new SimpleDateFormat("yyyy-MM-dd");
        Subtype subtype = new Subtype();


        subtype.setName(name == null ? "" : name);


        subtype.setParentid(parentid == null ? 0 : new Integer(parentid));

        //end forEach

        Boolean validateresult = subtypeSrv.isExist("  where  name='" + name + "'");
        if (validateresult)
            return JsonResult.error(-1,"已存在的子板块");


        subtypeSrv.save(subtype);
        return JsonResult.success(1,"成功");
    }

    @PostMapping("/admin/subtype/update")
    public JsonResult update() {

        String id = request.getParameter("id");
        if (id == null)
            return JsonResult.error(-1,"id不能为空");
        Subtype subtype = subtypeSrv.load("where id=" + id);
        if (subtype == null)
            return JsonResult.error(-1,"非法数据");
        String name = request.getParameter("name");
        String parentid = request.getParameter("parentid");
        SimpleDateFormat sdfsubtype = new SimpleDateFormat("yyyy-MM-dd");
        subtype.setName(name == null ? "" : name);
        subtype.setParentid(parentid == null ? 0 : new Integer(parentid));
        subtypeSrv.update(subtype);
        return JsonResult.success(1,"更新成功");
    }


    @RequestMapping("/admin/subtype/load")
    public  JsonResult  load(){
        String id=request.getParameter("id");

        if(id==null)
            return JsonResult.error(-1,"ID不能为空");
        Subtype  subtype=subtypeSrv.loadPlus(new Integer(id));
        if(subtype==null)
            return JsonResult.error(-2,"非法数据");
        return  JsonResult.success(1,"成功",subtype);

    }

    //##{{methods}}


}
