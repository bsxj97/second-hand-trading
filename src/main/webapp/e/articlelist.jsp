<%@  include file="import.jsp" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="daowen" uri="/daowenpager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

<head>
<title>新闻列表</title>
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
    <div  class="wrap round-block">
	<div class="line-title">
		当前位置：<a href="${pageContext.request.contextPath}/e/index.jsp">首页</a>
		&gt;&gt; {{lanmu.name}}
	</div>

		<div class="topic-nav-box">
			{{lanmu.name}}
			<a :href="hostHead+'/e/xinxiadd.jsp?lmid='+lanmu.id+'&subtypeid='+lanmu.subtypes[selectedIndex].id" class="el-button el-button--primary">发布帖子</a>
		</div>
	<div class="filter-box">

		<div class="item">

			<div class="title">{{lanmu.name}}:</div>
			<div class="content-list">
				<ul>

					<li>
						<span class="subtype" v-if="lanmu.subtypes!=null" @click="getXinxi(lanmu.id,subtype.id)" v-for="subtype in lanmu.subtypes">{{subtype.name}}</span>
					</li>


				</ul>
			</div>
		</div>

	</div>


	<div class="two-split">
		 <div class="split-left">

				<div class="article-list">
					<div v-for="xinxi in listXinxi" class="item">
						<div class="picar">
							<a :href="hostHead+'/e/xinxiinfo.jsp?id='+xinxi.id">
							<img class="image" :src="hostHead+xinxi.tupian"/></a>
						</div>
						<div style="width:720px;" class="textar">
							<div class="title"><a :href="hostHead+'/e/xinxiinfo.jsp?id='+xinxi.id">{{xinxi.title}}</a></div>
							<div class="brief">{{xinxi.abstact}}</div>
							<div class="props">
								<div class="time">
									<i class="el-icon-time"></i>{{xinxi.pubtime}}
								</div>
								<div class="count">
									<i class="el-icon-set-up"></i>{{xinxi.clickcount}}次
								</div>
							</div>

						</div>



					</div>
				</div>



		 </div>
		<div style="width:260px; " class="split-right">
			<div class="vm-sidebar">
				<div class="hd">热门信息</div>
				<div class="bd">


						<div v-for="xinxi in listHot" class="item">
							<a :href="hostHead+'/e/xinxiinfo.jsp?id='+xinxi.id">
								<div class="image-wrap">
									<img :src="hostHead+xinxi.images[0]"/>
								</div>
								<div class="text-wrap">
									<div class="name">{{xinxi.title}}</div>
									<div class="muted">{{xinxi.pubtime}}</div>
									<div class="bm-wrap">{{xinxi.clickcount}}人点击</div>
								</div>
							</a>
						</div>


				</div>
			</div>
		</div>
	</div>
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

<jsp:include page="bottom.jsp"></jsp:include>
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
			listHot:[],
			pageindex:1,
			lanmuid:"${param.lanmuid}",
			lanmu:{},
			pagesize:10,
			total:10,
			selectedIndex:0,
			name:""

		},
		async created() {
			console.log("created");

			this.getXinxi(this.lanmuid);
			this.getHot();
			this.getLanmu();

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
				this.getXinxi();
			},
			getXinxi(lmid,subtypeid,index) {
				if(index!=null)
					this.selectedIndex=index;
				let param={
					currentpageindex:this.pageindex,
					pagesize:this.pagesize
				};
				if(lmid!="")
					param.lmid=lmid;
				if(subtypeid!=null)
					param.subtypeid=subtypeid;

				let url = "admin/xinxi/list";
				this.$http.post(url,param).then(res => {
					console.log(res.data);
					if(res.data!=null&&res.data.data!=null) {
						let pageInfo=res.data.data;
						this.total=pageInfo.total;
						this.listXinxi = pageInfo.list;
					}
				});
			},

			getLanmu(){
				let url = "admin/lanmu/info";
				this.$http.post(url,{
					id:this.lanmuid
				}).then(res => {
					console.log(res.data);
					if(res.data!=null&&res.data.data!=null) {
						this.lanmu =res.data.data;
					}
				});
			},
			getHot(){
				let url = "admin/xinxi/hot";
				this.$http.post(url).then(res => {
					console.log(res.data);
					if(res.data!=null&&res.data.data!=null) {
						this.listHot =res.data.data;
					}
				});
			}

		}

	});

</script>
