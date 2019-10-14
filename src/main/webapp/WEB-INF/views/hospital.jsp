<%@ page language="java" contentType="text/html;charset=UTF-8"  %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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