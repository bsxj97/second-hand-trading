
<%@  include file="import.jsp"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="daowen" uri="/daowenpager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>产品信息</title>
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
	<div  class="wrap round-block" style="background-color:#f8f8f8;" >

		<div class="topic-nav-box">
			{{lanmu.name}}
			<a :href="hostHead+'/e/xinxiadd.jsp?lmid='+lanmu.id+'&subtypeid='+lanmu.subtypes[selectedIndex].id" class="el-button el-button--primary">发布帖子</a>
		</div>
		<div class="image-text-box3">


			<div class="filter-box">

				<div class="item">

					<div class="title">{{lanmu.name}}:</div>
					<div class="content-list">
						<ul>

							<li>
								<span class="subtype" :class="{active:index==selectedIndex}" v-if="lanmu.subtypes!=null" @click="getXinxi(lanmu.id,subtype.id,index)" v-for="(subtype,index) in lanmu.subtypes">{{subtype.name}}</span>
							</li>


						</ul>
					</div>
				</div>

			</div>

			<div class="bd">


				<div v-for="xinxi in listXinxi" class="item">
					<div class="image-ar">
						<a :href="hostHead+'/e/xinxiinfo.jsp?id='+xinxi.id"><img :src="hostHead+xinxi.images[0]"/></a>
					</div>
					<div class="text-ar">
						<div class="title"><a :href="hostHead+'/e/xinxiinfo.jsp?id='+xinxi.id">{{xinxi.title}}</a></div>
						<div class="time">{{xinxi.pubtime}}</div>
						<div class="abstract">{{xinxi.abstact}}</div>
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
