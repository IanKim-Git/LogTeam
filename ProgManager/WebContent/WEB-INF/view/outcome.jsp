<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="topBar.jsp" flush="false" />
	<jsp:include page="leftMenu.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="css/default.css" rel="stylesheet" type="text/css" />
<title>Outcome</title>
</head>

<script src="js/jquery-1.10.2.js"></script>
<script>var jb = jQuery.noConflict();</script>

<body>
	<h6>����������</h6>
	������Ʈ ��ȣ : ${requestScope.pnum}
	���� �̸��� : ${sessionScope.userData.uemail}<br>
</body>
</html>
