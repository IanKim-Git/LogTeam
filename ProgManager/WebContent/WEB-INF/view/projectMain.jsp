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
유 이메일 - ${requestScope.uemail}<br>



<form action="projectInfo.do" method="post">
   <input type="submit" value="프로젝트 정보">
   <input type="hidden" name="pnum" value="${requestScope.pnum}">
</form>

</body>
</html>