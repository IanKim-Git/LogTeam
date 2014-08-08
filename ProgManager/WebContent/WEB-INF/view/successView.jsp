<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 성공 화면</title>
</head>
<body>
	이메일 - ${requestScope.email}<br>
	비밀번호 - ${requestScope.pw}<br>
	이름 - ${requestScope.name}<br>
	전화번호 - ${requestScope.phone}<br>
	
	<a href="updateInfo.html">개인정보 변경 화면</a>
</body>
</html>