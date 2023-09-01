
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="import.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>忘记密码</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/index.css" type="text/css"></link>

<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/forgetpw.css" type="text/css"></link>

<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/box.all.css" type="text/css"></link>

<script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>

<script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
 <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
 <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
<script type="text/javascript">
		 $(function (){
		       $.metadata.setType("attr","validate");
		       $("#form1").validate();
			 $("#form1").submit(function () {

				 let accountname=$("[name=accountname]").val();
				 if(accountname==""){
					 return ;
				 }
				 $.ajax({
					 url:encodeURI('${pageContext.request.contextPath}/admin/huiyuan/forgetpw'),
					 method:'post',
					 data:{
						 "accountname":accountname
					 },
					 success:function(data){
						 if(data.stateCode<0){
							 alert(data.des);
							 return;
						 }
						 window.location.href="${pageContext.request.contextPath}/e/"+data.data.url;
					 },
					 error:function(xmhttprequest,status,excetpion){
						 alert("系统错误，错误编码"+status);
					 }
				 });
				 return false;
			 });
		 });  
 </script>
</head>
<body>


	<div class="wrap round-block">
		<div class="line-title">
			当前位置：<a href="${pageContext.request.contextPath}/e/index.jsp">首页</a> &gt;&gt; 忘记密码
		</div>
	
		<div style="min-height:600px;" class="whitebox">

			<h1>忘记密码</h1>
           <form name="form1" id="form1" method="post" action="${pageContext.request.contextPath}/admin/huiyuanmanager.do">

			<div class="reg-box">

				<div class="reg-title">
					${errormsg}
					
				</div>
				<div class="reg-content">
					

					<dl>
						<dt>账号:</dt>
						<dd>
							<input type="text"  value="${accountname}" validate="{required:true,messages:{required:'请输入账号'}}" class="input width250" id="txtAccountname"
								name="accountname"> 

						</dd>

					</dl>

				
					<dl>
						<dt></dt>
						<dd>
							<button class="btn btn-danger"><i class="fa fa-arrow-right"></i>下一步</button>

						</dd>

					</dl>

                
				</div>


			</div>
          </form>

		</div>
		

	</div>

	<div class="fn-clear"></div>



</body>
</html>