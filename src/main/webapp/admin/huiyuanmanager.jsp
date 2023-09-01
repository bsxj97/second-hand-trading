<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="law.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

	<title>会员管理</title>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
	<link href="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.umd.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
	<link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />

</head>


<body >
<div id="app">

	<div class="search-title">
		<h2>会员管理</h2>
		<div class="description">
		</div>
	</div>

	<!-- 搜索控件开始 -->
	<div class="search-options">


		<table  cellspacing="0" width="100%">
			<tbody>

			<tr>
				<td>



					账号:<input name="accountname" @keyup.enter="search"  v-model="accountname"  class="input-txt" type="text"   />

					<el-button @click="search" type="primary" icon="el-icon-search">搜索</el-button>
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

			<el-button @click="deleteRec"  type="danger" icon="el-icon-delete"> 删除</el-button>

		</el-button-group>
	</div>

	<table id="huiyuan" width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">
		<thead>
		<tr >
			<th >
				<input type="checkbox" @click="selectedAllHandler" v-model="selectedAll"/>
			</th>



			<th><b>账号</b></th>
			<th><b>邮箱</b></th>
			<th><b>姓名</b></th>
			<th><b>注册时间</b></th>
			<th><b>级别</b></th>
			<th><b>性别</b></th>
			<th><b>余额（元）</b></th>
			<th><b>登录次数</b></th>
			<th>
				操作
			</th>

		</tr>

		</thead>
		<tbody>


		<tr v-for="(huiyuan,index) in  listHuiyuan" :key="huiyuan.id">
			<td>
				<input  class="check" name="ids" type="checkbox" v-model="huiyuan.rowSelected" />


			</td>
			<td>
				{{huiyuan.accountname}}
			</td>
			<td>
				{{huiyuan.email}}
			</td>

			<td>
				{{huiyuan.name}}
			</td>
			<td>
				{{huiyuan.regdate}}
			</td>
			<td>
				<span v-if="huiyuan.hytype!=null">{{huiyuan.hytype.name}}</span>

			</td>
			<td>
				{{huiyuan.sex}}
			</td>
			<td>
				{{huiyuan.yue}}¥
			</td>
			<td>
				{{huiyuan.logtimes}}
			</td>
			<td >
				<div class="btn-group">


					<span class="btn btn-success" @click="showInfo(huiyuan)" ><i class="fa fa-info"></i>查看</span>
					<a class="btn btn-danger"  :href="hostHead+'/admin/huiyuanadd.jsp?id='+huiyuan.id"><i class="fa fa-edit"></i>修改</a>

				</div>
			</td>
		</tr>

		<tr v-if="listHuiyuan.length==0">
			<td colspan="20">
				没有相关会员信息
			</td>
		</tr>


		</tbody>
	</table>

	<el-dialog title="设置会员级别" :visible.sync="updatejbdlg">

		<table cellpadding="0" cellspacing="1" class="grid" width="100%">
			<tr>
				<td align="right" class="title">用户名:</td>
				<td>
					{{huiyuan.accountname}}({{huiyuan.nickname}})
				</td>
				<td colspan="2" rowspan="6"><img  width="200px"
												  height="200px" :src="hostHead+huiyuan.touxiang" /></td>
			</tr>
			<tr>
				<td align="right" class="title">姓名:</td>
				<td>{{huiyuan.name}}</td>
			</tr>
			<tr>
				<td align="right">会员级别:</td>
				<td>
					<dw-dropdownlist name="typeid" v-model="huiyuan.typeid" :url="hostHead+'/admin/hytype/list?ispaged=-1'"></dw-dropdownlist>
				</td>
			</tr>

			<tr>
				<td align="right" class="title">注册时间:</td>
				<td>
					{{huiyuan.regdate}}
				</td>
			</tr>
			<tr>
				<td align="right" class="title">登录次数:</td>
				<td>{{huiyuan.logtimes}}</td>
			</tr>

			<tr>
				<td align="right" class="title">邮箱:</td>
				<td>{{huiyuan.email}}</td>
			</tr>
			<tr>
				<td align="right" class="title">移动电话:</td>
				<td>{{huiyuan.mobile}}</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<td align="right" class="title">地址:</td>
				<td>{{huiyuan.address}}</td>


			</tr>

		</table>
		  <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitHandler">确 定</el-button>
            <el-button @click="updatejbdlg= false">取 消</el-button>
         </div>


	</el-dialog>

	<el-dialog title="查看会员信息" :visible.sync="infodlg">

		<table cellpadding="0" cellspacing="1" class="grid" width="100%">
			<tr>
				<td align="right" class="title">用户名:</td>
				<td>
					{{huiyuan.accountname}}({{huiyuan.nickname}})
				</td>
				<td colspan="2" rowspan="6"><img  width="200px"
												  height="200px" :src="hostHead+huiyuan.touxiang" /></td>
			</tr>
			<tr>
				<td align="right" class="title">姓名:</td>
				<td>{{huiyuan.name}}</td>
			</tr>
			<tr>
				<td align="right">会员级别:</td>
				<td>
					<span v-if="huiyuan.hytype!=null">{{huiyuan.hytype.name}}</span>

				</td>
			</tr>

			<tr>
				<td align="right" class="title">注册时间:</td>
				<td>
					{{huiyuan.regdate}}
				</td>
			</tr>
			<tr>
				<td align="right" class="title">登录次数:</td>
				<td>{{huiyuan.logtimes}}</td>
			</tr>

			<tr>
				<td align="right" class="title">邮箱:</td>
				<td>{{huiyuan.email}}</td>
			</tr>
			<tr>
				<td align="right" class="title">移动电话:</td>
				<td>{{huiyuan.mobile}}</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<td align="right" class="title">地址:</td>
				<td>{{huiyuan.address}}</td>


			</tr>

		</table>


	</el-dialog>


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


	let vm=new Vue({

		el:"#app",
		data(){
			return {
				"accountname":"",
				hostHead:"${pageContext.request.contextPath}",
				selectedAll:false,
				listHuiyuan:[],
				pageindex:1, //初始页
				pagesize:10,
				total:10,
				updatejbdlg:false,
				infodlg:false,
				huiyuan:{}
			}

		},
		methods:{
			pagesizeChange: function (pagesize) {
				this.pagesize = pagesize;
			},
			pageindexChange: function(pageindex){
				this.pageindex = pageindex;
				console.log(this.pageindex);
				this.search();
			},
			async search(){
				let url="admin/huiyuan/list";
				let param={
					currentpageindex:this.pageindex,
					pagesize:this.pagesize,
					"accountname":this.accountname,
				};
				let util=new VueUtil(this);
				console.log("this.pageindex="+this.pageindex);
				let res=await util.http.post(url,param);
				if(res.data!=null){
					let pageInfo=res.data.data;
					this.total=pageInfo.total;
					this.listHuiyuan=pageInfo.list;
					console.log(pageInfo);
				}
			},
			async deleteRec(){
				let url="admin/huiyuan/delete";
				let util=new VueUtil(this);
				let hasChecked=this.listHuiyuan.some(c=>{
					return c.rowSelected==true;
				});
				if(!hasChecked){
					util.alert('请选择需要删除的记录', '系统提示', {
						confirmButtonText: '确定'
					});
					return;
				}

				let ids=this.listHuiyuan.filter(c=>c.rowSelected).map(c=>c.id);
				let res= util.confirm('是否要删除数据?', '系统提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning',
				}).then(()=>{
					util.http.post(url, {ids},{emulateJSON:false}).then(res=>{
						if (res.data != null && res.data.stateCode > 0) {
							this.search();
						}
					});
				}).catch(()=>{});
			},
			selectedAllHandler(){
				console.log(this.selectedAll);
				if(this.listHuiyuan!=null){
					this.listHuiyuan.forEach(c=>{
						c.rowSelected=!this.selectedAll;
					});
				}
			},
			showDlg(huiyuan){
				this.huiyuan=huiyuan;
				this.updatejbdlg=true;
			},
			showInfo(huiyuan){
				this.huiyuan=huiyuan;
				this.infodlg=true;
			},
			async submitHandler(){

				let util = new VueUtil(this);
				let url="admin/huiyuan/updatejb";
				let {data: res} = await util.http.post(url, {id: this.huiyuan.id,typeid:this.huiyuan.typeid});
				if (res != null && res.stateCode<0) {
					util.message.error(res.des);
					return;
				}
				this.updatejbdlg=false;
				this.$message.success("设置成功");
				this.search();
			}
		},
		created(){
			this.search();
		}
	});

</script>
