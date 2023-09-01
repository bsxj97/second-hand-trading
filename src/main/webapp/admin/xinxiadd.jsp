<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld" %>
<%@ include file="law.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>资讯资讯</title>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"  type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vuecontrol/dwvuecontrol.umd.js"></script>
    <script src="${pageContext.request.contextPath}/webui/quill/quill.min.js"></script>
    <script src="${pageContext.request.contextPath}/webui/quill/vue-quill-editor.js"></script>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.core.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.snow.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/webui/quill/quill.bubble.css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>

    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>


</head>
<body>
<div id="app">
    <div class="search-title">
        <h2>
            <span v-if="actiontype=='save'">发布资讯信息</span>
            <span v-if="actiontype=='update'">编辑资讯信息</span>
        </h2>
        <div class="description">
        </div>
    </div>

    <table class="grid" cellspacing="1" width="100%">

        <tr>
            <td width="10%" align="right">标题:</td>
            <td width="*">
                <input name="title" placeholder="标题" v-validate="{required:true,messages:{required:'请输入标题'}}"
                       v-model="xinxi.title" class="input-txt" type="text"/>
            </td>
        </tr>
        <tr>
            <td align="right">图片:</td>
            <td>
                <dw-upload v-model="xinxi.tupian" :host-head="hostHead"></dw-upload>
            </td>
        </tr>
        <tr>
            <td align="right">分类:</td>
            <td>
                <el-cascader
                        v-model="lmvalue"
                        :options="cascadeData"
                        :props="{ expandTrigger: 'hover' }"></el-cascader>
            </td>
        </tr>


        <tr>
            <td align="right">隐私:</td>
            <td>
                <el-radio-group v-model="xinxi.tuijian">
                    <el-radio-button label="1">公开</el-radio-button>
                    <el-radio-button label="0">私有</el-radio-button>

                </el-radio-group>
            </td>
        </tr>

        <tr>
            <td align="right">标签:</td>
            <td>
                <el-select v-model="xinxi.tagid" clearable placeholder="请选择">
                    <el-option
                            v-for="item in listStag"
                            :key="item.id"
                            :label="item.name"
                            :value="item.id">
                    </el-option>
                </el-select>
            </td>
        </tr>



        <tr>
            <td align="right">介绍:</td>
            <td colspan="3">
                <quill-editor v-model="xinxi.dcontent"></quill-editor>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <button @click="submitHandler" class="btn btn-danger"><i class="fa fa-plus"></i>提交</button>
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
    Vue.use(VueQuillEditor);

    let vm = new Vue({
        el: "#app",
        data() {
            return {

                actiontype: 'save',
                lmvalue:[],
                fileList: [],
                listStag:[],
                cascadeData: [],
                hostHead: '${pageContext.request.contextPath}',
                "xinxi": {
                    "title": "",
                    "lmid": 0,
                    "subtypeid":1,
                    "tupian": "/upload/nopic.jpg",
                    "clickcount": 0,
                    "agreecount": 0,
                    "againstcount": 0,
                    "pubren": "${sessionScope.users.username}",
                    "state": 1,
                    "tuijian": 1,
                    "fileurl":"",
                    "tagid": 1,
                    "dcontent": ""
                },
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                if (id != "") {
                    this.actiontype = "update";
                    this.pageTitle = "编辑资讯";
                    let url = "admin/xinxi/load";
                    let util = new VueUtil(this);
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null) {
                        this.xinxi = res.data;

                        this.lmvalue.push(...[this.xinxi.lmid,this.xinxi.subtypeid]);
                    }
                }
            },//end load
            async submitHandler() {

                let defaultOptions = {
                    url: "admin/xinxi/save",
                    actionTip: "资讯新增成功"
                };
                let util = new VueUtil(this);
                if (this.actiontype == "update") {
                    defaultOptions.url = "admin/xinxi/update";
                    defaultOptions.actionTip = "资讯更新成功";
                }
                const validRes = this.myValidator.valid(this);
                if (!validRes)
                    return;

                if (this.lmvalue.length<2){
                    util.message.error("请选择资讯类别");
                    return ;
                }
                this.xinxi.lmid=this.lmvalue[0];
                this.xinxi.subtypeid=this.lmvalue[1];

                let params = {...this.xinxi};
                let {data: res} = await util.http.post(defaultOptions.url, params);
                if (res.stateCode <= 0) {
                    util.alert(res.des, '系统提示', {
                        confirmButtonText: '确定'
                    });
                    return;
                }
                util.message({
                    message: defaultOptions.actionTip,
                    type: 'success',
                    duration: 2000
                });
                window.location.href = this.hostHead + "/admin/xinximanager.jsp";
            },
            async getLanmus(){
                let url = "admin/xinxi/cascadelanmu";
                let {data:res}=await this.$http.post(url);
                if (res.stateCode<0){
                    this.$message.error(res.des);
                    return ;
                }
                this.cascadeData=res.data;

                if (this.cascadeData!=null&&this.cascadeData.length>0){
                    this.lmvalue.push(this.cascadeData[0].value)
                    if (this.cascadeData[0].children!=null&&this.cascadeData[0].children.length>0){
                        this.lmvalue.push(this.cascadeData[0].children[0].value);
                    }

                }
            },
            async getTags(){
                let url = "admin/stag/list";
                let {data:res}=await this.$http.post(url,{ispaged:"-1"});
                if (res.stateCode<0){
                    this.$message.error(res.des);
                    return ;
                }
                this.listStag=res.data;
                if (this.listStag&&this.listStag.length>0)
                    this.xinxi.tagid=this.listStag[0].id;

            },
            successHandler(res, file) {
                console.log("success res=",res);
                console.log("success=",file);

            },
            changeHandler(file, fileList) {
                console.log("file=",file);
                this.fileList = fileList;
            },
            removeHandler(file, fileList) {
                console.log("remove file=",file);
                console.log("remove fileList=",fileList);
                this.fileList=fileList;
            },
        },
        async created() {
            await this.getLanmus();
            await this.getTags();
            await this.load();
        }

    });

</script>
