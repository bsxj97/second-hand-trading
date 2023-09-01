<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>发货</title>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js'></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>

</head>
<body>
<div id="app">
    <div class="search-title">
        <h2>
            在线发货
        </h2>
        <div class="description">
        </div>
    </div>
    <div style="margin:22px 30px; ">
        <el-steps :space="200" :active="3" finish-status="success">
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

        <table v-for="od in order.orderDetail" class="smart-table" border="1">
            <tr>
            <td class="tlabel">订单编号</td>
            <td>{{order.ddno}}</td>
            <td class="tlabel">下单时间:</td>
            <td>
                {{order.createtime}}

            </td>
        </tr>
            <tr >
                <td class="tlabel">商品</td>
                <td colspan="3">
                    <img width="80" height="80" :src="hostHead+od.images[0]"/>
                    {{od.spname}}
                    {{od.price}}¥X{{od.count}}
                </td>
            </tr>
            <tr>
                <td class="tlabel">物流类别</td>
                <td colspan="3">
                    <el-radio v-model="wltype" label="顺丰">顺丰</el-radio>
                    <el-radio v-model="wltype" label="中通">中通</el-radio>
                    <el-radio v-model="wltype" label="韵达">韵达</el-radio>
                    <el-radio v-model="wltype" label="京东">京东</el-radio>
                </td>
            </tr>
            <tr>
                <td class="tlabel">物流号</td>
                <td colspan="3">
                    <div style="width:300px; " v-if="od.state==2">
                        <el-input
                            placeholder="请输入物流单号"
                            v-model="wlno"
                            clearable>
                      </el-input>
                    </div>
                    <div v-if="od.state==3||od.state==4">{{od.wlno}}</div>

                </td>
            </tr>
            <tr v-if="od.state==2">

                <td colspan="4">
                    <span v-if="od.state==2" @click="fauoHandler" class="btn btn-danger">发货</span>
                </td>
            </tr>

        </table>



</div>


</body>
</html>
<script type="text/javascript">

    Vue.http.options.root = '${pageContext.request.contextPath}';
    Vue.http.options.emulateJSON = true;
    Vue.http.options.xhr = {withCredentials: true};

    let vm=new Vue({
        el:"#app",

        data:{
          id:"${param.id}",
          oiid:'${param.oiid}',
          wlno:'',
          wltype:'顺丰',
          hostHead:'${pageContext.request.contextPath}',
          order:{},
          huiyuan:null
        },
        methods:{

          async getOrderInfo(){
             let {data:res}= await this.$http.post("admin/shorder/info",{id:this.id});
             if (res.stateCode<0){
                 this.$message.error(res.des);
                 return ;
             }
             console.log("订单数据",res);

             res.data.orderDetail=res.data.orderDetail.filter(c=>{
                return c.id==this.oiid;
             });

             this.order=res.data;
             console.log("order",this.order);

          },
          async getHuiyuanInfo(){

              let {data:res}=await this.$http.post("admin/huiyuan/info",{id:this.order.purchaser});

              if (res.stateCode<0){
                  this.$message.error(res.des);
                  return ;
              }
              this.huiyuan=res.data;
              console.log("huiyuan",this.huiyuan);
          },
         async fauoHandler(){
             if (this.wlno==""){
                 this.$message.error("请输入物流号");
                 return;
             }
             let {data:res}=await this.$http.post("admin/shorder/deliver",{oiid:this.oiid,wlno:this.wlno,wltype:this.wltype});

             if (res.stateCode<0){
                 this.$message.error(res.des);
                 return ;
             }
             this.$message.success("发货完成");
             this.getOrderInfo();


          }
        },
        async created(){
          await this.getOrderInfo();
          await this.getHuiyuanInfo();
        }

    });

</script>