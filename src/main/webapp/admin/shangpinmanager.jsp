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
	<title>商品信息</title>
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
		<h2>商品管理</h2>
		<div class="description">

		</div>
	</div>
	<!-- 搜索控件开始 -->
	<div class="search-options">

		<table cellspacing="0" width="100%">
			<tbody>
			<tr>
				<td>
					名称:
					<div style="width:200px;display: inline-block;">
						<el-input placeholder="标题" v-model="name" />
					</div>

					类别:
					<el-cascader v-model="lmvalue"
								 :options="options"
								 :props="{ checkStrictly: true }"
								 clearable></el-cascader>

					<el-button icon="el-icon-search" @click="search" type="danger">
						搜索
					</el-button>
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
			<el-button type="success" icon="el-icon-check" @click="selectedAllHandler">选择</el-button>
			<el-button type="danger" icon="el-icon-delete" @click="deleteRec">删除</el-button>
			<el-button type="primary" icon="el-icon-plus" @click="shangjiaHandler">上架</el-button>
			<el-button type="warning" icon="el-icon-download" @click="xiajiaHandler">下架</el-button>
		</el-button-group>

	</div>

	<div class="image-text-box3">


		<div class="bd">


			<div v-for="shangpin in listShangpin" class="item">
				<div class="image-ar">
					<a :href="hostHead+'/admin/shangpindetails.jsp?id='+shangpin.id">
						<img :src="hostHead+shangpin.images[0]"/>
					</a>
					<span class="name"><input type="checkbox" v-model="shangpin.rowSelected" :value="shangpin.id" />{{shangpin.name}}</span>

				</div>
				<div class="text-ar">
					<div class="title"><a :href="hostHead+'/admin/shangpinadd.jsp?id='+shangpin.id">{{shangpin.name}}</a></div>
					<div class="subtitle"><el-tag>{{shangpin.typename}}/{{shangpin.subtypename}}</el-tag></div>
					<div class="time">{{shangpin.pubtime}}</div>
					<div class="time">{{shangpin.kucun}}{{shangpin.danwei}}</div>
					<div class="time">{{shangpin.chandi}}</div>
					<div v-if="shangpin.spstate==1" class="time">
						<a :href="hostHead+'/admin/shangpindetails.jsp?id='+shangpin.id" class="el-button el-button--primary"><i class="el-icon-arrow-right"></i>审批</a>
					</div>

				</div>
				<div class="toolbar-op">
					<div class="btn-group">
						<span @click="deleteOne(shangpin.id)" title="删除" class="btn btn-danger"><i class="fa fa-trash"></i></span>
						<a :href="hostHead+'/admin/shangpinadd.jsp?id='+shangpin.id" title="编辑" class="btn btn-primary"><i class="fa fa-edit"></i></a>
						<a :href="hostHead+'/admin/spcaigou.jsp?id='+shangpin.id" title="加库存" class="btn btn-success"><i class="fa fa-plus"></i></a>
						<a :href="hostHead+'/admin/shangpindetails.jsp?id='+shangpin.id" title="商品详情" class="btn btn-success"><i class="fa fa-eye"></i></a>

					</div>
				</div>
				<div class="tag">
					<div class="name">
						<span v-if="shangpin.state==1">上架</span>
						<span v-if="shangpin.state==2">下架</span>
					</div>
				</div>
			</div>


			<div v-if="listShangpin.length==0" style="width: 100%;" class="no-record-tip white-paper">
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
			listShangpin:[],
			options:[],
			lmvalue:[],
			pageindex:1,
			pagesize:10,
			total:10,
			selectedAll:false,
			name:""

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
			async search() {

				let param={
					currentpageindex:this.pageindex,
					pagesize:this.pagesize,
					name:this.name
				};
				if(this.lmvalue!=null&&this.lmvalue.length>0)
					param.typeid=this.lmvalue[0];
				if(this.lmvalue!=null&&this.lmvalue.length>=2)
					param.subtypeid=this.lmvalue[1];

				let url = "admin/shangpin/pagelist";
				let {data:res}=await this.$http.post(url,param);
				if(res!=null&&res.data!=null) {
					this.total=res.data.total;
					if (res.data.list!=null) {
						res.data.list.forEach(c => {
							c.rowSelected = false;
						});
						this.listShangpin = res.data.list;
						console.log("listShangpin=",this.listShangpin);
					}
				}

			},

			async getLanmus(){
				let url = "admin/shangpin/cascadelanmu";
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
				if (this.listShangpin != null) {
					this.listShangpin.forEach(c => {
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
			async shangjiaHandler(){
				let url = "admin/shangpin/shangjia";
				let util = new VueUtil(this);
				let ids = this.listShangpin.filter(c => c.rowSelected).map(c => c.id);
				if (ids!=null&&ids.length<=0) {
					util.alert('请选择需要上架的商品', '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}
				let {data:res}=await util.http.post(url, {ids}, {emulateJSON: false});
				if (res!=null&&res.stateCode<0){
					util.message.error(res.des);
					return ;
				}
				util.message.success("上架成功");
				this.search();
			},
			async xiajiaHandler(){
				let url = "admin/shangpin/xiajia";
				let util = new VueUtil(this);
				let ids = this.listShangpin.filter(c => c.rowSelected).map(c => c.id);
				if (ids!=null&&ids.length<=0) {
					util.alert('请选择需要下架的商品', '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}
				let {data:res}=await util.http.post(url, {ids}, {emulateJSON: false});
				if (res!=null&&res.stateCode<0){
					util.message.error(res.des);
					return ;
				}
				util.message.success("上架成功");
				this.search();
			}

		}

	});

</script>
