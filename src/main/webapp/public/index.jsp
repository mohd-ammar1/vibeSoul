<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>vibeSoul</title>
</head>
<body>
<div>
<!-- Navbar -->
<%@ include file="navbar.jsp" %>
</div>
<hr>
<div style="width:100%; margin-top:0px;">
<%
    String mid = request.getParameter("mid");
    if(mid == null) {
        mid = "home"; // default page
    }

    if("home".equals(mid)) {
%>
<jsp:include page="home.jsp" />
<%
} else if("login".equals(mid)) {
%>
<jsp:include page="login.jsp" />
<%
} else if("signup".equals(mid)) {
%>
<jsp:include page="signup.jsp" />
<%
    }
%>

</div>
</body>
</html>
