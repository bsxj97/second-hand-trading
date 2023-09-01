<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>订单信息查看</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/index.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/box.all.css" type="text/css"></link>

	<script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.umd.js"></script>
	<script src="${pageContext.request.contextPath}/webui/quill/quill.min.js"></script>
	<script src="${pageContext.request.contextPath}/webui/quill/vue-quill-editor.js"></script>
	<link href="${pageContext.request.contextPath}/webui/quill/quill.core.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/webui/quill/quill.snow.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/webui/quill/quill.bubble.css" rel="stylesheet"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>

	<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>

</head>
<body >

<div id="app">
	<page-header active="${param.headid}"></page-header>

	<div class="wrap">

		<div class="line-title">
			当前位置：<a href="${pageContext.request.contextPath}/e/index.jsp">首页</a> &gt;&gt; 密码修改
		</div>

		<div class="main">

			<page-menu seedid="${param.seedid}"></page-menu>
			<div  class="main-content">


			<div style="margin-top:80px;font-size:26px; margin-left:80px;">
					<i class="fa fa-check"></i> 密码修改成功

				</div>

			</div>
		</div>
		</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
</body>
</html>

<script type="text/javascript">

	Vue.http.options.root = '${pageContext.request.contextPath}';
	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};

	let  vm=new Vue({
		el:"#app",
		data(){
			return {
				hostHead:"${pageContext.request.contextPath}",
				id:"${sessionScope.huiyuan.id}",

			}
		},
		methods:{

		}

	})

</script>
