<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="law.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>资讯资讯信息</title>
		<link href="${pageContext.request.contextPath}/e/css/box.all.css" rel="stylesheet" type="text/css"/>

		<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
		<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
		<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
		<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>


	</head>
	<body>
	<div id="app">
	<div class="search-title">
		<h2>资讯管理</h2>
		<div class="description">

		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">

			<table cellspacing="0" width="100%">
				<tbody>
				<tr>
					<td>
						标题:
						<div style="width:200px;display: inline-block;">
							<el-input placeholder="标题" v-model="title" />
						</div>

						类别:
						<el-cascader v-model="lmvalue"
									:options="options"
									:props="{ checkStrictly: true }"
									clearable></el-cascader>

						<el-button type="danger" icon="el-icon-search"  @click="search">查找</el-button>

					</td>
				</tr>
				</tbody>
			</table>

	</div>
	<!-- 搜索控件结束 -->
	<div class="clear">
	</div>
	<div class="action-details">
		<el-button-group>
			<el-button @click="selectedAllHandler" type="success" icon="el-icon-check">选择</el-button>
			<el-button @click="deleteRec"  type="danger" icon="el-icon-delete"> 删除</el-button>
		</el-button-group>

	</div>

		<div class="image-text-box3">


			<div class="bd">


				<div v-for="xinxi in listXinxi" class="item">
					<div class="image-ar">
						<a :href="hostHead+'/admin/xinxidetails.jsp?id='+xinxi.id">
							<img :src="hostHead+xinxi.images[0]"/>
							<input type="checkbox" v-model="xinxi.rowSelected" :value="xinxi.id" />
							{{xinxi.title}}
						</a>
					</div>
					<div class="text-ar">
						<div class="title"><a :href="hostHead+'/admin/xinxidetails.jsp?id='+xinxi.id">{{xinxi.title}}</a></div>
						<div class="subtitle"><el-tag>{{xinxi.lmname}}/{{xinxi.subtypename}}</el-tag></div>
						<div class="time">{{xinxi.pubtime}}</div>
						<div class="abstract">{{xinxi.abstact}}</div>
					</div>
					<div class="toolbar-op">
						<div class="btn-group">
							<span @click="deleteOne(xinxi.id)" class="btn btn-danger"><i class="fa fa-trash"></i></span>
							<a :href="hostHead+'/admin/xinxiadd.jsp?id='+xinxi.id" class="btn btn-primary"><i class="fa fa-edit"></i></a>
							<a :href="hostHead+'/admin/xinxidetails.jsp?id='+xinxi.id" class="btn btn-success"><i class="fa fa-eye"></i></a>

						</div>
					</div>
					<div class="tag">
						<div class="name">
							<span v-if="xinxi.tuijian==1">公开</span>
							<span v-if="xinxi.tuijian==0">私有</span>
						</div>
					</div>
				</div>


				<div v-if="listXinxi.length==0" style="width: 100%;" class="no-record-tip white-paper">
					<div class="content">
						<i class="fa fa-warning"></i> 没有相关内容
					</div>
				</div>

			</div>

		</div>

		<div class="clear"></div>
		<el-pagination
				@size-change="pagesizeChange"
				@current-change="pageindexChange"
				:current-page="pageindex"
				:page-sizes="[pagesize]"
				:page-size="pagesize"
				layout="total, sizes, prev, pager, next, jumper"
				:total="total">
		</el-pagination>


		<div class="clear"></div>
	</div>
	</body>
</html>



<script type="text/javascript">


	Vue.http.options.root = '${pageContext.request.contextPath}';

	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};

	let vm = new Vue({
		el: "#app",
		data: {

			hostHead: '${pageContext.request.contextPath}',
			listXinxi:[],
			options:[],
			lmvalue:[],
			pageindex:1,
			pagesize:10,
			total:10,
			selectedAll:false,
			title:""

		},
		async created() {
			console.log("created");
			this.search();
			this.getLanmus();

		},
		async mounted() {


		},
		methods: {
			pagesizeChange: function (pagesize) {
				this.pagesize = pagesize;
			},
			pageindexChange: function(pageindex){
				this.pageindex = pageindex;
				console.log(this.pageindex);
				this.search();
			},
			search() {

				let param={
					currentpageindex:this.pageindex,
					pagesize:this.pagesize,
					title:this.title
				};
				if(this.lmvalue!=null&&this.lmvalue.length>0)
					param.lmid=this.lmvalue[0];
				if(this.lmvalue!=null&&this.lmvalue.length>=2)
					param.subtypeid=this.lmvalue[1];

				let url = "admin/xinxi/list";
				this.$http.post(url,param).then(res => {
					console.log(res.data);
					if(res.data!=null&&res.data.data!=null) {
						let pageInfo=res.data.data;
						this.total=pageInfo.total;
						if (pageInfo.list!=null) {
							pageInfo.list.forEach(c => {
								c.rowSelected = false;
							});
							this.listXinxi = pageInfo.list;
						}
					}
				});
			},

			async getLanmus(){
				let url = "admin/xinxi/cascadelanmu";
				let {data:res}=await this.$http.post(url,{
					id:this.lanmuid
				});
				if (res.stateCode<0){
					this.$message.error(res.des);
					return ;
				}
				this.options=res.data;
			},
			selectedAllHandler() {

				this.selectedAll=!this.selectedAll;
				if (this.listXinxi != null) {
					this.listXinxi.forEach(c => {
						c.rowSelected = this.selectedAll;
					});
				}
			},
			async deleteOne(id){
				let util=new VueUtil(this);
				if (id==null)
					return ;
				let ids=[].push(id);
				let res = util.confirm('是否要删除数据?', '系统提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning',
				}).then(() => {
					util.http.post(url, {ids}, {emulateJSON: false}).then(res => {
						if (res.data != null && res.data.stateCode > 0) {
							util.message.success("删除成功");
							this.search();
						}
					});
				}).catch(() => {
				});
			},
			async deleteRec() {
				let url = "admin/xinxi/delete";
				let util = new VueUtil(this);
				let ids = this.listXinxi.filter(c => c.rowSelected).map(c => c.id);
				if (ids!=null&&ids.length<=0) {
					util.alert('请选择需要删除的记录', '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}


				let res = util.confirm('是否要删除数据?', '系统提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning',
				}).then(() => {
					util.http.post(url, {ids}, {emulateJSON: false}).then(res => {
						if (res.data != null && res.data.stateCode > 0) {
							util.message.success("删除成功");
							this.search();
						}
					});
				}).catch(() => {
				});
			},

		}

	});

</script>
