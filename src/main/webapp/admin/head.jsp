<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

   $(function(){
   
       
        $("#btnExit").click(function(){
        
            if(!confirm("确定退出系统？")){
            
               return;
            
            }
            top.window.location.href="login.jsp";
            
        
        })
   
   })
</script>

  
  <div class="head">
       
            
             <div style="float:left;font-size:18px;color:white;margin:12px 2px 2px 12px;">
                 大学校园闲置书籍共享服务系统
             </div>


             <div class="head-account">
                             <div class="label-text" style="margin-right:22px; "><a style="color: #fff"  href="${pageContext.request.contextPath}/e/index.jsp" target="_blank">首页</a></div>
                              <div class="label-text">欢迎你</div>
                              <div  class="dropdown account-drop">
                            
                         
                                <span class="dropdown-toggle"  data-toggle="dropdown">
                                     ${sessionScope.users.username} (${sessionScope.users.rolename})
                                    <i class="caret"></i>
                                </span>
                                <ul class="dropdown-menu" style="z-index:10000" role="menu">
                                    <li id="btnExit" ><a role="menuitem" tabindex="-1" href="#">退出</a></li>
                                    <li ><a target="main"
						                  href="${pageContext.request.contextPath}/admin/modifypw.jsp">修改密码</a></li>
                                    <li><a target="main"
						                   href="${pageContext.request.contextPath}/admin/modifyinfo.jsp">编辑信息</a></li>
                                
                                </ul>

                   </div>
            
            
                
                
            </div>
   </div>
