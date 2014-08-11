<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
This is project Main<br>

프 번호 - ${requestScope.pnum}<br>
유 이메일 - ${sessionScope.userData.uemail}<br>
<form action="logList.do" id="logList" method="post">
	<input type="submit" value="로그게시판">
	<input type="hidden" name="enterLogPnum" value="${requestScope.pnum}">
</form>
</body>
</html>
