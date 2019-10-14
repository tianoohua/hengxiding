<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html;charset=UTF-8"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
    <title>百度一下，你就知道</title>
    <script src="${pageContext.request.contextPath}\js\baseJS\jquery.min.js" />
    <script stc="${pageContext.request.contextPath}\js\baseJS\jquery.easyui.min.js" />
    <script src="${pageContext.request.contextPath}\js\baseJS\vue.min.js" />

</head>
<body>
<div class="s_tab_inner">
    <b>网页</b>
</div>

<table align='center' border='1' cellspacing='0'>
    <tr>
        <td>id</td>
        <td>name</td>
    </tr>
    <c:forEach items="${hospital}" var="s" varStatus="st">
        <tr>
            <td>${s.akb020}</td>
            <td>${s.akb021}</td>
        </tr>
    </c:forEach>
</table>
<h1>我的第一个 JavaScript 程序</h1>
<p id="demo">这是一个段落</p>
<p id="de">这是er个段落</p>
<button onclick="tgin()">现在的时间是?</button>
<div id="example">
    <div>
        <p>{{message}}</p>

    </div>
</div>
<button onclick="this.innerHTML=Date();">现在的时间是?</button>

</body>
</html>

<script>
    $(document).ready(function(){
        tgin();
    })
    new Vue({
        el: '#example',
        data: {
            message: 'Hello Vue.js!'
        }
    })
    var lo_fi = "1"
    function tgin(){
        lo_fi ="333333333333";
        // document.getElementById("de").innerHTML()=lo_fi;
    }
</script>