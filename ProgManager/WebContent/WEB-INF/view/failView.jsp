<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 실패 화면</title>
</head>
<body>
	<b>존재하지 않는 사용자입니다.</b><br>
	이메일 - ${requestScope.email}<br>
	비밀번호 - ${requestScope.pw}<br>
	
	<a href="index.html">로그인 화면으로 돌아가기</a>
</body>
</html>