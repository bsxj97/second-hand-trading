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




		<div class="two-split">
			<div   style="width:250px;" class="split-right">
				<div class="catebox">
					<div class="title">商品类别</div>
					<div class="content">

						<dl v-for="lanmu in listLanmu">
							<dt><span @click="getShangpin({typeid:lanmu.id,pubren:'${param.id}'})">{{lanmu.name}}</span></dt>

							<dd>
								<span class="item" v-for="subtype in lanmu.subtypes"  @click="getShangpin({typeid:lanmu.id,subtypeid:subtype.id,pubren:'${param.id}'})" >{{subtype.name}}</span>
							</dd>
						</dl>


					</div>

				</div>


			</div>
			<div style="width:960px;" class="split-left">

				<div style="min-height:600px;" v-if="listShangpin.length>0" class="picture-list">

					<ul>

						<li v-for="item in listShangpin">

							<div class="item">


								<div class="img">
									<a :href="hostHead+'/e/shangpininfo.jsp?id='+item.id" >

										<img :src="hostHead+item.images[0]" />
									</a>
								</div>

								<div class="name">{{item.name}}</div>
								<div class="price">{{item.hyjia}}元 {{item.chandi}}</div>


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

			hostHead: '${pageContext.request.contextPath}',
			listShangpin:[],
			pageindex:1,
			typeid:-1,
			listLanmu:[],
			selectedIndex:0,
			pagesize:10,
			total:10,
		},
		async created(){
			await this.getLanmu();
			await this.getShangpin();
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
			getShangpin(options) {

				let param={
					currentpageindex:this.pageindex,
					state:1,
					"chandi":"全新",
					spstate:2,
					pagesize:this.pagesize
				};
				if(options!=null&&options.typeid!=null)
					param.typeid=options.typeid;
				if(options!=null&&options.subtypeid!=null)
					param.subtypeid=options.subtypeid;

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
				let url = "admin/shangpin/mylanmu";
				let {data:res}=await this.$http.post(url);
				if(res!=null&&res.data!=null) {
					this.listLanmu =res.data;
					if (this.listLanmu.length>0)
						this.typeid=this.listLanmu[0].id;
				}
			},


		}

	});
</script>