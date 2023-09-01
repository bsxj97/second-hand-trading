<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="daowen" uri="/daowenpager"%>
<%@  include file="import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

	<title> 商品</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/index.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/box.all.css" type="text/css"></link>
	<script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js'></script>
	<link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
	<script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>

</head>
<body>

<div id="app">
	<page-header  headid="${param.headid}"></page-header>
	<div class="banner1">
		<img :src="hostHead+'/e/images/banner01.jpg'" width="100%" height="300"/>
	</div>
	<div class="wrap">


		<div class="filter-box">

			<div class="item">

				<div class="title">{{lanmu.name}}:</div>
				<div class="content-list">
					<ul>

						<li>
							<span class="subtype" :class="{active:index==selectedIndex}" v-if="lanmu.subtypes!=null" @click="getShangpin(lanmu.id,subtype.id,index)" v-for="(subtype,index) in lanmu.subtypes">{{subtype.name}}</span>
						</li>


					</ul>
				</div>
			</div>

		</div>

		<div class="two-split">
			<div style="width:960px;" class="split-left">

				<div v-if="listShangpin.length>0" class="picture-list">

					<ul>

						<li v-for="item in listShangpin">

							<div class="item">


								<div class="img">
									<a :href="hostHead+'/e/shangpininfo.jsp?id='+item.id" >

										<img :src="hostHead+item.images[0]" />
									</a>
								</div>

								<div class="name">{{item.name}}</div>
								<div class="price">{{item.hyjia}}元</div>


							</div>
						</li>

					</ul>

				</div>

				<div v-else class="no-record-tip">
					<div class="content">
						<i class="fa fa-warning"></i>没有找到相关信息
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

			</div>
			<div style="width:250px;" class="split-right">
				<div  class="vm-sidebar">
					<div class="hd">热销商品</div>
					<div class="bd">

						<div v-for="(shangpin,index) in hotSales " class="item">
							<a :href="'${pageContext.request.contextPath}/e/shangpininfo.jsp?id='+shangpin.id">
								<div class="image-wrap">
									<img :src="hostHead+shangpin.images[0]" />
								</div>
								<div class="tag">{{index+1}}</div>
								<div class="text-wrap">
									<div class="name">{{shangpin.name}}</div>
									<div class="muted">销售:{{shangpin.saledcount}}{{shangpin.danwei}}</div>
									<div class="bm-wrap">¥{{shangpin.hyjia}}</div>
								</div>
							</a>
						</div>

					</div>
				</div>
			</div>
		</div>

		<div class="fn-clear"></div>
	</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>



</body>
</html>

<script type="text/javascript">


	Vue.http.options.root = '${pageContext.request.contextPath}';

	Vue.http.options.emulateJSON = true;
	Vue.http.options.xhr = {withCredentials: true};

	let vm=new Vue({
		el:"#app",
		data:{
			hotSales:[],
			hostHead: '${pageContext.request.contextPath}',
			listShangpin:[],
			pageindex:1,
			typeid:"${param.typeid}",
			lanmu:{},
			selectedIndex:0,
			pagesize:10,
			total:10,
		},
		async created(){
			await this.getLanmu();
			this.getHotSales();
			this.getShangpin(this.typeid);
		},
		methods:{


			pagesizeChange: function (pagesize) {
				this.pagesize = pagesize;
			},
			pageindexChange: function(pageindex){
				this.pageindex = pageindex;
				console.log(this.pageindex);
				this.getShangpin(this.typeid);
			},
			getShangpin(typeid,subtypeid,index) {
				this.selectedIndex=index;
				let param={
					currentpageindex:this.pageindex,
					pagesize:this.pagesize,
					spstate:2,
					state:1
				};
				if(typeid!="")
					param.typeid=typeid;
				if(subtypeid!=null)
					param.subtypeid=subtypeid;

				let url = "admin/shangpin/pagelist";
				this.$http.post(url,param).then(res => {
					console.log(res.data);
					if(res.data!=null&&res.data.data!=null) {
						let pageInfo=res.data.data;
						this.total=pageInfo.total;
						this.listShangpin = pageInfo.list;
					}
				});
			},

			async getLanmu(){
				let url = "admin/lanmu/info";
				this.$http.post(url,{
					id:this.typeid
				}).then(res => {
					console.log(res.data);
					if(res.data!=null&&res.data.data!=null) {
						this.lanmu =res.data.data;
					}
				});
			},

			getHotSales(){
				let url="admin/shangpin/hotsales";
				this.$http.post(url).then(res=>{
					if(res.data.data!=null) {
						res.data.data.forEach(c => {
							c.images=c.tupian.split("$;");
						});
						this.hotSales = res.data.data;
					}
				});
			}
		}

	});
</script>