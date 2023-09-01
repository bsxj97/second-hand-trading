<%@ include file="import.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="huiyuan/law.jsp"%>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/index.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/web2table.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/box.all.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/e/css/leaveword.css" type="text/css"></link>
    <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue.js'></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js'></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/e/js/SmartStorage.js'></script>

</head>
<body>

<div id="app">
    <page-header  headid="${param.headid}"></page-header>


    <div class="wrap round-block">
        <el-steps :space="200" :active="1" finish-status="success">
            <el-step title="加入购物车"></el-step>
            <el-step title="填写收货地址"></el-step>
            <el-step title="付款"></el-step>
        </el-steps>
        <div class="shopcart-box">
            <div class="hd">购物车</div>
            <div class="bd">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th>商品</th>
                        <th>名称</th>
                        <th>数量</th>
                        <th>单价(元)</th>
                        <th>金额(元)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr  v-for="item in cartItems" :key="item.id">
                        <td>
                            <img width="120" height="120" :src="contextPath+item.value.tupian"/>
                        </td>
                        <td>{{item.value.name}}</td>
                        <td>
                           {{item.value.count}}
                        </td>
                        <td>{{ item.value.price }}¥</td>
                        <td>{{ item.value.count*item.value.price }}¥</td>
                    </tr>
                    </tbody>

                </table>


            </div>
        </div>


    <div class="total-price-panel">
        <div class="pull-left">
            总金额:<span class="price">{{totalPrice}}¥</span>
        </div>
        <div class="pull-right">

        </div>
    </div>



    <!--addressBegin-->


        <div class="address-list clearfix">
            <div class="plus-address">
                <el-button  type="danger" @click="addressdlg=true" icon="el-icon-plus">新增地址</el-button>
            </div>
            <div v-for="(address,index) in listReceaddress">
               <ul  @click="checkAddress(index)"   class="address-info" :class="{selected:index==selectedIndex}">
                        <div class="add-title">
                                {{address.title }}
                        </div><!-- end title -->
                        <li>{{address.shr}}</li>
                        <li>{{address.addinfo }}</li>
                        <li>{{address.mobile }}</li>
                        <li>{{address.postcode}}</li>
                    </ul>
            </div>



        </div>

        <table class="smart-table" width="100%"   border="1">

            <tr>
                <td width="15%" class="tlabel" align="right" height="34px">
                    说明:
                </td>
                <td>
                         <textarea v-model="remark" style="width:500px;height:80px;" name="des">
                         </textarea>
                </td>
            </tr>

            <tr>
                <td colspan="2" height="34px">
                    <el-button-group>
                        <el-button @click="newOrderHandler"  type="warning" icon="el-icon-plus">下单结算</el-button>

                        <a class="el-button--primary el-button" href="${pageContext.request.contextPath}/e/index.jsp">继续选物品</a>

                    </el-button-group>


                </td>

            </tr>




        </table>

    </div>

    <!--addressEnd--->


        <el-dialog title="收货地址管理" :visible.sync="addressdlg">


            <div class="form-group">
                <label>收货人</label>
                <input type="text" class="form-control" name="shr" v-model="receaddress.shr" placeholder="收货人"/>
            </div>



            <div class="form-group">
                <label>联系电话</label>
                <input type="text" class="form-control" name="mobile" v-model="receaddress.mobile"  placeholder="联系电话"/>
            </div>



            <div class="form-group">
                <label>邮编</label>
                <input type="text" class="form-control" v-model="receaddress.postcode" name="postcode"   placeholder="邮编"/>
            </div>



            <div class="form-group">
                <label>地址</label>
                <input type="text" class="form-control" name="addinfo"   v-model="receaddress.addinfo"   placeholder="地址"/>
            </div>


            <div class="form-group">
                <label>备注</label>
                <input type="text" class="form-control" name="title" v-model="receaddress.title"    placeholder="请输入标题"/>
            </div>

            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="saveReceadd">确 定</el-button>
                <el-button @click="addressdlg= false">取 消</el-button>
            </div>



        </el-dialog>


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
    let vm=new Vue({
        el: "#app",
        data(){
            return {
                cartItems:[],
                contextPath:"${pageContext.request.contextPath}",
                hyid:"${sessionScope.huiyuan.id}",
                remark:'',
                openLogin:false,
                addressdlg:false,
                selectedIndex:0,
                receaddress: {
                    shr: "${sessionScope.huiyuan.name}",
                    mobile: "${sessionScope.huiyuan.mobile}",
                    hyid:"${sessionScope.huiyuan.id}",
                    postcode: "",
                    addinfo: "",
                    title: ""
                },
                listReceaddress:[]
            }
        },
        methods:{

            load(){
                let cart=new SmartStorage();
                let temItems=cart.getItems();
                if (temItems!=null)
                    temItems.forEach(c=>{
                        if (c.value.selected)
                            this.cartItems.push(c);
                    });

                this.getAddressList();

            },
            checkAddress(idx){
                this.selectedIndex=idx;
            },
            async getAddressList(){
                let url="admin/receaddress/list";

                let {data:res}=await this.$http.post(url,{hyid:this.hyid,paged:-1});
                if(res!=null&&res.stateCode<0){
                    this.$message.error(res.des);
                    return;
                }
                this.listReceaddress=res.data;
                this.addrid=this.listReceaddress[0].id;
            },
            async saveReceadd(){

                let url="admin/receaddress/save";
                if (this.receaddress.shr==""){
                    this.$message.error("请填写收货人地址");
                    return ;
                }
                if (this.receaddress.mobile==""){
                    this.$message.error("请填写手机号");
                    return ;
                }
                if (this.receaddress.postcode==""){
                    this.$message.error("请填写邮编");
                    return ;
                }
                if (this.receaddress.addinfo==""){
                    this.$message.error("请填写地址");
                    return ;
                }
                if (this.receaddress.title==""){
                    this.$message.error("请填写备注");
                    return ;
                }
                let {data:res}=await this.$http.post(url,this.receaddress);
                if(res!=null&&res.stateCode<0){
                    this.$message.error(res.des);
                    return;
                }
                this.$message.success("保存成功");
                this.addressdlg=false;
                this.getAddressList();
            },
            newOrderHandler(){
                if (this.listReceaddress==null||this.listReceaddress.length==0){
                    this.$alert('请填写收货地址', '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }
                let goods = [];
                this.cartItems.forEach(c => {
                    if (c.value.selected) {
                        goods.push({
                            spid: c.value.id,
                            count: c.value.count,
                            price: c.value.price
                        });
                    }
                });
                let addid=this.listReceaddress[this.selectedIndex].id
               let {data:res}= this.$http.post("admin/shorder/save", {
                    purchaser:this.hyid,
                    psstyle:"网购",
                    remark:this.remark,
                    addid:addid,
                    goods,

                },{
                    emulateJSON:false
                });
                if (res!=null&&res.stateCode<0){
                    this.$message.error(res.des);
                    return;
                }
                new SmartStorage().clear();
                window.location.href="xiadanresult.jsp";
            }

        },
        computed:{
            totalPrice(){
                if(this.cartItems==null||this.cartItems.length==0)
                    return 0;
                let sum=0;
                this.cartItems.forEach(c=>{
                    if(c.value.selected)
                        sum+=c.value.count*c.value.price;
                });
                return sum;
            }

        },
        created () {
            this.load();
        }

    });
</script>