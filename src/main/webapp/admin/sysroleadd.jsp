<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="law.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>后台角色</title>

    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
          type="text/css"/>
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
            新建后台角色
        </h2>
        <div class="description">
        </div>
    </div>


    <table class="grid" cellspacing="1" width="100%">


        <tr>
            <td width="10%" align="right">名称:</td>
            <td width="*">
                <input name="name" v-model="sysrole.name" placeholder="名称"
                       v-validate="{required:true,messages:{required:'请输入名称'}}" class="input-txt" type="text"/>
            </td>
        </tr>


        <tr>
            <td colspan="4">

                <button @click="submitHandler" class="btn btn-danger"><i class="fa fa-check"></i>提交</button>

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
    Vue.use(window.VueQuillEditor);
    let vm = new Vue({
        el: "#app",
        data() {
            return {

                actiontype: 'save',
                hostHead: '${pageContext.request.contextPath}',
                errors: {},
                "sysrole": {


                    "name": "",


                },
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${param.id}"
                if (id != "") {
                    this.actiontype = "update";
                    this.pageTitle = "编辑后台角色";
                    let url = "admin/sysrole/load";
                    let util = new VueUtil(this);
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null)
                        this.sysrole = res.data;
                }
            },//end load
            async submitHandler() {

                let defaultOptions = {
                    url: "admin/sysrole/save",
                    actionTip: "后台角色新增成功"
                };
                if (this.actiontype == "update") {
                    defaultOptions.url = "admin/sysrole/update";
                    defaultOptions.actionTip = "后台角色更新成功";
                }
                const  validRes=this.myValidator.valid(this);
                if (!validRes)
                    return ;
                let util = new VueUtil(this);
                let params = {...this.sysrole};
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
                window.location.href = this.hostHead + "/admin/sysrolemanager.jsp";
            }
        },
        created() {
            this.load();
        }

    });

</script>