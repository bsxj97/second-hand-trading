
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<%@ include file="law.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改信息</title>
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
<body>
   <div id="app">
	   <page-header active="${param.headid}"></page-header>

	   <div class="wrap">
		<div class="line-title">
			当前位置：<a href="${pageContext.request.contextPath}/e/index.jsp">首页</a> &gt;&gt;修改账户信息
		</div>
	

		<div class="main">

			<page-menu seedid="${param.seedid}"></page-menu>
			<div  class="main-content">

				<table class="smart-table"  cellspacing="1" border="1" width="100%">

					<tr>
						<td class="tlabel" align="right">用户名:</td>
						<td>{{huiyuan.accountname}}</td>
						<td  rowspan="6" colspan="2">
							<dw-upload :host-head="hostHead" v-model="huiyuan.touxiang"></dw-upload>
						</td>
					</tr>

					<tr>
						<td class="tlabel" align="right">姓名:</td>
						<td>

							<input name="name" v-model="huiyuan.name" v-validate="{required:true,messages:{required:'请输入名称'}}"
								   class="input-txt" type="text"  /></td>
					</tr>
					<tr>
						<td class="tlabel" align="right">身份证号:</td>
						<td>

							<input name="idcardno" v-model="huiyuan.idcardno" v-validate="{required:true,idcardno:true,messages:{required:'请输入身份证号',idcardno:'请输入正确的身份证号'}}"
								   class="input-txt" type="text"  /></td>
					</tr>
					<tr>
						<td class="tlabel" align="right">昵称:</td>
						<td><input name="nickname"
								   value="${requestScope.huiyuan.nickname}" validate="{required:true,messages:{required:'请输入昵称'}}" class="input-txt"
								   type="text" id="txtNickname" /></td>
					</tr>


					<tr>
						<td class="tlabel" align="right">邮箱:</td>
						<td><input name="email"
								   v-model="huiyuan.email" validate="{required:true,email:true,messages:{required:'请输入邮箱',email:'请输入正确的邮箱'}}" class="input-txt"
								   type="text" id="txtEmail" /></td>
					</tr>


					<tr>
						<td class="tlabel" align="right">性别:</td>
						<td>
							<el-radio-group v-model="huiyuan.sex">
								<el-radio label="男">男</el-radio>
								<el-radio label="女">女</el-radio>
							</el-radio-group>
						</td>
					</tr>
					<tr>
						<td class="tlabel" align="right">地址:</td>
						<td><input name="address"
								   v-model="huiyuan.address" class="input-txt"
								   type="text"  /></td>

						<td class="tlabel" align="right">移动电话:</td>
						<td><input name="mobile"
								   v-model="huiyuan.mobile" validate="{required:true,mobile:true,messages:{required:'请输入名称'}}" class="input-txt"
								   type="text" /></td>
					</tr>

					<tr>
						<td colspan="4">
							<el-button @click="submitHandler" type="danger" icon="el-icon-check">提交</el-button>
						</td>
					</tr>



				</table>

			</div>
		</div>

	</div>

   </div>

	<div class="fn-clear"></div>


	<jsp:include page="bottom.jsp"></jsp:include>



</body>
</html>


<script type="text/javascript">

	Vue.http.options.root = '${pageContext.request.contextPath}';
	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};
	Vue.use(window.VueQuillEditor);
	let vm = new Vue({
		el: "#app",
		data() {
			return {

				actiontype: 'save',
				errors:"",
				hostHead: '${pageContext.request.contextPath}',
				"huiyuan": {
					"accountname": "",
					"address": "",
					"email": "",
					"idcardno": "",
					"nickname": "",
					"name": "",
					"sex": "",
					"touxiang": "/upload/nopic.jpg",
					"des": ""
				},
			}
		},
		methods: {
			//begin load
			async load() {
				let id = "${sessionScope.huiyuan.id}"
				if (id != "") {
					this.actiontype = "update";
					this.pageTitle = "编辑会员";
					let url = "admin/huiyuan/load";
					let util = new VueUtil(this);
					let {data: res} = await util.http.post(url, {id: id});
					console.log("res", res);
					if (res != null && res.data != null)
						this.huiyuan = res.data;
				}
			},//end load
			async submitHandler() {

				let defaultOptions = {
					url: "admin/huiyuan/save",
					actionTip: "会员新增成功"
				};
				if (this.actiontype == "update") {
					defaultOptions.url = "admin/huiyuan/update";
					defaultOptions.actionTip = "会员更新成功";
				}
				const  validRes=this.myValidator.valid(this);
				console.log("valRes",validRes);
				if (!validRes)
					return ;
				let util = new VueUtil(this);
				let params = {...this.huiyuan};
				let {data: res} = await util.http.post(defaultOptions.url, params);
				if (res.stateCode <= 0) {
					util.alert(res.des, '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}
				util.message({
					message: defaultOptions.actionTip,
					type: 'success',
					duration: 2000
				});
				window.location.href = this.hostHead + "/e/huiyuan/accountinfo.jsp";
			}
		},
		created() {
			this.load();
		}

	});

</script>