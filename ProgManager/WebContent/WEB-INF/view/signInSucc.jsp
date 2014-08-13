<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입 성공 화면</title>
</head>
<body>
${requestScope.name }님, 회원가입에 성공하셨습니다!<br>
ID(email) : ${requestScope.email}
<a href="index.html">로그인 화면</a>
</body>
</html>