<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>订单信息查看</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/index.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/box.all.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/web2table.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js'></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>


</head>
<body>
<div id="app">
    <page-header></page-header>
    <div class="wrap round-block">
        <div class="line-title">
            当前位置：<a href="${pageContext.request.contextPath}/e/index.jsp">首页</a> &gt;&gt; 在线付款
        </div>



        <div  class="main">

            <page-menu seedid="${param.seedid}"></page-menu>
            <div  class="main-content">

                <div style="margin:22px 30px; ">
                    <el-steps :space="200" :active="2" finish-status="success">
                        <el-step title="下单"></el-step>
                        <el-step title="付款"></el-step>
                        <el-step title="发货"></el-step>
                        <el-step title="收货评价"></el-step>
                    </el-steps>
                </div>
                <div class="shaddr-wrap">
                    <div class="logo"><i class="fa fa-location-arrow"></i></div>
                    <div v-if="huiyuan!=null" class="bd">

                        <div class="contact">
                            {{huiyuan.receaddresses[0].mobile}}
                            {{huiyuan.name}}
                        </div>
                        <div class="addinfo">{{huiyuan.receaddresses[0].addinfo}}
                            <span>{{huiyuan.receaddresses[0].postcode}}</span>
                        </div>

                    </div>

                </div>
                <table border="1" class="smart-table">
                    <tr>
                        <td class="tlabel">订单编号</td>
                        <td>{{order.ddno}}</td>
                        <td class="tlabel">下单时间:</td>
                        <td>
                            {{order.createtime}}

                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ui-record-table">


                    <thead>

                    <tr>
                        <th width="300px">名称</th>
                        <th>价格</th>
                        <th>数量</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>

                    <tr v-for="od in order.orderDetail">
                        <td width="300px;">
                            <div style="display: flex;flex-direction:row;padding:5px 20px; ">
                                <img width="80" height="80" :src="hostHead+od.images[0]"/>
                                <div style="margin-left: 18px;">{{od.spname}}</div>
                            </div>
                        </td>
                        <td>{{od.price}}元</td>
                        <td>{{od.count}}</td>
                        <td>
                            <span v-if="od.state==1">待付款</span>
                            <span v-if="od.state==2">已付款</span>
                            <span v-if="od.state==3">
									物流号:{{od.wlno}}
								</span>
                            <span v-if="od.state==4">已完成</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            总金额:{{order.totalfee}}元
                        </td>

                    </tr>


                    <tr v-if="order.state==1">

                        <td colspan="4" align="left">
                            支付密码:
                            <div style="width:220px;display:inline-block">
                                <el-input
                                        placeholder="请输入支付密码"
                                        v-model="paypwd"
                                        show-password
                                        clearable>
                                </el-input>
                            </div>

                        </td>

                    </tr>

                    <tr v-if="order.state==1">
                        <td colspan="4">
                            <button @click="payHandler(order.id)" class="btn btn-danger">
                                <i class="fa fa-check"></i>确定付款
                            </button>

                        </td>

                    </tr>


                    </tbody>
                </table>

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

    let vm = new Vue({
        el: "#app",

        data: {
            id: "${param.id}",
            paypwd: '',
            hostHead: '${pageContext.request.contextPath}',
            order: {},
            huiyuan: null
        },
        methods: {

            async getOrderInfo() {
                let {data: res} = await this.$http.post("admin/shorder/info", {id: this.id});
                if (res.stateCode < 0) {
                    this.$message.error(res.des);
                    return;
                }
                console.log("订单数据", res);
                this.order = res.data;

            },
            async getHuiyuanInfo() {

                let {data: res} = await this.$http.post("admin/huiyuan/info", {id: this.order.purchaser});

                if (res.stateCode < 0) {
                    this.$message.error(res.des);
                    return;
                }
                this.huiyuan = res.data;
                console.log("huiyuan", this.huiyuan);
            },
            async payHandler(oid) {
                if (this.paypwd == "") {
                    this.$message.error("请输入支付密码");
                    return;
                }
                let {data: res} = await this.$http.post("admin/shorder/payment", {id: this.id, paypwd: this.paypwd});
                if (res.stateCode < 0) {
                    this.$message.error(res.des);
                    return;
                }
                this.$message.success("支付成功");
                window.location.href = "paymentres.jsp";

            }

        },
        async created() {
            await this.getOrderInfo();
            await this.getHuiyuanInfo();
        }

    });

</script>
