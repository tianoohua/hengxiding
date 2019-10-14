<%@page language="java" pageEncoding="UTF-8" %>
<%--<%@ include file="../../../tian/inc-path.jsp"%>--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="css/usercss/login.css">
    <link rel="stylesheet" type="text/css" href="css/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/themes/icon.css">
    <script type="text/javascript" src="js/baseJS/jquery.min.js"></script>
    <script type="text/javascript" src="js/baseJS/jquery.easyui.min.js"></script>
</head>
<body>
<img id="bgimg" src="img/loginimg/bg.jpg" />
<div>
    <%--获取web应用的servlet上下文内容--%>
    <%--<p>${initParam.contextConfigLocation}</p>--%>
        <div class="container">
            <img class="bgimgimg" src="img/loginimg/logo1.png" />
            <div class="right">
                <div class="loginform" style="width:380px">
                        <form id="loginForm" method="post">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td ><span id="logint">用户登录</span></td>
                                </tr>
                                <tr>
                                    <td class="txhid">
                                        <hr style="color:#111"/>
                                    </td>
                                </tr>
                                <tr >
                                    <td ><input class="easyui-textbox" id="nam" style="width:100%;height:34px;padding:10px" data-options="required:true,iconCls:'icon-man'" prompt="用户名"></input></td>
                                </tr>
                                <tr>
                                    <td class="txhid"></td>
                                </tr>
                                <tr>
                                    <td><input class="easyui-passwordbox" id="psw"  style="width:100%;height:34px;padding:10px" data-options="required:true" prompt="密码"></input></td>
                                </tr>
                                <tr>
                                    <td class="txhid"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input class="easyui-textbox" id="code" data-options="required:true,iconCls:'icon-ok'" prompt="验证码"  style="width:62%;height:34px;padding:10px"></input>
                                        <a href="#" style="float:right"><img id="codeimg"
                                                         onclick="javascript:refeshCode();" src="CaptchaImg"
                                                         title="点击获取验证码" style="float:left;width:95px;height:34px;margin-left:12px;border:1px solid #dcdcdc;" /></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="txhid"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <a href="javascript:void(0)" id="loginid" class="easyui-linkbutton" data-options="plain:true"  style="background-color:#0081c2; width:100%;height:34px;padding:10px;color:white;font-size:x-large" onclick="submitForm()">登录</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <a href="javascript:void(0)" onclick="openWin()" >
                                           <span style="font-size:10px">修改密码</span> </a>
                                    </td>
                                </tr>
                            </table>
                        </form>
                </div>
            </div>
        </div>
        <div id="w" class="easyui-window" title="修改密码" data-options="model:true,draggable:false,maximizable:false,minimizable:false,collapsible:false" style="width:320px;height:305px;padding:2px;background-color: linen">
            <div class="easyui-layout" data-options="fit:true" style="margin: 10px 30px">
                <form id="pswf" method="post">
                    <table cellpadding="8">
                        <tr>
                            <td>用户名: <input class="easyui-textbox" type="name"  data-options="required:true"></input></td>
                        </tr>
                        <tr>
                            <td>原密码: <input class="easyui-textbox" type="password" name="oldp" data-options="required:true"></input></td>
                        </tr>
                        <tr>
                            <td>现密码: <input class="easyui-textbox" type="password" name="nowp" data-options="required:true"></input></td>
                        </tr>
                        <tr>
                            <td>
                                <input class="easyui-textbox" data-options="required:true,iconCls:'icon-ok'" prompt="验证码"  style="width:62%;height:30px;padding:10px"></input>
                                <a href="#" style="float:right"><img id="codeimgpsd"
                                                                     onclick="javascript:refeshChaCode();" src="CaptchaImg"
                                                                     title="点击获取验证码" style="float:left;width:50px;height:30px;margin-left:1px;border:1px solid #dcdcdc;" /></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true"  style="background-color:#0081c2; width:240px;height:34px;padding:10px;color:white;font-size:x-large" onclick="changepsw()">修改</a>
                            </td>
                        </tr>
                    </table>
                </form>
                <div style="text-align:center;padding:5px">
                    </div>
            </div>
        </div>
</div>
</body>
<script type="text/javascript">
    $(function(){
        $('#w').window('close');
    });

    function refeshCode() {
        document.getElementById("codeimg").src = "CaptchaImg?j="+ Math.random();
    }

    function refeshChaCode() {
        document.getElementById("codeimgpsd").src = "CaptchaImg?j="+ Math.random();
    }

    function openWin(){
        $('#w').window('open');
        refeshChaCode();
    }

    function changepsw() {

        // $.messager.alert('修改密码','密码修改成功!','info');
        // $('#w').window('close');
    }

    $('#pswf').form('submit', {
        url: "/imple/login/changepsd.do",
        onSubmit: function(param){
            param.login = "tianhua";
            param.psw = "123456";
            var isValid = $(this).form('validate');
            if (!isValid){
                $.messager.progress('close');	// hide progress bar while the form is invalid
            }
            return isValid;	// return false will stop the form submission
        },
        success: function(data){
            var data = eval('(' + data + ')'); // change the JSON string to javascript object
            if (data.success){
                alert(data.message)
            }
        }
    });
</script>
</html>
