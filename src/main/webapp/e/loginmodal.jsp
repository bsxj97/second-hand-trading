<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){

        $(".required-login").click(function(e){
            if($(this).hasClass("disabled-btn"))
                return;
            var url=$(this).data("url");
            var accountname="${sessionScope.huiyuan.accountname}";
            if(accountname==""){

                $("#loginDlg [name=nexturl]").val(url);
                $("#loginDlg").modal({show:true});
                return;
            }
            var callback=$(this).data("fun");

            if(callback!=null){

                window[callback].call(this);
                return;
            }
            window.location.href=url;

        });
        $("#btnLoginOK").click(function(){

            var accountname= $("[name='mod-accountname']").val();
            var password=$("[name='mod-password']").val();
            if(accountname==""){
                alert("请输入账号");
                return ;
            }
            if(password==""){
                alert("请输入密码");
                return ;
            }

            var success=false;
            $.ajax({
                url:'${pageContext.request.contextPath}/admin/huiyuan/login',
                data:{
                    'accountname':accountname,
                    'password':password
                },
                method:'post',
                datatype:'JSON',
                async: false,
                success:function(data){
                    if(data.stateCode>0){
                        success=true;
                    }else{
                        $.alert({
                            title: '错误提示',
                            icon: 'fa fa-warning',
                            content: data.des,
                            confirmButton: '确定'
                        });
                    }

                },
                errror:function(XMLHttpRequest, textStatus, errorThrown){
                    alert(XMLHttpRequest.status + errorThrown);
                }


            });
            var url=$("#loginDlg [name=nexturl]").val();

            if(success){
                if(url=="")
                    window.location.reload();
                else
                    window.location.href=url;
            }

        });


    });
</script>
<div class="modal fade" id="loginDlg">
    <input type="hidden" name="nexturl" value=""/>
    <div class="modal-dialog">
        <div class="modal-content" style="width: 600px; height:400px;">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

                <h4 class="modal-title">用户登录</h4>
            </div>
            <div class="modal-body" style="width: 100%; height:200px;">

                <div class="form-line">
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" class="form-control" name="mod-accountname"  placeholder="用户名">
                    </div>
                </div>

                <div class="form-line">
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" class="form-control"  name="mod-password" placeholder="密码">
                    </div>
                </div>



            </div>
            <div class="modal-footer">
                <button type="button" class="dw-btn" data-dismiss="modal">关闭</button>
                <button type="button" id="btnLoginOK" class="dw-btn">登录</button>


            </div>
            <div  class="pull-right" style="padding-right:200px;"><a href="${pageContext.request.contextPath }/e/register.jsp">注册</a></div>


        </div>
    </div>
</div>
	