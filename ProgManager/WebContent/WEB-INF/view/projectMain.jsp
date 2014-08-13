<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Project Main</title>
</head>
<body>
This is project Main<br>

프 번호 - ${requestScope.pnum}<br>
유 이메일 - ${sessionScope.userData.uemail}<br>
<!-- 프로젝트 정보 -->
<form action="projectInfo.do" id="projectInfo" method="post">
	<input type="submit" value="프로젝트 정보">
	<input type="hidden" name="enterProInfoPnum" value="${requestScope.pnum}">
</form>
<!-- 공지사항 -->
<form action="announcement.do" id="announcement" method="post">
	<input type="submit" value="공지사항">
	<input type="hidden" name="enterAnnPnum" value="${requestScope.pnum}">
</form>
<!-- 캘린더 -->
<form action="calender.do" id="calender" method="post">
	<input type="submit" value="캘린더">
	<input type="hidden" name="enterCalPnum" value="${requestScope.pnum}">
</form>
<!-- 로그게시판 -->
<form action="logList.do" id="logList" method="post">
	<input type="submit" value="로그게시판">
	<input type="hidden" name="enterLogPnum" value="${requestScope.pnum}">
</form>
<!-- 팀원성과도 -->
<form action="outcome.do" id="outcome" method="post">
	<input type="submit" value="팀원성과도">
	<input type="hidden" name="enterOutPnum" value="${requestScope.pnum}">
</form>
<!-- 회계관리 -->
<form action="account.do" id="account" method="post">
	<input type="submit" value="회계관리">
	<input type="hidden" name="enterAccPnum" value="${requestScope.pnum}">
</form>
</body>
</html>
