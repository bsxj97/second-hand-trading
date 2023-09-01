package com.daowen.controller;

import com.daowen.ssm.simplecrud.SimpleController;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.daowen.entity.Receaddress;
import com.daowen.service.ReceaddressService;
import com.daowen.util.JsonResult;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

/**************************
 * 
 * 收货地址控制
 *
 */
@RestController
public class ReceaddressController extends SimpleController {
	@Autowired
	private ReceaddressService receaddressSrv = null;

	@PostMapping("/admin/receaddress/delete")
	public JsonResult delete() {
		String[] ids = request.getParameterValues("ids[]");
		if (ids == null)
			return JsonResult.error(-1,"编号不能为空");

		String SQL = " where id in(" + StringUtils.join(ids,",") + ")";

		receaddressSrv.delete(SQL);
		return  JsonResult.success(1,"删除成功");
	}

	@RequestMapping("/admin/receaddress/save")
	public JsonResult save() {
		String title = request.getParameter("title");
		String shr = request.getParameter("shr");
		String mobile = request.getParameter("mobile");
		String postcode = request.getParameter("postcode");
		String addinfo = request.getParameter("addinfo");
		String hyid = request.getParameter("hyid");
		Receaddress receaddress = new Receaddress();
		receaddress.setTitle(title == null ? "" : title);
		receaddress.setShr(shr == null ? "" : shr);
		receaddress.setMobile(mobile == null ? "" : mobile);
		receaddress.setPostcode(postcode == null ? "" : postcode);
		receaddress.setAddinfo(addinfo == null ? "" : addinfo);
		receaddress.setHyid(hyid==null?0:new Integer(hyid));
		receaddressSrv.save(receaddress);
		return JsonResult.success(1,"新增地址成功");

	}

   @PostMapping("/admin/receaddress/update")
	public JsonResult update() {
		String id = request.getParameter("id");
		if (id == null)
			return JsonResult.error(-1,"ID不能为空");
		Receaddress receaddress = receaddressSrv.load(new Integer(id));
		if (receaddress == null)
			return JsonResult.success(-2,"不合法的数据");
		String title = request.getParameter("title");
		String shr = request.getParameter("shr");
		String mobile = request.getParameter("mobile");
		String postcode = request.getParameter("postcode");
		String addinfo = request.getParameter("addinfo");
	   String hyid = request.getParameter("hyid");
		SimpleDateFormat sdfreceaddress = new SimpleDateFormat("yyyy-MM-dd");
		receaddress.setTitle(title);
		receaddress.setShr(shr);
		receaddress.setMobile(mobile);
		receaddress.setPostcode(postcode);
		receaddress.setAddinfo(addinfo);
	    receaddress.setHyid(hyid==null?0:new Integer(hyid));
		receaddressSrv.update(receaddress);
		return JsonResult.success(1,"更新成功",receaddress);
	}

	@PostMapping("/admin/receaddress/load")
	public JsonResult load() {
		//
		String id = request.getParameter("id");
		if (id == null)
			return JsonResult.error(-1,"ID不能为空");
		Receaddress receaddress = receaddressSrv.load(new Integer(id));
		if (receaddress == null)
			return JsonResult.success(-2,"不合法的数据");
		return JsonResult.success(1,"成功",receaddress);
	}


	@PostMapping("/admin/receaddress/list")
	public JsonResult list() {

		HashMap map =new HashMap();
		String title = request.getParameter("title");
		String hyid=request.getParameter("hyid");
		String paged=request.getParameter("paged");

		if (title != null)
			map.put("title",title);
		if(hyid!=null)
			map.put("hyid",hyid);
		int pageindex = 1;
		int pagesize = 10;
		// 获取当前分页
		String currentpageindex = request.getParameter("currentpageindex");
		// 当前页面面积
		String currentpagesize = request.getParameter("pagesize");
		// 设置当前页
		if (currentpageindex != null)
			pageindex = new Integer(currentpageindex);
		// 设置当前页面积
		if (currentpagesize != null)
			pagesize = new Integer(currentpagesize);
		if(!"-1".equals(paged))
		   PageHelper.startPage(pageindex,pagesize);
		List<Receaddress> listReceaddress = receaddressSrv.getEnityPlus(map);
		if(!"-1".equals(paged))
		   return JsonResult.success(1,"地址信息",new PageInfo(listReceaddress));

		return JsonResult.success(1,"地址信息",listReceaddress);

	}
}
