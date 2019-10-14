<%@page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("basePath", basePath);
%>
<%--easyui --%>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="themes/doc.css">
<script src="js\baseJS\jquery.min.js" ></script>
<script src="js\baseJS\jquery.easyui.min.js" ></script>
<%--vue --%>
<script src="js\baseJS\vue.min.js" ></script>
