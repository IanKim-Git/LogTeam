<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% System.out.println("logout.jsp"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
log out
<%
	session.removeAttribute("userData");
    session.invalidate();
    session = null;
%>
<script type="text/javascript">
	window.location.replace("./index.html");
	//location.href = './index.html';
</script>

</body>
</html>  