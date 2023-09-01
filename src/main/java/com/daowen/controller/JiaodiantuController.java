package com.daowen.controller;

import com.daowen.entity.Jiaodiantu;
import com.daowen.service.JiaodiantuService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.util.JsonResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
@RestController
public class JiaodiantuController extends SimpleController {

	@Autowired
	private JiaodiantuService focusSrv=null;

	@PostMapping("/admin/jiaodiantu/delete")
	public JsonResult delete() {
		String[] ids = request.getParameterValues("ids");
		if (ids == null)
			return JsonResult.error(-1,"编号不能为空");
		String where = " where id in(" + join(",", ids) + ")";
		focusSrv.delete(where);
		return JsonResult.success(1,"删除成功");
	}


	@PostMapping("/admin/jiaodiantu/save")
	public JsonResult save() {
		String title = request.getParameter("title");
		String tupian = request.getParameter("tupian");
		String href = request.getParameter("href");
		String xtype = request.getParameter("xtype");
		String pindex = request.getParameter("pindex");

		Jiaodiantu jiaodiantu = new Jiaodiantu();
		jiaodiantu.setTitle(title == null ? "" : title);
		jiaodiantu.setTupian(tupian == null ? "" : tupian);
		jiaodiantu.setHref(href == null ? "" : href);
		jiaodiantu.setXtype(xtype == null ? "" : xtype);
		jiaodiantu.setPindex(new Integer(pindex));
		focusSrv.save(jiaodiantu);
		return JsonResult.success(1,"新增成功",jiaodiantu);
	}

	@PostMapping("/admin/jiaodiantu/update")
	public JsonResult update() {
		String id = request.getParameter("id");
		if (id == null)
			return JsonResult.error(-1,"编号不能为空");
		Jiaodiantu jiaodiantu = focusSrv.load(new Integer(id));
		if (jiaodiantu == null)
			return JsonResult.error(-2,"非法的数据");
		String title = request.getParameter("title");
		String tupian = request.getParameter("tupian");
		String href = request.getParameter("href");
		String xtype = request.getParameter("xtype");
		String pindex = request.getParameter("pindex");

		jiaodiantu.setTitle(title);
		jiaodiantu.setTupian(tupian);
		jiaodiantu.setHref(href);
		jiaodiantu.setXtype(xtype);
		jiaodiantu.setPindex(new Integer(pindex));
		focusSrv.update(jiaodiantu);
		return  JsonResult.success(1,"成功更新",jiaodiantu);
	}

	@PostMapping("/admin/jiaodiantu/load")
	public JsonResult load() {
		//
		String id = request.getParameter("id");
		if (id == null)
			return JsonResult.error(-1,"编号不能为空");
		Jiaodiantu jiaodiantu = focusSrv.load(new Integer(id));
		if (jiaodiantu == null)
			return JsonResult.error(-2,"非法的数据");

		return  JsonResult.success(1,"成功更新",jiaodiantu);

	}


	@PostMapping("/admin/jiaodiantu/list")
	public JsonResult list() {

		HashMap map = new HashMap();
		int pageindex = 1;
		int pagesize = 10;

		String title = request.getParameter("title");
		String ispaged = request.getParameter("ispaged");

		if (title != null)
			map.put("title",title);
		// 获取当前分页
		String currentpageindex = request.getParameter("currentpageindex");
		// 当前页面尺寸
		String currentpagesize = request.getParameter("pagesize");
		// 设置当前页
		if (currentpageindex != null)
			pageindex = new Integer(currentpageindex);
		// 设置当前页尺寸
		if (currentpagesize != null)
			pagesize = new Integer(currentpagesize);
		if(!"-1".equals(ispaged))
		   PageHelper.startPage(pageindex,pagesize);
		List<Jiaodiantu> listJiaodaintu = focusSrv.getEntityPlus(map);
		if(!"-1".equals(ispaged))
		    return JsonResult.success(1,"成功",new PageInfo<>(listJiaodaintu));
		return JsonResult.success(1,"成功",listJiaodaintu);

	}



}
