package com.daowen.controller;

import com.daowen.entity.Users;
import com.daowen.service.SysroleService;
import com.daowen.service.UsersService;
import com.daowen.ssm.simplecrud.SimpleController;
import com.daowen.util.JsonResult;
import com.daowen.webcontrol.PagerMetal;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
public class UsersController  {

	@Autowired
	private UsersService usersService;
	@Autowired
	private HttpServletResponse response;
	@Autowired
	private HttpServletRequest  request;



	@PostMapping("/admin/users/list")
	public JsonResult list(){
		int pageindex = 1;
		int pagesize = 10;
		String filter = "where 1=1 ";
		HashMap<String,Object> map=new HashMap<String,Object>();
		String username=request.getParameter("username");
		if(username!=null)
			map.put("username",username);
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
		PageHelper.startPage(pageindex,pagesize);
		List<Users> listUsers = usersService.getEntityPlus(map);
		request.setAttribute("listUsers", listUsers);
		PageInfo<Users> pageInfo=new PageInfo<>(listUsers);
		return JsonResult.success(1,"获取用户信息",pageInfo);
	}



	@PostMapping("/admin/users/modifypw")
	public JsonResult modifyPw() {
		String password1 = request.getParameter("password1");
		String repassword1 = request.getParameter("repassword1");
		String id = request.getParameter("id");
		if (id == null || id == "")
			return JsonResult.error(-1,"id不能为空");
		Users users = usersService.loadPlus(new Integer(id));
        if(users==null)
        	return  JsonResult.error(-2,"数据非法");
		if(!password1.equals(users.getPassword()))
            return JsonResult.error(-3,"原始密码不正确");
		users.setPassword(repassword1);
		usersService.update(users);
		request.getSession().removeAttribute("users");
		return JsonResult.success(1,"密码修改成功");

	}

	@PostMapping("/admin/users/save")
	public JsonResult save() {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String creator = request.getParameter("creator");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String realname = request.getParameter("realname");
		String nickname = request.getParameter("nickname");
		String roleid = request.getParameter("roleid");
		String sex = request.getParameter("sex");
		String xiangpian = request.getParameter("xiangpian");
		SimpleDateFormat sdfusers = new SimpleDateFormat("yyyy-MM-dd");
		Users users = new Users();
		users.setUsername(username == null ? "" : username);
		users.setPassword(password == null ? "" : password);
		users.setCreator(creator == null ? "" : creator);
		users.setCreatetime(new Date());
		users.setEmail(email == null ? "" : email);
		users.setTel(tel == null ? "" : tel);
		users.setLogtimes(0);
		users.setRoleid(roleid == null ? 0 : Integer.parseInt(roleid));
		users.setRealname(realname == null ? "" : realname);
		users.setNickname(nickname == null ? "" : nickname);
		users.setSex(sex == null ? "" : sex);
		users.setXiangpian(xiangpian == null ? "" : xiangpian);
		if(usersService.isExist("where username='"+username+"'"))
			return JsonResult.error(-1,"已存在的账户名");
		usersService.save(users);
		return JsonResult.success(1,"新增成功");
	}

	@PostMapping("/admin/users/update")
	public JsonResult update() {
		String id = request.getParameter("id");
		if (id == null)
			return JsonResult.error(-1,"id不能为空");
		Users users = usersService.load(new Integer(id));
		if (users == null)
			return JsonResult.error(-2,"非法数据");
		String username = request.getParameter("username");
		String creator = request.getParameter("creator");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String realname = request.getParameter("realname");
		String roleid = request.getParameter("roleid");
		String nickname = request.getParameter("nickname");
		String sex = request.getParameter("sex");
		String xiangpian = request.getParameter("xiangpian");
		SimpleDateFormat sdfusers = new SimpleDateFormat("yyyy-MM-dd");
		users.setUsername(username);
		users.setEmail(email);
		users.setTel(tel);
		users.setRealname(realname);
		users.setRoleid(roleid == null ? 1 : Integer.parseInt(roleid));
		users.setNickname(nickname);
		users.setSex(sex);
		users.setXiangpian(xiangpian);
		usersService.update(users);
		return JsonResult.success(1,"更新成功");

	}


	@PostMapping("/admin/users/load")
	public JsonResult load(){
		String id = request.getParameter("id");
		if(id==null)
			return JsonResult.error(-1,"参数异常");
		Users users = usersService.loadPlus(new Integer(id));
		return  JsonResult.success(1,"获取用户数据",users);
	}


	@PostMapping("/admin/users/delete")
	public JsonResult delete(){
		String[] ids=request.getParameterValues("ids");
		String SQL = " where id in(" + String.join(",", ids)+ ")";
		usersService.delete(SQL);
		return JsonResult.success(1,"删除成功");
	}

}
