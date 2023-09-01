<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld" %>
<%@ include file="import.jsp" %>
<!DOCTYPE html >
<html>
<head>
	<title>发布信息</title>


	<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/index.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/box.all.css" type="text/css"></link>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
		  type="text/css"/>
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



</head>
<body>
<div id="app">

	<page-header headid="${param.headid}"></page-header>

	<div  style="min-height: 600px;" class="wrap round-block">


	<div class="line-title">
		当前位置：<a href="${pageContext.request.contextPath}/e/index.jsp">首页</a> &gt;&gt;{{lanmu.name}}/{{subtype.name}}
	</div>


	<div v-if="isLogin()" class="main-content">
		<table class="grid" cellspacing="1" width="100%">

			<tr>
				<td width="10%" align="right">标题:</td>
				<td width="*">
					<input name="title" placeholder="标题" v-validate="{required:true,messages:{required:'请输入标题'}}"
						   v-model="xinxi.title" class="input-txt" type="text"/>
				</td>
			</tr>



			<tr>
				<td align="right">封面:</td>
				<td>
					<dw-upload v-model="xinxi.tupian" :host-head="hostHead"></dw-upload>
				</td>
			</tr>
			<tr>
				<td align="right">标签:</td>
				<td>
					<el-select v-model="xinxi.tagid" clearable placeholder="请选择">
						<el-option
								v-for="item in listStag"
								:key="item.id"
								:label="item.name"
								:value="item.id">
						</el-option>
					</el-select>
				</td>
			</tr>


			<tr>
				<td align="right">介绍:</td>
				<td colspan="3">
					<quill-editor v-model="xinxi.dcontent"></quill-editor>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<el-button @click="submitHandler" type="primary" icon="el-icon-plus">提交</el-button>
				</td>
			</tr>
		</table>
	</div>


	<div v-else  style="font-size:18px;padding:20px 120px;">
		登录后才能发布帖子 ,<span @click="openLogin=true" style="color:#e9ab32;cursor: pointer;" >登录</span>
	</div>


	<login-dlg  :show.sync="openLogin"></login-dlg>


</div>
</div>
</body>
</html>
<div class="fn-clear"></div>

<jsp:include page="bottom.jsp"></jsp:include>
<jsp:include page="loginmodalvue.jsp"></jsp:include>




<script type="text/javascript">

	Vue.http.options.root = '${pageContext.request.contextPath}';
	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};
	Vue.use(VueQuillEditor);

	let vm = new Vue({
		el: "#app",
		data() {
			return {

				actiontype: 'save',
				lanmu: {},
				subtype:{},
				openLogin:false,
				listStag:[],
				hostHead: '${pageContext.request.contextPath}',
				"xinxi": {
					"title": "",
					"lmid": "${param.lmid}",
					"subtypeid":"${param.subtypeid}",
					"tupian": "/upload/nopic.jpg",
					"clickcount": 0,
					"agreecount": 0,
					"againstcount": 0,
					"pubren": "${sessionScope.huiyuan.id}",
					"state": 2,
					"jifen":0,
					"tuijian": 1,
					"tagid": 1,
					"dcontent": ""
				},
			}
		},
		methods: {
			//begin load

			async submitHandler() {

				let defaultOptions = {
					url: "admin/xinxi/save",
					actionTip: "发布成功"
				};
				let util = new VueUtil(this);

				const validRes = this.myValidator.valid(this);
				if (!validRes)
					return;

				let params = {...this.xinxi};
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
				window.location.href = this.hostHead + "/e/huiyuan/xinximanager.jsp";
			},
			async getLanmu(){
				let url = "admin/lanmu/info";
				let {data:res}=await this.$http.post(url,{
					id:this.xinxi.lmid
				});
				if (res.stateCode<0){
					this.$message.error(res.des);
					return ;
				}
				this.lanmu=res.data;
				this.subtype=this.lanmu.subtypes.find(c=>c.id==this.xinxi.subtypeid);
				if (this.subtype==null)
					this.subtype=this.lanmu.subtypes[0];
			},
			async getTags(){
				let url = "admin/stag/list";
				let {data:res}=await this.$http.post(url,{ispaged:"-1"});
				if (res.stateCode<0){
					this.$message.error(res.des);
					return ;
				}
				this.listStag=res.data;
				if (this.listStag&&this.listStag.length>0)
					this.xinxi.tagid=this.listStag[0].id;
			},
			isLogin() {
				let huiyuan = "${sessionScope.huiyuan.accountname}";
				if (huiyuan == "")
					return false;
				return true;
			},

		},
		async created() {

            await this.getLanmu();
			await this.getTags();

		}

	});

</script>

