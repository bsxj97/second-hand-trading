<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="law.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

    <title>后台用户信息查看</title>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet"
          type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-resource-1.3.4.js"></script>
    <link href="${pageContext.request.contextPath}/webui/vue/elementui/theme-chalk/index.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/webui/vue/elementui/index.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vueutil.js"></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>


</head>
<body>
<div id="app">
    <div class="search-title">
        <h2>
            查看后台用户
        </h2>
        <div class="description">
        </div>
    </div>
    <table cellpadding="0" cellspacing="1" border="1" class="smart-table" width="100%">


        <tr>
            <td class="tlabel" align="right">用户名:</td>
            <td>
                {{users.username}}
            </td>
            <td colspan="2" rowspan="6">
                <img width="200" height="200" :src="hostHead+users.xiangpian"/>
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">姓名:</td>
            <td>
                {{users.realname}}
            </td>
        </tr>



        <tr>
            <td class="tlabel" align="right">性别:</td>
            <td>
                {{users.sex}}
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">电话:</td>
            <td>
                {{users.tel}}
            </td>
        </tr>



        <tr>
            <td class="tlabel" align="right">昵称:</td>
            <td>
                {{users.nickname}}
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">创建时间:</td>
            <td>
                {{users.createtime}}
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">登录次数:</td>
            <td>
                {{users.logtimes}}
            </td>

            <td class="tlabel" align="right">邮箱:</td>
            <td>
                {{users.email}}
            </td>
        </tr>


        <tr>
            <td class="tlabel" align="right">创建人:</td>
            <td>
                {{users.creator}}
            </td>

            <td class="tlabel" align="right">角色:</td>
            <td>
                {{users.rolename}}
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

    let vm = new Vue({
        el: "#app",
        data() {
            return {
                actiontype: 'save',
                hostHead: '${pageContext.request.contextPath}',
                "users": {},
            }
        },
        methods: {
            //begin load
            async load() {
                let id = "${sessionScope.users.id}"
                let util = new VueUtil(this);
                if (id != "") {
                    let url = "admin/users/load";
                    let {data: res} = await util.http.post(url, {id: id});
                    console.log("res", res);
                    if (res != null && res.data != null)
                        this.users = res.data;
                }
            },//end load

        },
        created() {
            this.load();
        }

    });

</script>